Return-Path: <linux-kernel+bounces-44568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE284244E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AFEB25326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D167E68;
	Tue, 30 Jan 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UiwTFrlw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CE67E60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616195; cv=none; b=ue3iAejXUGPycyD5wwd531+hhCEAv69ZnN6vdjkjGzAj3lJuu0VfEiHXZedAJD+IGNF8dbk9Q/eIcaD95WhKBV0xdJ9WwwD/+zG7h6OaNb2WWvcFKbQ1LXt6of3jdy/fyO+QOp8SMZNVtMqbfO/RToZmS2R5G7Hztn8X6Cem97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616195; c=relaxed/simple;
	bh=tlA+jX2+X0ES44mMmHrP5toU5J4qr+/mnhjLIXFD7Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mArbMbYL6iVJsffnKPM8k9HU3djnF6tDDzPJ5Yb2bRFPeaMZiHMfQXzILzEJgFEYrRBi6QRCE4Q0XwD9lB4UgqJyreqgfs8EZE8Kbaop4XqnwPy2bFAMaVVZQmN4alEVrAyP1x6biEMYbnpbQcSKq5zzygRgSfBhFif9srs7ZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UiwTFrlw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UBgeKH021039;
	Tue, 30 Jan 2024 12:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VKY6PLreTsAeAlCJB7PUV8RRSGH/npEjFNI8hoSFBMg=; b=Ui
	wTFrlwQMi0ohSfLbokGQCilqFKIv6dT2sks1Pa3DjevEbK7twZ5D6oL/FXBZ5hps
	/fQUPrtiTLzK1yczqTHUeiOykAmnyGybZVO5KyBBsOxVURJvg4dbAeSWlhdlqs/y
	UY0EmpHG6M514eV3AUj+kf8fQFhFwe5ab5aOBq+kBqZeD2nWd9Vs+RVxQGFeXKxq
	T8J9/wo4UJHe7RDSLHjEmdAYaWXjdqhins01AA6vsaLdEdSPIHIXdDP9aQsB/rH1
	pw8wTp+xYdQ9qnZp7Rfqos8IhOfU6rT8OsgJ/MDRS+5FED3FUUUJ9xuv8p7VkuJM
	NzoJc39T12jRiRlb+2Og==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvwqrh1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 12:03:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UC2Uwi031462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 12:02:30 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 04:02:28 -0800
Message-ID: <e356adc5-937f-08ba-68bc-975ef96d6332@quicinc.com>
Date: Tue, 30 Jan 2024 17:32:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] devcoredump: Remove the mutex serialization
Content-Language: en-US
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose
 Souza <jose.souza@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <20240126151121.1076079-2-rodrigo.vivi@intel.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240126151121.1076079-2-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VpHlM8TKJ286BWm3Tf0EbiMGHsxCPb_s
X-Proofpoint-GUID: VpHlM8TKJ286BWm3Tf0EbiMGHsxCPb_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300088



On 1/26/2024 8:41 PM, Rodrigo Vivi wrote:
> The commit 01daccf74832 ("devcoredump : Serialize devcd_del work")
> introduced the mutex to protect the case where mod_delayed_work
> could be called before the delayed work even existed.
> 
> Instead, we can simply initialize the delayed work before the device
> is added, so the race condition doesn't exist at first place.
> 
> The mutex_unlock is very problematic here. Although mod_delayed_work
> is async, we have no warranty that the work is not finished before
> the mutex_unlock(devcd->mutex), and if that happen 'devcd' is used
> after freed.

I agree, Mutex is bad and last time there was only a situation of UAF 
from disable_store() and that can not occur as it keeps its ref, so
we went ahead with the change.,

