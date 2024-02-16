Return-Path: <linux-kernel+bounces-68306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE4857881
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48E01F24E13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629131B81C;
	Fri, 16 Feb 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpJvTVGu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA298BEC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074438; cv=none; b=b9eLMR19lRBy9tRE6SogTj4Qfh1Gct2iKsSfdHplshWR5Jy6iGD+xnmYwS7SkZbxixLqA+GaaTx3Jd9Qm0l/A5ntnTzSrL6QvqvNwINyOXjcxjwgVyWk/CDtAcAcpGxL2Wq0oQRPUNRBt3YnuMKbSXtAHRplqQV1D4RK5kdLs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074438; c=relaxed/simple;
	bh=T2ldxKEVL596wGHjU7kkHhvWD9KAge7N5vw8uGflx0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bG/u0QUqE0wJp0HPXaC/X2I51LKJMte0/lakz8Fq9PWZ8h6hTu0XJZdaszhxWSf/T0lQnUP58/MUOn3MLCdR/fTiWB0BjIY9LnldPyXxq/d74v5aMTnwc6V8sVL1GpO7ilyhDhzsvli+3lhhW7/mPnIfhvg9D+ZDK0+xaJfDlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HpJvTVGu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563d696ce87so1207977a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708074435; x=1708679235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HamjRFBjQ2qVdicv3DULvaDT9cBo0qS+9hQ3Sknz2SQ=;
        b=HpJvTVGuFtj7vGciOvESfO4PFyIK5nSmVkwgSXPfsjlvRliPl+Lo2NJLuXesn689be
         D70bES9vyUzQEUEUjU/gJ1qPG3nZAjaNAp5SqRzSLATcyRxFO/LU77I41tzIX4dZBZTF
         lIIaVgO0AnfKIGmK1LOPsyScC9E/rd6IZ0Kp0amvKusHCKDg7WfRRWBh7hNUpEk2cNYA
         SOPUJEd0iThQhocU+lOPitY8q+UAZAI0FRXiNSPM2rm7TTjHWZ9S3WqnnP4F3ZKIekh2
         9Bc0annRMxcpEtkT/kETP9ptsn/Hdr48LYaTi2PkwmuG9GiK1sAxocseSZGofD2rXn6z
         FqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074435; x=1708679235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HamjRFBjQ2qVdicv3DULvaDT9cBo0qS+9hQ3Sknz2SQ=;
        b=wDLc7bUDd1jPOlzHD2OWJLZtziDEIGtzie28TzSnqQ0qtwp8uhZDfXUwoPUtIIo+ks
         TiVxv/RHJwX7epKh6ryn7prgJeFuaCwi3w/1fn00/sjN1TKjHfQ2EDG3FUV33IIy88zR
         gRo67FDo8gwJ5NxbOGQr4ldQ7k7JWMw2nPUfDCfUicGRhEG9yzzE1l5MKjBJSG1flJsQ
         hSaKRWi61Eb4xljjXHXhQ9wCu/2K1JPjAPs8efrIuXS7seb63ZwTctB7MMmM5ClYnM70
         4ZpqVHFuMPyPIzAUgIe7hjPUmsGZF/TNpdpg+QIuwpU8hHGO93Zf3hfeu/jNk2oaEZW/
         8GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9XWiO2f6EWnGAikCf3iz+QE+pdk46bAF1TkUOq7AtxaYMV4deOwSixRfZR3lDPqYjnjlW7kN1rK5iNRkeK6pICWJD6Dp64twVs6t
X-Gm-Message-State: AOJu0Yyl+1itruXCiQ/C36yaylyQW96E7rfajuzi3l/7whKYFXhyjOxq
	aZEKO7Z982RHWX+Ah5GynQyKVz0BCXS1lXzkFHGA3NHGYoxivsLP47VAp+7SgQw=
X-Google-Smtp-Source: AGHT+IEUgSOOKDAi97LxXDelVgKRQxrSmqm2fmNwo6lm8ky2V+YruTn065g/aFweYnsmmRMFjV6nIg==
X-Received: by 2002:a05:6402:4582:b0:55f:ce14:337a with SMTP id ig2-20020a056402458200b0055fce14337amr5964730edb.11.1708074434995;
        Fri, 16 Feb 2024 01:07:14 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id co26-20020a0564020c1a00b00563d213b017sm774881edb.44.2024.02.16.01.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:07:14 -0800 (PST)
Message-ID: <23c7fee5-ed66-436b-bb1e-ca4cdc8d0a66@linaro.org>
Date: Fri, 16 Feb 2024 10:07:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible for
 MT7988
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213-resource-evaluator-0754cfd5882d@spud>
 <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d4391868-ddcd-4f66-b539-28d245fa83df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2024 07:34, Rafał Miłecki wrote:
> On 13.02.2024 19:18, Conor Dooley wrote:
>> On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> MT7988 has on-SoC controller that can control up to 8 PWMs.
>>
>> I see a binding and a dts patch, but no driver patch, how come?
> 
> I believe that to avoid cross-trees patchsets (which are sometimes
> tricky for maintainers) there are two ways of submiting such changes:
> 1. dt-binding + driver; then (separately) DTS
> 2. dt-binding + DTS; then (separately) driver
> 
> I chose later in this case as my personal priority right now is to deal
> with all MediaTek DTS files.
> 
> Is that wrong or unacceptable?

That was explained many, many times. For cases like driver+bindings+DTS,
bindings go via driver subsystem, so they should be posted with driver
patches.

Feel free to include DTS at the end of series, unless you send to Greg
or netdev.
Better, also required for Greg and netdev, is to send DTS separately
with lore links to the bindings.

Best regards,
Krzysztof


