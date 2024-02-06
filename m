Return-Path: <linux-kernel+bounces-54674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5584B24E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41770B258AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E312EBD8;
	Tue,  6 Feb 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db/hn3jj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3112E1CE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214595; cv=none; b=o9TcfYiSieo/+WlDjI130fyDrfSxvLt1Nl7OF/wTu4DIPyWsnSxBSy1ZAmI8V1bv93+oT4GA0q26R90klCn7rHfHQu2fTpk2nYxnl87R4rijc1bkmlZLHyWf2OWmjyLOKUSf8beylfb+gSATx/jyXbvE0rymTsHuaeEoOzqQKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214595; c=relaxed/simple;
	bh=x2iUZ9ZpFCei+ZnX2UaQKKpnNNBJpfw5hIourg0N3S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9Gq5RsIr3xIDMc0k3cdVXjv3xPGDDxrjYa7t5+6XjHz2ZOlA4zTq4+uaD2TW+JJyYQgm/MWeyzeHI/38hz7X07mDmu7LT6d/CW9FpovIoj6VR687c6HO4iDPGoY36TydKTE8wAHkUZehXGP3GKiu9NNfEVrzX1b/kfV8tSjmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Db/hn3jj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33adec41b55so3400886f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707214591; x=1707819391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq6XzKlQizFSqz/9bIKgOoSzkVTFHxQWd9dvc/XQNm4=;
        b=Db/hn3jjXSRBj8iEoXySI8HA5ZdbkpSh+ObZSug7V8MnPmUuxKrc/lcREUeWEqbik0
         LEn+3WVwWmhVKQakpJuPMIMUs5wRp36IoMqLSU4nl8BisD49NXdHgugipOCMsxX1k2h2
         7hOf/TMBlWXqTP+UlX9mIZLAS03I1K7oauc5Ytr1Dax9FtVBJFW9Y/N7OUjgKhdmhz4c
         MUPc5qgTzzE07/Rqi8CFx4xVOsuVrfOj0BVP4aX59PvBKH3feNVPiTbYXy0iGNaRRW4V
         ZWsDMlBIhTS+TyWFHP5rQFot5Htph9zFsGYiGSw3YRYy5ZIJxSZVXe5P/S2FYZmspr+l
         xHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214591; x=1707819391;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aq6XzKlQizFSqz/9bIKgOoSzkVTFHxQWd9dvc/XQNm4=;
        b=OIJRs3w4VlxLVLXEHWTRi50R6LUuybjIjzlJhQGVBiqq728+6Qv6Vmx+0qR6ISWEGl
         TyDeHNTjd4jvmVbNmmolNWYsZmbT+rvLkQ1FB055yIWzBoJkAMeVJyRTRJJdpI57gVXG
         cR9skEnnaNM3mX+0PgSSS62b0pEaQ0+bvTtJ4FsJ1XkCGnzPMGRvA7I2EB50J0fPxTiu
         igolRTs7s5u2XKPRgX6hXHl7U3tqpCiD6M8+e6t53co0gJuDqMIUTxcif+TYA6YTGDBQ
         IaBgoI2Dew4vpOyz83A549nVjGpwl7C5yTG9L5tUE5qHxK9cploE19QbhVT0ltFryceP
         UpQA==
X-Gm-Message-State: AOJu0YzKvqxC3TsXXz4Vo2XaooQBkZsP54QydYOLw6SohEHjX2gi3PcT
	fLqzqLjWa32BPRGW0x6h6h4KkXwWUUzuyKYbGQRJaTqCtRw9u6tQsI8+pM3uAv0=
X-Google-Smtp-Source: AGHT+IGtbG+spCM18LdwypKJoz7pmjNAGxrKZUDqQW3xYricixE43MshdkeM/tdIEZbWzKhbLeSeaw==
X-Received: by 2002:a5d:6da2:0:b0:33b:48ee:87f8 with SMTP id u2-20020a5d6da2000000b0033b48ee87f8mr650350wrs.29.1707214591617;
        Tue, 06 Feb 2024 02:16:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwHDjJrKKVl8qdw45m+9nT5h0fwPKOQtdtkRNC2vQPFh0XqEKROGB6pr33nugxDtulBPs+nABM4RvnoKx1QPrFWd7dbYZI6fzr58yI6Tha8vn4VsTZNGBvsq+6DxK5BXZyLhLVQTykzUPveKtxW7lWvs4GeVKRI+aOqGffGrg1lIPG+VIT4qum7hvKulTR/OQTMtYnEfoO1wZABzghYaRGkXBLtJITX6tL+0dECER5EwJBsUIAnZsLtoxmzxAdlFpyQ2vWfK7Oq4xZoWG5d5Vo35QuL1AjDVsym5mHCjWLx66Af3/H7fcaatx7M02wLm3ks6eu0l1KlHOfWPdvZK4Pask5nTZUckUgW1zhehhHXPUJXpuw4Fr3VfmU+iq4RxTkNL7SvZU7Q3Zy8R/Jvfly49trnOio8mgLsp8=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6849000000b0033affaade9csm1719403wrw.68.2024.02.06.02.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:16:31 -0800 (PST)
Message-ID: <0f207210-07c9-41d1-ad80-11429cbc7cfe@linaro.org>
Date: Tue, 6 Feb 2024 11:16:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: samsung: exynos5420-galaxy-tab-common: add
 wifi node
Content-Language: en-US
To: Henrik Grimler <henrik@grimler.se>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240130-galaxy-tab-s-cleanup-v1-0-d4e17857241d@grimler.se>
 <20240130-galaxy-tab-s-cleanup-v1-2-d4e17857241d@grimler.se>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130-galaxy-tab-s-cleanup-v1-2-d4e17857241d@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 21:40, Henrik Grimler wrote:
> By using brcm/brcmfmac4354-sdio.bin from linux-firmware together with
> nvram.txt from vendor firmware wifi works well on the chagall-wifi and
> klimt-lte.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

This does not apply, maybe because I skipped patch #1. Please resend.

Best regards,
Krzysztof