> 
> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jose Souza <jose.souza@intel.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   drivers/base/devcoredump.c | 97 +++-----------------------------------
>   1 file changed, 6 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 678ecc2fa242..0e26b1273920 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -25,47 +25,6 @@ struct devcd_entry {
>   	struct device devcd_dev;
>   	void *data;
>   	size_t datalen;
> -	/*
> -	 * Here, mutex is required to serialize the calls to del_wk work between
> -	 * user/kernel space which happens when devcd is added with device_add()
> -	 * and that sends uevent to user space. User space reads the uevents,
> -	 * and calls to devcd_data_write() which try to modify the work which is
> -	 * not even initialized/queued from devcoredump.
> -	 *
> -	 *
> -	 *
> -	 *        cpu0(X)                                 cpu1(Y)
> -	 *
> -	 *        dev_coredump() uevent sent to user space
> -	 *        device_add()  ======================> user space process Y reads the
> -	 *                                              uevents writes to devcd fd
> -	 *                                              which results into writes to
> -	 *
> -	 *                                             devcd_data_write()
> -	 *                                               mod_delayed_work()
> -	 *                                                 try_to_grab_pending()
> -	 *                                                   del_timer()
> -	 *                                                     debug_assert_init()
> -	 *       INIT_DELAYED_WORK()
> -	 *       schedule_delayed_work()
> -	 *
> -	 *
> -	 * Also, mutex alone would not be enough to avoid scheduling of
> -	 * del_wk work after it get flush from a call to devcd_free()
> -	 * mentioned as below.
> -	 *
> -	 *	disabled_store()
> -	 *        devcd_free()
> -	 *          mutex_lock()             devcd_data_write()
> -	 *          flush_delayed_work()
> -	 *          mutex_unlock()
> -	 *                                   mutex_lock()
> -	 *                                   mod_delayed_work()
> -	 *                                   mutex_unlock()
> -	 * So, delete_work flag is required.
> -	 */
> -	struct mutex mutex;
> -	bool delete_work;
>   	struct module *owner;
>   	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>   			void *data, size_t datalen);
> @@ -125,13 +84,8 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> -	mutex_lock(&devcd->mutex);
> -	if (!devcd->delete_work) {
> -		devcd->delete_work = true;
> -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> -	}
> -	mutex_unlock(&devcd->mutex);
> -
> +	/* This file needs to be closed before devcd can be deleted */
> +	mod_delayed_work(system_wq, &devcd->del_wk, 0);
>   	return count;
>   }
>   
> @@ -158,12 +112,7 @@ static int devcd_free(struct device *dev, void *data)
>   {
>   	struct devcd_entry *devcd = dev_to_devcd(dev);
>   
> -	mutex_lock(&devcd->mutex);
> -	if (!devcd->delete_work)
> -		devcd->delete_work = true;
> -
>   	flush_delayed_work(&devcd->del_wk);
> -	mutex_unlock(&devcd->mutex);
>   	return 0;
>   }
>   
> @@ -173,30 +122,6 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
>   	return sysfs_emit(buf, "%d\n", devcd_disabled);
>   }
>   
> -/*
> - *
> - *	disabled_store()                                	worker()
> - *	 class_for_each_device(&devcd_class,
> - *		NULL, NULL, devcd_free)
> - *         ...
> - *         ...
> - *	   while ((dev = class_dev_iter_next(&iter))
> - *                                                             devcd_del()
> - *                                                               device_del()
> - *                                                                 put_device() <- last reference
> - *             error = fn(dev, data)                           devcd_dev_release()
> - *             devcd_free(dev, data)                           kfree(devcd)
> - *             mutex_lock(&devcd->mutex);
> - *
> - *
> - * In the above diagram, It looks like disabled_store() would be racing with parallely
> - * running devcd_del() and result in memory abort while acquiring devcd->mutex which
> - * is called after kfree of devcd memory  after dropping its last reference with
> - * put_device(). However, this will not happens as fn(dev, data) runs
> - * with its own reference to device via klist_node so it is not its last reference.
> - * so, above situation would not occur.
> - */
> -
>   static ssize_t disabled_store(const struct class *class, const struct class_attribute *attr,
>   			      const char *buf, size_t count)
>   {
> @@ -308,13 +233,7 @@ static void devcd_remove(void *data)
>   {
>   	struct devcd_entry *devcd = data;
>   
> -	mutex_lock(&devcd->mutex);
> -	if (!devcd->delete_work) {
> -		devcd->delete_work = true;
> -		/* XXX: Cannot flush otherwise the mutex below will hit a UAF */
> -		mod_delayed_work(system_wq, &devcd->del_wk, 0);
> -	}
> -	mutex_unlock(&devcd->mutex);
> +	flush_delayed_work(&devcd->del_wk);
>   }
>   
>   /**
> @@ -365,16 +284,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   	devcd->read = read;
>   	devcd->free = free;
>   	devcd->failing_dev = get_device(dev);
> -	devcd->delete_work = false;
>   
> -	mutex_init(&devcd->mutex);
>   	device_initialize(&devcd->devcd_dev);
>   
>   	dev_set_name(&devcd->devcd_dev, "devcd%d",
>   		     atomic_inc_return(&devcd_count));
>   	devcd->devcd_dev.class = &devcd_class;
>   
> -	mutex_lock(&devcd->mutex);
> +	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> +	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);

Last time, we discussed [1] here, involves a assumption
about timeout can not happen before device_add() succeeds.
It is rare but it is there.

https://lore.kernel.org/all/87ilr15ekx.ffs@tglx/

-Mukesh

>   	dev_set_uevent_suppress(&devcd->devcd_dev, true);
>   	if (device_add(&devcd->devcd_dev))
>   		goto put_device;
> @@ -392,15 +310,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   
>   	dev_set_uevent_suppress(&devcd->devcd_dev, false);
>   	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> -	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
>   	if (devm_add_action(dev, devcd_remove, devcd))
>   		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
> -	mutex_unlock(&devcd->mutex);
>   	return;
>    put_device:
> +	cancel_delayed_work(&devcd->del_wk);
>   	put_device(&devcd->devcd_dev);
> -	mutex_unlock(&devcd->mutex);
>    put_module:
>   	module_put(owner);
>    free:

