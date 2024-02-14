Return-Path: <linux-kernel+bounces-65198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A385494A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29285B239F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E779524DE;
	Wed, 14 Feb 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcur9vBo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD1524C2;
	Wed, 14 Feb 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914209; cv=none; b=dtaON6/jkRz9FVy9YhNzFTQEGdGkEAhT6/W7dqo9ruIZfDyLSZvs6mY7tbYO9rLAQbasjb49JX05pZ0ArQEDuRPuI1JSzztweBN7I3UrQ1OfUdfetdLpsihFURkHBFMZNXy7dCeiQW2OPQ2sGEi0AUwxDSSVg7WL7BmX0Qz7fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914209; c=relaxed/simple;
	bh=Rs37AXTz4l3Lz4V1NRh4BL+a/kD0vmMjntyKl7JVXiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVDBwsyJr7gzpuzheFTyjMeEXhR0W2MGusss+NNRNj98YXkpd4FQUHkA+KEs87pHGOgZds0LtLGe8xhYDm5sxE3jOIrVVu/VzflZIAjSXz50V/AAIWUGDso9sE+UoWVmf4lMLgvUrRNYP8t5Yy0mDLUGXscgPGn+P1BEbgZwg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcur9vBo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1db562438e0so5542295ad.3;
        Wed, 14 Feb 2024 04:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914207; x=1708519007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3hOuwmcOy4h7Pq7KcsMS56Zfq3Ol0wBjKdoyWghw3M=;
        b=Kcur9vBo/9Iz4gQmuDQkSmouLNfA1iR2rSJC9GpZjXWDiz4w03QrEDOQ2+nWUOpQi+
         dtURbFwlTYhlTY+K2fc93foyjNVKIDzNj7zKQ/6gDuzbcztF8YcTipy6Yy2ATromyL+7
         gHSU8bonbpN0bt86F1BB7G8uJ0m1CyKJrUcbF9Q2rFsLvF/15QpI8t/NBH8d9oY1T2UI
         0Rz0Apf6XDtFx+5lGgWH+RzfQVYSBxso91XSoqlXGxjXbjwZhQz1UjLnycu9ig913VZl
         tjwMa/oexwO9q7bKUA3IL/N8Ce87HySG/cgDNsa/yEl/2vSjIP3vxonmmLrpHCNwgP8V
         IJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914207; x=1708519007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3hOuwmcOy4h7Pq7KcsMS56Zfq3Ol0wBjKdoyWghw3M=;
        b=qlmlTou2jWVgtlG7b+Pg3yHBhdw4oxR/fK1BQqHCQYH0l76twHux++IhEjFJgZmbqs
         Y+N3Tm4xLLH4rwRzNVvfIcFP9tgGBpB0pBvq2k6BSfCrLmgb0TSEJy8KueXQjD7OxJSF
         ik04EYYHVvGuh3cGbxhqFZtsWug80XBf6mA4agC9DX6mUl+TBCY7s/oSfO3cA+jc/a8Y
         TEIWTsSpIQy0tWi21Gs6ujJQy/3cNlQUl38onxzXVSX50REyRwfJndU+BtnDAhxIBRr6
         IjsLpjI8HwkcoArMbp0aqumugKrrfvdmUq7lFFiYEWjMNRA5/G1eS9CRgdeeIET3CqfT
         Gi+A==
X-Forwarded-Encrypted: i=1; AJvYcCVKKCGo/hV7igkfmmxvp+nRzjXVdvSCNTzK2f9efLVEu9Og7RmLPtts/CIEyNklOM2yp7jCOfwqjvX3VuvXW2xyQBas3zaYY0LmPvuLapixAyeLjbWLsNJUgeZiV/Cs4WnvpWBxyt/swQ==
X-Gm-Message-State: AOJu0YwzOIsEDy5aCgaEsVmbjIs+snbwfQbKjwkXUK3Ir5BYGajgJdUf
	PItorSlkeSUBoqz546Ezhz5LjqD7bMLd3i8YJeCWBFFRCu21mO4Mjk7DWFHLcv/p1nKElxWPU7s
	+4JvuF6Hmb1h2tVnwqB0pmkYLlcY=
X-Google-Smtp-Source: AGHT+IHXfLlKMUyG97H7k3BU81qTA+mF1/UVvd07cvvpzVXkxAA5MYm3B8l7cF2tSJYKaD4S4ZsvDWr0Pnfh+93lU/4=
X-Received: by 2002:a17:90b:1043:b0:298:c5f6:edf8 with SMTP id
 gq3-20020a17090b104300b00298c5f6edf8mr2565325pjb.0.1707914207196; Wed, 14 Feb
 2024 04:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210204606.11944-1-aford173@gmail.com> <20240210204606.11944-5-aford173@gmail.com>
 <20240214121517.54552a4a@booty>
In-Reply-To: <20240214121517.54552a4a@booty>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 14 Feb 2024 06:36:36 -0600
Message-ID: <CAHCN7xLnXMZJkTjWBP5HW0h2-bUOyeNEL2oO0rnV5tNaz9Hv7A@mail.gmail.com>
Subject: Re: [PATCH V4 4/6] arm64: dts: imx8mp: add HDMI irqsteer
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:15=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> On Sat, 10 Feb 2024 14:46:00 -0600
> Adam Ford <aford173@gmail.com> wrote:
>
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > The HDMI irqsteer is a secondary interrupt controller within the HDMI
> > subsystem that maps all HDMI peripheral IRQs into a single upstream
> > IRQ line.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Add my (Adam) s-o-b and re-order position under AIPS4
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 0730d4cf9bc4..9b8ab367d774 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1927,6 +1927,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
> >                                                    "hdcp", "hrv";
> >                               #power-domain-cells =3D <1>;
> >                       };
> > +
> > +                     irqsteer_hdmi: interrupt-controller@32fc2000 {
> > +                             compatible =3D "fsl,imx-irqsteer";
> > +                             reg =3D <0x32fc2000 0x44>;
>
> The last register being at offset 0x44, this should be <0x32fc2000
> 0x48> or even <... 0x1000> as the TRM mentions a 4 kB size.

I'll do 0x1000 in the next revision to match the documentation since
there doesn't appear to be any overlap.

adam
>
> [Tested using Avnet MSC SM2S-IMX8PLUS SoM on Avnet MSC SM2-MB-EP1]
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

