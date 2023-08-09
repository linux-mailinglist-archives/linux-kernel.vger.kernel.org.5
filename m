Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533BF775F02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjHIMbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHIMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:31:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07710F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:31:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4039f7e1d3aso51421601cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691584277; x=1692189077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwxMc/Jnf4KYiaUH2KdLbTiq/tI1vp0nwZHG7xf4bjQ=;
        b=JGgHp8s1/q17mE16KjiuAbrpI+wZnxS9jiieUXX6BnO3L5pZOuM+jYpbmKm+ouHJlR
         7WEC2Qb6WMFXDl436d9Q58D2e9JubHm8efuk/mVFKuTFjMIEx0oSiMtnEw4YjyMCyhBj
         mBdPARJI9Y3w/N9xVq/0QF9mWnFLBGa9YALweT5v58LILwqqj8KmJwEnQQZlZ3GEkhe2
         5susF1zxhAh0BbxG9LLWGjMrXnBX1CvlxqwkqSUUHk6eLhHCL1hmSckD1zgeXja36aeh
         mqjmx1656ysy1g1Gfa5RflRrmlXBBXMusGLtNkXO0RgEMslQ45NWKkalm+AFfCNEZywR
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584277; x=1692189077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwxMc/Jnf4KYiaUH2KdLbTiq/tI1vp0nwZHG7xf4bjQ=;
        b=lslgq9x7GjM0RMb8sF66roS4n/qQf6xB5bF3fUu7cYplXQzIQWVwe4zFB7hcnGw2MH
         bWxdTXgcj+PgOB4vaQx/rrQ74DlfOzEMnCkf5eoN4VRScQuTY4I0Y83Uy0kWqlCTmFN6
         838z0waVeRpewnuRUW9o6+P1haP+HILgdN4TwASAIKRy/GsnlqR3rRvzbIfFffAmQQmt
         KU6ly5s9QVq8eLFsuNpen74D+SGvqA1xpT7ZBjpkaKwTn4ounuGyguSBtC6aJPNFlI6H
         mZwFL8/qVD08OCpgmIjHt/aMqViHo9RrlmFhCyQrf2QsCkGOOeYvbzi+CkN5MdWjC9wN
         xz/Q==
X-Gm-Message-State: AOJu0YxQQqkDGADtH9LDjQNgehLdAud1xU0UF/wncRO+xLoUIxuKA+GU
        L5IV1ewKOHQ5P4jPP0lSR1CWLg==
X-Google-Smtp-Source: AGHT+IE/9nPEzWHTfAO4Unck7OivGgxHUDY+IIy8TYtQWjM35uS0OME7kSgnmqRHBiRv00LegSDHZw==
X-Received: by 2002:a05:622a:101:b0:40f:d66e:8134 with SMTP id u1-20020a05622a010100b0040fd66e8134mr2652250qtw.59.1691584277408;
        Wed, 09 Aug 2023 05:31:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id fu25-20020a05622a5d9900b0040fdcd391d8sm4039493qtb.72.2023.08.09.05.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:31:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTiLM-0051Mb-4k;
        Wed, 09 Aug 2023 09:31:16 -0300
Date:   Wed, 9 Aug 2023 09:31:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Zhang, Tina" <tina.zhang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Message-ID: <ZNOHFKbkQ75owuwC@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-2-tina.zhang@intel.com>
 <ZNJY/9pwRxIkFEjD@ziepe.ca>
 <BN9PR11MB527654AF38084B07EC7734468C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527654AF38084B07EC7734468C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:47:15AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, August 8, 2023 11:02 PM
> > 
> > On Tue, Aug 08, 2023 at 03:49:40PM +0800, Tina Zhang wrote:
> > > mm_get_pasid() is for getting mm pasid value.
> > >
> > > The motivation is to replace mm->pasid with an iommu private data
> > > structure that is introduced in a later patch.
> > 
> > Maybe we should start out by calling it what it actually is:
> > 
> > 'mm_get_enqcmd_pasid()'
> > 
> > We can't actually have multiple SVA domains with different PASIDs
> > until the places wrongly calling this are removed :\
> > 
> 
> it's kind of egg-chicken problem. mm_get_pasid() is used by all SVA
> scenarios beyond enqcmd then calling it mm_get_enqcmd_pasid()
> also sounds weird for non-enqcmd case.

Well, those are wrong. We need to be fixing them not hide our eyes to
the wrongness.

Michael is cooking a fix for ARM, Tina should come with a fix for
Intel in this series.

Jason
