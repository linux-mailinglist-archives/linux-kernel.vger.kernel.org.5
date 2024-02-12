Return-Path: <linux-kernel+bounces-61681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291A851554
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8832DB26CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91540BFA;
	Mon, 12 Feb 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/nf2kVL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534583B798
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744343; cv=none; b=a1vcv6XU7BlXp6ukdFffRYmQiSD4U6FpNXMvqIYMU2dZzMLbexTXUeOl/TuwiZPCQ6YkJglTq2CfydpnUSykAScWl4rL04FyroggrCSgawPv4Q6n5TE1cnMmF10FdxbLFJQiC6EFoZ6pmQg4oWhZoxG4WHz3lEmRXN1Ap65QVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744343; c=relaxed/simple;
	bh=QxYtAME1YukcHFh4dmZlhc7ARx2Bjoo1mjpxV9Jes+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLJOTgp61N+6aw5cwMMOVinxaEgQQpscqXHZKLK2tBkXS2UlGb33gjyrG2mWf3ud24RGv2OoUCMc3e1Xs6DciXl/LaPVorQ4vlm07b+UBgFlS7qsnyB0dd23eXFAq12hvQYHbDMhvrdPf8NrtHUwWyaHSN5w/I5js4qOgUEg7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/nf2kVL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b13332ca7so1804942f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744338; x=1708349138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JapXB6+D1451x3z9FdC+nz4nmYs/L0GA2QX4UUKd5gc=;
        b=p/nf2kVLwRfidqdk4WRxnG8NAuEEstfnLhVcT2ozXUulWZyTEbkXacOwAHmoGo7nji
         9IJcAPMQk3xtEhXo/oqvN2w9A0kYb3gOj0+K5vuv/cfc9zUWMeipyhdMv/q7Ltpy4lTr
         hlg2Cux/tetGPhAQqjUkz4EfgLhk79nZAhF+J2pxrnY8kd65CXpE7Z2twp65G1g8ShqW
         ot4dM1R8vINVAD7ZfstszbFNGqt8Wvnftom+DisaC1emTRqhGgQuS6aZrKM4JcidkMxL
         PJsooay+lUDnwOp8lbburGZPujAwBFXv7JXozd1cyFLUAleIacUjyBgXZKhj7rE8Tt3A
         Z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744338; x=1708349138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JapXB6+D1451x3z9FdC+nz4nmYs/L0GA2QX4UUKd5gc=;
        b=FTPzpLIbR3UWa7GjNZ+Ww/jsJr1V2JfN1xrFdNdGrGKVO9UDOQoTPLPClhW2ayb/l3
         5ndUeT9ME8W+R0fIQmYCZKcbBX96PrI7dUJtgkHMTkFfCCkpKTuCMVssYd8Bh/hlGIkB
         ZpADIzwQ8ji7p6Nex0FDqcUSE0dZa50F8MZJGEXaP2Y/Ic7TmAdFZlc971k9iQiIpAs2
         kn+VxWWKBnB44QTkx7ObFG54MrkA1PIQxtaurkFt8BQeMDtnvf455fiNB/kvaSFNStLy
         uWZu6zv+Kjh3FCX4T42POkWBPKBi0Z5seA7c3UvJDk0+mwf4UlQUcpHfnBgB9jhoR6sI
         MhEQ==
X-Gm-Message-State: AOJu0YxZU3LzAJ/WK+GIA+qOeHgwBcdgXw2+bYL+U9AAFUpyXzLG+Zrp
	e2agEW4kZcJ6soYEgrMndDjZC6AMca93afSiODADoh6O/5Bf/PirW/3Pl9EyOSY=
X-Google-Smtp-Source: AGHT+IEWmA8ZydyFCkFtvEcGezRwVyRoBbsaVsP9L9e/zUeBFWks03GaqEEiuG4JF9OMbTti8XN5rg==
X-Received: by 2002:a5d:55d0:0:b0:33b:28b9:fd05 with SMTP id i16-20020a5d55d0000000b0033b28b9fd05mr4709101wrw.56.1707744338555;
        Mon, 12 Feb 2024 05:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9VtsZGo0jPc0cgSp7MMZBRZdN//CdEVzpGOSPez8CjoIfyyHK2vLNuwbybrlqe8KCDPRdu/E2xZhdJbSdVSGsAgfQOsVhEr91izTzQ5qQnfSmlaEANQSoeuHxTko+gG59C5o60GyeTlSf99P/Rt5M0yoGVld8oZpXcz7c/JrRGMM6Dj6fd2ErD6h7Vg/ZaF0DYRVjRCkxtxpvWJLxTAIdy2WtlhVtheoeGx/hrVprOj7wHBkmhIcizd8nnN7zrj9RobHDm3orgqj6vP4CWbYvgib8zSx9iokv2YNFeIbKyRgI3Vn+hWmLPWjEJtybZS7KPCKQY0TYkadtQEiiTkALz+VIkyBSnbtrGctIka+cnJIIWBIUZywiD2+G4yBmZ88KoPvJ9dERl0qZ5vvj+3KRgMBzGDFCbekz4Ongk5W1HnBh1yLP0Fl+xKVyodYuy9bCvEDxOjLsQrGKLyOudmJgtkbOzjS5OuHIj2zQ+c0GJCRY5RinnXtORylHsK5+hEO/hyWjhFejRjbvP/PC7wCAV8TtsYVdI6FWhRyFNOF2FPPrYMi9NOofJC6W1lT1+TtfXxoL5nanFpaZmj8dNXUf7+ZnYS1jT/tFZY/2cPyJHBtnxRQocDrgvR5Msnjg6nzxZjpiQve4ZubvbkDSPGzRoEvuTYwCsQKVMmmnK4XK+2v0VFD4GvN7yfZocb7zTfnsU89Xng5NFzhUxpgzd18zxlTFBalUe9U3kwQ/M3bnTWCs4NO+iNTcZxf66ZgBk5BIw6s5JzantZM3gZd3/1YgLaojWd1CcgQt942oRNq/v2CHEDyXgi3hYl3Y0FRzWU3ywD2mIyHAxZJ60drR36mYA3MzSA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b0033b888a0a63sm645201wrw.0.2024.02.12.05.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:25:36 -0800 (PST)
Message-ID: <ac5cbfbf-45ea-4d34-ac3d-d3a0fc6ff061@linaro.org>
Date: Mon, 12 Feb 2024 14:25:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: ASoC: cs35l45: Add interrupts
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
 <20240210-topic-1v-v1-1-fda0db38e29b@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210-topic-1v-v1-1-fda0db38e29b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:10, Konrad Dybcio wrote:
> This chip seems to have an IRQ line, let us describe it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Subject: ASoC: dt-bindings: cs35l45......


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


