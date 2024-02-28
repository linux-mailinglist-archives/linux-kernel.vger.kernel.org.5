Return-Path: <linux-kernel+bounces-85187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B186B1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDA81F279C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1D159574;
	Wed, 28 Feb 2024 14:33:02 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC237140
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130782; cv=none; b=Ut0ZuNbeZb7wYsMNKNhXX5PSxu6FAiogX0PuVuO8JRx9G44jQBNFtuyi/whLYTfDf6d04XyBejv58AXQpTWhsMyuJQEIuMU6ro5O1oJ84iqXVhYACuGgoUrqwRfz438WyxCyERBtt9+ksnDJddQTf4ismjhpz5da23JpEdEVHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130782; c=relaxed/simple;
	bh=wqoB8zcfxjW73Uldj3tr5z78Zp+ZJv8D2kVrXyMTshI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xie9Elhqnal/n2f2jpGSMTAkSZ9w2dVT2eoo6JfGQhfJ6XFz6osn5LB4Pyt6F9IBne7YsjmV9MOU36zAiwIvICGYrbVuysOILc+K8Kd9sa89EHyXhRW5NKuB1E3cErh73rgq8FDSoOcY8hOGr6/O2lC99Ad9v2LEfhQo+Dc1T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709130771-1eb14e0c7e4c120001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id wblIV0teK9jWjlKG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Feb 2024 22:32:51 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Feb
 2024 22:32:51 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Feb
 2024 22:32:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Thu, 29 Feb 2024 06:32:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with
 device not attached.
To: Oliver Neukum <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>
CC: <WeitaoWang@zhaoxin.com>, <stable@vger.kernel.org>
References: <20240228111521.3864-1-WeitaoWang-oc@zhaoxin.com>
 <e8c4e8a3-bfc3-463f-afce-b9f600b588b2@suse.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <e8c4e8a3-bfc3-463f-afce-b9f600b588b2@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709130771
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2490
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121446
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/2/28 16:00, Oliver Neukum wrote:
> 
>> @@ -562,9 +561,9 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
>>
>>       lockdep_assert_held(&devinfo->lock);
>>       if (cmdinfo->state & SUBMIT_STATUS_URB) {
>> -             urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
>> -             if (!urb)
>> -                     return SCSI_MLQUEUE_DEVICE_BUSY;
>> +             err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
>> +             if (err)
>> +                     return (err == -ENODEV) ? -ENODEV : SCSI_MLQUEUE_DEVICE_BUSY;
> 
> Either we ought to use SCSI error codes or generic error codes.
> There is no need to translate all but one error condition here.
> 

  static int uas_submit_urbs(struct scsi_cmnd *cmnd,
@@ -562,10 +561,13 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,

  	lockdep_assert_held(&devinfo->lock);
  	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (!err)
+			cmdinfo->state &= ~SUBMIT_STATUS_URB;
+		else if (err == -ENODEV)
+			return -ENODEV;
+		else
  			return SCSI_MLQUEUE_DEVICE_BUSY;
-		cmdinfo->state &= ~SUBMIT_STATUS_URB;
  	}

  	if (cmdinfo->state & ALLOC_DATA_IN_URB) {
@@ -582,6 +584,8 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->data_in_urb);
  			uas_log_cmd_state(cmnd, "data in submit err", err);
+			if (err == -ENODEV)
+				return -ENODEV;
  			return SCSI_MLQUEUE_DEVICE_BUSY;
  		}
  		cmdinfo->state &= ~SUBMIT_DATA_IN_URB;
@@ -602,6 +606,8 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->data_out_urb);
  			uas_log_cmd_state(cmnd, "data out submit err", err);
+			if (err == -ENODEV)
+				return -ENODEV;
  			return SCSI_MLQUEUE_DEVICE_BUSY;
  		}
  		cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
@@ -621,6 +627,8 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->cmd_urb);
  			uas_log_cmd_state(cmnd, "cmd submit err", err);
+			if (err == -ENODEV)
+				return -ENODEV;
  			return SCSI_MLQUEUE_DEVICE_BUSY;
  		}

I'm not sure I fully understand what your mean.
Whether the above code is more reasonable? If not,could you give me some
suggestion? Thanks for your help!

Weitao



