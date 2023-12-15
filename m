Return-Path: <linux-kernel+bounces-1555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F182815008
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0DB2254F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895903FE2C;
	Fri, 15 Dec 2023 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHCXvTmY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058E3EA71;
	Fri, 15 Dec 2023 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db99bad7745so852376276.0;
        Fri, 15 Dec 2023 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702667581; x=1703272381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lLFpd5y805Nps4s2XX5uixG/NjQY/nNvAtSKCIs9Bl8=;
        b=PHCXvTmY1MYic2tXzmdqjN/gqNKA3/3GgMLFBKxCIZQjdPXZLXGhPsXdTND2h1X23H
         rWw1w7guOk7Oibfp21pdMdwZ0yuKIChJkXBtAXQGRloSkEVS88syczYpmU2kxOduLatJ
         yPY1j1oIkm9D6Hm6+adc1RU8OpLHV6JadMoUh6vfPk4SIxEy7bBCT0S0BgEqhUkcIUcG
         QYqnAdJ2EKWgGKFjKhTnZ1rc7ke0qPpPViR55CNmNiYRgSkIvMwEGufUCwIR+DPu6gq4
         6by+/fcu5WdlG8kA4pSDua3NAmqwtcGHUHRSSRtSAaNnjPwq01XI7Vx1ymrsyLmyneQ5
         Vebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667581; x=1703272381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLFpd5y805Nps4s2XX5uixG/NjQY/nNvAtSKCIs9Bl8=;
        b=ZFOa8JqCYF1mACRMcW2F1zO2YXo54/8wSJvYXh1P9xuKJVIM4QHMzdQoCY5PbCC54p
         pfEDP5wGHIECGyoxEtlXcgz/UiEk+goUJpwQGpcS3s+clfZYyzfJGXa/yfaiD2ImsCf1
         /F5pGLwYoiqW65ZVeDKlkRYABoxcVsop4YzuHACQitqllSCnWnMwE3CbHOItx2ZllGmh
         /Souoi1h5H5/2n2G/6vCQo8JREswUwnijNzgz24CkAZuorLGWygq7reHCu0cvizvEUZw
         gmyID5kN/teLQ4mAhKrdOciDKwshMHnZhIr1+ag8ceXHajSPMo/06JkKFQ37VfNnopKn
         tMfw==
X-Gm-Message-State: AOJu0YwDQ+C0O4xlzBDn4D8aHhkazaoVIiyO1ZM2471flgEh7iSSRi3M
	1ir1PCN1DGVtw8MI8xfhlE8=
X-Google-Smtp-Source: AGHT+IGt67eGD9roiP3bQK6okpeM3fYNWdM+zlOx2EA2pnKlg+S5/yA4jXNcg0kR5zCKdhJKHfja8A==
X-Received: by 2002:a5b:786:0:b0:db5:4680:ceb3 with SMTP id b6-20020a5b0786000000b00db54680ceb3mr8523533ybq.0.1702667581169;
        Fri, 15 Dec 2023 11:13:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12-20020a258d8c000000b00dbcb622b2e9sm2941010ybl.53.2023.12.15.11.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 11:13:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <db04551a-0eff-4089-8a5b-026783f2afc7@roeck-us.net>
Date: Fri, 15 Dec 2023 11:12:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Elad Nachman <enachman@marvell.com>
Cc: wim@linux-watchdog.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, gregory.clement@bootlin.com,
 chris.packham@alliedtelesis.co.nz, andrew@lunn.ch, fu.wei@linaro.org,
 Suravee.Suthikulpanit@amd.com, al.stone@linaro.org, timur@codeaurora.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cyuval@marvell.com
References: <20231214150414.1849058-1-enachman@marvell.com>
 <20231214150414.1849058-4-enachman@marvell.com>
 <20231215180127.GB52386-robh@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231215180127.GB52386-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 10:01, Rob Herring wrote:
> On Thu, Dec 14, 2023 at 05:04:14PM +0200, Elad Nachman wrote:
>> From: Elad Nachman <enachman@marvell.com>
>>
>> Add support for Marvell ac5/x variant of the ARM
>> sbsa global watchdog. This watchdog deviates from
>> the standard driver by the following items:
>>
>> 1. Registers reside in secure register section.
>>     hence access is only possible via SMC calls to ATF.
>>
>> 2. There are couple more registers which reside in
>>     other register areas, which needs to be configured
>>     in order for the watchdog to properly generate
>>     reset through the SOC.
>>
>> The new Marvell compatibility string differentiates between
>> the original sbsa mode of operation and the Marvell mode of
>> operation.
>>
>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>> ---
>>   drivers/watchdog/sbsa_gwdt.c | 247 ++++++++++++++++++++++++++++++++---
> 
> That's more than half the existing driver...
> 

... which makes me really unhappy and wonder if it is appropriate
to hack up the existing driver that much. it doesn't look like
Marvell ac5/x really implements SBSA. Given the large number of
device specific deviations, a separate driver may be more appropriate.

Guenter


