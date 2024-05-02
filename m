Return-Path: <linux-kernel+bounces-166753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2978B9EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9F11C20B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714F16DEB2;
	Thu,  2 May 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NHzoKBIp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2D1E894;
	Thu,  2 May 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668945; cv=none; b=rfKlZt4yNnpbb6T6FbzgA5ijcNfbvy0d8Obo56oVoVVpx5N1BbK/f7kTWxR3LluVqoiUTxvUTdob8POZwBFszWIuifFyCoPy2LY9oZUs4F9dqb/ijm3mtIzJ/rBexF5T/MDXX67g5nLi4rvM2vanIh6igiizD9p8en6KMPtg6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668945; c=relaxed/simple;
	bh=NTiH9xtmjaaUSzcq1AeIlKIisEgq8Mn91h3eXZilv7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PP+4FWUinjq3j2NOKW5OR5WJd12uAGICIi+/Hsr7VJpQO4eqx+IHpXV7oRhnLYSH6qfmb+E+BWEXeTpNrb/XS8ddoeSpu5KRNRjBqJBAeYQ3uGEBFGbqMpTgrs8X0p5f3VH/qDEPvccx21yyXvy9wR8rW7ZVCn1SlnANH4uPaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NHzoKBIp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442FK5ke030693;
	Thu, 2 May 2024 16:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9o2BA+pquRrnaYiKJ2EhY+0yNfSzSbd9cIh0wfWqN9s=; b=NH
	zoKBIpJGfATl5cU+Sk9oQD4rEJ//FA9OCEhOd8Y8MrnqDLuhwK46ySI7TcPjoC/T
	/P+0898lmMgpkabRaEUG6FIefHeYblxKrliI/u6TfBL79SoRqTibPf/mnG5w0UkG
	1JPyumOW6QqwLRBzVJ+yA+J2BOzU/YsaIdDqDP8S9LEv17OTZad4SF+Z/8PlH9cr
	HwvhTpIvLhkX62hc5rf9rl46u5eILVykUDqjUsSgQvyGAvBIHq3GY1oOFtYRtJBy
	mHPNAWBTco6ezhrXlUeG2sHdxIxqcvkpvjhHTocQzHk0QOWMR9RF4MdXs8tmxkPx
	MAAR9bqJ/REOTJF5dBDQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xurt72n34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 16:55:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442GtYaB011441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 16:55:34 GMT
Received: from [10.253.39.74] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 09:55:32 -0700
Message-ID: <0acc171b-31d2-46e7-9156-d7d3432b1b22@quicinc.com>
Date: Fri, 3 May 2024 00:55:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: cdev: Fix use after free in
 lineinfo_changed_notify
To: Kent Gibson <warthog618@gmail.com>
CC: <brgl@bgdev.pl>, <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
References: <20240501022612.1787143-1-quic_zhonhan@quicinc.com>
 <20240502015122.GA15967@rigel>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <20240502015122.GA15967@rigel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9LM3uz8yI3dRjx6VPy0W5ZP3WzJcuw6e
X-Proofpoint-ORIG-GUID: 9LM3uz8yI3dRjx6VPy0W5ZP3WzJcuw6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_08,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020111

On 5/2/2024 9:51 AM, Kent Gibson wrote:
> On Wed, May 01, 2024 at 10:26:12AM +0800, Zhongqiu Han wrote:
>> The use-after-free issue occurs when userspace closes the GPIO chip device
>> file (e.g., "/dev/gpiochip0") by invoking gpio_chrdev_release(), while one
>> of its GPIO lines is simultaneously being released. In a stress test
>> scenario, stress-ng tool starts multi stress-ng-dev threads to continuously
>> open and close device file in the /dev, the use-after-free issue will occur
>> with a low reproducibility.
> 
> This could be clearer.  Use-after-free of what?  We don't find out it is
> the watched_lines bitmap until much later...
> 

Hi Kent,
Thanks a lot for the review, I will take care of this on v2 and plan to
verify it as follows:

The use-after-free issue occurs as follows: when the GPIO chip device
file is being closed by invoking gpio_chrdev_release(), watched_lines is
freed by bitmap_free(), but the unregistration of lineinfo_changed_nb
notifier chain failed due to waiting write rwsem. Additionally, one of
the GPIO chip's lines is also in the release process and holds the
notifier chain's read rwsem. Consequently, a race condition leads to the
use-after-free of watched_lines.

>>
>> Here is the typical stack when issue happened:
>>
> 
> This stack trace is excessive [1].
> 
Acknowledged. I will drop it.

