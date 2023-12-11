Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E170280CF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjLKPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:31 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADFE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:12:37 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77f335002cfso284487585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702307556; x=1702912356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BcXaEe04wsiYi+jVUtHZ96GrfMgRR6SNn2Jekjosbw=;
        b=dJn8Krm8CVupD7xQ0LE+7gi/QoFJBcPjbWjosJ5jt11OxQPGaP8cvsjYs2JxPod+ZA
         XnkqaE1bt/O4BjYs71BYeLVPox084VUmG3A7sdiMek2yaEo1IFQ2D7gfSlM/dtCw80Tc
         S38w9G35CCfjbc9XIZP9JmvQRSrJduJnYY5gVajbtFyFH5BUQEKuYo4HUKS5i+v641hU
         UOJtnBw1GV+WlrXR6Y8LpHUILNGj1bp5ESRUcYumyWQdb0Ia6FO31VjYt7mlmFOfYRXH
         Yn0vOvfuFxJ2ap3labjDHbGaNJY+WqNe6SjaO/q9Czn93WBDqA+5Q6Z5VDL06cLZ4bil
         tUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307556; x=1702912356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BcXaEe04wsiYi+jVUtHZ96GrfMgRR6SNn2Jekjosbw=;
        b=Tkx8N12uvcjfvPjwlFGPlfA0h3tvoI12TwLQB81YaRFMNWezuIymNiKSkc9rbpc0iI
         1RaovKRbG26y7CW3TGf9E6cCGsSXXy3X4dptPPkRNvHcNKAd98TC3OGLViPI4H3a/Cat
         jZDVcu8slM5vJx4HUDaTv4r6RPG/R9WsIISxzBgrDavyqZvNjXmOlG95YK+le7ggmaYK
         gi5m2N1rFDdaOzCiQq6MbR2PT/ON7wtiDah6F+R3KrrXRWpMJMls1cOqj6bRQVMX5NzW
         LiFKPcMGAAQM4H3bXNlFP/q6neshqbDNxfPsn2hzs8P8+OTO7eQcG7o4xUR10LnQVK9q
         8Ayg==
X-Gm-Message-State: AOJu0YyOPUlvnLO+fbggzX5nlXU53a5/WHL/U1URCmsZQ0jWD3LW3Xm4
        t7ir/ZiYDNh4Aej34DvXPt0jO+9xKhmsjxCWwic=
X-Google-Smtp-Source: AGHT+IETaBdKmCMU8wf7A05/MNS1AJow0FY9ZM2OzwBlmMfqdMQer9Be2sf6osE+CPp3FrHn69KTiA==
X-Received: by 2002:a05:620a:2201:b0:77a:55b2:5dae with SMTP id m1-20020a05620a220100b0077a55b25daemr4753742qkh.53.1702307556526;
        Mon, 11 Dec 2023 07:12:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 26-20020a05620a04da00b0077d7557653bsm2986936qks.64.2023.12.11.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:12:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rChxT-00CcMk-Ec;
        Mon, 11 Dec 2023 11:12:35 -0400
