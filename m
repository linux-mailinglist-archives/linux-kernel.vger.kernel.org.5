Return-Path: <linux-kernel+bounces-17261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83E8824A86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA501C228F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84A2C859;
	Thu,  4 Jan 2024 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTeEfE8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF62C84F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so145125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704405396; x=1705010196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12fLjY3V2aHyKRvHjCJjs0z1gfnzQU+/rSN+3Gfrkvk=;
        b=pTeEfE8vXUcWoXs3ogxKHhikjJHa2FKa9axR7mw4tATR0TprK2AfhQrknMhbdTAURL
         x6Kr4EInaYgtsudyposkgbnVLQHdyfqsuT1cpIMm/Js0D070Y2EVawJMmAVaqXaSCBZ9
         Q2IlOkX3Shnn3rmOLl7C6m85k1jTdid3k2WHPAmuiCRGQKFvTOygA8BkIb7dAIGqf1kD
         GMPGSRiFr1y+fGt84PAtJXeVcPtl9fPqw+MvaflGMgiawidKPZWR9Tn+rEMgeZNGrqGA
         CHmKsjaGHgiA9DwUrSisr946ZB4bQOJFeZie5l/Ph45QANvf9H6jVUK6JYtOPoC/YuOi
         QxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405396; x=1705010196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12fLjY3V2aHyKRvHjCJjs0z1gfnzQU+/rSN+3Gfrkvk=;
        b=S+vK5AyQczuDi7TAksF5TfE34hHZYX3LAzHmp5a2epZcrIxFJo/dpfemOV/byl15JK
         tJfD3kVAndSdpGO6+j9ZT6flI4lWnsCYQ/y/1G93DEj/TlGxtjsKAJtndd+s1/XCdjo7
         H1rZ1FUFrE2jpuXB/zNn6tjVIEsSLsRraxa0bmQV89a9hphfvZn8cS9au3vlkfMvMeT1
         PQfTKePj5jKbrrgQ7/SArDArt+BEFhAZmpbsHp9bbzLO6lHsylotGNxgc5wgjQLnh3ZG
         RARRHdIcgycffVY+L/0IdmxfADyit3hklF8+n2SymIjmaVpQt8bFQs9B2elXpBTHnGRN
         xxJg==
X-Gm-Message-State: AOJu0YwVoTJ7g/Q7KmkqNvl4pRYP1GvwVEgXNVObJPsAO1J5xulaOJa7
	iZohw9QcATkXP7JfW3J2H9WU8yAbbOI7
X-Google-Smtp-Source: AGHT+IG3ufCvOdqmgbI9rjYdydk7M56k37e9DHVhn/r+yDyUyqpkJTt3Auc0PidFKjW4wBoS0dhsgg==
X-Received: by 2002:a17:903:2448:b0:1d4:c44a:7644 with SMTP id l8-20020a170903244800b001d4c44a7644mr1654491pls.4.1704405396292;
        Thu, 04 Jan 2024 13:56:36 -0800 (PST)
Received: from [192.168.60.239] (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902aa4a00b001d3ee84ef0csm77598plr.235.2024.01.04.13.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:56:35 -0800 (PST)
Message-ID: <20c1e825-8e90-4874-bff0-0985649d333e@google.com>
Date: Thu, 4 Jan 2024 13:56:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: gadget: uvc: Fix use are free during STREAMOFF
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
 etalvala@google.com, jchowdhary@google.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20231215210746.821494-1-arakesh@google.com>
 <2024010450-humming-bullion-1af4@gregkh>
Content-Language: en-US
From: Avichal Rakesh <arakesh@google.com>
In-Reply-To: <2024010450-humming-bullion-1af4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for the review, Greg!

Sent out V2 with the comments addressed.

On 1/4/24 06:19, Greg KH wrote:
> On Fri, Dec 15, 2023 at 01:07:44PM -0800, Avichal Rakesh wrote:
>> There is a path that may lead to freed memory being referenced,
>> and causing kernel panics.
>>
>> The kernel panic has the following stack trace:
>>
>> Workqueue: uvcgadget uvcg_video_pump.c51fb85fece46625450f86adbf92c56c.cfi_jt
>> pstate: 60c00085 (nZCv daIf +PAN +UAO -TCO BTYPE=--)
>> pc : __list_del_entry_valid+0xc0/0xd4
>> lr : __list_del_entry_valid+0xc0/0xd4
>> Call trace:
>>   __list_del_entry_valid+0xc0/0xd4
>>   uvc_video_free_request+0x60/0x98
>>   uvcg_video_pump+0x1cc/0x204
>>   process_one_work+0x21c/0x4b8
>>   worker_thread+0x29c/0x574
>>   kthread+0x158/0x1b0
>>   ret_from_fork+0x10/0x30
>>
>> The root cause is that uvcg_video_usb_req_queue frees the uvc_request
>> if is_enabled is false and returns an error status. video_pump also
>> frees the associated request if uvcg_video_usb_req_queue returns an e
>> rror status, leading to double free and accessing garbage memory.
> 
> Odd line wrapping :(

Sigh! Fixed. Apologies.

> 
>>
>> To fix the issue, this patch removes freeing logic from
>> uvcg_video_usb_req_queue, and lets the callers to the function handle
>> queueing errors as they see fit.
>>
>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>> ---
>>  drivers/usb/gadget/function/uvc_video.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> What commit id does this fix?

The commit that caused the bug is not in linus' branch yet. Added
the "Fixes" tag with the commit SHA from usb-next branch. Let me know
if I should be using some other SHA.

> 
> 
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index 98ba524c27f5..e5db1be14ca3 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -277,8 +277,7 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
>>  	struct list_head *list = NULL;
>>  
>>  	if (!video->is_enabled) {
>> -		uvc_video_free_request(req->context, video->ep);
>> -		return -ENODEV;
>> +		return -EINVAL;
> 
> Isn't this a separate change?  And does it actually matter?

It was meant to differentiate between usb_ep_queue failing 
and the video stream being disabled, but we don't really
care about that. Reverted.

Thank you!

- Avi.

