Return-Path: <linux-kernel+bounces-89979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AA86F892
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215411C20C07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866F23BF;
	Mon,  4 Mar 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmHVL+am"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20D15D1;
	Mon,  4 Mar 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519385; cv=none; b=PyhQm5lR8DGb/rrnu80KbF2ZVBJXnnE5hA0tZLyxucEtscXoTNXthCCVvw+bXftQVKjHDvrp9vVZVEl8AJr9jrdSyOoDqWppxhTmVtn5EpB20xXyc3X3Fhtlz5D9mcJwfHUlM/gjHoaaBiEm6Pp4pN3xzwN0x3JQ2++CvphOJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519385; c=relaxed/simple;
	bh=bB4tck9gwozMA/nPufvx9fjtKwxpzEIlV7+1xP1kxdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOS0cZLJC8MQkqFxx8XzWCEenMTMIv0ygJKgALo4jrP5UJsRjm3xFuRCE7F86cn/bDS8ufy+uu4B2SPdm7nRNSf15X3oeBhqAC1e3aZYQVxxYR469ynvbT1TuPwGGOeDh1WkdJnGsHBcszvKJ1PtvFRVR+IsxsrhG+yJedSrciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmHVL+am; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea5f29a6so491884b6e.0;
        Sun, 03 Mar 2024 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709519382; x=1710124182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsT1xP/aqrlEd2K9EXySx8X6EjIeBBpcAVZbIuX2Mto=;
        b=FmHVL+am94Fq0I3BQCoU4OCq6iq5jURglHxjUb115mqgQE/CfJ/yxi2pjMoJb+MRZY
         WGlOtjEoPWcQgk1HP3HygUHm0xTUkf49hxJR3RKPk8yzxKSLwJDV9bdfXejVHwcyhZuM
         iSbwlW7TqS6rUXRQntgktMTnb1rgFLun4OBxuMs+XBIDWuqRHoH+1uFG7SH3phsinDBi
         S8BE92MfB8Lz/VHYG19Jo0z5Cy52wXTliFXOEtks+br5l0CD2nkxUZEhVSMLKqNIfrgj
         V6HG6/U/0M0EFjcVICnoDrpXfgoIDFBNDsYxLN71ecdRDgqDO+NHR+65czK7tT50h4mt
         ErkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709519382; x=1710124182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsT1xP/aqrlEd2K9EXySx8X6EjIeBBpcAVZbIuX2Mto=;
        b=dO+b/faxXXf3TScvMq1ToEpaAUDo1tNfyZMeCzvxTUSM9onQn4mRweu+ArfdKQD7bd
         3dRqRZDqwf66qtjBGXaJi0DgLJrvN/qSvwxdzVsraR1EIxwVrf9P964Rn4QdOK8dDXSh
         2BaDJCRqCfLhfueKaCJKj/atIjwzT8g3Z8yLUOGJf0AMy/qA0Vv+EYYIZe+7VCHwT/4W
         wfUlRf7lN9j4jUnE6O9hm4u2UwJdJ06leFyF/oI8V2vVYqJo2oiK+NuzC/MN6YnQEssW
         BDRV207K2ogybhpOLgK2bTQTTVqR1/yhHfbLpwHEVqqpdl7HylQkqNyswUyDkX67Dk57
         oDJw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZmuSquVcgvRegsOv1L6CTF5mU1cNNBVwmWLSkRX3Z7W8uN0BQhq29SwvVJ7kMiKh5cBxarEc8ko4nBhBReiPQHFS7g9r12k5lHIE1S5xPApUoyCNWbF4OSlJP87aPNP8P0HYhBhF
X-Gm-Message-State: AOJu0YzObXBERdEgmyX3ssqvrhirebiMdF8MXDG0cwKFa7RVdomceq67
	6qOwwnjYsNG2fjVfbVFcmWOfFUc2Pw/74GIvQJu43bWoPYGww0CaWtC+RUC8jOqW77L7
X-Google-Smtp-Source: AGHT+IFiot7rInDJ4eM2kT9x0oSTVV2Y01Wbo7oaKCSTtbKr1/3sjN4ZynJ6YQIGuSHmesQXNWRjFg==
X-Received: by 2002:a05:6808:eca:b0:3c1:c7cb:13f6 with SMTP id q10-20020a0568080eca00b003c1c7cb13f6mr10297374oiv.22.1709519382612;
        Sun, 03 Mar 2024 18:29:42 -0800 (PST)
Received: from [100.64.100.6] ([193.37.32.146])
        by smtp.googlemail.com with ESMTPSA id h16-20020a17090a051000b0029932d64c2bsm7483503pjh.17.2024.03.03.18.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 18:29:42 -0800 (PST)
Message-ID: <fac909fe-164c-40cf-9182-4a9ae08e980a@gmail.com>
Date: Mon, 4 Mar 2024 09:29:36 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Add Brain USB3-FW to IGNORE_UAS
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tom Hu <huxiaoying@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20240226075936.1744353-1-huxiaoying@kylinos.cn>
 <a960f1c2-a858-498e-a0cf-4c15d74487d5@rowland.harvard.edu>
 <960d9120-47b3-4961-9ce7-cd9e8b760220@gmail.com>
 <2024030221-tilt-remission-7d7a@gregkh>
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <2024030221-tilt-remission-7d7a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-03 02:19, Greg KH wrote:
> On Sat, Mar 02, 2024 at 07:06:20PM +0700, Lars Melin wrote:
>> On 2024-03-01 23:53, Alan Stern wrote:
>>>>    drivers/usb/storage/unusual_uas.h | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
>>>> index 1f8c9b16a0fb..98b7ff2c76ba 100644
>>>> --- a/drivers/usb/storage/unusual_uas.h
>>>> +++ b/drivers/usb/storage/unusual_uas.h
>>>> @@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
>>>>    		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>>>>    		US_FL_NO_REPORT_LUNS),
>>>> +/* Reported-by: Tom Hu <huxiaoying@kylinos.cn> */
>>>> +UNUSUAL_DEV(0x1234, 0x1234, 0x0000, 0x9999,
>>>
>>> The vendor and product ID values have a suspicious look, but they appear
>>> to be genuine.
>>
>> Hi Alan,
>> it is of course a bogus Id, here is another one:
>>
>> "SmartWi - Multi Room Solution is a Smart Card Reader hardware device. This
>> driver was developed by SmartWi International A/S. The hardware id of this
>> driver is USB/VID_1234&PID_1234."
>>
>> found by googling vid_1234&pid_1234.
>>
>> There are others like 1234:5678 which also looks suspicious.
> 
> Yeah, this is a "fake" number, which happens a lot (0000/0000 is also
> used.)
> 
> Because of this, I don't know if we should take this change.  It
> obviously fixes an issue for _this_ device, but for any other
> usb-storage device using this fake id, will it cause issues?
> 
> thanks,
> 
> greg k-h


If you are asking me then I say that the patch should not be taken.
If the manufacturer doesn't make it possible to distinguish this USB 
device from another USB device then there is nothing we can do for him.


thanks
Lars