Date:   Mon, 11 Dec 2023 11:12:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
Message-ID: <20231211151235.GA1489931@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207064308.313316-13-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:43:08PM +0800, Lu Baolu wrote:
> +/*
> + * Return the fault parameter of a device if it exists. Otherwise, return NULL.
> + * On a successful return, the caller takes a reference of this parameter and
> + * should put it after use by calling iopf_put_dev_fault_param().
> + */
> +static struct iommu_fault_param *iopf_get_dev_fault_param(struct device *dev)
> +{
> +	struct dev_iommu *param = dev->iommu;
> +	struct iommu_fault_param *fault_param;
> +
> +	if (!param)
> +		return NULL;

Is it actually possible to call this function on a device that does
not have an iommu driver probed? I'd be surprised by that, maybe this
should be WARN_ONE

> +
> +	rcu_read_lock();
> +	fault_param = param->fault_param;

The RCU stuff is not right, like this:

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 2ace32c6d13bf3..0258f79c8ddf98 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -40,7 +40,7 @@ static struct iommu_fault_param *iopf_get_dev_fault_param(struct device *dev)
 		return NULL;
 
 	rcu_read_lock();
-	fault_param = param->fault_param;
+	fault_param = rcu_dereference(param->fault_param);
 	if (fault_param && !refcount_inc_not_zero(&fault_param->users))
 		fault_param = NULL;
 	rcu_read_unlock();
@@ -51,17 +51,8 @@ static struct iommu_fault_param *iopf_get_dev_fault_param(struct device *dev)
 /* Caller must hold a reference of the fault parameter. */
 static void iopf_put_dev_fault_param(struct iommu_fault_param *fault_param)
 {
-	struct dev_iommu *param = fault_param->dev->iommu;
-
-	rcu_read_lock();
-	if (!refcount_dec_and_test(&fault_param->users)) {
-		rcu_read_unlock();
-		return;
-	}
-	rcu_read_unlock();
-
-	param->fault_param = NULL;
-	kfree_rcu(fault_param, rcu);
+	if (refcount_dec_and_test(&fault_param->users))
+		kfree_rcu(fault_param, rcu);
 }
 
 /**
@@ -174,7 +165,7 @@ static int iommu_handle_iopf(struct iommu_fault *fault,
 	}
 
 	mutex_unlock(&iopf_param->lock);
-	ret = domain->iopf_handler(group);
+	ret = domain->iopf_handler(iopf_param, group);
 	mutex_lock(&iopf_param->lock);
 	if (ret)
 		iopf_free_group(group);
@@ -398,7 +389,8 @@ int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
-	if (param->fault_param) {
+	if (rcu_dereference_check(param->fault_param,
+				  lockdep_is_held(&param->lock))) {
 		ret = -EBUSY;
 		goto done_unlock;
 	}
@@ -418,7 +410,7 @@ int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 	list_add(&fault_param->queue_list, &queue->devices);
 	fault_param->queue = queue;
 
-	param->fault_param = fault_param;
+	rcu_assign_pointer(param->fault_param, fault_param);
 
 done_unlock:
 	mutex_unlock(&param->lock);
@@ -442,10 +434,12 @@ int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	int ret = 0;
 	struct iopf_fault *iopf, *next;
 	struct dev_iommu *param = dev->iommu;
-	struct iommu_fault_param *fault_param = param->fault_param;
+	struct iommu_fault_param *fault_param;
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
+	fault_param = rcu_dereference_check(param->fault_param,
+					    lockdep_is_held(&param->lock));
 	if (!fault_param) {
 		ret = -ENODEV;
 		goto unlock;
@@ -467,7 +461,10 @@ int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	list_for_each_entry_safe(iopf, next, &fault_param->partial, list)
 		kfree(iopf);
 
-	iopf_put_dev_fault_param(fault_param);
+	/* dec the ref owned by iopf_queue_add_device() */
+	rcu_assign_pointer(param->fault_param, NULL);
+	if (refcount_dec_and_test(&fault_param->users))
+		kfree_rcu(fault_param, rcu);
 unlock:
 	mutex_unlock(&param->lock);
 	mutex_unlock(&queue->lock);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 325d1810e133a1..63c1a233a7e91f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -232,10 +232,9 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 	iopf_free_group(group);
 }
 
-static int iommu_sva_iopf_handler(struct iopf_group *group)
+static int iommu_sva_iopf_handler(struct iommu_fault_param *fault_param,
+				  struct iopf_group *group)
 {
-	struct iommu_fault_param *fault_param = group->dev->iommu->fault_param;
-
 	INIT_WORK(&group->work, iommu_sva_handle_iopf);
 	if (!queue_work(fault_param->queue->wq, &group->work))
 		return -EBUSY;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8020bb44a64ab1..e16fa9811d5023 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,7 @@ struct iommu_dirty_ops;
 struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
+struct iommu_fault_param;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -210,7 +211,8 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
-	int (*iopf_handler)(struct iopf_group *group);
+	int (*iopf_handler)(struct iommu_fault_param *fault_param,
+			    struct iopf_group *group);
 	void *fault_data;
 	union {
 		struct {
@@ -637,7 +639,7 @@ struct iommu_fault_param {
  */
 struct dev_iommu {
 	struct mutex lock;
-	struct iommu_fault_param	*fault_param;
+	struct iommu_fault_param __rcu	*fault_param;
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
