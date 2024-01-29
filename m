Return-Path: <linux-kernel+bounces-42737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D427A8405C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134BD1C217DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A0651BF;
	Mon, 29 Jan 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yo0ueFqH"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E065197
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532864; cv=none; b=jKB/yvDty40ObelRWvMsC5Cssm7bbavCNR96rsypq87XDWgar0c08smvT/N02K3dwa/Ecr9EGel+uMcXiymjfHOUxLNZblbxhNri4PKsHGCWVIKfXUjeCilyXZJX4fEeb63ZBwezboPAoole7whvFiKOY9N9DDtsd8V2rUvlEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532864; c=relaxed/simple;
	bh=9fhnjxZ/Z3eDiIl/YeEMnJ3S6KNDkcBYjFwOq1E+8ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVMWybXHTIH3QDbT5oHjRvx0eNiTrPlBhLR9eeC6W6B2xIDojXmdNcfziQE2UwD7c9PIaN9ik4thZSonhjc0Ro1N/mc4jl31EfcTwlbh6pXBFEIPRI9LmERjWCYZojC1QTEjiLujMgMS5WV+GQh56Lv9QEy3hLVryGcvZ7mVvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yo0ueFqH; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4bdb534410dso567996e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532861; x=1707137661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fhnjxZ/Z3eDiIl/YeEMnJ3S6KNDkcBYjFwOq1E+8ic=;
        b=Yo0ueFqHRTYnDfScc9XqOUMKIcve+GHSNAzBIaRpd52Hx64rGuutlG/0eOm92u5Ykl
         w5kvcRd5CkalsJEiHMvXO38tuZsK5ExSv9U+84eltOVthjzZZBg+a0ax8J3gvXrKUzo6
         5trF+Y3vklfuuB9ujtasvkP4Y3cijekQNdEZYLiHDd3voWxLyGhKD9CSBb9gUOw29Vuk
         1nXrnFsYJU+Gq7L3F6tOH6qKI73QgCYz3Qz7cTPnVkPmpfm8Rw92XpYoueRw5lbLg1ja
         +9jcXdSoFzzOWCSG+bw49VIErFndeAdOfV5ocdu6LmsZCd4VlrPc/Zcpq3DzY0Sk7dw9
         TPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532861; x=1707137661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fhnjxZ/Z3eDiIl/YeEMnJ3S6KNDkcBYjFwOq1E+8ic=;
        b=K5WxNE2NBilJc5y+OV+hckGn2XFF3V4NxkdVbzE9UWMphMQMX4tDsocxMg9smwM//5
         oJBoCQwijbrGkDObXIHlPG67SHnwrCvyU6exDQVpXRk/Pi0Ef/kFAjw5LkhiQmJ7V80f
         S5i9IUv88LE+zx4mj2mjf+qYARhXXjSnRjxj9MSdtpDvTbKnpVUpMdT7wm53B02lIlF2
         EPLJli0Dfj0Hn+wNFsw1kMJGAKqBcxQhhLqUyJ03TyHwyiE/0Beiw0/4EKWAXtFZmnUr
         Q1xUow9dBiCkAgDkj9tcN6RRwUq9CYqdJS0hUqPt5kMgk5rCOLos6zuWKZaQEyc+wY0y
         EfIQ==
X-Gm-Message-State: AOJu0YwmiF+6VBuN5lRuD7iOKwDOWq4/K+FUZ7kz3/a0Yzm4b+K58p4V
	Mo29aqfHnzycZ3IvjerFoXzQC+IlbNG3f9uJ4w3hWco6J6svupXELD+7tnY9FzwWRoxJuVUDvwq
	ZyGHxjbWOBQWChG7va606sS0vpvN+UX8RudDXag==
X-Google-Smtp-Source: AGHT+IGPu8IxPwCZdmDI+aLgUZ/+xyElq1oXto8vc6/h7JrJnAJ8UG3qkg/uKgc6/g7pLgSpiTY7msPMtetgCHtV67U=
X-Received: by 2002:a05:6122:2525:b0:4b7:8199:5d11 with SMTP id
 cl37-20020a056122252500b004b781995d11mr1970096vkb.8.1706532861322; Mon, 29
 Jan 2024 04:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127003607.501086-1-andre.draszik@linaro.org> <20240127003607.501086-2-andre.draszik@linaro.org>
In-Reply-To: <20240127003607.501086-2-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 12:54:10 +0000
Message-ID: <CADrjBPpabnoOUBcq=wyaWZdiJr9jmHadvqvtj0Thvo8qQzWD=g@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: samsung: gs101: gpio_peric0_pclk needs to be
 kept on
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 at 00:37, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> This pclk clock is required any time we access the pinctrl registers of
> this block.
>
> Since pinctrl-samsung doesn't support a clock at the moment, we just
> keep the kernel from disabling it at boot, until we have an update for
> pinctrl-samsung to handle this required clock, at which point we'll be
> able to drop the flag again.
>
> Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

