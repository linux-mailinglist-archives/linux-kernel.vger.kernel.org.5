Return-Path: <linux-kernel+bounces-93685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A6873342
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701AEB251B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF25FB81;
	Wed,  6 Mar 2024 09:58:22 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232A5C5E9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719102; cv=none; b=AKwrD4SfGRLFWS3rdixK3K/Csrnf0JZcX1rw8dEucBtmCMcaa39roAhReQXCsomBux3WGaV1HYGWbeje5SMw8wXbCmsOZ76LusHgUKGC2Gix/LQAGkgXOjXIus72SP9dPfdGNxESxHateGKYJONji4OT9r7YihbsFqWCF1sCLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719102; c=relaxed/simple;
	bh=F0VrgEoGn3VKVW7CjuxLe+mN+rspzZTMdmiYktONjv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ElU6tM4TrSvlR24aE7C/hcD3VcnY0FwgII2Nf5XFeMZZQDm7wcUQ0mKHXah5KstCh8Ok3b1XacS8zVR0WGdNmPcnzeuPZ0o4CF4WkUv1Ud3tk+PoXR7N28VYOHFFGPucDu5GboxHFfLtIXDAKxBJILnz9gFzs8/vy+/8+1ywpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709719089-086e23661a01e80001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id s9aSJHPSEpQwNNlP (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 06 Mar 2024 17:58:09 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Mar
 2024 17:58:08 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Mar
 2024 17:58:07 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <3d5254cf-27de-b689-352b-45698e265f5e@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Thu, 7 Mar 2024 01:58:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] USB:UAS:return ENODEV when submit urbs fail with
 device not attached
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v3] USB:UAS:return ENODEV when submit urbs fail with
 device not attached
To: Greg KH <gregkh@linuxfoundation.org>
CC: <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <usb-storage@lists.one-eyed-alien.net>,
	<WeitaoWang@zhaoxin.com>, <stable@vger.kernel.org>
References: <20240229193349.5407-1-WeitaoWang-oc@zhaoxin.com>
 <2024030530-trinity-triangle-c334@gregkh>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <2024030530-trinity-triangle-c334@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709719089
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2055
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121736
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/3/5 21:25, Greg KH wrote:
> 
> 
> On Fri, Mar 01, 2024 at 03:33:49AM +0800, Weitao Wang wrote:
>> In the scenario of entering hibernation with udisk in the system, if the
>> udisk was gone or resume fail in the thaw phase of hibernation. Its state
>> will be set to NOTATTACHED. At this point, usb_hub_wq was already freezed
>> and can't not handle disconnect event. Next, in the poweroff phase of
>> hibernation, SYNCHRONIZE_CACHE SCSI command will be sent to this udisk
>> when poweroff this scsi device, which will cause uas_submit_urbs to be
>> called to submit URB for sense/data/cmd pipe. However, these URBs will
>> submit fail as device was set to NOTATTACHED state. Then, uas_submit_urbs
>> will return a value SCSI_MLQUEUE_DEVICE_BUSY to the caller. That will lead
>> the SCSI layer go into an ugly loop and system fail to go into hibernation.
>>
>> On the other hand, when we specially check for -ENODEV in function
>> uas_queuecommand_lck, returning DID_ERROR to SCSI layer will cause device
>> poweroff fail and system shutdown instead of entering hibernation.
>>
>> To fix this issue, let uas_submit_urbs to return original generic error
>> when submitting URB failed. At the same time, we need to translate -ENODEV
>> to DID_NOT_CONNECT for the SCSI layer.
>>
>> Suggested-by: Oliver Neukum <oneukum@suse.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> ---
>> v2->v3
>>   - Modify the description of this patch.
>>   - An error is returned directly when submitting URB fails.
> 
> This change breaks the build, please be more careful'
> 
> drivers/usb/storage/uas.c: In function ‘uas_submit_urbs’:
> drivers/usb/storage/uas.c:559:21: error: unused variable ‘urb’ [-Werror=unused-variable]
>    559 |         struct urb *urb;
>       |                     ^~~
> 

I'm sorry for the carelessness. Now, I have removed this unused variable
and completed the compilation test. I'll resubmit this patch with a new version.

Thanks
weitao

