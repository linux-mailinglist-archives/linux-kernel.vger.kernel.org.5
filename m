Return-Path: <linux-kernel+bounces-120506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0412D88D882
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AB1F2A586
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC082D04A;
	Wed, 27 Mar 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFOtDwyw"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2C23D7;
	Wed, 27 Mar 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527229; cv=none; b=QamClrZ5wS5nK4f/5wm0zTPf4vIkKsbPKKXLtjuy1rykzYUyVqOMMOO7MGXvugjqxy5YY5B2ptkOm4Jv4rTyo9xw6HHMrNAPJasYYTiDqykgtbXX/LI0vvFgK6attwRqpYjbPGNcpDta9uKrYg/kXmlkkxVJMR1CB3hysLJKX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527229; c=relaxed/simple;
	bh=422qgjDjcc0R+F7arnFQm2Jz0k4zOlxMuTVKFQhSX94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hfn+aOu5jrHYA48a9EWqGFEYCH6h5cHm9MiAilOWA0Qv9PiXapTLYhbnMGCyyUDO/Wm+mtU+zMot8nxz8sjX+4qwR/R4rmxxrhW+bAvSO0FMWIJE8riLuRIPIc1nYSwAW5Ut9CRg1e+OCFnQIypFR+pTi3JDzoc2ZMoszO35w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFOtDwyw; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d8a2ff9d68so635481e0c.0;
        Wed, 27 Mar 2024 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711527226; x=1712132026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsmjHEUm6Fev6qF+PhIOPw/ZPhhQx87uLXE+GyQJ340=;
        b=AFOtDwywCuUDQOZzboeDnwDVrKDeG+6NqkvmUN6JpuRd943Bi+3G1Zp6m+N2nMhyOt
         QQ2FedRw6BCA+D+I/orqo6tSc1ftrherGindbiFUNfGRIXE3qEFodAXLmVpDG6aEpJyW
         maHBNPq0gx1xTs3jGq8OrM64tQqp1UHQRo//GqjwfHGLSU1F6pKIze6jkokk7qBHL/7j
         QxW3z8mmTnw/LHnaE9RdZsTAyfUrMPc4birklhFFvetsxZsWlp1V/U6eA0fvDhPRl/9r
         9Q5fykOdCElQSGU0FXrj57rMzngjlzNdu5275ySmHvxgV0gDjsXEhJ/9zJ9cCyHiKNcx
         vboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527226; x=1712132026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsmjHEUm6Fev6qF+PhIOPw/ZPhhQx87uLXE+GyQJ340=;
        b=bQIndFVDiwdO4RM1W2Qo1eNIbpwAPJq5BASRThaa/36AJ0pkRm/qPZYsWeTDrMI7nW
         uaLfvzjNM2QTFiOjpyd1aQG0HqaTUFlPKBnvQ7xjvKnuRIUnDpOjnLb/d+sQbHLCD7ey
         RGtlahHuJkY8LcOWu8DGTALI8FFff1e4PSIrLMTiPEXw+2U522jU7h6uArG0f1KeXkd1
         A/21xywBPxoitOsgJWYz8UhiAlj6pPuH1owNnTrAfh/zK//dWl6hWXEHw5nsBG8eEHdh
         0KSO2KR3akLUhRG33jxrSi7ZceQibTWZq7VC5yavanSgc1ZVlXm63ETC9EWs/l/BHAZm
         VlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD7tJ4RNxla1E418MKnVA1j6C5CAW+EVPVMFuf+8xI1vm5pKTvPCjYFd6nMy2tkJ/z0oklsZTjYarHzdDEPDRpM1CLfr7NPBE2myKQGvUfg5MW7lvufReC803VuNp8L28tSpQYiDxpruSSOfXni+1FyJOo3jBAKqli9Ic5PBL4YBoMSsyaVxa614MJdCZHaBb820ybPN7kdEiKoDekJFYd5RldD2srLQ==
X-Gm-Message-State: AOJu0YziMs96xtW0nZjebNmmcd4xoOcSi3B7u8+x7Qib7/z+dRxsk6Nd
	QJK8hqA79z+nF0yUeRzOV3eijZ4O/U9Dz2aTuo7gnUN3Rm7ilgjGUFLkwnCloUfR02vDVoYNMiQ
	nuSwLNUmUIQFD94kcVceEjJmaGrkH8XhEbB8=
X-Google-Smtp-Source: AGHT+IG7uB7yrmlwrEOOJ8CrqG+h6L37bUCHCiXdPLo94zqDRp1odoZJIVd5g24kkQ90YpJ/zonb0ynlSblygtEobOY=
X-Received: by 2002:a1f:de82:0:b0:4d4:17c5:8605 with SMTP id
 v124-20020a1fde82000000b004d417c58605mr1935939vkg.7.1711527226654; Wed, 27
 Mar 2024 01:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <a0d7e6f4-5f4d-4601-857a-c485cceffe3b@moroto.mountain>
In-Reply-To: <a0d7e6f4-5f4d-4601-857a-c485cceffe3b@moroto.mountain>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 27 Mar 2024 08:13:20 +0000
Message-ID: <CA+V-a8vuCBzo_2gXsccFuQgzBhWQ7JznFcNsEq_K_6RyhRp_5A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] pinctrl: renesas: pinctrl-rzg2l: Validate power
 registers for SD and ETH
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for the review.

On Wed, Mar 27, 2024 at 7:58=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> On Tue, Mar 26, 2024 at 10:28:38PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
> > resulting in invalid register offsets. Ensure that the register offsets
> > are valid before any read/write operations are performed. If the power
>                                                             ^^^^^^^^^^^^
> > registers are not available, both SD and ETH will be set to -EINVAL.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Where does this happen?  It doesn't seem to be a part of this patchset.
> -EINVAL seems weird here, but it's hard to judge without actually seeing
> it.
>
Good catch, in patch 13/13 it should be below instead of sd_ch and
eth_poc assigned to 0.

+static const struct rzg2l_hwcfg rzv2h_hwcfg =3D {
+       .regs =3D {
+               .pwpr =3D 0x3c04,
+               .sd_ch =3D -EINVAL,
+               .eth_poc =3D -EINVAL,
+       },
+};

Cheers,
Prabhakar