>> BUG: KASAN: slab-use-after-free in lineinfo_changed_notify+0x84/0x1bc
>> Read of size 8 at addr ffffff803c06e840 by task stress-ng-dev/5437
>> Call trace:
>>   dump_backtrace
>>   show_stack
>>   dump_stack_lvl
>>   print_report
>>   kasan_report
>>   __asan_load8
>>   lineinfo_changed_notify
>>   notifier_call_chain
>>   blocking_notifier_call_chain
>>   gpiod_free_commit
>>   gpiod_free
>>   gpio_free
>>   st54spi_gpio_dev_release
>>   __fput
>>   __fput_sync
>>   __arm64_sys_close
>>   invoke_syscall
>>   el0_svc_common
>>   do_el0_svc
>>   el0_svc
>>   el0t_64_sync_handler
>>   el0t_64_sync
>> Allocated by task 5425:
>>   kasan_set_track
>>   kasan_save_alloc_info
>>   __kasan_kmalloc
>>   __kmalloc
>>   bitmap_zalloc
>>   gpio_chrdev_open
>>   chrdev_open
>>   do_dentry_open
>>   vfs_open
>>   path_openat
>>   do_filp_open
>>   do_sys_openat2
>>   __arm64_sys_openat
>>   invoke_syscall
>>   el0_svc_common
>>   do_el0_svc
>>   el0_svc
>>   el0t_64_sync_handler
>>   el0t_64_sync
>> Freed by task 5425:
>>   kasan_set_track
>>   kasan_save_free_info
>>   ____kasan_slab_free
>>   __kasan_slab_free
>>   slab_free_freelist_hook
>>   __kmem_cache_free
>>   kfree
>>   bitmap_free
>>   gpio_chrdev_release
>>   __fput
>>   __fput_sync
>>   __arm64_sys_close
>>   invoke_syscall
>>   el0_svc_common
>>   do_el0_svc
>>   el0_svc
>>   el0t_64_sync_handler
>>   el0t_64_sync
>>
>> The use-after-free issue occurs as follows: watched_lines is freed by
>> bitmap_free(), but the lineinfo_changed_nb notifier chain cannot be
>> successfully unregistered due to waiting write rwsem when closing the
>> GPIO chip device file. Additionally, one of the GPIO chip's lines is
>> also in the release process and holds the notifier chain's read rwsem.
>> Consequently, a race condition leads to the use-after-free of
>> watched_lines.
>>
> 
> Drop the stack trace above and rework this paragraph into the opening
> paragraph.
> 

Yes, I will drop the stack above and rework this paragraph into
opening paragraph. Like the first comments reply.


> Might be good to note the side effects of the use-after-free.
> AFAICT it may only result in an event being generated for userspace where
> it shouldn't.  But, as the chrdev is being closed, userspace wont have the
> chance to read that event anyway, so no appreciable difference?
> 

Yes, there is no NULL access issue because there doesn't set
watched_lines = NULL; after bitmap_free, I also think it can only cause
the unexpected event is being generated. I will take care of it on v2.


>> [free]
>> gpio_chrdev_release()
>>    --> bitmap_free(cdev->watched_lines)                  <-- freed
>>    --> blocking_notifier_chain_unregister()
>>      --> down_write(&nh->rwsem)                          <-- waiting rwsem
>>            --> __down_write_common()
>>              --> rwsem_down_write_slowpath()
>>                    --> schedule_preempt_disabled()
>>                      --> schedule()
>>
>> [use]
>> st54spi_gpio_dev_release()
>>    --> gpio_free()
>>      --> gpiod_free()
>>        --> gpiod_free_commit()
>>          --> gpiod_line_state_notify()
>>            --> blocking_notifier_call_chain()
>>              --> down_read(&nh->rwsem);                  <-- held rwsem
>>              --> notifier_call_chain()
>>                --> lineinfo_changed_notify()
>>                  --> test_bit(xxxx, cdev->watched_lines) <-- use after free
>>
>> To fix this issue, call the bitmap_free() function after successfully
>  > "successfully" is confusing here as there is no unsuccessfully.
> 

Acknowledged. I plan to verify it as follows:

To fix this issue, call the bitmap_free() function after
blocking_notifier_chain_unregister.

>> unregistering the notifier chain. This prevents lineinfo_changed_notify()
>> from being called, thus avoiding the use-after-free race condition.
> 
> The final sentence doesn't add anything - the reorder fixing the problem
> is clear enough.
> 

Acknowledged. I will remove it.

>>
>> Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   drivers/gpio/gpiolib-cdev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
>> index d09c7d728365..6b3a43e3ba47 100644
>> --- a/drivers/gpio/gpiolib-cdev.c
>> +++ b/drivers/gpio/gpiolib-cdev.c
>> @@ -2799,11 +2799,11 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
>>   	struct gpio_chardev_data *cdev = file->private_data;
>>   	struct gpio_device *gdev = cdev->gdev;
>>
>> -	bitmap_free(cdev->watched_lines);
>>   	blocking_notifier_chain_unregister(&gdev->device_notifier,
>>   					   &cdev->device_unregistered_nb);
>>   	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
>>   					   &cdev->lineinfo_changed_nb);
>> +	bitmap_free(cdev->watched_lines);
>>   	gpio_device_put(gdev);
>>   	kfree(cdev);
>>
> 
> No problem with the code change - makes total sense.
> 
Thanks for the review.

> Cheers,
> Kent.
> 
> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

-- 
Thx and BRs,
Zhongqiu Han


