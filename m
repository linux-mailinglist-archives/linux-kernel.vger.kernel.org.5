Return-Path: <linux-kernel+bounces-61677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED01851542
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1531A282E62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC73F8D9;
	Mon, 12 Feb 2024 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsYVeZpo"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6B3B2BD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744169; cv=none; b=nyEsJ9IT/LGrc7vgEfxilIi3KM+2rka9IRldE0reRi9OnbaeEIAG6MivGLFgCSceeVG6f5LSw3PpneJvFcggCZHTJgC3bNqsYD0pf5UF3EL6ritQUlM2AuyfeNuyjeE5h0e8ikzlKAZtKWkyH/BE7awz92MvWjsj+TKzc1nDcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744169; c=relaxed/simple;
	bh=X9Q5+2TlUzUnmsFKMEoSk6Tsa61ElxRh2JwsL+jRt5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqA322so7wmd2ua9IzhVwJ8ruJ5HhRR+FICwaALM1GAH3WGfZybs3Wp5Trxe7S9KGpUo4AUMgZ1IqUzyWYHMztwpXnu9CbDghQg6T/UfSlqGOF2cPYIYFumQ/chtHj+LXR8ASHqjV106fbFJEbRnhMZwHaaZ5HEn4adrA2obdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsYVeZpo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1771185f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744166; x=1708348966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cI2jKSsRdCkdhU88BMA0Y+iUU2U1B5Jm4ieaR+xGaAU=;
        b=QsYVeZpoTuFwjkMDnjY9sslchhUvsh+mywryk7DIHCVsqFnW7Frb7kaPJ9ZNImeM2M
         rhp1JOW0ENZa7Z68O/jFVX2DNP0ppsD49KhjHjF0iwlEWOcYr79UzQzZunm6akzZVhH+
         EaB83c9yY3or0c2GzLwN/s5/5vjxARi60et4HDpJCLm91j1P9kthffaWYvJIRQntPkuC
         u9plPvfUCQrcr2cqabpI8aex5MlniD2jq9LpQ2I8B+CQRCLHO/9wf48OadOaVuA6nrT7
         tGSNWvzoNLtYC+PjUoaO+VUaqPnwnBU9bsG5UTX+17Dx1pyrHvKA0eCEG0tuzSq0lLJJ
         N5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744166; x=1708348966;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2jKSsRdCkdhU88BMA0Y+iUU2U1B5Jm4ieaR+xGaAU=;
        b=L1942qasoiyTau4lE7NR+owNSmrjQt4ShV91ccpoa8hn5XF0XeRRBy59hfok3zViU6
         oGrAriCyXhhTDsZdAMLL/Mkxw1MHVQaw43v709+6+++PbIbWREdH8MjF/eP4F9CjH844
         NNwdQXouYC01MfVAF0QQZlVsLdvMZkJsulOXJjFgsIrRnpFin3Iv2WZJ8Q6N3NO/fknd
         sDYSrKgBj28fXNw9iB9INlZo/qBEP3LQz1YjaFViSf0/Yvbl0xN2oP7Vzpaxw7TeoYxV
         /pkV7h9SBjAfAdxoehmjA70X0uux4DI2Bd4xp056HWHS0nEStS3YUkIRBOdbq49ve2KE
         auQQ==
X-Gm-Message-State: AOJu0YxDf8yYC5v8tZVVqNR7URLdq9K4cWVJLD0u1+8j6U9gy3bJbSE1
	WvxpWI26G/dreIF7nLPO20juaJbxux73bdE6DKwXeRsuoH+cqX1sfoNzAJQi2hc=
X-Google-Smtp-Source: AGHT+IHjzVxIEnUb+cBW32ajbIGNxI5A8aoxXlNUxHOs8ptUq/b4r7ASxA20+XMgTxztsGeFfh3EuA==
X-Received: by 2002:adf:ed4f:0:b0:33b:daa:3b5a with SMTP id u15-20020adfed4f000000b0033b0daa3b5amr4033482wro.71.1707744165970;
        Mon, 12 Feb 2024 05:22:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgLoob+TZePyqqUvDKFxm6gqdEgMME4xS7Rk4XqVRltLJluK+d3OkHlUkh/b7Zw3WP3OMHJR2JFDMIQCCel8mb+mS7qY0xB7Yx77zYs1WkTMUbmcoP7PPyKkJweoh02jANYii9woLIdupy/oKGgsRXMaAwsoveS36BMjIuE0iWGbMu/PY2Oo53++aYXobFOX+a/aU7jdpibEP8GU+LwSY5mPO/uX+J+R5EYCrDDW2M4WivvEwZEiS4Kn8hoHAtLRhcddmqg99p8mINV4b8o0QoSb8dU2zWl/SQ0sbl4o3INYF491vuLc+MqsYzr0KYhwx4m5d6yROCkyofg4JvmIHvcnvAyUuvlo4+KipvQgTebWuk/H7Kb4lziUvf9f8xbGY5bieYtroRCRceQnAeUDlxI5sv0+ks1ZSFruJLSbPqZiqkhv2p3yEHRWIV5AdKFlmdF9eNLriQ+jbfQplhin4P0T0NjlU87jAReMprvNsUDFSWvce3pMsTSgU=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bn8-20020a056000060800b0033b198efbedsm6938782wrb.15.2024.02.12.05.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:22:44 -0800 (PST)
Message-ID: <27b85493-62d6-49b2-a6a8-c656c534d697@linaro.org>
Date: Mon, 12 Feb 2024 14:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130233700.2287442-1-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 00:37, André Draszik wrote:
> Now that we have more than i2c interface, add aliases to ensure
> deterministic bus number assignment.
> 
> So as to keep compatibility with existing Pixel userspace builds, use
> the same bus numbers for hsi2c_8 and hsi2c_12 as the downstream
> drivers with the intention to eventually add all the earlier busses as
> well.
> 
> Suggested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> Note, this patch should only be applied after series
> "[PATCH v3 0/7] gs101 oriole: peripheral block 1 (peric1) and i2c12 support"
> https://lore.kernel.org/all/20240129174703.1175426-1-andre.draszik@linaro.org/

Dropped on request.

Best regards,
Krzysztof


