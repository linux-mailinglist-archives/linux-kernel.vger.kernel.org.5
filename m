Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467138013A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbjLATp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379522AbjLATp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:45:58 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C410E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:46:04 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77d8d1b7952so134108385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701459964; x=1702064764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U51b6DOvae7badw0cILrKOdmI7KPWtEKHdBIgXOpwAo=;
        b=QPQah+1fCKIXihr7g3GgqZX0YvSG96x2por4j5JJDDXcVoKmc4zbxjgDGnISyl4RZ/
         6rWWvWMyf2MAZXEH8r1ZfUCU91saqC2r1iuo4rD/8q7ab53BJfsqgn1YOsnCDkS09Ve8
         bnbj5Kbv/UtaGYZta9C4NZmkKYmmhvYur14DfehLPHJ+Sh60NmSojIGuPK4vLpffqM9t
         DnQHn3aly8QtTtIgm43uJktxAlOpnjso5O8iWG1AGJzhCuRpsRKryhjZVTpA9Gv8k0kj
         uNxQ1/mCudE1xfx3JNPJ8klfItrYDLUjtWyxz9K575ZPOnhKrKlc7yAnIiXBBFDQ+DZk
         Zt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701459964; x=1702064764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U51b6DOvae7badw0cILrKOdmI7KPWtEKHdBIgXOpwAo=;
        b=JczAjpOQBY64EmQHKuMEKPbi17tXzKt33r9ZqWt1VK2gQXoolxzC0cmBzX4l9Xr9+V
         hBcCKkro9WZc6KrPQfVNOFByBCsw4UcJSDzhmmAWt2RuHZaRHkM89FUHE6z8ZLmV7Lqh
         Wj05jcMrRomvx+LKOQ6F0uoMfkyAcepyvXPWhWLVVGrVozNXSnD/lRxGcibkeewiVp/A
         4LGuY8P2oL2HYy1uKYTzo7/MXcHWLsqi0RRbjNONXnBRIj9fnrL4zE7qWyM4wpA6vduh
         GXjr+eCHoKmq1Zot9JXglSBNXZPyp8B4sAh+vQ2pRXTRpiEfM8l3MB0xgGg8YBvdp8Ub
         BwXA==
X-Gm-Message-State: AOJu0YzETH9sG2271tgSJ9dMPZuNAEBnnztPzSr/8bbAjCqsMTQW7dlz
        08+jAFP2UtSwEAK0RaWc7MXBfutl1G6JZEDtNvE=
X-Google-Smtp-Source: AGHT+IHJCuV3KvM+nqo/V6zkIZj2zDcpkiMw26vPVeayu5TilFxweaNcQBHSSoPH460XwQaorBXMvw==
X-Received: by 2002:ac8:5c02:0:b0:41e:3259:529a with SMTP id i2-20020ac85c02000000b0041e3259529amr39547qti.9.1701459963863;
        Fri, 01 Dec 2023 11:46:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id r21-20020ac85215000000b004181c32dcc3sm1743712qtn.16.2023.12.01.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:46:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r99Sc-006JuU-B4;
        Fri, 01 Dec 2023 15:46:02 -0400
Date:   Fri, 1 Dec 2023 15:46:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/12] iommu: Consolidate per-device fault data
 management
Message-ID: <20231201194602.GF1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-12-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02:25AM +0800, Lu Baolu wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d19031c1b0e6..c17d5979d70d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -597,6 +597,8 @@ struct iommu_device {
>  /**
>   * struct iommu_fault_param - per-device IOMMU fault data
>   * @lock: protect pending faults list
> + * @users: user counter to manage the lifetime of the data, this field
> + *         is protected by dev->iommu->lock.
>   * @dev: the device that owns this param
>   * @queue: IOPF queue
>   * @queue_list: index into queue->devices
> @@ -606,6 +608,7 @@ struct iommu_device {
>   */
>  struct iommu_fault_param {
>  	struct mutex lock;
> +	int users;

Use refcount_t for the debugging features

>  	struct device *dev;
>  	struct iopf_queue *queue;

But why do we need this to be refcounted? iopf_queue_remove_device()
is always called before we get to release? This struct isn't very big
so I'd just leave it allocated and free it during release?

> @@ -72,23 +115,14 @@ static int iommu_handle_iopf(struct iommu_fault *fault, struct device *dev)
>  	struct iopf_group *group;
>  	struct iopf_fault *iopf, *next;
>  	struct iommu_domain *domain = NULL;
> -	struct iommu_fault_param *iopf_param;
> -	struct dev_iommu *param = dev->iommu;
> +	struct iommu_fault_param *iopf_param = dev->iommu->fault_param;
>  
> -	lockdep_assert_held(&param->lock);
> +	lockdep_assert_held(&iopf_param->lock);

This patch seems like it is doing a few things, can the locking
changes be kept in their own patch?

Jason
