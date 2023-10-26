Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2C7D827C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbjJZMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJZMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:20:23 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA710A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:20:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so489753a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698322819; x=1698927619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qU0vFWhyRKz3l1/cwtPJ3LxAPBuI6AFrBw6ekYuxL/0=;
        b=JwIWbPuSIlEAzErLDUZCUYAB/HvHJ268TV3p/ST5+UqhyCdJNDrF9Och3m9NYvfmXf
         jkJMfWrrVbLK8sqHkeQ2eM8i5Mb5Byq4oKy5PIcT5+/XtEp5ID0SZtcE1pAbmua7NvIA
         LyMXkslyggLlp4GUq9ZPEDbWh/ezYOjeoEsaQekAD7TVKED0hEH7pUDnlOO+8RfbRLXZ
         23su9Ol77c1znaMB0huWtmXYGJe6ydNUDIlQzl5Q7rSjIQuMH9iRBYIz8tecPaVzSnnV
         Fr8vs8q3H2jnXcSO9elDZlbpVcsHkSRQiVc6uqqx7bhTp6Os4eeZmhJfivIU/rRwK04E
         HvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322819; x=1698927619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU0vFWhyRKz3l1/cwtPJ3LxAPBuI6AFrBw6ekYuxL/0=;
        b=iK3nyjnStOUKT4KyaOsxcWA7I2jBNyvZSJL+Xj0dQOJxUjyQXaZ/gWJBK18LtIA9q9
         ymulABtFm0sa81/s2qJhrhO8a/em/QFktNP1XC1mrNP30A5e5kn9pMHiYFh5rS9EG34R
         G5jlYtjnJSEWbCm7BXjlFO5z0F7IvGYjn78/SAEOSEJd+SddjxUdLLLqXxqamyKIbcux
         b5TmeJ6FFH0HsMNbgVu7gxnz5lQtrvL7mQnppminkZ9f/3FkRKe2dHkz+pSoaQX8+nOf
         ZIbM1XburGhpxsewdIE6Lfhv8UDBzosRc0dV0MKZj348fEIl7BT5QBM/1dgXM2qV2ucK
         02FA==
X-Gm-Message-State: AOJu0YxcVUf/wC3ox1TjolLI3AiVKcVAG9L0jkN7Bg79q7St09uGFXp1
        ZGpGMGnnr4l5tx9743N09f2a1Q==
X-Google-Smtp-Source: AGHT+IH3V0Wyvq3WAkx6gNZbtYj7bpXecF10nQELMvJIJVFlv9xPTITWAHw3myCxCfAO9zsI2u+Iww==
X-Received: by 2002:a9d:73c3:0:b0:6b9:b226:d08e with SMTP id m3-20020a9d73c3000000b006b9b226d08emr20022310otk.34.1698322818799;
        Thu, 26 Oct 2023 05:20:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t16-20020a9d7750000000b006b8c87551e8sm2616543otl.35.2023.10.26.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:20:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qvzLU-005091-VY;
        Thu, 26 Oct 2023 09:20:16 -0300
Date:   Thu, 26 Oct 2023 09:20:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231026122016.GU691768@ziepe.ca>
References: <20231018050640.24936-1-tina.zhang@intel.com>
 <ZToUOKSqqI6Bh_03@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZToUOKSqqI6Bh_03@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:24:40AM +0200, Joerg Roedel wrote:
> Hi Tina,
> 
> On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> > Tina Zhang (5):
> >   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
> >   iommu: Add mm_get_enqcmd_pasid() helper function
> >   mm: Add structure to keep sva information
> >   iommu: Support mm PASID 1:n with sva domains
> >   mm: Deprecate pasid field
> 
> Thanks for doing this, it all looks reasonable to me. But there is one
> thing missing which needs to be done before we can move forward with
> this.
> 
> There was a discussion about the Kconfig symbol naming used in
> mm_struct. Please see the discussion here:
> 
> 	https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
>
> Please update this patch-set to solve this and I will take the series.

Lets call it CONFIG_IOMMU_MM_DATA then. It is still pretty nonsensical
but it speaks to what it does after this series

Thanks,
Jason
