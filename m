Return-Path: <linux-kernel+bounces-133592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAA89A60E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08D2282F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80A175552;
	Fri,  5 Apr 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjQSSyP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0561C36;
	Fri,  5 Apr 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352344; cv=none; b=Ij1VQ8GgcGL33HR5N67UOD/4AJEPOEJlUpFJG2sCjuZUo2vgD6/DYimjtuD5ax8mRiJ5RptYIpTbi8E5MpDXrW38RC1/uUcw4DNLQnjPXXaig8NeHjNjO9Y2oPNNfR7oduUyNsQRqAY57E531cvLWy0FVCTfmUNB1d/DrLq3AQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352344; c=relaxed/simple;
	bh=qtrepOP/++YzudVg2mOAW7Yr5SJM+9y2cmpgD1N/WK8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=K2l5pwvDbDqN50PYPLokeAKEVV0hn6lajy0hlxMvkw3HI96PrzQywIYCPwohhR1YbfPvUA5K+ru27jQc7Z/rqJQGPiYdzOjO005kv50JfWmg9bAIsGH8woYbLINfcWipXUBP7Gzka6Xf3R43EGI36FLvHMEAvgNZmng1Ob6tJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjQSSyP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E47BC433F1;
	Fri,  5 Apr 2024 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712352343;
	bh=qtrepOP/++YzudVg2mOAW7Yr5SJM+9y2cmpgD1N/WK8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AjQSSyP9hOpfox3T1hgMDJ7CFV7RxrxK8yREv/JBVV1RehSGh+ziIrXPFGZg1DJS6
	 8EWK52CGbPA7vlea/Xa5DjpX3MvN95FE/7dLmPXsouPMzgRl/Hq0WR2WTCnoeE34OO
	 iKlzMv2MpaOnPeUvP+f0FAx8gIKuvonJKe9QZu6O8SFA0aHrn0pRcnDCjjIYS1n54H
	 EowcI3w5q93MuNcEaROcjFXPfdQa6flqWmxkMJb0f2CHofm9SIVwkBZBYWsI8dnOKu
	 wc0letDzZJmFwZSouoJrLVc8yd8FyuwiF18eC9FYGPkNepOGz1GAjjU9lvdrIPk3xv
	 RmZ5zbvUhQ6Xw==
Message-ID: <9d738246b5043cd2a3c1dc7609805f0f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZgaceJT2FMsQVoPa@hu-varada-blr.qualcomm.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com> <20240328075936.223461-4-quic_varada@quicinc.com> <80131262978e6e4799864cdfd0784fdf.sboyd@kernel.org> <ZgaceJT2FMsQVoPa@hu-varada-blr.qualcomm.com>
Subject: Re: [PATCH v5 3/5] clk: qcom: common: Add interconnect clocks support
From: Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, djakov@kernel.org, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, quic_anusha@quicinc.com, robh@kernel.org
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Fri, 05 Apr 2024 14:25:41 -0700
User-Agent: alot/0.10

Quoting Varadarajan Narayanan (2024-03-29 03:48:24)
> On Thu, Mar 28, 2024 at 02:54:52PM -0700, Stephen Boyd wrote:
> > Quoting Varadarajan Narayanan (2024-03-28 00:59:34)
> > > diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> > > index 75f09e6e057e..9fa271812373 100644
> > > --- a/drivers/clk/qcom/common.c
> > > +++ b/drivers/clk/qcom/common.c
> > > @@ -234,6 +236,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct =
of_phandle_args *clkspec,
> > >         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)
> > > +static int qcom_cc_icc_register(struct device *dev,
> > > +                               const struct qcom_cc_desc *desc)
> > > +{
> > > +       struct icc_clk_data *icd;
> > > +       int i;
> > > +
> > > +       if (!desc->icc_hws)
> > > +               return 0;
> > > +
> > > +       icd =3D devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GF=
P_KERNEL);
> > > +       if (!icd)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i =3D 0; i < desc->num_icc_hws; i++) {
> > > +               icd[i].clk =3D devm_clk_hw_get_clk(dev, desc->icc_hws=
[i], "qcom");
> >
> > Make the con_id "icc" instead please, so we know the consumer is
> > icc_clk.
>=20
> Ok.
>=20
> > Even better would be for the icc_clk device itself to be the
> > one requesting with devm_clk_hw_get_clk() so that we associate the clk
> > handle with the consumer device. It would also help us make it so that
> > drivers defer probe until their clk isn't an orphan.
>=20
> Not sure if I understand the comments correctly.
>=20
> In one of the previous patches, had
>         icd[i].clk =3D clks[noc_clks[i]]->hw.clk;
>=20
> This was said to be error prone since the clock would not be
> ref counted. Hence used devm_clk_hw_get_clk before doing
> icc_clk_register.
>=20
> Now, are you suggesting to use the direct clock pointer
> and do a devm_clk_hw_get_clk from the consumer driver?
> This will take care of the refcounting. However, we will
> have to add these clock entries to the consumer DT node.
> Is this ok?

Why do they need to be added to the consumer DT node? Why can't the
icc_clk device driver (icc_clk_driver?) use struct clk_hw instead of
struct clk in struct icc_clk_data? The answer cannot be that the icc_clk
driver cannot be changed.

> > > diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> > > index 9c8f7b798d9f..d8ac26d83f3c 100644
> > > --- a/drivers/clk/qcom/common.h
> > > +++ b/drivers/clk/qcom/common.h
> > > @@ -29,6 +29,9 @@ struct qcom_cc_desc {
> > >         size_t num_gdscs;
> > >         struct clk_hw **clk_hws;
> > >         size_t num_clk_hws;
> > > +       struct clk_hw **icc_hws;
> > > +       size_t num_icc_hws;
> > > +       unsigned int first_id;
> >
> > 'first_id' is gross.
>=20
> will change it to 'icc_id'.

That's not what I meant :) The whole concept of having to pick some
random number is bad. At the least, hide that in the icc_clk driver so
that we don't have to put this in every clk provider that is also an
interconnect provider.

