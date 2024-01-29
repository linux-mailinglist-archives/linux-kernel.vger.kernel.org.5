Return-Path: <linux-kernel+bounces-42790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9B8406D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D4DB23DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEED63138;
	Mon, 29 Jan 2024 13:25:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8562A03;
	Mon, 29 Jan 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534741; cv=none; b=HTEU/5XxnGfFkXRrbJJq3hPQ5ieOUEAG6p88LYHLcb3bDg6+6sAAHMEeA2aKKcQGi+lRl8/PE5mHhofdgNO2MnSebUQCcUhn0Jsp/jrxOVIazr+xkM7bQsNZvEwxn+j99/mascD97AxNmOHKfQGejtPJjZ5rF4hjcDKNfWi7wCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534741; c=relaxed/simple;
	bh=z5xE0fMmic6lVGkGXJwNakVx3vuTF4xsPryw28cimIk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B8NtZm15A9FWjDPdYMucfyKIYasElKZ0BSBJFnCgFHJDgSxfbQBz7OCK1S+53Tax7z2l3ciumqqoyf2Zad8R0zqXTl6NRk3CrUVFJFWfuzCL0AfkCK8z5/fgqJrnoqLhyfsl99GDQfibxUtBw/VUUwKVKv2rXfdUCU9t8JebNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TNpsX2BPHz1gy49;
	Mon, 29 Jan 2024 21:23:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id DB14E1A016B;
	Mon, 29 Jan 2024 21:25:32 +0800 (CST)
Received: from [10.67.120.153] (10.67.120.153) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 21:25:32 +0800
Subject: Re: [PATCH 2/3] crypto: hisilicon/qm - obtain stop queue status
To: liulongfang <liulongfang@huawei.com>, <herbert@gondor.apana.org.au>
References: <20240127131530.64617-1-qianweili@huawei.com>
 <20240127131530.64617-3-qianweili@huawei.com>
 <3d2359ad-e3c3-5e77-ae77-c824b1ef9f9a@huawei.com>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Weili Qian <qianweili@huawei.com>
Message-ID: <491abb79-0d4e-418c-b24a-ce5f9607a7a6@huawei.com>
Date: Mon, 29 Jan 2024 21:25:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3d2359ad-e3c3-5e77-ae77-c824b1ef9f9a@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)



