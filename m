Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE18775F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjHIMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjHIMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:35:06 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636F10F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:35:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd0a0a675dso1282945a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691584505; x=1692189305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1vlk426yx9I7RvL78AONvP5VHRKVeaBopr8pvsM2ew=;
        b=kZqvQo7QPz15n/1fXXXDdFKSI0e4A/DXzZVaQfaTr7UjANpLuMN3SzY5NxH7MwzQou
         FsNvDyhGFtnBkr34Jr3/ehvKXZ7FKv+3efLEWkVBKZqVsxsZwHLk9+NuV9pYNSDQAttt
         FVreMUaoInrkupaNoigWXu7tLt8LU4K8IL8ZsX9HSuR2iM7+Wwmu1hfOsdVBFPpNh4m0
         asP6tXW7QTlzIOErn16fFZ8FrcUBTYRzMThlg9BT3rb4h51TIXX98ai9eaS7lKWzJkKj
         eEZ7S8/BOrUG55+UoAVm1UcV993ktA0o6xFys38oDvqmcNiRisb4+X9vvSlkuobUELjn
         Um1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584505; x=1692189305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1vlk426yx9I7RvL78AONvP5VHRKVeaBopr8pvsM2ew=;
        b=cPmlBZyMb1biCa1peU9ybDAIFU8gxXOkiA1V+JjRyHf9LZnxYAidqBJKHWnn2h2WOr
         PoovewjPwLLwzaRt/4GJHdwUkZH4MjZibI7+Up7R+vq30VD31hn2XNB0n40mn8R2peK0
         ONNvP9bADqoJRXUX6D1IkwVZ7yq2T6GDPIgLm2DP9SFfughhJl21j1kuRIcacjnTdLjp
         TKDxpLePISjHzhNdkdxcSP37/O9/ccg0SWu4V9y+pQJwRwtt0joV2PMZaFFMcqo8rJLZ
         +YjQ+NQYDYwzFTXNdfl1Q11u5cch/fIPPkyQsFMZ7lN0Wd3/kpsW07NGvhO/D83mCIIT
         OAYg==
X-Gm-Message-State: AOJu0YxLmH0h3jwuoEd2IKVcfKT65QIpps2V/33KOH/AXVH0acNwRZCp
        hE3pP9HA/UWQvi2KISr1bzrDLg==
X-Google-Smtp-Source: AGHT+IFXJv4SSKywPDvp9X/J5cU2mrSKT+Vbk1TAqRv+ipibzkD6pTEls1NDEePZUTv1nQ0uFw/t3g==
X-Received: by 2002:a05:6358:428c:b0:135:b4c:a490 with SMTP id s12-20020a056358428c00b001350b4ca490mr2799558rwc.10.1691584503427;
        Wed, 09 Aug 2023 05:35:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86bd1000000b0040ff25d8712sm4030373qtt.18.2023.08.09.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:35:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTiP0-0051O0-Ef;
        Wed, 09 Aug 2023 09:35:02 -0300
Date:   Wed, 9 Aug 2023 09:35:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNOH9lPdTnltb9JZ@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:49:16AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, August 9, 2023 8:22 AM
> > 
> > On 2023/8/8 15:49, Tina Zhang wrote:
> > > Use the helper function mm_get_pasid() to get the mm assigned pasid
> > > value.
> > 
> > For internal iommu drivers, perhaps we should use another helper.
> > Something like sva_domain_get_pasid()?
> > 
> > Suppose that the iommu drivers should have no idea about the "mm".
> > 
> 
> Aren't all touched functions accept a struct mm_struct pointer?

It is wrong for the driver to even ask this question.

Domains, regardless of what they are, get attached to PASIDs. Maybe
many PASIDs, driver doesn't get to care. SVA isn't special. Stop
making it special.

The driver should rely on there being exactly one iommu_domain for SVA
per mm so it can hang the mm_notifier off the iommu_domain

But otherwise invalidation for a SVA domain should be *exactly the
same flow* as invalidation for a paging domain. It iterates over the
attachments and generates the correct list of PASIDs and ATCs.

Jason
