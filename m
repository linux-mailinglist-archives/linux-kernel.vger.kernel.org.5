Return-Path: <linux-kernel+bounces-92636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17E872340
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4051C23226
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D9128373;
	Tue,  5 Mar 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNJKp2+y"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C931127B68
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654111; cv=none; b=lTLg+rIMXMdm5gmS8bmOtqj3hyW7Mk6hoR5bvbx74VjITYCorD/JqOpqz5dRTR1UjR1msL0t+Xl/tAP1noRvWE18R52JHShCAIW0cIS3m5cBK/Bsg8uwEQh9VvaeP3pITZ7N8e2sip1XZ6NCgTdIL5EBpdUhJJwZ89B8U9L/Y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654111; c=relaxed/simple;
	bh=0MFMA/5/EBNpSxHlCl5hMLR/T70CB1Xb8VS/QDE+tKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQl8AprTOXxuWQkmJIYQGpYfktETX/1GLNiUlhrjAaf/KyKWXk4FlJwRFQhFlA0/vE593oL9fi+T52P5XaqwIybWAkWH8C5T9SKpzVQFXupM+TzBcuOLngi6Ud5zuo0psWaR8Jd+wCak36fbbgs67BtG7MITdAfkgxEm90sFv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNJKp2+y; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5134d7e16a8so2118031e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709654107; x=1710258907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r7Bnl4XN924keLTWvY+GFPpZnAjIYOoWtnEA26PCh0=;
        b=xNJKp2+ywCkCcKTDyR+ChK/CmT8lC0PNh9t46Hst7kvJ0vptAamGU6aYPQY8mtaj8n
         B0qTh+tcEsuqY4tRm5xoruBi9UjofU2srBdUDs+BMFBAgjL/fyjB5OjH+tzei/M5L+Ng
         OwAUOEOJTlqWr59cVfAlX4PprjHZcVxKDMzeAbK7n0R3ygAnXCo7ttbtDFKwUiI7OhvR
         6tH/VcXXsJftL0Rupb2qAfJsktVw4cG0yycG/UY91PQoS6rXrXPfPsy3DiWYGUctB8Vf
         AlrKdmfsWsSPQUQ9Tt280p2gr0rnKouJaD8r7o1Iu+JY0ZFIHI+JXCL1lEHtbrv/GxAo
         b9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654107; x=1710258907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r7Bnl4XN924keLTWvY+GFPpZnAjIYOoWtnEA26PCh0=;
        b=CxOruQymcjONmLmeU0lINQ/D7WSPxnoJrIPECB6TKHGLszK6VaBpGu190vb/9joW1f
         iFBaZuC96C+40AVr6Ff9rOmAogpDS1hSVJHLdfqw3xiNqbadtSZyuHT4Iwf6a9g74Rrj
         ltwIMLgJ+wm6NBlheM3uT/GUDxTUSlDxCXmGwujdoOD2sEW9u9rzWVWRCvBvOmaGdDXJ
         98rM+buMkkB6fpFg6Q4xbWM5DiffDbZXTe+7pscxW/zr5r/ywZbpJWwF9EO6SjMUEN2A
         Kg0fLZ7TG/kkVnVPwheslZqmnIwWhGzJ/JITFnuO1CnAnsv5cRz8dllCEuP3s/ip2ZIe
         o3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVGXDz2CNAafujkzdv6LKLKLSWQnZ952opu/8vVTo0QvOeEU9V7dRbNU6tiNLgoUzUr13EcX5ewVrh9zVDzAXJFhClYzEzrFmUin3A0
X-Gm-Message-State: AOJu0Yz0PUyiappEmVwItlshuqaLGuiReHdGgXHtBwAJuSUIqww5w0tp
	SCVvxV0vNGXVr93QjMJrEyQh8WJwSdHCuP2f2ifxDzXAnBzEsdeM2+pESmEMJHA=
X-Google-Smtp-Source: AGHT+IEIp9OrNr80xjtbdelKWhdH9/KeI9jtSkLmT7psMLpSMiDSq32bgbtvdDcu2le8CfgT59OKBA==
X-Received: by 2002:a19:5206:0:b0:512:d89e:946 with SMTP id m6-20020a195206000000b00512d89e0946mr1350557lfb.44.1709654107433;
        Tue, 05 Mar 2024 07:55:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906118e00b00a45a72fadfcsm867761eja.23.2024.03.05.07.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:55:06 -0800 (PST)
Message-ID: <27bdcc35-a821-4dc4-a410-a939ef0d9af6@linaro.org>
Date: Tue, 5 Mar 2024 16:55:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: replace underscores in node names
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk <linux-clk@vger.kernel.org>
References: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=qgPgUqNDMtF6X0Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=qgPgUqNDMtF6X0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 15:44, Geert Uytterhoeven wrote:
> Hi Krzysztof
> 
> On Tue, Feb 13, 2024 at 3:48 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> Underscores should not be used in node names (dtc with W=2 warns about
>> them), so replace them with hyphens.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for your patch, which is now commit f03606470886e781 ("riscv:
> dts: starfive: replace underscores in node names") in v6.8-rc6.
> 
> This causes e.g. BeagleV Starlight to hang during boot without any
> output.  Booting with "earlycon" reveals:
> 
>     dw-apb-uart 12440000.serial: error -EINVAL: clock rate not defined
>     dw-apb-uart: probe of 12440000.serial failed with error -22
> 
> and indeed, p->uartclk = 0.
> 
>> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> @@ -113,28 +113,28 @@ cpu_crit {
>>                 };
>>         };
>>
>> -       osc_sys: osc_sys {
>> +       osc_sys: osc-sys {
>>                 compatible = "fixed-clock";
>>                 #clock-cells = <0>;
>>                 /* This value must be overridden by the board */
>>                 clock-frequency = <0>;
>>         };
>>
>> -       osc_aud: osc_aud {
>> +       osc_aud: osc-aud {
>>                 compatible = "fixed-clock";
>>                 #clock-cells = <0>;
>>                 /* This value must be overridden by the board */
>>                 clock-frequency = <0>;
>>         };
>>
>> -       gmac_rmii_ref: gmac_rmii_ref {
>> +       gmac_rmii_ref: gmac-rmii-ref {
>>                 compatible = "fixed-clock";
>>                 #clock-cells = <0>;
>>                 /* Should be overridden by the board when needed */
>>                 clock-frequency = <0>;
>>         };
>>
>> -       gmac_gr_mii_rxclk: gmac_gr_mii_rxclk {
>> +       gmac_gr_mii_rxclk: gmac-gr-mii-rxclk {
>>                 compatible = "fixed-clock";
>>                 #clock-cells = <0>;
>>                 /* Should be overridden by the board when needed */
> 
> The clock driver relies on the clock names, which are (in the absence
> of clock-output-names properties) identical to the actual node names:
> 
> drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name = "osc_sys";
> drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name = "osc_aud";
> drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =
> "gmac_rmii_ref";
> drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =
> "gmac_gr_mii_rxclk";
> 
> Hence these clocks can no longer be found, and all children have a
> zero clock rate, causing the breakage.

Uh, sorry :( and thanks for the report. I'll add clock-output-names.

Best regards,
Krzysztof


