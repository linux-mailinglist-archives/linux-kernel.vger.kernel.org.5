Return-Path: <linux-kernel+bounces-89440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DC86F063
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E266C1C20CAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354221756D;
	Sat,  2 Mar 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGd8BMRl"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71F15EA2;
	Sat,  2 Mar 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709381188; cv=none; b=j2tJaEvpiDKXOc4TPTrpDXNAmjBxW3hiEsOqDnvuubbtd0y/U54pxPcEjMreGQLLbqP+1IdNEFJWIlexXZjqRHOef/fbmrQdR6e+4zerPSZG5nQ5dTSjo5oIhKyfP2++PFr3eyUwwtgPVnRJBuXdOikgvmI8aARslNf0RRnOYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709381188; c=relaxed/simple;
	bh=s0g+Mxm2v9ob8hUuHGSRnqyhywC49ZBJykfEz9emqMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2+OLVJJUCaRs+lMVVCy+QNYpSImvhdLs2M9SsxP+sTW8ZR8EldiPMAIG5Sxy4+sAk6CYG0wxN+v7fIdXV5PfnJJcOUAVwv5na27XuhHTnBBV20yZEE4eiyCX5NGOEg5SFD4TJQ08mWSOK+t4CFoZ59PQs9rCRe0hnCryFllmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGd8BMRl; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2520838a12.2;
        Sat, 02 Mar 2024 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709381186; x=1709985986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HT9/Vy2V44ilIXrSvJD5YsCNGho8hRscI9pYyv6DRg=;
        b=jGd8BMRlm/BSg+HUranCyUliwcoiLxRBIG05sMb6WphKoaHpvKHVfOii/mZcPLx+Mu
         P0kdTva0F9YRBfTzb+McxT8j7748VLrRZYelYBljt3Wg7WumtuGlH1E8Rlf4l0wJt+Re
         VSeZ4SU0O6zIyVRiMISiJt/lSbffMh0OMLsEMj4SSpdIntf21aMMrDHk+HX/LLPIP1ZJ
         enZH0qGJo0sCIs2kbNQL8DJ8owcFPltmuKp0e3tavsew27VtIIq3j86qew9Ys31NcV/+
         dPHBNtv0QxCdSJjBDaccVULhDxW7rFg+vGSEmgIh4QZDj6V82pQJ4QpeAdFnlrrTROG5
         wbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709381186; x=1709985986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HT9/Vy2V44ilIXrSvJD5YsCNGho8hRscI9pYyv6DRg=;
        b=rTFfgv2bK5vKmOEG5kW1yrCkMeeu32FRhcoTT8hfG/TRXmWahgKxQ05zT3uTdLwIGo
         OQFrYDJCckW5lfvjsUkKq95/4baQQJ2mxZ0V6PX4AKUorhAe4HAGPXEAbqGVi5zupoSI
         El7K+eJuaL4Y942WcBNC0TeHYZmaTsppbv3AFwc0emxlvfhEQau+R1TvhHjjS8Mn+lMu
         yOOnqNdADjqJHWLbtoLUyyAVC3FSE+y/dzXlXQXGbepgs20H4XPusQkVNJEzAGMB2qU6
         SWSvAK/lyRKM0wT2bYWN401lJiAPjA1tRWEb7CURu2lQi8pp9SMG3r4qSl+kucnEZTnp
         SCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQprAvyby67ZUuGwutp7LWWjeqJjeq8sKg6XWIiIvS+Z3ANqj8oSIt9h4vUdelSWzZ5vqBhqfjBoMTifQ8bSxjtYuHLJ2SByKU
X-Gm-Message-State: AOJu0Yw3apbLYpOyPumob5wN1tpQnFp8jZs10zRbZVkMt549AoENa2HQ
	6e69q4qiV82DVI1kyfAIof83arEEw8QnU316J2/BZDRhjsr4U8z3ns8hpTOqsXY=
X-Google-Smtp-Source: AGHT+IFcUzDS2LfcSqN1HYDpq/xSIYpNKqq8j3tYP3f0oBK38Ai8EkU11h8j0gGZkKzQsYzdXcP0gQ==
X-Received: by 2002:a17:90b:1094:b0:299:906b:488e with SMTP id gj20-20020a17090b109400b00299906b488emr4033682pjb.18.1709381186041;
        Sat, 02 Mar 2024 04:06:26 -0800 (PST)
Received: from [192.168.1.7] ([159.192.166.184])
        by smtp.googlemail.com with ESMTPSA id 1-20020a17090a0f0100b0029981c0d5c5sm5264227pjy.19.2024.03.02.04.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 04:06:25 -0800 (PST)
Message-ID: <960d9120-47b3-4961-9ce7-cd9e8b760220@gmail.com>
Date: Sat, 2 Mar 2024 19:06:20 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Add Brain USB3-FW to IGNORE_UAS
To: Alan Stern <stern@rowland.harvard.edu>, Tom Hu <huxiaoying@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20240226075936.1744353-1-huxiaoying@kylinos.cn>
 <a960f1c2-a858-498e-a0cf-4c15d74487d5@rowland.harvard.edu>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <a960f1c2-a858-498e-a0cf-4c15d74487d5@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 23:53, Alan Stern wrote:
>>   drivers/usb/storage/unusual_uas.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
>> index 1f8c9b16a0fb..98b7ff2c76ba 100644
>> --- a/drivers/usb/storage/unusual_uas.h
>> +++ b/drivers/usb/storage/unusual_uas.h
>> @@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
>>   		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>>   		US_FL_NO_REPORT_LUNS),
>>   
>> +/* Reported-by: Tom Hu <huxiaoying@kylinos.cn> */
>> +UNUSUAL_DEV(0x1234, 0x1234, 0x0000, 0x9999,
> 
> The vendor and product ID values have a suspicious look, but they appear
> to be genuine.

Hi Alan,
it is of course a bogus Id, here is another one:

"SmartWi - Multi Room Solution is a Smart Card Reader hardware device. 
This driver was developed by SmartWi International A/S. The hardware id 
of this driver is USB/VID_1234&PID_1234."

found by googling vid_1234&pid_1234.

There are others like 1234:5678 which also looks suspicious.

thanks
Lars


