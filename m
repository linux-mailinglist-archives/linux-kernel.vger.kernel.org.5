Return-Path: <linux-kernel+bounces-161775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CE8B5106
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07A8281D59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A279107B2;
	Mon, 29 Apr 2024 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGP6dD41"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB1D530
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370967; cv=none; b=N/MFhtSMcKd5t0uLJX7cgrz17zAGmJHC4KXH/zX71/nr/V1a5Rx80nR9rlDyPKogdEUb/CAbKszLpo7cOMvEXD3+Fp67i74C1bK2C1gyCGV6ZXef9BJtNlC2wsmkcmmeRTzs3SF7bjL1FE9nPPL1ALT9ksE0o+wdF2Ly8gTmBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370967; c=relaxed/simple;
	bh=/6it5xkGgIhTojVNnH4p2CS+/918qvpnvDXjSgLr4lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXNddWNHXx4ZkPKe+kNyQERMJv+K8xemk46nSEQP9HmDxGuXYBKJfRxMbw5Wq5mTpf89On0LgqbQF56+Gpw+JopxjwPgksAjQpqr6/jaF0lx7S497U2ixpIA5O4VwHWSEhENlq8TLlNsSj21siu5wjXe/jqVehrDSlEEYYkEFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGP6dD41; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so6177936a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714370963; x=1714975763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BqXTuUT+Z0n9gqAKDYWzZZWlnbSrS2cciknsCfpUpLo=;
        b=gGP6dD41U7u/TdxXkXO5jYC0fpO4l5d/Vi/E2XOoZSTR2b3D7Fp9fysmGEYCRhVw/J
         LT4nWvLJRY6xwXqonX3JVq7IHfP+w2KegLrSgL/qYUqmP5tS9GoFb7z535OxZKFDTVAz
         RqTP5DTm4DZNNE+JsWZRFu0vH+yR0giAqPtl6U7ZDhyJ/sajFmNv80u8R02PuuiVcNXr
         MmgnPoeaXE5TAEn1EwRDs+yUEkYNYHbQgyzHdzSqbe4HaaBXTaGjPxPle6en37borY2b
         /EvoSY7mizTm0PzVAn3v9EH2wQnMhbruHnDnvdhukbgSnuWLaeT4gfvOSmZWCjuPXSWt
         mRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714370963; x=1714975763;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqXTuUT+Z0n9gqAKDYWzZZWlnbSrS2cciknsCfpUpLo=;
        b=EJstYPOh3r/fJyCyYgRvEEUT7ReuL4VmsuGBVvDXytbw7i1Df7+AZVnDpALEqwf7Qf
         SufNBJKUbqXbOVC+SZQHapCzl28SBG++brdAAA9yUnUQq4KJsODbd0CTr6x+z9zfpwuV
         GWSZBIsc91hZQIVUsIRcFLxnkZ/O8LTzEd5jSUvyZnu6wSzQST4FY7XK1hJxaRDYMOHw
         +KjmHdNTvWCKMgMGKoGiFE9ihqDm/1Sne1vu0UOTWfiTIGej/O7LwGyooMuQgY4bHQe8
         vctbJVKrgcPITnda0UQbti8wOZyy2MP5/mlCxU4HvaajyYjGo+yePVHtOtng1LOOaTXy
         ZoAA==
X-Forwarded-Encrypted: i=1; AJvYcCX2FS/teYqMG3O8cj0Wa3x0ZYC7v8PPyotM7dqtMPFn/e+0dnPIlOKZ83/VNO6eXMrAMBHsJAbOVV1c2hjwQFRomYmDNgv5XnxI4wcZ
X-Gm-Message-State: AOJu0YwcO2UcTvYs120jH6NDTFKJrcKM5KzAtpkw+YZvqIc2OkOhn9gr
	Ci6XoK4mYUnxhP4TuYV7EXYpjPWYR17tq2eqF6WK+k9yyuyyOMRvMHcpWfSP8NU=
X-Google-Smtp-Source: AGHT+IECChsKhf55fBtX6MdjJsWmkvH0gni/8kFfqEZTQt7C8ELWQYu33MUQ5UwDbmguloQAoK+eag==
X-Received: by 2002:a50:9987:0:b0:570:35e:9a09 with SMTP id m7-20020a509987000000b00570035e9a09mr8369944edb.7.1714370963427;
        Sun, 28 Apr 2024 23:09:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b0057259943ba2sm3217129edb.12.2024.04.28.23.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:09:22 -0700 (PDT)
Message-ID: <d5b4b3fc-8fbf-48ec-87d1-758a2d877f11@linaro.org>
Date: Mon, 29 Apr 2024 08:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
To: =?UTF-8?Q?Ram=C3=B3n_Nordin_Rodriguez?=
 <ramon.nordin.rodriguez@ferroamp.se>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
 ruanjinjie@huawei.com, steen.hegelund@microchip.com,
 vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
 Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
 benjamin.bigler@bernformulastudent.ch
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zi68sDje4wfgftyZ@builder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/04/2024 23:16, Ramón Nordin Rodriguez wrote:
> From c65e42982684d5fd8b2294eb6acf755aa0fcab83 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Ram=C3=B3n=20Nordin=20Rodriguez?=
>  <ramon.nordin.rodriguez@ferroamp.se>
> Date: Sun, 28 Apr 2024 22:25:12 +0200
> Subject: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This commit optionally enables a hardware reset of the lan8650/1
> mac-phy. These chips have a software reset that is discourage from use
> in the manual since it only resets the internal phy.
> 
> Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
> ---
>  .../bindings/net/microchip,lan865x.yaml       |  4 +++
>  .../net/ethernet/microchip/lan865x/lan865x.c  | 28 +++++++++++++++++++

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


