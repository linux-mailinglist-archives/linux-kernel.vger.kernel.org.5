Return-Path: <linux-kernel+bounces-68409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49E8579DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C81C21592
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE041CAB1;
	Fri, 16 Feb 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsok1pDB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE21C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077790; cv=none; b=ra3F8g4VuU09SJGl0FdEaO1MMcIF7ro6bzP9+bWHo8LL65oa9FTV3PZYO2o69KPfQxwDjIRc6bAQNSP4vCS4K4lneVS0Iz/+eKM4vS4FI6RbtKofJsw/ioBXXMKlepiN8zsi70HanxE8kt+eKjp/EQaiyw4Dqz7aZRcZFQZQQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077790; c=relaxed/simple;
	bh=Ng8TWmBB/HBAX+i4Lcrhc8P82UliiHjNDyiKLl+UDO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThBlJvKXdxYEXdPdg90SVZsA6KN1Swj3jWnTUR+5ibCcRWnoe4r7DUuMOnxrpCezzlOcbyHnhAEIGjhAyOI6T9up1XoPihp6o3mloehOobKudNOV7tXypfeynsyE1D8MWznQ8psM+Z1/4u9Qw80WPFe3iqUlees0raOWV3krb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsok1pDB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5639ffbcc10so2116678a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708077787; x=1708682587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jm3UgGlMNkbIvZSZrfTMr+zRaBb92EXyZ+EDLRjPkmM=;
        b=fsok1pDB9Usy5y71fYcT/vsxeT5l5cK63xiW9JNW93MJUpjNIJ3FEm3TzcnyFY/YOF
         uDjCBg/JxogfTU8EwbnJpEJ1xwvVxzGXv6vZ6CPGJYmCHUoNbOPxf8+hBe4MfSTXiyeV
         AsAiS6P6hJDJVPY8F86gEmE/9pkuBlyxtnd/AfiTEDprhJg0ItK7+p8Qt+0dlW9Sh1Rq
         7o209QxbFVhyW1/BTJmX1WPyyDpykajtIXCmxW/ZPqfKNOMVytFolzcgp+y5zGQYpXvY
         MaDuObJo/Rv+ww+w/sUecNoD+jp+YNRt7D5zIIYEX2zqx+P/s/6QhKIO3mMD97lnSnH0
         04bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077787; x=1708682587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm3UgGlMNkbIvZSZrfTMr+zRaBb92EXyZ+EDLRjPkmM=;
        b=wUNUD4XhM8t2I9HJwMiLojXxiJ3cmA70hIEdazMzeHza3ImsZGPpBZzLKHB0/7vTtC
         39RhjMuU4Gj8GqNsksp+G3eFoU11jnhJRSB/BzoFV6AeV842x44IO9+50FPdILj09W8d
         T3QXZp9yRp5W+n6J2ibGQKINWgq4/xkELYRoDQDg0xe9oqRplVUCB1xtrNWN93lHEt7l
         za4U/jx6mlBVswrJV3z2IInl8Yfmwe+oYZu/HGso1zZAzmeMW231Cbi8PXMO23NQeQKJ
         tCURg8v27JqLb/TdMsSCmqKV5OlOz7KOC8iReaCtG4WwbPI9iYX7uyS17EGyiZRx50ku
         Fvhw==
X-Forwarded-Encrypted: i=1; AJvYcCU25oAtEnYdTZGArNYQLRp/qVEzA42qt0FV8ec10HQb/hhtTfLXLbX9Kdb0EfeLrDPkGcLHi/cROyc0x2YM7TfyjhINTCOXpIC0/D7K
X-Gm-Message-State: AOJu0YyAIrQp3MXQV/2S2w1bc10T6yHIgGTRmn2KBWt0Ca/TP2n7wwP/
	vhLYlPGTSpkEOChonquWJUKlMyPSWN2rOMR2tkqh4T1HuH7QIdsScssXGJMdQls=
X-Google-Smtp-Source: AGHT+IGyyB5KoX2BTi/fhuhn2a2i4yHeyeUatRb+8KuuKxEyuD5U/2iLAGb6tEZgy3wfFDpVUpO62g==
X-Received: by 2002:a17:906:7d86:b0:a3d:8207:c83b with SMTP id v6-20020a1709067d8600b00a3d8207c83bmr3103932ejo.37.1708077786751;
        Fri, 16 Feb 2024 02:03:06 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3d1b3c5f1esm1400467ejc.77.2024.02.16.02.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:03:06 -0800 (PST)
Message-ID: <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
Date: Fri, 16 Feb 2024 11:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: rockchip: rst-rk3588: Add BIU reset
Content-Language: en-US
To: Shreeya Patel <shreeya.patel@collabora.com>, heiko@sntech.de,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com,
 dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com,
 shawn.wen@rock-chips.com
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-dt@vger.kernel.org,
 linux-arm@lists.infradead.org
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-2-shreeya.patel@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216094922.257674-2-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 10:49, Shreeya Patel wrote:
> Export hdmirx_biu soft reset id which is required by the hdmirx controller.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  drivers/clk/rockchip/rst-rk3588.c               | 1 +
>  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Please do internal review. The internal Collabora review would tell you:
YOU MUST run checkpatch. Then you see errors, so why do you send patch
with errors to the mailing list?

Best regards,
Krzysztof


