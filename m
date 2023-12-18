Return-Path: <linux-kernel+bounces-2918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8581643F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DEB1F21D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CE23D2;
	Mon, 18 Dec 2023 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYnpCtjw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646620E6;
	Mon, 18 Dec 2023 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da16eab6fcso1966503a34.3;
        Sun, 17 Dec 2023 18:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702865156; x=1703469956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYgxq/oGHPZP2QPh2THF7yf9x5x7XDARqeJu+ip26js=;
        b=gYnpCtjwcFxHVX+w1IgCiE7CQZtFJEyzZMVw7++2ZHCw+MtmBMc7LBD9LkHHtML/Ku
         nQwAgov12B/wZWcRlapIJFLjx/i28xggIJV9kyyEeds4Ae15/xjw6sjdkbWyFAfuAGQn
         b2zcmaav7F6WHjwQ9DziEt78+7s0ZwBrM9tzd0Z6dGnETxEoqbH1aeCMvo7VRYwOzFGt
         knl0iOqJNIpCdlROqW4hmh2lWRHVTxjNoy3DQGRMl8oAM8bQ+rVnAFbVAlW34x6vW0ZX
         FyOwD+qp6Y3u6/EOQC77mSRm2wx853A7lkm3/e6dhVDcaRb8VittqkUNfGs5UmJEHtEM
         dGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702865156; x=1703469956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYgxq/oGHPZP2QPh2THF7yf9x5x7XDARqeJu+ip26js=;
        b=YFcKH5z7lwIRQS97xZT6Xo1f/8c5M2taXWAS324Rn3PP/vaX753cIC8x4lYHcYPvFG
         /hc8uNvly6ZqKfXztX9tPfuB+xDd+JnKFmEhekxJY8gH+UYYLTa01taLnyv9r81Eg+zZ
         OxSjwPXlnhJj9mK/4FncoOk53lo93UIY4Xa1a8oSxWzIyBerwcotkc51crfFQTLekASk
         4YliIcvceNagkXWXQJQ3Wed0vWMrC62PuYJxqEtJMuub8rl1wDCV0gpkBqEzJg6jCbxV
         DHGycZ06Zs/zY8Qc4b+CEAU+IhHDVeS/fXowo3dkXa3dNE3JKDyGzx217VvsSmgR4zdg
         fobg==
X-Gm-Message-State: AOJu0YyyrCPiXQRUfEljZLK+Fhb4lv0DUeyMmyFM8qaEPGbeEYOPN69a
	RkJyJzQAGbxR+danr0bs8E7SFTR9vTxzrkzCIJv7T0U16b8jtQ==
X-Google-Smtp-Source: AGHT+IGBwrGNS9Dnl9lwF/1w+WhHz837HY02kVuOAbrIADpxHLShvoerEHFpRqt9ZQ+uwBHPb34OjffS5iiPGeqVEOI=
X-Received: by 2002:a05:6830:268c:b0:6da:5923:3d74 with SMTP id
 l12-20020a056830268c00b006da59233d74mr2051629otu.31.1702865155577; Sun, 17
 Dec 2023 18:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-4-qiujingbao.dlmu@gmail.com> <20231217-congenial-unwoven-8067fcbff9d5@spud>
In-Reply-To: <20231217-congenial-unwoven-8067fcbff9d5@spud>
From: jingbao qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 18 Dec 2023 10:05:44 +0800
Message-ID: <CAJRtX8TgK9Pi+urMSzCzKROw_gsDeMK2GeFSfXAougk_iHQ_vQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Conor Dooley <conor@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:48=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Dec 17, 2023 at 07:09:52PM +0800, Jingbao Qiu wrote:
> > Add the rtc device tree node to cv1800 SoC.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/=
dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..429bee76f677 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -119,5 +119,12 @@ clint: timer@74000000 {
> >                       reg =3D <0x74000000 0x10000>;
> >                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>;
> >               };
> > +
> > +             rtc@5025000 {
> > +                     compatible =3D "sophgo,cv1800-rtc";
>
> This is a cv1800b, not a cv1800.
>

Thanks, I will fix it.

Best regards,
Jingbao Qiu

> > +                     reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
> > +                     clocks =3D <&osc>;
> > +                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> >       };
> >  };
> > --
> > 2.25.1
> >

