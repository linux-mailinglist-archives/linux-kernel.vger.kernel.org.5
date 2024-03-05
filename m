Return-Path: <linux-kernel+bounces-92499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65295872139
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C6E1C22751
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7E86146;
	Tue,  5 Mar 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrGzuKNl"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0448663E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648009; cv=none; b=rWXfZR8j44sIFPkFZZns0q5xzzmU80jy17xvo7GUjtwUbkmt075N+vWMJlLnktEivvbJQV4MwMwIHqg9HP8BqU+Ow5AoLp30pCWgJqeosAaj9S5YHRDjMiUJ6brXFoMBudoi3+hE41+axdst4LZH0EZcxoKzqvgUMo53OIDIHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648009; c=relaxed/simple;
	bh=eGiNgG9XJPza6VPIyf3BJC4BfCUg0c2aQFnUyKz9ikA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNnAqLKZDrBvIZzheYS6pe2QFto6eRir9t2jhTjMdJzXWVt4BDfQ20wfM944eJ4gaPkhW5UvSzeTvY+a9/hK70Sfb0u2KGVoaR3Kimj7b1mHQTPM1LwqZ6A0EdvXfFtmF4MDJuhKAivrT/re5LLXIsrtmfdOs5WC5sdmpiYbff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GrGzuKNl; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22034c323a3so2676747fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709648007; x=1710252807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY3yRlJtrPJaWCV2eKpoVN0ktxbrrrJg0Uk7bVZ2jGw=;
        b=GrGzuKNlbMs/q9iTQRCGowHpEdqiFY5QuwObVPzbtbz2KyeZ/m+QxE3VMdMIVlrTxP
         Nld6tqOPLHXyt3lgMmj2q/dR9xd1yuedqA30CkuuxSPOxrEyT6vlNw9kCHAhzMibyUpD
         E4s0eqfuvsegeTwKL9t7LKImZ6p61DG268vBeuWd4vm5GrLsLZKWnE5rtCFYXn8fAN5s
         FsklQZfiNadkSCR68wsQL3fI5/1QQQ8hERQTAU8EloyzBS7psRLvpUnEOgghKIxvehSA
         n3R4KHo3h65u9xJAYVax9lYhdX6cf7jiGmNtJM6jvzWPYkbIUEtbdeGLVBzQOyJbzDJX
         ywwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648007; x=1710252807;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LY3yRlJtrPJaWCV2eKpoVN0ktxbrrrJg0Uk7bVZ2jGw=;
        b=ut0CWBsGfGGCAQ6lctKpNDB+998NFiQT0vHY0XYEZCwWK6M8NslTZq8zG4hPMOU+Ko
         S9uOJnKoAxgFGOT2TWpZSfsWMJS1OY/F/VerJnwo+uVNkQxtEpw40lFfMgHmwidE4CEL
         vBcttChbn2bKbL999JckMeB4pVZnLr3vf+TL6y4l3aBh+LoOhVjyYmeAnF+yVl8Jv+E5
         JxoyKUFvuYUYlrYTz1GQEDEEflOf47obCxc3lmm6ooSWx3HArr0tn5ZPnDheVOk4DTMO
         M6p8ti08kByv6pBalqqubpFpdSTKTVMFl5hxrORmuUio+8y6J9qUaapI0eGEzelfwSE8
         uhMg==
X-Forwarded-Encrypted: i=1; AJvYcCWNCXDS/UUkAO0xOOY9Idh9kttjTuAyqFSjgTTFJ8S+0cIJypOjvNP4q1N6xx8WHFTaCMC1cLU/4Pw/CYUxFExb70deqWwqbtxqGvfa
X-Gm-Message-State: AOJu0Yw+xg3JtfyxkyO8zgzGjJS175hZti8lpJavbM8LJ0p+B4Mnhn79
	3ZU5R178y+b4lsaQP7UkipbSBFdcXBfcTEn+i/a22IHdhbkai1tyQGw7BecxqWw=
X-Google-Smtp-Source: AGHT+IH+PA+FnyyDU058WUM/sHWcAQk69D7eAKhY/I4P7I1Qd45O72ySOwFqQFJNv7xlBRylZbjOZA==
X-Received: by 2002:a05:6870:f203:b0:21e:4605:962b with SMTP id t3-20020a056870f20300b0021e4605962bmr1977753oao.22.1709648007440;
        Tue, 05 Mar 2024 06:13:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id nd6-20020a056871440600b0022147ef9172sm5416oab.52.2024.03.05.06.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:13:27 -0800 (PST)
Message-ID: <c010c46b-25b1-418f-8e92-e5c1683ce88b@linaro.org>
Date: Tue, 5 Mar 2024 15:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Content-Language: en-US
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 14:32, Yang Xiwen via B4 Relay wrote:
> This should be considered a hack. The proper solution would be
> extracting write_reg logic to a separate regmap driver. Leaving only
> "write BIT(2) to address 0x6" to the PHY driver.
> 
> A proper fix should be implemented later.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v5:
> - commit msg: bulk->array. (Philipp)
> - use devm_reset_control_array_exclusive() instead. (Philipp)
> - Link to v4: https://lore.kernel.org/r/20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com

One patchset per 24h. Allow people to actually review your code, before
posting new version.

Best regards,
Krzysztof


