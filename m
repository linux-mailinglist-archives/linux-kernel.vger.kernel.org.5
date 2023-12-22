Return-Path: <linux-kernel+bounces-9693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D081C9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC062874B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569BE182D8;
	Fri, 22 Dec 2023 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKjWkAsh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23021182A8;
	Fri, 22 Dec 2023 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d4a7f0d17so989305e9.1;
        Fri, 22 Dec 2023 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703246916; x=1703851716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLmNJV1KCwtCk4AJyZ66y9UiWpbx0XO2tfF5Ht++t+4=;
        b=AKjWkAshUtHbqIvFrQI0NqlA/25ztuRopsGnPS3hvlR2rjRjRekvK2ulhAWZHNfP/b
         udeW6zzchVSjKGtxhf1a0bsNBFn1MMRMGwjp/Wr3sBHrRYRoopJ+RrsLHhJbRN8P7iX7
         QNODP3Ye1U862UebOPkQCTYJARBdfMWRyjtP9gzYV1KhceaaJQUamF1D27axrV8+5X3p
         G+PAcO5UFEM2w4pPCmtc13UtEMlGQerlhFFmie7/eACIgGcDEaUFIrx0NNg9Fyk64U48
         iJXlqmwIR4pJp4P7/LvCTey69xYQbgnF5+FKL6BymRv0zwWPgqQdjMiuaHTIA0pKqAKT
         8ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703246916; x=1703851716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLmNJV1KCwtCk4AJyZ66y9UiWpbx0XO2tfF5Ht++t+4=;
        b=DecvjThc7HJnXEObVdG24YB8ZNX7M2JGMRyKTzrjhI4rpV3v0OkIsgINdfhlthMcPR
         TX1FNEQ6kKR8/6zE4XPBDjqBe+y7+Isc0/cUcgYCP1zuc3so1BU98yPo40zrWCJ+vECU
         ZBx6UhoOShh8w14n1CVymnwPMamNpwKuiyXgFW5fk/EMeOWHLaC4YpMAKOF15deAJAsp
         PybaY1XS3xX9m1DTinrc0M7V4/RHuAzlbr6t7Nw0jvc4tdB0aIgsEV941orHEfJtk43u
         r3/ov4GWcVqL1akN0Nj4HZtQl1L4MURVXZ+B/WCaEyawftDR5Ua1lG7f+41sBr0PtMWS
         laXA==
X-Gm-Message-State: AOJu0YzK+lsA7V4P1jfSgNQKeK/h9Qi3dCetC4Bajb7mfXMSRzGu2/eW
	Ysu23DwCr1JPCor36dwRt0E=
X-Google-Smtp-Source: AGHT+IHoGTr2p2JAjQmbfoEPN/+cqVGVjgmUq+aoT4KXXzWTti1FsgE83RW6pxbzizHKFOXmgyzILw==
X-Received: by 2002:a05:600c:5409:b0:40c:357e:289 with SMTP id he9-20020a05600c540900b0040c357e0289mr649594wmb.65.1703246916101;
        Fri, 22 Dec 2023 04:08:36 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id w19-20020a05600c475300b0040c4620b9fasm6658024wmo.11.2023.12.22.04.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 04:08:35 -0800 (PST)
Message-ID: <75cd2090-857e-4082-bbc1-e3726235bda1@gmail.com>
Date: Fri, 22 Dec 2023 12:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify"
 -> "notify"
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231220141831.10063-1-colin.i.king@gmail.com>
 <2839b824a2a04aab9514ce89b3735e52@realtek.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <2839b824a2a04aab9514ce89b3735e52@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/2023 00:19, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Colin Ian King <colin.i.king@gmail.com>
>> Sent: Wednesday, December 20, 2023 10:19 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org
>> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"
>>
>> There are two spelling mistakes in rtw89_err error messages. Fix these
>> and also add space between [ERR] and message text.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Thanks for the correctness. Could I know the tool you used to find out these
> typo?

Sure,

https://github.com/ColinIanKing/kernelscan

It needs the american dictionary, installed in /usr/share/dict e.g.
apt-get install wamerican

and then spellcheck with:

./kernelscan -k path-to-code-you-want-to-scan

I run kernelscan on the entire linux-next source daily and diff the 
days's results with the previous day using the meld diff tool.

Colin


> 
> Ping-Ke
> 
> 


