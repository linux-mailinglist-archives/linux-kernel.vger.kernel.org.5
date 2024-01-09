Return-Path: <linux-kernel+bounces-20778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6407828515
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7571C2388E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5837153;
	Tue,  9 Jan 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFHx6csJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F933CDF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e5280a33eso1549325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704799793; x=1705404593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgbvqIYvBUxj10ixtEFDfU0FQhLB0SSctCceSDCXc3M=;
        b=QFHx6csJJnEi187gcLv+gAAHA1WyAVxFwRyJzp2zpiDno25CllGleEnFvEd1u4yfZe
         YLOia4iqeo/C8eUET4fFX+ZqZ29oAE2d3z8imPvIar4b37k1r5XTJwe3Ny51c9ipC3i2
         HVQJYDP3flXkikDIPJlZ8EOQhvPgupa3V69O03lT+h7p5RCAtCvK74nH7Upt31U2G3FD
         teCsLLtGgqtaaArbYPsv5aqOCXSmtbOFnC6mR2DLnmkjajonzABUZDhMtU7K+KBHOVUL
         wWrbuERH5loUA1pJuamw5juXSytSotjFdKG6WPK+1jaHE34kLjPo1EFnlSY16n0bi+p0
         yOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799793; x=1705404593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgbvqIYvBUxj10ixtEFDfU0FQhLB0SSctCceSDCXc3M=;
        b=tBsOMkMBKyXQM7B3lzCbES5iSSrclsoKmBV/V8sFBnqr96syA+OdOd5eI13r8Hzz9d
         HsIbLrL4nPh21qUqRkCWU0DIyu8PsGb4ft8I+wrMaTeUBw5pMfKb+aIoOLnIIg3UVMCI
         Qvr28oJRqB4ZRpO+TYQJZMqy0ohHBiR2P/QZqElxDxMv2wwSXBpCQBZc1mjyuouxxIGU
         FaltIx0jSQXcr5oaa/YhNMFE5lPZ7vLR2UpLaBDEQ6+kz/LwsuYwSIlz0HTbB3U1hefw
         7YqIfZWwPLp/QSDhJLVEQLTEd/PCEjlrR9nYat1UsTGQ9qFaICiJ0PrTDZk51Dh1vMrq
         ilVA==
X-Gm-Message-State: AOJu0YzSCvBMQWNZNXuf7XxdlSyZ2GYroDLzzNUFGfon3NRps4HohSsC
	9YAAWLAbTWSddchEfcMlA7rBwmVTu9IslQ==
X-Google-Smtp-Source: AGHT+IGldD1BEkbtVkbbPqS974LEVoLdQFi6cNbHOaEavh2Md9dn4p2S2vM42KQMeN6gSs4s/zX6nw==
X-Received: by 2002:a05:600c:a296:b0:40d:7822:ce28 with SMTP id hu22-20020a05600ca29600b0040d7822ce28mr334079wmb.83.1704799793596;
        Tue, 09 Jan 2024 03:29:53 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c15-20020a5d4ccf000000b00336765e9babsm2151544wrt.83.2024.01.09.03.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:29:53 -0800 (PST)
Message-ID: <fea54453-7589-4f3f-8a70-83b727e4016f@linaro.org>
Date: Tue, 9 Jan 2024 12:29:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] thermal: netlink: Drop
 thermal_notify_tz_trip_add/delete()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <10409811.nUPlyArG6x@kreacher>
 <4eb9b38f-5364-466b-99fa-b2c42c1a4997@arm.com>
 <CAJZ5v0h=y0=Cd3PEKK8dvwJzbSt_6rzS84hzgrSrxTrDkA_5Ug@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h=y0=Cd3PEKK8dvwJzbSt_6rzS84hzgrSrxTrDkA_5Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/01/2024 12:12, Rafael J. Wysocki wrote:
> On Wed, Jan 3, 2024 at 9:06 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/15/23 19:59, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Because thermal_notify_tz_trip_add/delete() are never used, drop them
>>> entirely along with the related code.
>>>
>>> The addition or removal of trip points is not supported by the thermal
>>> core and is unlikely to be supported in the future, so it is also
>>> unlikely that these functions will ever be needed.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


