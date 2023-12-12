Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7880EFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376625AbjLLPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376469AbjLLPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:18:05 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A7AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:11 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f3c4914e5so310170285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394290; x=1702999090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fUIa9V7UktxZJFMOjKnGCbu4VLxyvHPNj4gCPjpKbw=;
        b=dbZCWhMdelQt22bjfK5pmXaNXkzjATMkBRQRgAymNXmWujrCV26O56Tbrkho8v/hHm
         +UvT0vg00L/E+5+tiKwCIM68hDT5un4m6E/RDxYtINwSiXqYtGf7jm4vFOd/PUYe+lXX
         5WY8dKgzGaiJ3zy7/7N+IwEMzSPD0pLaa9NatW+JuAjOyG6L3osoQgzA8MDQK06F9yoj
         9lpnBHiSkP08SWNPvuBIkFnYXHb8cTNmF6CTyiKh/+Pnsbeln7tYcgIHgtufxo4up0ev
         rXb8oTu02eO2qS68oEgwitsE5/Txj7Vew/1HaqYVT2sBaSFpJHN+YtVupagf5XL2GAiq
         Dxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394290; x=1702999090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fUIa9V7UktxZJFMOjKnGCbu4VLxyvHPNj4gCPjpKbw=;
        b=fWt5pSsyGdIZgc4UM3iMcMgSZfLfdyhdIpskepCrereVH8T0RGHBDtx4feNigV8upb
         7LDAlDGF4dep8IB7X7kdAyzRuxcKWpa2GIhgdzFxh93Px58mzrk4+p7eyfyJG0Syfkjs
         zWCb3ZpJ8ZQdcru7zrfhzpSSg/3fLmy/vxnCG5Oxfbb94j1x00JhTSABIuJOrvHbEeP+
         9za4GALcyBIdkyuri0pIVDNdoPSFsYwX+T7rWeBO4mDxvx7T1j2BH2MZWLeb7h4mXLtk
         sXWn35ZIHog19ly4968YVvLzTkzct6PrtPN4L3Rxd3auD1pN68mHEzcANwPz7Cpqbj6L
         9i1g==
X-Gm-Message-State: AOJu0Ywun+RUplt3EJgO7OVxqDO8/0GrW4dn09n/+mSL0d/zeS8lgSof
        Mhqssq1gfeJ2O9iSRXAe65gq/w==
X-Google-Smtp-Source: AGHT+IEO/Sp55UvFmU80+iPDIwa6VlDwgsHYJtE8bskomQaUuOkqvskk69ktoa1wViJw6YFWts4t4A==
X-Received: by 2002:a0c:d644:0:b0:67a:bc4f:341f with SMTP id e4-20020a0cd644000000b0067abc4f341fmr7016622qvj.83.1702394290678;
        Tue, 12 Dec 2023 07:18:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id c13-20020a056214004d00b0067a4f49a13csm4048421qvr.127.2023.12.12.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:18:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rD4WP-00Ck2Y-Mq;
        Tue, 12 Dec 2023 11:18:09 -0400
Date:   Tue, 12 Dec 2023 11:18:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151809.GD3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f23e37a-5ace-492c-82e9-cf3d13f4ef6f@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:07:17PM +0800, Baolu Lu wrote:

> Yes, agreed. The iopf_fault_param should be passed in together with the
> iopf_group. The reference count should be released in the
> iopf_free_group(). These two helps could look like below:
> 
> int iommu_page_response(struct iopf_group *group,
> 			struct iommu_page_response *msg)
> {
> 	bool needs_pasid;
> 	int ret = -EINVAL;
> 	struct iopf_fault *evt;
> 	struct iommu_fault_page_request *prm;
> 	struct device *dev = group->fault_param->dev;
> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
> 	struct iommu_fault_param *fault_param = group->fault_param;
>
> 	if (!ops->page_response)
> 		return -ENODEV;

We should never get here if this is the case, prevent the device from
being added in the first place

> 	/* Only send response if there is a fault report pending */
> 	mutex_lock(&fault_param->lock);
> 	if (list_empty(&fault_param->faults)) {
> 		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
> 		goto done_unlock;
> 	}
> 	/*
> 	 * Check if we have a matching page request pending to respond,
> 	 * otherwise return -EINVAL
> 	 */
> 	list_for_each_entry(evt, &fault_param->faults, list) {
> 		prm = &evt->fault.prm;
> 		if (prm->grpid != msg->grpid)
> 			continue;
> 
> 		/*
> 		 * If the PASID is required, the corresponding request is
> 		 * matched using the group ID, the PASID valid bit and the PASID
> 		 * value. Otherwise only the group ID matches request and
> 		 * response.
> 		 */
> 		needs_pasid = prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> 		if (needs_pasid && (!has_pasid || msg->pasid != prm->pasid))
> 			continue;
> 
> 		if (!needs_pasid && has_pasid) {
> 			/* No big deal, just clear it. */
> 			msg->flags &= ~IOMMU_PAGE_RESP_PASID_VALID;
> 			msg->pasid = 0;
> 		}
> 
> 		ret = ops->page_response(dev, evt, msg);
> 		list_del(&evt->list);
> 		kfree(evt);
> 		break;
> 	}
> 
> done_unlock:
> 	mutex_unlock(&fault_param->lock);

I would have expected the group to free'd here? But regardless this
looks like a good direction

Jason
