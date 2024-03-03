Return-Path: <linux-kernel+bounces-89705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BC86F46B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A74A1F2162E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2291B664;
	Sun,  3 Mar 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e3UIQ6U5"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FCA48
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709462059; cv=none; b=kkP2urL+O1m2siewgnkNePbyBGp5OPHeamUPvbUEjyPr/9g4CX5Jw4rYlwh1jC5tehX9E8L5ca31EFmM+xwlZPQJhpKgME8t73HkSPs4P1nePDjp6BnQ02IQcxE+VVb6WLyBmGMTEwCT5u0K7c9ig8GH3Za+T2c19+oOtnaUieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709462059; c=relaxed/simple;
	bh=sSlbWp8w0fo6ZB9I6p27wDD69va7J35DqYMgs206rog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSv/BEYHyIVWM/gH80fZczqfwqOqkhQ+7/3egFUY37xGV9g5t+ikp1x7Du8Jl3RDspP8Mof21eJgOw5ituEm74m7dVaka92pC9yIox6PokS+kWDdAol2IkqC6blQlfvK++lPzmfdLzgDkkdAtlnQgeS4d6Y+SB03o4KYipQEL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e3UIQ6U5; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-220ee7342ddso256851fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709462057; x=1710066857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAzMyEKFaHngaobY1UQKf8z/iADtcgL0TPLl027wmTk=;
        b=e3UIQ6U5HBJQJ77PMWPTWRMY8crSQvruo6jiFB3kvbCzlJrM4Wpt85T8RNowqIW6oG
         ayem5KpszdfqwZWjLUHdjvTyoZofhGpXfpG1VhGh2QJ/zY1wUiyJn2oMkp/U26xYi2jW
         /tCaY3KEn70zh3dLcatAD0sv9EG9KvFnrYVc35ZV4d8VdglJDvaeqIdUwQocTb1cUR5B
         rIWoUjAA4YUHHLmzdtpuNftrhSVxFsIy5IZJJuZ7W3Iqai5ai4y7IHQ9/rjmBnekBN6t
         NufRi7dXgKBKzN0OIYl6PR6jVcoXabvnrV0alVJLF/DwSr/1oYHNbdj7E6lcPUUCLNFV
         swxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709462057; x=1710066857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAzMyEKFaHngaobY1UQKf8z/iADtcgL0TPLl027wmTk=;
        b=nM8xLrDMTcBR2vtP7OstOQVcHvhl1TNUR2mGijQ4fP4rgZdC/CUFzMxdlAn8rlmsh3
         LEXQAgzRTwGqCZxqqe5AZyBfcgY2bjT4P1rFa2DW62AwqkobJ2OVz9n3cjMqbArRGNrV
         ktTmgYbwlDJeJEPiq1c1I6yyYKlvuXi2wcVhs5yU1uWEguGkGy3L9hoqax1MZQqA8AuC
         JGUMJOU0BIKf5ltm62+3+RibGUYlhAIsfPes/UzRuiL6m3FQ3Cx5+4oBHaCBLuevBkHr
         2ilBLdMS7lTM0jZ93iGU98mz2phT9h7eJANe7t+sKllSZua6NSl13eBkP2g5JCaV6/cn
         2mzw==
X-Forwarded-Encrypted: i=1; AJvYcCVT7o2diP/DIVrn4aqHTgxlvX0jBizHYNwETBa9eoEdY58oJR/bWVP5+au5ekcHRAWRoyxe+kz3YZ3pt/+jdjn5QHkFran8HJWGWuFa
X-Gm-Message-State: AOJu0YwGbSC71sdwpjlF4tzxwmbInLw+E0X1Uun8J59bAqqeAxTVO4eI
	heXIFtKdQLhWF86BrbxEB/uIy21+yHpFyw55+4TSNwRmYjm/bPnJYIsWcUu40fbtBK+8hWl+pGR
	BzI2+9JFr5V/DmbYskUUeu0SzmS5ESKHdMDDdEA+eIO/2vE7FpS8=
X-Google-Smtp-Source: AGHT+IEzN8xdVBqtqlwhG4wpvImy4MOGUyqq0KZMOKDBgFx1fHgLoq+HGJe7f7hQXjhHG8RKynxhLicyDtZs+AkI1BY=
X-Received: by 2002:a05:6871:4492:b0:21e:8cc7:c7c8 with SMTP id
 ne18-20020a056871449200b0021e8cc7c7c8mr5932387oab.37.1709462057213; Sun, 03
 Mar 2024 02:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219084610.11007-1-brgl@bgdev.pl>
In-Reply-To: <20240219084610.11007-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 3 Mar 2024 11:34:06 +0100
Message-ID: <CAMRc=Md0H4=UZWNOoZR3-b50BrF-ch=34aPdqm2JhOXQzNi-mQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 9:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> defconfig.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 056a6cc546a4..3f3d3350cf90 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -408,6 +408,7 @@ CONFIG_WCN36XX=3Dm
>  CONFIG_ATH11K=3Dm
>  CONFIG_ATH11K_AHB=3Dm
>  CONFIG_ATH11K_PCI=3Dm
> +CONFIG_ATH12K=3Dm
>  CONFIG_BRCMFMAC=3Dm
>  CONFIG_MWIFIEX=3Dm
>  CONFIG_MWIFIEX_SDIO=3Dm
> --
> 2.40.1
>

Gentle ping.

Bart

