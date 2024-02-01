Return-Path: <linux-kernel+bounces-47730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C68451E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1551C222A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA51586EA;
	Thu,  1 Feb 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwxausMh"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2B1586DE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772495; cv=none; b=Q+EeFeNtfiR6EaCUqGPOIFtShgeo+YxdIg4x/lTXWNvt5kCe1XQAR65Lwxk6e/PpQP7Lv2DczP0uhMkjlhWDdZLqY++vufKTDkT+a04g08UlwdOQTi9dYQRVOvnXJXXXYps28gAlIIQdyKQ26BOdDITzbWGvixdUBkQHSihrAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772495; c=relaxed/simple;
	bh=xgmfRdi+vmVIFEyMbzoT4M+74qnB4rTtIeYeCABq/2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFxT/TKhQt4qAtVC8jAO5wV1Tm/2r28EFA/gStJLU8zwd74YR0zjMsYiYTq1fAdf6ntkAS7bTTkNDf2EZhWYa/cuxzVFODPZX9+lg5tiB4NGNzoUqt3U6fUpNsBxeZszn6P6/fu4EpFUXg2q4jmmWmL0RGxX5CtOrv93w+iy/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwxausMh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55eedf5a284so677818a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706772491; x=1707377291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G3oTT5I9d4d+PQVGhDMSxWDkbgXuBkqCtCwmEt13epI=;
        b=ZwxausMhfRC89tUB7pB7hZ1PXF/h6xOfMz2O4QHOH6tm6E7b8rnBcH4QgggGHCO/9W
         HJ8ylWT9QL8fIe42HNR5C90/4byfgjaCDerjl54zoFjlkQdMbyUYRtDrT1W3hBjopOym
         WUF64WUlkSGrqM/rsjmv+8a5kZUZKr4Gz0PGPCTXNZtbmdZPOSk9rkOvI8fnpJ0jEXuf
         rSA1auJ3BZ46HOVAHSsN8XV2EuGednQFAIuOUfSwSRhlnPys0okwE6JH4VgSv3WxvdMh
         eA5aGMdXN90HCgSG4i316effGgIKs2gp1jIlxDaLSelBMjAy54mnwlZ36/7uZRo7oIhE
         hV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772491; x=1707377291;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3oTT5I9d4d+PQVGhDMSxWDkbgXuBkqCtCwmEt13epI=;
        b=tfHT+Ba9zDSy1C/92tXhzEy1F5aouThCKirvkNewVd5+Nj2hHkoRTzKA820FN7TU7u
         UEbbasAoOZ5PHfdHSt1sN707gKqS9oArqk8Qrlx4SglBsJPujPjKmpuDAq6jgErBjjWE
         rTgP/1A0QvVUVdrtlsg5LtJvzIZ5ZT9Et+yIfIWeHHlxunbIsubGeC0n3RK/bGEl0HiE
         06YlRywfKx2AAA8xYDNRqeTGct4adDQ6bTPUzpz692zJKFJMPh+XpEprjVPUd9HllpWx
         RE55p0Fn8nudrD8+oxm42Q2LcSscl8Fn95cMyiOxegyleo9vJQ8RChCkWTsWmPRubMpV
         cxIg==
X-Gm-Message-State: AOJu0YwX+O2eJkNT3MrCfht8BLBJwbwly3I5moLToiv53ArdbPqvDbR9
	Kv+tLGnmAyL4TNfQVad0hWAzcaG7Nbf1QGxjXiwIcErHiAkQYSErjtzWOoFFQIk=
X-Google-Smtp-Source: AGHT+IF/etod/Ycuj7wIVL3tdK/+iudC9malvzx4LqBpiZFPRDMF6dlyDVoALCT7LUN1Q8xnNPFIJA==
X-Received: by 2002:a17:906:81d1:b0:a35:3ce3:c492 with SMTP id e17-20020a17090681d100b00a353ce3c492mr975455ejx.26.1706772491340;
        Wed, 31 Jan 2024 23:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUmxqECc5dYVt0IwNFmNmKT+9u1RdYTzzEBE9AtOlU7k+e6CoyGVTXeM9JUHDwsrm7/e0Mn3+pnZedxyKHrri81elZ/I01F92MS2ZdWmbsNCuWSxzS/mMP0k5PLmMqrq9Cfzblnw1TY/Tq9CP7cmMgIGWaIKmrbG4ryZWz2hzkzHTyAx1Ll0SKXe5Yp5eJwYdhnV2QmC3XEMvQ1TIztV1LqUvHayeA3SI16K51cuC6pWNGCW2E5r9S1VIK0Jv+CZIuqCYkY8ukp79a4/gSy1TMabh1sGOTSIhN3RI1NXf5SoYVrrNgdL+pprMcG6dwv0hwS3bMdb/5j+ZvczHeVy6GjdUdCcMdajkGOOo4IGJqWSAD2JK5fanXEIqkdZS3BGcK9ATC24hsBhBhabOCcSH3LjyJ+8zXL1Jc=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a310c9d0cb9sm6847721ejc.121.2024.01.31.23.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:28:10 -0800 (PST)
Message-ID: <b94df34e-938b-4f89-97e2-ebfe694c8e7a@linaro.org>
Date: Thu, 1 Feb 2024 08:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Add tuning algorithm for delay chain
To: "Raghavendra, Vignesh" <vigneshr@ti.com>, Judith Mendez <jm@ti.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
 Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <5e03e867-b45f-482b-b734-7949e28fc97e@ti.com>
 <37af5a30-0e47-41f9-8d9f-f09a38d05fa5@linaro.org>
 <52b14b42-6e42-4435-b391-c3f48470e56c@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <52b14b42-6e42-4435-b391-c3f48470e56c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 14:53, Raghavendra, Vignesh wrote:
> 
> 
> On 1/31/2024 7:11 PM, Krzysztof Kozlowski wrote:
>> On 31/01/2024 14:35, Raghavendra, Vignesh wrote:
>>>> Judith Mendez (11):
>>>>   drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
>>>>   drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
>>>>   drivers: mmc: host: sdhci_am654: Add missing OTAP/ITAP enable
>>>>   drivers: mmc: host: sdhci_am654: Add ITAPDLYSEL in
>>>>     sdhci_j721e_4bit_set_clock
>>>>   drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing
>>>
>>> These patches needs to have Fixes: tag as they are bug fixes IMO.
>>>
>>>>   arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
>>>>   arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
>>>>   arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
>>>>   arm64: dts: ti: k3-am62p: Add missing properties for MMC
>>>>   arm64: dts: ti: k3-am6*: Remove DLL properties for soft phys
>>>>   arm64: dts: ti: k3-am6*: Reorganize MMC properties
>>>>
>>>> Nitin Yadav (2):
>>>>   arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
>>>>   arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
>>>>
>>>
>>> Can the driver changes be merged independent of DT changes? Or are they
>>> meant to go together? Latter would be problematic as it creates cross
>>> tree dependencies.
>>
>> DTS cannot depend on driver changes, because that would mean hardware
>> description is not really hardware but OS. So the answer to your
>> question must be "yes, can be merged independently".
>>
> 
> Normally yes, but here I see update to tuning algorithm and timing
> paramaters to the algorithm. DT updates seem to be nature of bug fixes
> where in parameters have been refined due to more HW char
> data/understanding being available.

Then the patchset should be probably split into fixes and new features,
so it would be clear that new DTS features do not depend on driver code.


Best regards,
Krzysztof


