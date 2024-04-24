Return-Path: <linux-kernel+bounces-156830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136F8B08DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30931C23751
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7C15B0E9;
	Wed, 24 Apr 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmfjRh9W"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1015A49E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960099; cv=none; b=WOUXu/m/69dNchhZBI6YoXGr6mh877RoOYkuBw4sMQsel+ESE2c593uK9I98C7PGrzVdYhzL1k5X0XzHaXhXiYMWdPFMaeDRb6dXmOMtao7lg1s6G8uzLx78lBiJom+C/z9Tt2sigTM60KRuxA89D49YUtZ5uRCrV3lmW63d5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960099; c=relaxed/simple;
	bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3usfTA9PQkuns49As0LzesTZwi/CCEcGbrXjyPdFRXvvQT0f/3TPYK3TY4yQloA3AeNm8TPwkJCDgHkBPnb76yplRrA1z4D1a5PclNfoaAzjm1gTMPFsPKcR7sL4+pblkcx+pRQ6QpcRPVDTFtIhbNKFZKXBA6nTYuikbdkzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tmfjRh9W; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so6517759276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713960094; x=1714564894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
        b=tmfjRh9WA0Gim+MnjfLeMq6a+z6+t7/PoXocOAzy57tNcXm7MC4AkgITeQPBCgtX1l
         dGQA05mIOtl559U1U+vgqcljQp/jVzHYxjKyf7K0boxeYS+TelG6aS6JVfV2C/+VWAig
         y4xxi26AzN7/payAGJA3aJtp47TRYDB+xU27ht8Puj8Rnq7QIQczyfCfeNvUfbhHEny3
         OWDZ/mV151DA3Yed6m+IRfHi9vp3HLTSl/UGvEW9rmhk/55lGpLkHyBsrvLzE9z+TGSk
         0LCUlRjO7SpThDjPoouXc+aOw3JU2qYVv31Zz5DrUM2zu+8tXPCWGdHjZ/JCTP2kBmEW
         49Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960094; x=1714564894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CvXLMHM5mvieJKsaX+p+mu975Ln9+UEW3V4OyydHIw=;
        b=VFXjRnkCcR/6UL0h7LNEZAN++E7KfV1US6DTi0rvUtKrjQKBIBbWI4i5G/Gt3ObPYz
         vR1eFVsHCebX8kv62EHJPmDO8QZHbt7oH836KZgE+37+rTY1oz05JwwCQoNCE4ToHkGC
         1TxFW08r3W7+uFUIxKi4ZqTxFhTy4YPWYaFDk6gl8iSPwzK64ouWzpGoi5gyDIBQo7z1
         /NWIoq6mZLjKPSFzyZcgLCnlbrp7Ro6eD1EqiOz0sw+ryFGNgFN1bs/8ic06O33PCHRI
         5cYCepuH+NbA0FTyyJVmtMi6KHc5OXR0FOfFT5JheDBR8VTeJnPgaigdGkU4g7riuzBA
         lwIw==
X-Forwarded-Encrypted: i=1; AJvYcCXrNAEygw2H/fgnLl6GefQG4VJol8GELA/3F4MvUhrR03gczasVtOesOYnvBtoqaXXIa7lwZEZQRl8jmU5UKOvu//aDu4gMkaYVj6GK
X-Gm-Message-State: AOJu0YxyWhA4PlAqTloiPGB8AzGou5Z3bKbBXAKsybaftyyxJDiLBCzS
	bBsjQv7VhqWzfZZC0ikfNB0A810rLnIcNJ6/BVSVTfDnIZ+JnKVucjsYIa3t3rUeQFHYO2gfwid
	ernNTIJDUHdbnTdvOKGQE1bZ4XzWAN1jStH71DA==
X-Google-Smtp-Source: AGHT+IHzZo4Ut6gU9UO63GhCLg1BvH9isGdACES/j0J9GVRMC/W9uMmUWJy79G52Yy/44lup2sqppkr+3ipIco497iw=
X-Received: by 2002:a25:2fd1:0:b0:de4:6efa:debd with SMTP id
 v200-20020a252fd1000000b00de46efadebdmr2514071ybv.29.1713960093802; Wed, 24
 Apr 2024 05:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org> <CAMRc=Mfwa2WSOLaUMaEM1czTcx31jynGqgxzLdCh7ROktQ_Vag@mail.gmail.com>
 <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
In-Reply-To: <6433c145-a448-45dd-a982-8b5df0ca5c16@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 14:01:22 +0200
Message-ID: <CACMJSetnNDwVuRksjE2k=OJYoaa0i89kWxd1WB9RmTcpz78haA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 13:59, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 4:53 AM, Bartosz Golaszewski wrote:
> > This must be your email client wrapping lines over a certain limit.
> > Try and get the diff from lore[1], it should be fine.
> >
> > Bart
> >
> > [1]https://lore.kernel.org/lkml/CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com/
>
> I don't think it's my client. The extra newlines are right there in the
> lore link.
>
> Look at the line that starts with "@@". That line is wrapped. The
> following line ("serdev_device *serdev)") should be at the end of the
> previous line. The same thing happened on the second "@@" line as well.
>

Indeed. I just noticed that it applies fine with git apply and figured
the output must be right. Anyway, this is not a proper patch, I will
send one once I adapt Zijun's code.

Bart

