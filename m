Return-Path: <linux-kernel+bounces-86322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE2886C3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DE21C2231B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407C524B8;
	Thu, 29 Feb 2024 08:40:53 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61F4F205
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196053; cv=none; b=ulDq/p5U9u8QfZrtc8A6q6TMIBMBDHdoJCf+HQekiiOgE8hbbSw165MqxvrdWQXowpKmMDUISQgwWJHXmBlYIOgnoHSsjKe3r4P7EiotUTVp4JWhRGtUcG4VgVMPnZljgJALBWLxlKxT2Nx+wWNsJxvkmjRveuH14WXiCcI9+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196053; c=relaxed/simple;
	bh=FLBMpOnUYTtHFFdZlsSLuXW6H+PMwcHf+HhPg0BQiiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dcdJDY2SP3fFBwHPE7NO77R0FRGtjpqO5ERa4jAW3CYfGPjmWht2fwiz3FC05tqPm3KetvNGaDW1XYix/dWEDTMLdmymwXTsA+af2l5jZRIV1HNQhtw4MKgPq5mkzavxJIEMHzNm+SaImwokzZuB4wHwEijMxvrnlrTda2SMwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709196046-1eb14e0c7c4cd80001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id IFq8M5OlV5QskFli (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 29 Feb 2024 16:40:46 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 16:40:46 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 16:40:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <bb269ab0-128b-1988-acf1-8df05f08cf86@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Fri, 1 Mar 2024 00:40:43 +0800
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
 <07e80d55-d766-1781-ffc9-fab9ddcd33e3@zhaoxin.com>
 <49a365a7-199a-42cd-b8d3-86d72fe5bca6@suse.com>
 <0b0eefa5-71b6-dc08-d103-72b9aebd9237@zhaoxin.com>
 <9263b77e-9ebe-4987-bf7f-8f9fafcf06b3@suse.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <9263b77e-9ebe-4987-bf7f-8f9fafcf06b3@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1709196046
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4700
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121476
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/2/29 16:08, Oliver Neukum wrote:
> 

> On 29.02.24 12:19, WeitaoWang-oc@zhaoxin.com wrote:
> 
>> When alloc urb fail in the same function uas_submit_urbs,
>> whether we should replace SCSI_MLQUEUE_DEVICE_BUSY with generic
>> error code -ENOMEM? Such like this:
>>
>> @@ -572,7 +571,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
>>           cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
>>                               cmnd, DMA_FROM_DEVICE);
>>           if (!cmdinfo->data_in_urb)
>> -            return SCSI_MLQUEUE_DEVICE_BUSY;
>> +            return -ENOMEM;
>>           cmdinfo->state &= ~ALLOC_DATA_IN_URB;
>>       }
> 
> Hi,
> 
> yes, and then you translate in one central place for the SCSI layer
> into DID_ERROR or DID_NO_CONNECT.
> 

OK, I'll submit a new version after you help to review the following patch.


diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 9707f53cfda9..689396777b6f 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -533,7 +533,7 @@ static struct urb *uas_alloc_cmd_urb(struct uas_dev_info *devinfo, 
gfp_t gfp,
   * daft to me.
   */

-static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
+static int uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
  {
  	struct uas_dev_info *devinfo = cmnd->device->hostdata;
  	struct urb *urb;
@@ -541,16 +541,15 @@ static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, 
gfp_t gfp)

  	urb = uas_alloc_sense_urb(devinfo, gfp, cmnd);
  	if (!urb)
-		return NULL;
+		return -ENOMEM;
  	usb_anchor_urb(urb, &devinfo->sense_urbs);
  	err = usb_submit_urb(urb, gfp);
  	if (err) {
  		usb_unanchor_urb(urb);
  		uas_log_cmd_state(cmnd, "sense submit err", err);
  		usb_free_urb(urb);
-		return NULL;
  	}
-	return urb;
+	return err;
  }

  static int uas_submit_urbs(struct scsi_cmnd *cmnd,
@@ -562,9 +561,9 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,

  	lockdep_assert_held(&devinfo->lock);
  	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (err)
+			return err;
  		cmdinfo->state &= ~SUBMIT_STATUS_URB;
  	}

@@ -572,7 +571,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		cmdinfo->data_in_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
  							cmnd, DMA_FROM_DEVICE);
  		if (!cmdinfo->data_in_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
  		cmdinfo->state &= ~ALLOC_DATA_IN_URB;
  	}

@@ -582,7 +581,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->data_in_urb);
  			uas_log_cmd_state(cmnd, "data in submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
  		}
  		cmdinfo->state &= ~SUBMIT_DATA_IN_URB;
  		cmdinfo->state |= DATA_IN_URB_INFLIGHT;
@@ -592,7 +591,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		cmdinfo->data_out_urb = uas_alloc_data_urb(devinfo, GFP_ATOMIC,
  							cmnd, DMA_TO_DEVICE);
  		if (!cmdinfo->data_out_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
  		cmdinfo->state &= ~ALLOC_DATA_OUT_URB;
  	}

@@ -602,7 +601,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->data_out_urb);
  			uas_log_cmd_state(cmnd, "data out submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
  		}
  		cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
  		cmdinfo->state |= DATA_OUT_URB_INFLIGHT;
@@ -611,7 +610,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  	if (cmdinfo->state & ALLOC_CMD_URB) {
  		cmdinfo->cmd_urb = uas_alloc_cmd_urb(devinfo, GFP_ATOMIC, cmnd);
  		if (!cmdinfo->cmd_urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return -ENOMEM;
  		cmdinfo->state &= ~ALLOC_CMD_URB;
  	}

@@ -621,7 +620,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
  		if (err) {
  			usb_unanchor_urb(cmdinfo->cmd_urb);
  			uas_log_cmd_state(cmnd, "cmd submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return err;
  		}
  		cmdinfo->cmd_urb = NULL;
  		cmdinfo->state &= ~SUBMIT_CMD_URB;
@@ -698,7 +697,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
  	 * of queueing, no matter how fatal the error
  	 */
  	if (err == -ENODEV) {
-		set_host_byte(cmnd, DID_ERROR);
+		set_host_byte(cmnd, DID_NO_CONNECT);
  		scsi_done(cmnd);
  		goto zombie;
  	}

Thanks and best regards,
weitao