On 2024/1/29 10:40, liulongfang wrote:
> On 2024/1/27 21:15, Weili Qian wrote:
>> The debugfs files 'dev_state' and 'dev_timeout' are added.
>> Users can query the current queue stop status through these two
>> files. And set the waiting timeout when the queue is released.
>>
>> dev_state: if dev_timeout is set, dev_state indicates the status
>> of stopping the queue. 0 indicates that the queue is stopped
>> successfully. Other values indicate that the queue stops fail.
>> if dev_timeout is not set, the value of dev_state is 0;
>>
>> dev_timeout: If the queue fails to stop, the queue is released
>> after waiting dev_timeout * 20ms.
>>
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> ---
>>  Documentation/ABI/testing/debugfs-hisi-hpre | 15 ++++
>>  Documentation/ABI/testing/debugfs-hisi-sec  | 15 ++++
>>  Documentation/ABI/testing/debugfs-hisi-zip  | 15 ++++
>>  drivers/crypto/hisilicon/debugfs.c          |  5 ++
>>  drivers/crypto/hisilicon/qm.c               | 97 +++++++++++++++------
>>  include/linux/hisi_acc_qm.h                 | 14 +++
>>  6 files changed, 135 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
>> index 6ed9258605c7..e6394a2fb371 100644
>> --- a/Documentation/ABI/testing/debugfs-hisi-hpre
>> +++ b/Documentation/ABI/testing/debugfs-hisi-hpre
>> @@ -118,6 +118,21 @@ Description:	Dump the state of the device.
>>  		0: busy, 1: idle.
>>  		Only available for PF, and take no other effect on HPRE.
>>  
>> +What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/dev_timeout
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Set the wait time when stop queue fails. Available for both PF
>> +		and VF, and take no other effect on HPRE.
>> +		0: not wait(default), others value: wait dev_timeout * 20 microsecond.
>> +
>> +What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/dev_state
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Dump the stop queue status of the QM. The default value is 0,
>> +		if dev_timeout is set, when stop queue fails, the dev_state
>> +		will return non-zero value. Available for both PF and VF,
>> +		and take no other effect on HPRE.
>> +
>>  What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/diff_regs
>>  Date:		Mar 2022
>>  Contact:	linux-crypto@vger.kernel.org
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
>> index 403f5de96318..2b5db193b5e6 100644
>> --- a/Documentation/ABI/testing/debugfs-hisi-sec
>> +++ b/Documentation/ABI/testing/debugfs-hisi-sec
>> @@ -98,6 +98,21 @@ Description:	Dump the state of the device.
>>  		0: busy, 1: idle.
>>  		Only available for PF, and take no other effect on SEC.
>>  
>> +What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/dev_timeout
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Set the wait time when stop queue fails. Available for both PF
>> +		and VF, and take no other effect on SEC.
>> +		0: not wait(default), others value: wait dev_timeout * 20 microsecond.
>> +
>> +What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/dev_state
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Dump the stop queue status of the QM. The default value is 0,
>> +		if dev_timeout is set, when stop queue fails, the dev_state
>> +		will return non-zero value. Available for both PF and VF,
>> +		and take no other effect on SEC.
>> +
>>  What:		/sys/kernel/debug/hisi_sec2/<bdf>/sec_dfx/diff_regs
>>  Date:		Mar 2022
>>  Contact:	linux-crypto@vger.kernel.org
>> diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
>> index 2394e6a3cfe2..260c514e0e9e 100644
>> --- a/Documentation/ABI/testing/debugfs-hisi-zip
>> +++ b/Documentation/ABI/testing/debugfs-hisi-zip
>> @@ -111,6 +111,21 @@ Description:	Dump the state of the device.
>>  		0: busy, 1: idle.
>>  		Only available for PF, and take no other effect on ZIP.
>>  
>> +What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/dev_timeout
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Set the wait time when stop queue fails. Available for both PF
>> +		and VF, and take no other effect on ZIP.
>> +		0: not wait(default), others value: wait dev_timeout * 20 microsecond.
>> +
>> +What:		/sys/kernel/debug/hisi_zip/<bdf>/qm/dev_state
>> +Date:		Jan 2024
>> +Contact:	linux-crypto@vger.kernel.org
>> +Description:	Dump the stop queue status of the QM. The default value is 0,
>> +		if dev_timeout is set, when stop queue fails, the dev_state
>> +		will return non-zero value. Available for both PF and VF,
>> +		and take no other effect on ZIP.
>> +
>>  What:		/sys/kernel/debug/hisi_zip/<bdf>/zip_dfx/diff_regs
>>  Date:		Mar 2022
>>  Contact:	linux-crypto@vger.kernel.org
>> diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
>> index 06e67eda409f..cd67fa348ca7 100644
>> --- a/drivers/crypto/hisilicon/debugfs.c
>> +++ b/drivers/crypto/hisilicon/debugfs.c
>> @@ -1112,6 +1112,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(qm_atomic64_ops, qm_debugfs_atomic64_get,
>>  void hisi_qm_debug_init(struct hisi_qm *qm)
>>  {
>>  	struct dfx_diff_registers *qm_regs = qm->debug.qm_diff_regs;
>> +	struct qm_dev_dfx *dev_dfx = &qm->debug.dev_dfx;
>>  	struct qm_dfx *dfx = &qm->debug.dfx;
>>  	struct dentry *qm_d;
>>  	void *data;
>> @@ -1140,6 +1141,10 @@ void hisi_qm_debug_init(struct hisi_qm *qm)
>>  
>>  	debugfs_create_file("status", 0444, qm->debug.qm_d, qm,
>>  			&qm_status_fops);
>> +
>> +	debugfs_create_u32("dev_state", 0444, qm->debug.qm_d, &dev_dfx->dev_state);
>> +	debugfs_create_u32("dev_timeout", 0644, qm->debug.qm_d, &dev_dfx->dev_timeout);
>> +
>>  	for (i = 0; i < ARRAY_SIZE(qm_dfx_files); i++) {
>>  		data = (atomic64_t *)((uintptr_t)dfx + qm_dfx_files[i].offset);
>>  		debugfs_create_file(qm_dfx_files[i].name,
>> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
>> index 3b015482b4e6..75d0b2ea117e 100644
>> --- a/drivers/crypto/hisilicon/qm.c
>> +++ b/drivers/crypto/hisilicon/qm.c
>> @@ -2037,43 +2037,25 @@ static void qp_stop_fail_cb(struct hisi_qp *qp)
>>  	}
>>  }
>>  
>> -/**
>> - * qm_drain_qp() - Drain a qp.
>> - * @qp: The qp we want to drain.
>> - *
>> - * Determine whether the queue is cleared by judging the tail pointers of
>> - * sq and cq.
>> - */
>> -static int qm_drain_qp(struct hisi_qp *qp)
>> +static int qm_wait_qp_empty(struct hisi_qm *qm, u32 *state, u32 qp_id)
>>  {
>> -	struct hisi_qm *qm = qp->qm;
>>  	struct device *dev = &qm->pdev->dev;
>>  	struct qm_sqc sqc;
>>  	struct qm_cqc cqc;
>>  	int ret, i = 0;
>>  
>> -	/* No need to judge if master OOO is blocked. */
>> -	if (qm_check_dev_error(qm))
>> -		return 0;
>> -
>> -	/* Kunpeng930 supports drain qp by device */
>> -	if (test_bit(QM_SUPPORT_STOP_QP, &qm->caps)) {
>> -		ret = qm_stop_qp(qp);
>> -		if (ret)
>> -			dev_err(dev, "Failed to stop qp(%u)!\n", qp->qp_id);
>> -		return ret;
>> -	}
>> -
>>  	while (++i) {
>> -		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp->qp_id, 1);
>> +		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp_id, 1);
>>  		if (ret) {
>>  			dev_err_ratelimited(dev, "Failed to dump sqc!\n");
>> +			*state = DUMP_SQC_FAIL;
>>  			return ret;
>>  		}
>>  
>> -		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp->qp_id, 1);
>> +		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp_id, 1);
>>  		if (ret) {
>>  			dev_err_ratelimited(dev, "Failed to dump cqc!\n");
>> +			*state = DUMP_CQC_FAIL;
>>  			return ret;
>>  		}
>>  
>> @@ -2082,8 +2064,9 @@ static int qm_drain_qp(struct hisi_qp *qp)
>>  			break;
>>  
>>  		if (i == MAX_WAIT_COUNTS) {
>> -			dev_err(dev, "Fail to empty queue %u!\n", qp->qp_id);
>> -			return -EBUSY;
>> +			dev_err(dev, "Fail to empty queue %u!\n", qp_id);
>> +			*state = STOP_QUEUE_FAIL;
>> +			return -ETIMEDOUT;
>>  		}
>>  
>>  		usleep_range(WAIT_PERIOD_US_MIN, WAIT_PERIOD_US_MAX);
>> @@ -2092,6 +2075,49 @@ static int qm_drain_qp(struct hisi_qp *qp)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * qm_drain_qp() - Drain a qp.
>> + * @qp: The qp we want to drain.
>> + *
>> + * If the device does not support stopping queue by sending mailbox,
>> + * determine whether the queue is cleared by judging the tail pointers of
>> + * sq and cq.
>> + */
>> +static int qm_drain_qp(struct hisi_qp *qp)
>> +{
>> +	struct hisi_qm *qm = qp->qm;
>> +	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
>> +	u32 state = 0;
>> +	int ret;
>> +
>> +	/* No need to judge if master OOO is blocked. */
>> +	if (qm_check_dev_error(pf_qm))
>> +		return 0;
>> +
>> +	/* HW V3 supports drain qp by device */
>> +	if (test_bit(QM_SUPPORT_STOP_QP, &qm->caps)) {
>> +		ret = qm_stop_qp(qp);
>> +		if (ret) {
>> +			dev_err(&qm->pdev->dev, "Failed to stop qp!\n");
>> +			state = STOP_QUEUE_FAIL;
>> +			goto set_dev_state;
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	ret = qm_wait_qp_empty(qm, &state, qp->qp_id);
>> +	if (ret)
>> +		goto set_dev_state;
>> +
>> +	return 0;
>> +
>> +set_dev_state:
>> +	if (qm->debug.dev_dfx.dev_timeout)
>> +		qm->debug.dev_dfx.dev_state = state;
>> +
>> +	return ret;
>> +}
>> +
>>  static int qm_stop_qp_nolock(struct hisi_qp *qp)
>>  {
>>  	struct hisi_qm *qm = qp->qm;
>> @@ -2319,7 +2345,26 @@ static int hisi_qm_uacce_start_queue(struct uacce_queue *q)
>>  
>>  static void hisi_qm_uacce_stop_queue(struct uacce_queue *q)
>>  {
>> -	hisi_qm_stop_qp(q->priv);
>> +	struct hisi_qp *qp = q->priv;
>> +	struct hisi_qm *qm = qp->qm;
>> +	struct qm_dev_dfx *dev_dfx = &qm->debug.dev_dfx;
>> +	u32 i = 0;
>> +
>> +	hisi_qm_stop_qp(qp);
>> +
>> +	if (!dev_dfx->dev_timeout || !dev_dfx->dev_state)
>> +		return;
>> +
>> +	while (++i) {
>> +		if (!i || i > dev_dfx->dev_timeout) {
> 
> 
> The "!i" judgment here is redundant. What needs to be considered is the situation
> if i is equal to dev_timeout and both are UINT_MAX.
> 
> Thanks,
> Longfang.

Thanks for the catch.I will send v2 to modify it.

Thanks,
Weili

> 
>> +			dev_err(&qm->pdev->dev, "Stop q %u timeout, state %u\n",
>> +			       qp->qp_id, dev_dfx->dev_state);
>> +			dev_dfx->dev_state = FINISH_WAIT;
>> +			break;
>> +		}
>> +
>> +		msleep(WAIT_PERIOD);
>> +	}
>>  }
>>  
>>  static int hisi_qm_is_q_updated(struct uacce_queue *q)
>> diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
>> index 720f10874a66..ec5a70ade511 100644
>> --- a/include/linux/hisi_acc_qm.h
>> +++ b/include/linux/hisi_acc_qm.h
>> @@ -158,6 +158,19 @@ enum qm_cap_bits {
>>  	QM_SUPPORT_RPM,
>>  };
>>  
>> +enum qm_dev_fail_state {
>> +	STOP_QUEUE_FAIL = 1,
>> +	ALLOC_CTX_FAIL,
>> +	DUMP_SQC_FAIL,
>> +	DUMP_CQC_FAIL,
>> +	FINISH_WAIT,
>> +};
>> +
>> +struct qm_dev_dfx {
>> +	u32 dev_state;
>> +	u32 dev_timeout;
>> +};
>> +
>>  struct qm_dev_alg {
>>  	u64 alg_msk;
>>  	const char *alg;
>> @@ -191,6 +204,7 @@ struct qm_debug {
>>  	struct dentry *debug_root;
>>  	struct dentry *qm_d;
>>  	struct debugfs_file files[DEBUG_FILE_NUM];
>> +	struct qm_dev_dfx dev_dfx;
>>  	unsigned int *qm_last_words;
>>  	/* ACC engines recoreding last regs */
>>  	unsigned int *last_words;
>>
> .
> 

