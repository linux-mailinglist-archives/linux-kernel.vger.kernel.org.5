Return-Path: <linux-kernel+bounces-84481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1A86A744
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4426E1C26949
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A200D6;
	Wed, 28 Feb 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEV9jy+H"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DA5250;
	Wed, 28 Feb 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091596; cv=none; b=LyRKwJ+DASZHdEo34evuP05LzDoLgk86aSmTsAi8pmSzW/l/QzqPxl3SQrt8uVd/vsIfwycKURHfbc8SC77SwBgMnHfvd5RFFtm7Lxyh1RVi4IeI1rDF8zOhYjL8XsxkOaRkcFrtay0XguwHR3CNhZnHQZtDJtI5JkDmFcpOHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091596; c=relaxed/simple;
	bh=mW6D6M1yT22JJqFLgs3x7ZnTglIxJO1Tk9f5ri1JeME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af1Mnw76gsOiS051boF5sICyENv9eyXFKuwmWswwz2ZvJ9Jl8M3NBSU5Is3ke7bKg3vd/jKUAjDfBOcI8ttnn+nlzgYCfvuvXzq/s27qKeaQQY5NqRF5UMvXUlmopA8/tA35JH7vP37IaH67c1/p7Mta0U3FLA1W6MZ7yrP0WeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEV9jy+H; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so173478339f.2;
        Tue, 27 Feb 2024 19:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709091594; x=1709696394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkLm6jeps8t+V7s2Mn4hBd06iwYNznPOICfgeewB+Ns=;
        b=DEV9jy+Hvetceog0EwP62peuyM878J0AUkWVCaoTAH7FwG2fbaRmf15e3jRidm26tR
         mgory1DJOqrAuVN+q88V4zph4cbwEWK+gw4ti8xzEr8ZPeVBCwFeUYKAvmY+vaynGA86
         CRn3b028gFpp/6voY3WNro0FtN7c4N7lPXtbNyVOeJcpJpe0GrWBkTq8NwDFbkohZ1E5
         i7N1aAOqepCVC9NA/J4c38almpou7GXTgXR7LX+kdjl1+ehBkMiHkI6Z3pKfeOQ048y+
         ABoyfgCGRYslWKp+SFYT0wuvLIFflTJvh0nnFpt6k36VdnwvF5Ss1rYonmC647WKPKNG
         1NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709091594; x=1709696394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkLm6jeps8t+V7s2Mn4hBd06iwYNznPOICfgeewB+Ns=;
        b=j+fYjqjYS2Xl5x4oYkhdoXVZKLnVRI67vtfJIAOPeyCmEQbSSxzQdJtDxDt0XZPLM3
         FjJQ5XtMAw7YpZtC+66cPQyoM9bblrVylataf9T2LwPlzRTAH+kAtc5QOTftjhriSQEX
         p5HkJTgbc61VEZdsbbZkf7ltJuzc+kK8gr1klgFfbHNZqmc0GYx1RPCVQ0HU07ErXGWG
         jgKrXfZfO00sJL/fSg8GmQqwziYZFAh2Yjr6ZwKgr1Meem5FhUW/TtZjy2QwFxaJ5KOU
         oK8YB9zYiE+WwoWkVUMGUk1R/jyAH+j3ksEofaXo2AQVqKA+q9HkX9Z3irquNUbbWNC2
         +y8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDzZYzqJsMWPW4PHWodGXMbwhAUewbHIR4SIBYXB91AGKwOepuA1SIqmafkKeAbJU7Tovbl4fDNuTRVtE5QiDuDS3pWgElUGZ0KBNTaZzKPrEWvMtafuWxfiY/g0wOrHTnblPj++j7yA==
X-Gm-Message-State: AOJu0YxP14a7ghLqXjP4j5AU07rfFWRB6xXSMpiLhnvNRIsomkJPDqd7
	hRnVT1st/5PSvG47OkUO8tp6pKw0W7BBiLaZ5EncnZd+cciF6S+MKQA92tC1YTQ4WMlBkO9jP1Q
	RGUCR9c06B/GUPsaemyjD3QG/Ee0=
X-Google-Smtp-Source: AGHT+IEfc6kJ5DV5LF5/1F1TDY6OkXiHJFBLZ4d+aaiZEdIRgqKAMb5jg80kxCcito9zL2vmyTu0ZHtDXZDlxGUf1ko=
X-Received: by 2002:a05:6e02:ec1:b0:365:70c5:7e5d with SMTP id
 i1-20020a056e020ec100b0036570c57e5dmr11849186ilk.30.1709091594189; Tue, 27
 Feb 2024 19:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709017406-12624-1-git-send-email-shengjiu.wang@nxp.com> <4905911.31r3eYUQgx@steina-w>
In-Reply-To: <4905911.31r3eYUQgx@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 28 Feb 2024 11:39:43 +0800
Message-ID: <CAA+D8AOS5XQhBcDQ2TXen9OdrCpHs-nQUE0QSUJwJM88w4ME=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:49=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Dienstag, 27. Februar 2024, 08:03:25 CET schrieb Shengjiu Wang:
> > The AUD2HTX is a digital module that provides a bridge between
> > the Audio Subsystem and the HDMI RTX Subsystem. This
> > module includes intermediate storage to queue SDMA transactions
> > prior to being synchronized and passed to the HDMI
> > RTX Subsystem over the Audio Link.
> >
> > AUD2HTX works as the cpu dai in HDMI audio sound card.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >
> > changes in v2:
> > - remove 'status' in sound-hdmi
> >
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 11 +++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 ++++++++++
>
> Maybe split this patch into two:
> * adding aud2htx node
> * enabling board support

ok, will update.

Best regards
Shengjiu Wang
>
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/=
boot/dts/freescale/imx8mp-evk.dts
> > index f87fa5a948cc..0fc6c0d21cd6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -138,6 +138,13 @@ simple-audio-card,codec {
> >
> >       };
> >
> > +     sound-hdmi {
> > +             compatible =3D "fsl,imx-audio-hdmi";
> > +             model =3D "audio-hdmi";
> > +             audio-cpu =3D <&aud2htx>;
> > +             hdmi-out;
> > +     };
> > +
> >       reserved-memory {
> >               #address-cells =3D <2>;
> >               #size-cells =3D <2>;
> > @@ -191,6 +198,10 @@ &A53_3 {
> >       cpu-supply =3D <&reg_arm>;
> >  };
> >
> > +&aud2htx {
> > +     status =3D "okay";
> > +};
> > +
> >  &eqos {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_eqos>;
>
> This part looks good:
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 9ab9c057f41e..721ab630d895 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1513,6 +1513,16 @@ micfil: audio-controller@30ca0000 {
> >                                       status =3D "disabled";
> >                               };
> >
> > +                             aud2htx: aud2htx@30cb0000 {
> > +                                     compatible =3D "fsl,imx8mp-aud2ht=
x";
> > +                                     reg =3D <0x30cb0000 0x10000>;
> > +                                     interrupts =3D <GIC_SPI 130 IRQ_T=
YPE_LEVEL_HIGH>;
> > +                                     clocks =3D <&audio_blk_ctrl IMX8M=
P_CLK_AUDIOMIX_AUD2HTX_IPG>;
> > +                                     clock-names =3D "bus";
> > +                                     dmas =3D <&sdma2 26 2 0>;
> > +                                     dma-names =3D "tx";
> > +                                     status =3D "disabled";
> > +                             };
>
> My WIP has the same node:
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>
> >                       };
> >
> >                       sdma3: dma-controller@30e00000 {
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

