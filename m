Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89577421F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjHHReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjHHRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:33:43 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C593041
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:14:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7679ea01e16so467893785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691511271; x=1692116071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCc1UHSmLrCN4Qj1bGiz7L7tPa3C3ijmKD+nZL6nYGQ=;
        b=ZNZTVWeCRIY8Sg5OmLSDokYpAaEbvcUX3obxXgzGSnDGtAanPkvLyMJruCnCXLfAUX
         6XuZSBvXa+axf4tXWm8PLS4xhWNo/7c0uuHfcm/gWrKO7QHJZbgqrUIx5evITaJsf6uh
         nfQ8s7P2TIATXcczqQt/BKpGPA5STgmaghnfovHeaJlUxw+CYRwYqNp4076tthmduZ1t
         4PP0UJDoixzHh65kcBe08GAeWYm1vnGtLcpD8zyNz9bAGXiQXitDE9IiQX/5B9Czx+qY
         fQLaYPWkfL10QMGWNlyg8fRU84v+T//AJ0AZN7AsaKYlHFhpJT/p2GYQiPFyoqXlkUXT
         c++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511271; x=1692116071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCc1UHSmLrCN4Qj1bGiz7L7tPa3C3ijmKD+nZL6nYGQ=;
        b=eb+M3xbMELCSt0LhIVzICqkB8NddKrWI0UBgKAF9fvkPXQN+9J9vFjoHIO5IrnO0pw
         TveG9Wb3INwB/X+6RuBm0ejG+RJN+Ri35i8h2jg51TKua7p8tTemMrjpK+AAKepyI0ca
         +eJYdeaRm8Z07Ek1h9s7CvlFPQZ/NT99B5Nr5OsKYvX82qN4BUmrVyZuXWtuhaM7WqPn
         ukBmC2PvEr1qZUJDfNE/sNmppFFMsyuOeR+Jn157M/RDRjJCPV12OZfLz2dEgk49un5M
         ex0NcM3CsN4xkeKtdoNdKGcl/KBrgEdIKc1iUbc+f1NiI/8Nx5aTFloNL6bFzWoe4iqO
         QmMA==
X-Gm-Message-State: AOJu0Yw41XefmdDHmmmI1T5JShsP7pNCS+0wXfFt562suxB2Mqyt3z/L
        Oa28KvaUsMW/oNBEgq4ugDJ4yNds5bxVG6Ibf2E=
X-Google-Smtp-Source: AGHT+IFzrrTqeR30y0Ocpf5EcBwjJlaKJeQEmsrYs8bPjImvTGvp6mVAN6gGXRZBpxRj5Gzog4nk6Q==
X-Received: by 2002:a05:620a:21c6:b0:76a:dad9:8889 with SMTP id h6-20020a05620a21c600b0076adad98889mr12720117qka.43.1691507564018;
        Tue, 08 Aug 2023 08:12:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm3320994qkk.132.2023.08.08.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:12:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTOO2-004d4y-Hd;
        Tue, 08 Aug 2023 12:12:42 -0300
Date:   Tue, 8 Aug 2023 12:12:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZNJbaiTDG+YTgpDP@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-5-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808074944.7825-5-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:49:43PM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when on one is using it (the reference count is decremented
> in iommu_sva_unbind_device()).
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>  include/linux/iommu.h     | 10 +++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0a4a1ed40814..35366f51ad27 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
>  /* Allocate a PASID for the mm within range (inclusive) */
>  static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  {
> +	struct iommu_mm_data *iommu_mm = NULL;
>  	int ret = 0;
>  
>  	if (min == IOMMU_PASID_INVALID ||
> @@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>  		goto out;
>  	}
>  
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(iommu_mm);
>  		goto out;
> +	}
> +
> +	iommu_mm->pasid = ret;
> +	mm->iommu_mm = iommu_mm;
> +	INIT_LIST_HEAD(&mm->iommu_mm->sva_domains);
>  
> -	mm->pasid = ret;
>  	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
> @@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm

Lets please rework this function into two parts

The first should be 'iommu_sva_alloc_domain()'

It should do the list searching and user management. The usual
'iommu_domain_free()' should be modified to clean it up.

Then you have the 'alloc global/enqcmd pasid' function

Then bind is just callling alloc sva domain, alloc global pasid,
set_dev_pasid in a sequence.

It will make this much more understandable what all the parts are
supposed to be doing.

Jason
