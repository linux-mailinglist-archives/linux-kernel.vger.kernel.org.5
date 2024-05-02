Return-Path: <linux-kernel+bounces-166023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738578B94E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A61DB20E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7DF2575B;
	Thu,  2 May 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjHdj1sw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833C1CAA5
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632648; cv=none; b=eQYrCJae3f7Ygwmic1bEhKxvNoJdSxlavrWHQTkVmIgTc1XClOUfiOzrH4rHJRk+EFdIHKojzKLa077w33oJIw2Y0Ugdkikq7y6y/p/REpNLYg7PgnvvjS9b0CmDSDN9l+koCDUTU0P+OofVH6tdEoALxNJT/syHR2A2ntnCsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632648; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBEsl/zg7ED0pVd6E9ii1/D4539aF0AOYzhcel4Ut7O+Fv9771WPtBqdYKHTLAPYVhmr/HayC6U1JGiPM93S4SRDY/Qq4+jnV2zvY64IgbKKiQUF3wq4fNFXAMQ9KJQ3b1kxUIOvEONSnLDoJucDRG4hiU+1Joh0XIF7b6VALMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjHdj1sw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so7396585a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714632645; x=1715237445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=tjHdj1sw4LmVaCMs0X8OaPrJwin9CaDOJYFyQVAgG+gu2hHuv33O3MklYUx7JV/Fp+
         GnvQVZPijjfRU+7ym1NRUWVmREVpSjyk1CLebYNQxkHmaXQwETj1+dtqb9wQaGReudTr
         sNr7k+tKIDMUQkVdteSt3VRxhOdGgHNzy5e9kA5bOCLqQcraCkakgNPYE1Qjgx1jfHqa
         EqF03Xvv0zJIC93xcKuawdemULKUt8e2zK3IjYuI0heJFKwUWaS1JSkwYIPt5/V52Alw
         ugRNaJl5YOO56myAgnqtE5NfCcloR/OhJVtEI9CwOoMPKohsnj3iVsFe3Rx3kejLLr+r
         Cxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714632645; x=1715237445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=AvpwUszx66jbyTv/ExMFm5LZG3FMt/hUUDxdlmx4Hm2M41sO8x9Y4H++qQ6YkQY4ot
         +szGSb7uGKLPWFXx6wiNUzE/y+lIAVFpbEc6JF+9pmMdh82sFc59644xWzNJ7bXHeRDC
         b353TWGjIUZ9pxS31ZyDrheB9pkfSimNHpcB7XqS7GlVdh3XqctYIVyTolslZA6ABvVE
         mFkSXTHkfJ4r2AURaOnZrMb4Yy22Ga42tjcdb1uxFe/7hkQxCX6t9i5S8BKUeMnLxUsJ
         xiJZpSihzAvaBZLJGyBpg5/rr5XvN8v+yI93kf6JUU0UX25WwUsIJSN5c/TOenSYnSIh
         vuRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/BoNMNWuvMbWWrrNDGIMItquMZzNgc2ZyvZxe7Xn0TE4QVLMIVM8KDRS3IKdVXsaZV9LnjoCsut3ohmm+Z/1rbfQCznwGtGh3EsB0
X-Gm-Message-State: AOJu0YxVNOAK/gbpyiAikvhEtcyN63SLemNJu3tklPE2R+iTio1ndLg0
	7wosH0N8MUdeBZBQlGBiayaKLiLAmEpbAMNo41Zq37nzMzZ0Mpfdgw6Z1TaoF3A=
X-Google-Smtp-Source: AGHT+IEm4hxtYeUITzy9KskvdEwvovQTQ7goiMjdbtjJXbgiREClpPvtcTNcEi0/QqCMuqRmWxzfgg==
X-Received: by 2002:a17:906:3510:b0:a58:eb98:6806 with SMTP id r16-20020a170906351000b00a58eb986806mr2983352eja.32.1714632644997;
        Wed, 01 May 2024 23:50:44 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.85.172])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090624c800b00a526fe5ac61sm179547ejb.209.2024.05.01.23.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 23:50:44 -0700 (PDT)
Message-ID: <29eebff9-04ad-4c4d-a3be-2f2da7a9a280@linaro.org>
Date: Thu, 2 May 2024 07:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: gs101: specify bus clock for
 pinctrl_hsi2
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240430-samsung-pinctrl-busclock-dts-v2-0-14fc988139dd@linaro.org>
 <20240430-samsung-pinctrl-busclock-dts-v2-3-14fc988139dd@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240430-samsung-pinctrl-busclock-dts-v2-3-14fc988139dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

