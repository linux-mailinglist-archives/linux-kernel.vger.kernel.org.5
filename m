Return-Path: <linux-kernel+bounces-18552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD1825F23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF426283203
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DD6AA3;
	Sat,  6 Jan 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="trFmD2qV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D863AD;
	Sat,  6 Jan 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1704536390; bh=9SZWaERZ6kFi4eiL/X+GEHa0mjNT0xBYc1aGVq0w4LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=trFmD2qVUrnaP2Kb+yuhBN8Kfmhxi2CFv3Umstvta+xTiqS4hmd0cwDjzkYYBS+KL
	 5Ccv0t63ehxb4zcpZra33Jk95T3NqEvrlRi7nvL+/YdvAybMLnD4LeKO1tP2erZZuN
	 28lPTAWCJjcVsosVvlXLYhYCLmLBfOP4G6384bOE=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: hfpll: Add QCS404-specific compatible
Date: Sat, 06 Jan 2024 11:19:48 +0100
Message-ID: <6706261.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <588dd6c3-7d2b-48db-b5ea-48a07077dc5d@linaro.org>
References:
 <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
 <20231231-hfpll-yaml-v1-2-359d44a4e194@z3ntu.xyz>
 <588dd6c3-7d2b-48db-b5ea-48a07077dc5d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 2. J=E4nner 2024 11:41:26 CET Krzysztof Kozlowski wrote:
> On 31/12/2023 15:48, Luca Weiss wrote:
> > It doesn't appear that the configuration is for the HFPLL is generic, so
>=20
> That's ok...
>=20
> > add a qcs404-specific compatible and rename the existing struct to
>=20
> but why this is the solution? If the qcom,hfpll compatible was
> deprecated, but it is not. This commit is contradictory to the bindings.
>=20
> > qcs404.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >=20
> >  drivers/clk/qcom/hfpll.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
> > index dac27e31ef60..5b12982519be 100644
> > --- a/drivers/clk/qcom/hfpll.c
> > +++ b/drivers/clk/qcom/hfpll.c
> > @@ -14,7 +14,7 @@
> >=20
> >  #include "clk-regmap.h"
> >  #include "clk-hfpll.h"
> >=20
> > -static const struct hfpll_data hdata =3D {
> > +static const struct hfpll_data qcs404 =3D {
> >=20
> >  	.mode_reg =3D 0x00,
> >  	.l_reg =3D 0x04,
> >  	.m_reg =3D 0x08,
> >=20
> > @@ -84,10 +84,12 @@ static const struct hfpll_data msm8976_cci =3D {
> >=20
> >  };
> > =20
> >  static const struct of_device_id qcom_hfpll_match_table[] =3D {
> >=20
> > -	{ .compatible =3D "qcom,hfpll", .data =3D &hdata },
> >=20
> >  	{ .compatible =3D "qcom,msm8976-hfpll-a53", .data =3D &msm8976_a53 },
> >  	{ .compatible =3D "qcom,msm8976-hfpll-a72", .data =3D &msm8976_a72 },
> >  	{ .compatible =3D "qcom,msm8976-hfpll-cci", .data =3D &msm8976_cci },
> >=20
> > +	{ .compatible =3D "qcom,qcs404-hfpll", .data =3D &qcs404 },
> > +	/* deprecated, use SoC-specific compatible */
>=20
> Why? That's not a deprecated compatible. You now expect to create many
> unnecessary entries, which is not really needed. This is opposite of
> what we try to achieve with compatibility lists.

Just "qcom,hfpll" is not allowed by the bindings.

The problem is that it's actually unclear to me what "qcom,hfpll" was suppo=
sed=20
to be currently. It was added originally for MSM8974 and friends (see git l=
og)=20
but then is currently only used by QCS404 while in QCS404 downstream msm-4.=
4=20
(I think it was 4.4) I see different driver data than what's here.

So I wanted to just move what's used here to be qcs404-specific and then in=
 an=20
upcoming patch add a msm8974-specific compatible with different driver data.

Also wouldn't the "don't extend driver lists when not neccessary" mean usin=
g=20
something like "qcom,msm1234-hfpll", "qcom,qcs404-hfpll", "qcom,hfpll" then=
?=20
That was kind of my idea if some other SoC can reuse e.g. qcs404 data?

Regards
Luca

>=20
> Best regards,
> Krzysztof





