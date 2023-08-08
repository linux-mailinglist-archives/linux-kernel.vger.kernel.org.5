Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E3774149
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjHHRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjHHRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B971F30
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:07:04 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9c9944da8so5235767a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691510823; x=1692115623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rM9s45ajvUEfm13rVKA/b953azw8KNY+yLlHhnSd5UQ=;
        b=WLgcVzoJ3XK6T7xTzzy8tx8ViaidY8gaHp7njFUnZXRlWlis9CqmBOrDiSDb38c6p/
         jS3EvcdvH4dCdaUhe6nPlMKpPQR8mhdx1a6a61FO6NHrJz+sstwg/L5eveVJ5vGCTKAn
         XiQxpB1qdSmpo4HLg4vHfBIuShyAtSE6Q+xTO0mxz9jpByDti384QNn7d8wCv24LoBbm
         cKK8RAIuhJmjoAafttec1s0BeerUT2ujrATFRMAuFwNIWLiJkP4RWVqq5YKmXlQhmehZ
         QcEb0t3tQ5Z2H0PMCwQdyAnURkhWw3Q5H1N2dTAoQUrtnzVXJmB6P5qJDYEoG89h5XdU
         a2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510823; x=1692115623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM9s45ajvUEfm13rVKA/b953azw8KNY+yLlHhnSd5UQ=;
        b=VVbTOxoQ50mAzKXhNXCEvrbVs0X1EU1yT5eTFeSjeoiOlG7NPEgOqFArH0tFSX5rkt
         aUc7lsHv3eRWKYTPMAn1DEEv3+UyyaGcv8luDBxkWPmuWCON3mdpQ2bFlXt3WSWW8spw
         We2Y1FPbBVF1tnLZpwPmt0SAKE0AQr5uohUo4+lG96tKjLRtsdxwgodR/LE1AYwW2mUB
         vlFMQnhFIXPnN2ukn/OUyuvCKZuSIQvNta5v4/FtrruI+z0sChucXETf8wcEV/SoKh9H
         1DFAnLOwkH2UoFuJcoMJYMDkrwT2Scg4cNo/GfWlEwjB41KmG7D1fjGDNuLyC7whzwF6
         mxgA==
X-Gm-Message-State: AOJu0Yxub2ADJg2mNxneHxxjZSbpSiBNtqf2X7E94qc9f/Ot5rUW3K1p
        J+f9q93W6SQC3zFeiAtxrdBYOWouCmKcKS2IBs8=
X-Google-Smtp-Source: AGHT+IH1k2gtxB/qMeg2HYGK22I3eNo31aRxolvh9gdfopezij2ls2Y2lVbvyMlNtptN2VT/xlyoFA==
X-Received: by 2002:a05:622a:93:b0:410:bc4:d7c4 with SMTP id o19-20020a05622a009300b004100bc4d7c4mr7082848qtw.51.1691506944768;
        Tue, 08 Aug 2023 08:02:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8604e000000b0040fefceb8d1sm3387788qtm.20.2023.08.08.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:02:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTOE3-004cz2-M4;
        Tue, 08 Aug 2023 12:02:23 -0300
Date:   Tue, 8 Aug 2023 12:02:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Message-ID: <ZNJY/9pwRxIkFEjD@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808074944.7825-2-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
> mm_get_pasid() is for getting mm pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.

Maybe we should start out by calling it what it actually is:

'mm_get_enqcmd_pasid()'

We can't actually have multiple SVA domains with different PASIDs
until the places wrongly calling this are removed :\

eg, I would expect this series to also come with removing
'pasid_private' from the Intel driver.

The mmu_notifier should be placed in the singular iommu_domain that is
the SVA domain for the mm. Drivers should not attempt to de-duplicate
this, the core code will do it like you are showing in this series.

Jason
