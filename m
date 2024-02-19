Return-Path: <linux-kernel+bounces-70979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3A9859EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A41F21B27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44922309;
	Mon, 19 Feb 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gxjqTYk/"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E22224E3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333049; cv=none; b=h3jk9Lvlsu63gFkI/OKXtpHM10Qk3kxKsx2ntgH5+59V+XkT0WYROXuTfoXjr2Nry4eh79sGaCg4/YXDv4LzVEX8wGT+8EA+hAG1A3JmBKRoLr1qt/M4+pjurbjWrYgCi49rqhErtsKoIQgtEgwZTUrBwOsHezq9KsIOThokHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333049; c=relaxed/simple;
	bh=c42WCWRiTaPf87t3x+ZiIv1VljBs50nMTA2Bg90PJIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcOTQzqm0Oo/dvS+MQBSI4Uu1St4+AUiFEU3tFYxSv2Foz5wf+otq8W1s7iOCqCcszWVfjxmyGmBUs9ZsYl+HnWRTZBeACrqb0md/eLF7JgQcu+BYdAqOmDK5uLfMjsAEM4C2BMSHI7JY91GMrjWy1xBOBZ0RIwp0VpEYy0nJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gxjqTYk/; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c0375d438eso1236555e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708333047; x=1708937847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48j6pMjCnD+Yl6EF0CTrphjsX30B0HWxj3BeNo7ksYA=;
        b=gxjqTYk/q/Jc8QZF4GD30VhB/+hhvhMfDbTRwoUSlSGb1oAnFDoeWWu3neGDpTLP+Q
         jOp3iFGPTsFnMCKM5M1sfMtJU7JhVCK829Dqoys5XyOl36xx8xfhdM+4iCOzuWS3gNy4
         /Po67fVkjRUdbry1Uc3AVn0C8OF1PZ7gzS5VqFgQcalRX+MuYd6MX8CiOwuEcgDKp0iO
         oB1fKkGsI7IZCDmybGyd7NGwlp5TgzsHg6oWSNBBIXqYfSRtgVYxN/MP2u/s4m0kHNWb
         fVoLLzRxl9Lkuvy0ifEFhBz4HduN+2hGJDQrwJO4qXD3fEHf6YlV/PrTW54FMiHRhekB
         Ytdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333047; x=1708937847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48j6pMjCnD+Yl6EF0CTrphjsX30B0HWxj3BeNo7ksYA=;
        b=U2v6+JM6gNFFXKvEmxEYu0eN4zxYT/Gpobhw5ZKsyi0sWDMqzMBh6GULftqWmRUMAd
         rtdfWbCTAFgrOg20KlqJGNuBfMiTEwuTiYX5Onb5YHkTCgUqNjw9idMj8yWF7OrQoiVO
         SODMecYM2+/RC8X7yu96ANWjaM77WG2c5gqiZiw93mxsjGiFGsrGK+Sku156ohbbkWxS
         80OkXOHJzWCrg8K5obAgChv5Lf5SGRcj6hzBQr2XPy0YqCuoEgpiIZADDKZTVfYfbvk+
         BPrre14dvSSSJyefwbOhuwZwY948tdRTeBUgFLRjtnZpegtIrcB0Kl1RyCWGD8GcF9Mq
         Yx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXPa7mybhV60nMeV1VXKqHPYL0c5MQINfDi6z7q3QjDdDlOSGq1d0nwfa2fWBdKD2DL7gdYZvnDETjNansEGzg4amgH7FTOZzNeCbk
X-Gm-Message-State: AOJu0Yx7ddK2tVDJkotorXBJmHUha81jtngQsKat2q8XKABsHOgPaBiu
	KGaElJSjh/vSzaQzLTVvUd5pp8btRDBoyJXREWNrKd353n1S/i3o8oRGeHlhBA7soy4phtu6Hbz
	k6i4jyoU/7IXR6BbQDxIUPvZnyeXJXpofmeG1KA==
X-Google-Smtp-Source: AGHT+IHuPtUCziaW9cBhydlAFjFx0EF9TQMAOnujfZIMTtF/3mTIQARC6OmmbkoDvg2F8OPga2OpZtcbYCHKgH9NFCY=
X-Received: by 2002:a1f:d345:0:b0:4c0:7055:35bb with SMTP id
 k66-20020a1fd345000000b004c0705535bbmr9615404vkg.14.1708333046835; Mon, 19
 Feb 2024 00:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219084610.11007-1-brgl@bgdev.pl> <c083c1af-31ef-43a8-ba2d-98d63dfe45e0@app.fastmail.com>
In-Reply-To: <c083c1af-31ef-43a8-ba2d-98d63dfe45e0@app.fastmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 09:57:15 +0100
Message-ID: <CAMRc=Me1q_CV02DO4+i+-yik2RMwAbbTqropd9JU7c2axVwY8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 9:48=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Feb 19, 2024, at 09:46, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part o=
f
> > their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> > defconfig.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> I assume that Bjorn will pick this up through the qualcomm
> tree.
>
>      Arnd

This doesn't conflict with any of my other work and I was told to send
it separately to make the pwrseq series smaller. I think you can pick
it up already and send it upstream earlier.

Bart

