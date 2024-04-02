Return-Path: <linux-kernel+bounces-127796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1CE895117
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F4E1F234FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FCE7829C;
	Tue,  2 Apr 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttPHB8Im"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F07691F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055463; cv=none; b=EglVKcNGs0l4102lVw8yOXiOIGfyHy6WnjC9oUJsOTSe9mGaN8BfvoKo7XC4OB81p6+Meq1GEIAtigd+tmxY8o52atbs+OrFNkaVF98RLEMFCIZoiyBxDzErlSw7k6E1VCnDf2I9hKg4G/rcWXoepEJMCBtBbY3lIfZEBtiPWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055463; c=relaxed/simple;
	bh=wb8z4B2R8uSmX36QzPxkA3oErAbdtrPTFeokB1Hj6n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=golfg70L8BWj3J8QipToZWpIe4Eq6Rhy3BcT5+wSavm3bMWaOk3mPCNYV25CxeZRB3LZaieTo8yCXyQQrCfbbMld7v25P3MYKOfQlozb4BjhjWYqjRf2hWWZ6AHai0beqelkwb8g2FUOl7Kvzs5Tg1OlFelkfE2V1seR/7LoMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttPHB8Im; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a104601dcso51334457b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055460; x=1712660260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wScIIYCuS3okuM5iCNhPB7h15aR5cz5zXHllkO0Azc=;
        b=ttPHB8ImvMyUiFYkAXv74ieSO8lUozsfq9L3DdR0WS23Qgt35kGyG5kFNJIWls2Ykl
         e5GLoaIp6U91wFM7ZiT3ArW7Ta3I3WOmO4YKeCmWQ5H1uJHK967kAg7tZlM25yrqRGkL
         oN6yzOySfUxhY2t5HZolxwUVvWOUPS2/HpRnqvudTv0Un+OFcQpjVwPUqP2z8HEW5DhV
         7aCTMU9xx50ghxDashLoFkhcfAVGycBomwn30S68aKBezMb8Uuky1ZqgIVUIRL/IgsHr
         Nkm28+bxRYJ3nVo+FbcBYxUByNQRsCQLL5oRDchF87r7vyHcaIucGiiUceiAglYVFJRV
         krFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055460; x=1712660260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wScIIYCuS3okuM5iCNhPB7h15aR5cz5zXHllkO0Azc=;
        b=EhIwhjIxkF6a1pqoNejfnPZjTkF10A0Lzkd0G88UUUEnoPLiuOB+5/f/n6N+FQ1vX9
         GLP+mq66Fx1hTsvP97QUbvRBdj7v+Q5Kp7M+vM/YfpFy8QzGbRUV8FbNVHV/9dE8GCXp
         blTK9clOoMzBe8dtDweMeri/HQ8DL+KHxolUEvsp2n3Ge9z1/32wyZW7q0g6dlhmIh8B
         M6erInsfjV20TBSPJKg1TjE2FqBZSiYFVBG5L+FvoUzZ3BVouk6qVADGjkbqn5UMxZlK
         oCB/KqtwdqMQLP5k8SOCH5Rowuh8NGSVlvi7q2kaG7OYKN8Jux4xfuCrPyQsRGYk+SF6
         a3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX793ntp4jkV0ma1Hkgz6L1AEIUDQfPjn34Y8uPblBZPSTr1iBRtuFtuq1qn/YLkF7fdTwapBjVIJ3BwUxEUUeJSVYq3S7/XoD/DSYT
X-Gm-Message-State: AOJu0Yxz2xN2FGkhMTZz0VZIuG0yJstlO/yo9sP/Lsg/Yv653b1ixv3O
	4icjOPgo7DHNIGwXKXv3NdXslP4+2lrdZM7fk1f8wpOEWBfZ4Re2UsrZJa7mkUhxGVJgYGOyBPD
	Q3/DAVHAOTKOBUnWti0D2Hu2iPyS1jvpgf3+9Vg==
X-Google-Smtp-Source: AGHT+IFQCv3dm5qgowWNv3KJpRYhlCiUVr3vJHaiLx4pCad0+caOe63/2WYWFMOxhNqEMQRVMozACvlWGPQkYE1hg9k=
X-Received: by 2002:a81:9194:0:b0:615:15fe:3cbc with SMTP id
 i142-20020a819194000000b0061515fe3cbcmr2251957ywg.25.1712055459131; Tue, 02
 Apr 2024 03:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214831.1544595-1-helgaas@kernel.org>
In-Reply-To: <20240327214831.1544595-1-helgaas@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:03 +0200
Message-ID: <CAPDyKFrxZYrUDEk2Jn0tOPVZ7=mhFfVy3_KMG2DLEQRFj4G=VQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci-gli: Remove unnecessary
 device-dependent code
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Kai-Heng Feng <kai.heng.geng@canonical.com>, Sven van Ashbrook <svenva@chromium.org>, 
	Stanislaw Kardach <skardach@google.com>, Brian Norris <briannorris@chromium.org>, 
	Jason Lai <jasonlai.genesyslogic@gmail.com>, Renius Chen <reniuschengl@gmail.com>, 
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 22:48, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously the driver hard-coded the config space locations of the Power
> Management and the AER Capabilities and included device-specific #defines
> for bits defined by the PCI spec.  This replaces those with the equivalents
> from the PCI core.
>
> This also replace hard-coded power state changes (to D3hot and back to D0)
> with the pci_set_power_state() interface, which takes care of the required
> delays after these transitions.
>
> Bjorn Helgaas (2):
>   mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
>   mmc: sdhci-pci-gli: Use pci_set_power_state(), not direct PMCSR writes
>
>  drivers/mmc/host/sdhci-pci-gli.c | 46 +++++++++++++-------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

