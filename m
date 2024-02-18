Return-Path: <linux-kernel+bounces-70599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E528599AF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669C72816FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65E745C6;
	Sun, 18 Feb 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgJf9XqW"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8174E32
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294065; cv=none; b=nL1C5q+sbTc/OE0VzsCQbvfP8LuUswCQGkwMGzsClfcRxkyIZhr4ZPyYLm8x/tPORF3n6Zv+K8b1GUPI1UQY1y9R1R1UckWdcAjmRfkOM0C/x042JKk0fUM8Qdnrc5qzkSY9hFTDfjNZ5T4F7VBTosA+Z26VMoRVetpZatU+Rf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294065; c=relaxed/simple;
	bh=noyT0NVbOw9JrKezMpMB75c/1hxZ5UzrFj4VHYRvb7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDC0y7r7SWw9QPcmqltctmf/e9JuYJm4Y/nGr26zAi6WjS0urXNRcgWszD9vAjFa9cRZop+obLqxT8MtbwTg3xwoMPCY+hINWCvugP2gyrozm2ul223btCo64O+VyDACOLtjY1sKI9Fr77SIqScd2kqZVhcs/On4mY37D7MBDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgJf9XqW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6082d35b690so3565247b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708294045; x=1708898845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/A2VqH3T77p5BaaLS4Ba0fiwlO0C0XzwKCCFd7AcBU=;
        b=mgJf9XqWGUumAC+UNXonICacLre696tHk+hJsYaLF7sJ6x/bEtcK6DUC0/6nP3/IBg
         qyfTzye5aMjFKYCAMX5XGbMCcbdWZPMvEV9zLzwlhV/0URrdFIHHKjB4vaoBD2gT/dgy
         cGiivjyKiEzSzg/aDXSs8UX6S0/wbP2y02PntYndRAtU080d9vrshuVtt6pNVMVgSQVA
         dgqlyvmfRTwt89cWHf8QnuOsx2EPp35CATQ9sa14ZCqgSQg8oFwTkvCAE+LtHqaBCcQ+
         NG1Z2/Ld/PSm72h5uH21ddClzCzv8NsDRz/CsnE/QCwQkPrFFHFBYWsEWK/n3hKD6iAv
         RO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708294045; x=1708898845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/A2VqH3T77p5BaaLS4Ba0fiwlO0C0XzwKCCFd7AcBU=;
        b=TFn3hPIUrlN4vRjhs/nM/KzFIhnBmtkGBVK8TBXT9MZOWCMAP78N6lF+krjO5mztXt
         6YkiaSkE+vKi4FDh3VMypjfmXvKEZLhdjRQ9kpv8POBEz+Dyc20Wuv9Dqpgxb1n8pwYg
         2b58i9iV25k6XbNBXSYOqepdhmr8CoKcPWYHtuwO3dK6QBcP5OqxC7v+ee/3cFHEEAGc
         Yv7b+7NBlHqgUCAiyjhyNv6hoxVzyAwXA9t/klrdYuyOVFwdMmnYCe7KyweDsIwFxdrb
         bCLHaopORtteRdsLPMciqnGa8efJsmg82xrAa/9Py1BL8XW7S6ljVeI4zw7/Jc7XWZv/
         csBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTad0vNECFkoZj2kq4MhX6s7crlCQqrWpAYOYqOMuwDCrfNpGF1cHKDpuuoDy+KKYHXnIatgYhiyT63s3QOs7TvlzUlqbUOeOMmmNQ
X-Gm-Message-State: AOJu0YxHK5Rp2rVgwBjmE/Fbp5vmDyRnjqHsuXlXqjeSEGeybeJzctZQ
	RFSfUPl0xapNQN3DhBlZlern1ziipgdeVYoHuSPKbNpX477iXv/oS1A1Od+X6+3HfKmZ4T9Zi8l
	9qzPetNOVnXg5Wwkutqay5k7fl5hxysPZwqaD+g==
X-Google-Smtp-Source: AGHT+IELeLyIUJs5SAO08A3FKHyNU3pAuY4NxArUAv+xkFbNbCBUKbAWybGbjMfZ1EVD+aa6gQDaSPl5tjX9WAb5sEI=
X-Received: by 2002:a0d:ca12:0:b0:607:84d9:9820 with SMTP id
 m18-20020a0dca12000000b0060784d99820mr9366084ywd.24.1708294044760; Sun, 18
 Feb 2024 14:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217163201.32989-1-danila@jiaxyga.com> <20240217163201.32989-4-danila@jiaxyga.com>
 <6bf11ccd-ff08-369b-913f-277c189afb76@linaro.org> <b0b732b8-456a-4021-8277-cd51f01ead17@jiaxyga.com>
 <44c669a0-3722-4a58-be78-0c91f0573ca1@linaro.org> <60728953-bdf0-4a06-a90a-d1191d41962b@jiaxyga.com>
In-Reply-To: <60728953-bdf0-4a06-a90a-d1191d41962b@jiaxyga.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 00:07:13 +0200
Message-ID: <CAA8EJpqxoCwqOWuWe4B63swO_hvREhN2czOpe0wM5mt-FaWUgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm6150: define USB-C related blocks
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, andersson@kernel.org, 
	konrad.dybcio@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, quic_wcheng@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 20:53, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> You are referring to Dmitry Baryshkov, as I see. But Dmitry has already
> reviewed my patch (message above).
> So it would be rude to change anything without his knowledge. Let's wait
> for his answer.

I missed this point, so please update the IRQ flags accordingly to
PM8150B, as Bryan has pointed out.

>
> ---
> Best wishes
> Danila
>
> On 2/18/24 20:14, Bryan O'Donoghue wrote:
> > On 18/02/2024 8:05 a.m., Danila Tikhonov wrote:
> >> I know that some interrupts have both for PM8150B, but for PM6150 all
> >> interrupts are rising.
> >> Please look at the downstream kernel:
> >> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm6150.dtsi#L319
> >>
> >> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/187022f2721d584ac4ec92c0ac1af77da487521d/arch/arm64/boot/dts/qcom/pm8150b.dtsi#L292
> >>
> >>
> >
> >
> > Please take a look here, I think the same logic should apply to your
> > patchset.
> >
> > https://www.spinics.net/lists/devicetree/msg665558.html
> >
> > ---
> > bod
>


-- 
With best wishes
Dmitry

