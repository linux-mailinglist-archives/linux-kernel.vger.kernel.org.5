Return-Path: <linux-kernel+bounces-112317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD642887845
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6E2B216F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407381863B;
	Sat, 23 Mar 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZnkXKJT"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F0168A9;
	Sat, 23 Mar 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195538; cv=none; b=FtIW4d9/Bbn5smLtYwaphYZDH58TleOZpKonSHMvFmR4BXTDgyfoou85BMAjMEpe4Uvxmlw/3eLISx8W4hTbgpaRob9QtLq3rXsfH4aEn978TiT5UD8SJqkZxycopT4KJq60N9mvKvely+GZVdnkR6C7PV9cM1lOhXJwtp1PWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195538; c=relaxed/simple;
	bh=PnqDrGN1ZM8+Q/bDbLibxzzNp2zx5uAhEttwWQSJ2lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFgN+Kp4o38t2apssdLZER62AUggZY0PSDDslUd9lxGaanfEhtbLB0aEIwjYMG+/Fzny8HvfL4nCQXq+e8AFs/dBhjefABo3hHqB2lVp7RoxGNpGmXiMrCwnuEwdFts3HGINQwxRG8BcSYYFRnHPJYK4WkPNLNk12Xa7dLtPGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZnkXKJT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a0579a931so32371727b3.0;
        Sat, 23 Mar 2024 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711195536; x=1711800336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx/cNzl80P2Wm4x7ZRKtP27dRRaiUpFd8uaJOVCtaXQ=;
        b=GZnkXKJTqcEcFnRSgwQDwWHQd2NL1f+tAWE6abTRSrUYUMtiEJhR5Yufol4z9JywF2
         6M2rEEuutk2yAuzv4xImX6P/ASsEsfX9mg5HlZ20L2tHKU+dxJ9IoSQda+u4lpmU/7Zh
         Trhabb2Q068mCadDQk+3RxrHtxw+a49hIthRJ20rr6PDSEWtZfSq+Jn8bT4CsxHdldPS
         ldP54xFq2rdO2pzyYLTCTEsX9VMnewI5BQCS5zVrK1yg4FcFbVPPuK53OSOMIrqfbn2Z
         id0IMkrCGLUzXFfOqnbjMIRlRy3qeFYaEr4/4qdo6eT6uKoNS3HR10lohjNDeU4jhAJK
         dDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711195536; x=1711800336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx/cNzl80P2Wm4x7ZRKtP27dRRaiUpFd8uaJOVCtaXQ=;
        b=q5AbOWlkBYlrnSPjDHTOB2kp2Pv9KZNnKjY1SmX3t8LzpFDmemfihYJYVBLYW3DKqv
         grBrVISiIWf1fVl4qCRPfJZZq56bdojbCVqGU4v931R9FEgug+vkMRaB7EBAwWjS1qvP
         tWWK9uQtWtn6DUkuvua2QbaRV2SGRm8BogsrM1kU6FycaYRa/KQgGFX1MIfF/Y/9C3mF
         9kZos8Mu5kqDAO6+tA+VrwfZL6zVV90mzgl2GJJHaauRHjc5F1DupKq4CgS62ieGN0GX
         xrZaTT0UM4NppVg5zddqqh2gnFDHuK+09db2Z9HC9SRg02G/wZRTZtp3wF94YZIXunp6
         Kc/A==
X-Forwarded-Encrypted: i=1; AJvYcCWY8qWcN2ZQIywJrUWzJYrJoZtIxZP1yHyckLFgRI+uKAsUdX3X9J5Asm79ysfiim3N0ZW3UkX+c4dOkBfLPxZplPHj3fyZzHXYVkHon02v/zozymOJthoDJ2694pDkqu+JPAXivqx28oPR2ZUoM/nZ0d6J8VuNaCBdAyxyJXx61j9lRg==
X-Gm-Message-State: AOJu0YzBuFDkRS1ip1Tjvx3mR3FCpwoqJbKoyq4u8IWCyC2cpOjFLvyh
	cTK0O99zCMxczrTi6FXehloFBT6uhzoFYG0l01OcyD7SdDq2I5IXlbewwZZ+Uqq2qfL1aXGnNIB
	1Fcr3K8azGpthgPZxkVLhpQMGaxI=
X-Google-Smtp-Source: AGHT+IE67pFu6J76ApCzstA3UueztcGecLYefoGHKYtkiU1HwYRSn0q0pR41zjxqkue6C88lhNIho+KyRYCom69dHGw=
X-Received: by 2002:a25:c381:0:b0:dc7:4b0a:589 with SMTP id
 t123-20020a25c381000000b00dc74b0a0589mr1500585ybf.55.1711195534625; Sat, 23
 Mar 2024 05:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322003713.6918-1-l.rubusch@gmail.com> <20240322003713.6918-4-l.rubusch@gmail.com>
 <20240322021739.GA3418523-robh@kernel.org>
In-Reply-To: <20240322021739.GA3418523-robh@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 23 Mar 2024 13:04:58 +0100
Message-ID: <CAFXKEHYrRn+vKZB9eX_RFDLanhqLsRwT1b-wxUdeZTrBrshSzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Rob Herring <robh@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:17=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Mar 22, 2024 at 12:37:13AM +0000, Lothar Rubusch wrote:
> > Provide the optional spi-3wire in the example.
>
> That doesn't match the diff as you don't touch the example. But really,
> this should say why you need spi-3wire.

I understand. The change does not add anything to the example. which
is definitely wrong.
Anyway I'm unsure about this change in particular. I know the spi-3wire
binding exists and can be implemented. Not all spi devices offer it. Not al=
l
drivers implement it. My patch set tries to implement spi-3wire for the
particular accelerometer.
Do I need to add something here to dt-bindings documentation of the
adxl345? Or, as an optional spi feature, is it covered anyway by
documentation of optional spi bindings? So, should I refrase this particula=
r
patch or may I drop it entirely? Could you please clarify.

>
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.ya=
ml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > index 07cacc3f6..280ed479e 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > @@ -32,6 +32,8 @@ properties:
> >
> >    spi-cpol: true
> >
> > +  spi-3wire: true
> > +
> >    interrupts:
> >      maxItems: 1
> >
> > --
> > 2.25.1
> >

