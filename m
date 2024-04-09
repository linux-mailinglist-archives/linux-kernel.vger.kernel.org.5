Return-Path: <linux-kernel+bounces-136507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FA89D4E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9997B1C2155A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFF7E58D;
	Tue,  9 Apr 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+z2DPkb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735F1EA90;
	Tue,  9 Apr 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652780; cv=none; b=XfISqqyKanlvtdIJ2d8fEn6UKGQiU3NqBVoYiSyc2V5TkTvSNpuKu0XKM8bXehrieLx3GdUA+MXMMNOA6+Vf6yUvo5Br6ZR8Vj4JI6pmaof4hTj5D88s0kK7Rh0Lcr+lTpVv9Ha9wzl8K6E5QDcB9znRRAhOdikbK1NA0IxjQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652780; c=relaxed/simple;
	bh=x+c/zqnc1Z85ooz0Ode42DcXG6xxK0T6y0d+nbFikTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR0GGdMLHjPaYfBF40WPU9rB9kokUqLiurrhXBsDaqMqkNk5wb8NK1CpaFQQIb1ps8e88qeglg08znvE+he+InmpW8djHhFMn6EW/JmosgESS19/HUoD6calYx0fR4TZutZzpnrPoM3+26p6/hU0mYESCYSmw/DA2lja3eKYAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+z2DPkb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e6e08d328so1052550a12.2;
        Tue, 09 Apr 2024 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712652777; x=1713257577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0jIR2OL0GyuZ7AB0nPnmYn4Ft44qzFta5fRUBXkOno=;
        b=A+z2DPkbqWWmpGqeHauvej32rI7d0/+9RzNxl0lgxO939UYwQu6Km7bbG4HtXJmiBo
         teqCQ/X5EXpQj/3vcwA/6oBqol/RIB209/IoNgEv8Vg9GfaCPQT+yPNuRCrFuvP01TK4
         XJaKDgPcKMDgGiZHDMFLwBnGPbeMSXnfXZHvnz9HKTFMsp49cp2E1o7KNpwTWxb899Xe
         BOYjziSmJ/4rECAxN9TevjJvJZxH5FVMfab/jDfpZ+bOcTw1fKzDGHGvSkAW5xALASQK
         bnkPD22A+06xUOFWpDwpsu+LRRZ+SvqMO5AiAfjMYsQFRoKSLEYaiVSEI5MtaCgxsolY
         zo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712652777; x=1713257577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0jIR2OL0GyuZ7AB0nPnmYn4Ft44qzFta5fRUBXkOno=;
        b=xKeVJFExppRwpoRpgvAFM7HHu7woWOMCU3u2qMSrXVrxc3HuKBX48zTp0GO4sNZqnG
         zF8KBIahyrp/lmRPvqhKyrwJO1IFg/2ficvpg2E9IQOV+hnNgl3RtvMi4e5BKTg9ouBt
         ogrZftWKHAYGNEv5bry0VW60q9hzb2NRe6acB1AeOMUXVqwwf3/fdBMGq50D23m5op3x
         Ec/zS9dp7f8pX+P3KPIFFH0t4qqr14ZUHrzZkwyZKDD1S1EiNeXYFOwZx4a4f9xUTTmw
         dXj5CZKfXNq9KKxT+rBHTGFZAFvc720CY6rx5PVTqpQEjjgMO9Z5H/R8jX2MfpjhZn7M
         DiOw==
X-Forwarded-Encrypted: i=1; AJvYcCXs1rcWL1cOAsVTawoFXy3CI87TF05kXjezPlNEsss2eX0pK2B06T3Yk8tO1HRpVAKLtymqmzQeTmGZ7I2+rxD63S+zH31JGqdGi1WiXeW/00PWA1srLXTbJFxl0qRrsGehGYpHfRu1zA==
X-Gm-Message-State: AOJu0YzserxPwiMKDTxkLhocmF5SVresqKCp04BQ9p4vME9n5noPJiEC
	Iae+vmQC3KyVxZQCxydUyZuXhK9KdSYptpSipw8x+/pnrEGf7oGL
X-Google-Smtp-Source: AGHT+IEAFHw1NjWQVbVzBzYATvddUlqkzBcIRzHxlgvPpMiPiCZOtlevHR5EjAtm+ZEjmL4iwtsgFA==
X-Received: by 2002:a17:906:6c97:b0:a51:88e5:5451 with SMTP id s23-20020a1709066c9700b00a5188e55451mr5956856ejr.29.1712652777110;
        Tue, 09 Apr 2024 01:52:57 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id ak2-20020a170906888200b00a51dccd16d9sm1836588ejc.99.2024.04.09.01.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 01:52:56 -0700 (PDT)
Message-ID: <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
Date: Tue, 9 Apr 2024 10:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
 <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 09:34, Krzysztof Kozlowski wrote:
> On 08/04/2024 17:53, Javier Carrasco wrote:
>> This RTC requires a compatible, a reg and a single interrupt,
>> which makes it suitable for a direct conversion into trivial-rtc.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
>>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> This one no... and if you tested DTS you would see errors, although you
> need to test specific lpc config, not multi_v7.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> Anyway, you *must* check all DTS before moving anything to trivial.
> 
> Does it mean all other bindings were not checked against DTS at all?
> 
> Best regards,
> Krzysztof
> 
Hi,

I did check the conversion against nxp/lpc/lpc3250-phy3250.dts, which
throws a message about the 'clocks' property.

That property is not documented in the original binding, and even though
it could be missing, I could not find any function to get a clock (i.e.
any form of clk_get()) in rtc-lpc32xx.c, which is the only file where
the compatible can be found.

Is therefore the property not useless in the dts? My apologies if I am
missing something here.

Thanks and best regards,
Javier Carrasco

