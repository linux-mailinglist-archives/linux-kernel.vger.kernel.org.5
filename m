Return-Path: <linux-kernel+bounces-89778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8C86F599
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3A1285E70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AB67A19;
	Sun,  3 Mar 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlA8FB3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56235B1E8;
	Sun,  3 Mar 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709477724; cv=none; b=M44U1adKFplhLJEVCCjral3QDtdYgZF87m5hjhlAoxf8hb2B2m4G2/vL2Y6tZQrlRgXlUfYyr5SU1VNgjc9aRbP8r2vtiiD8iNkdRIT32lFlMf6biHoh/bnpduxjVkdNolru+No09iVaftbLWW1z6hvrH9zPnrS6yyYkYzdSnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709477724; c=relaxed/simple;
	bh=zKFNE4/BKI7X/507/duOC2eR6r5WNqry55jGlRdStBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1zrnA2vuYovJ3NCM71ouVfX/QGHHkXczp1tIi61P11L8ib9YnaLbuIGDHsKuwiA04BTzhH+8eWRSMZraWsv1TCXOHHN/S8K2eKNL/nCQ+D8ngwy+pMR2pt/zf+T0MTzIg3szPevFNHGEfOy6PLQ66LOCrnnm24pfYCiHZOzZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlA8FB3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23353C433F1;
	Sun,  3 Mar 2024 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709477724;
	bh=zKFNE4/BKI7X/507/duOC2eR6r5WNqry55jGlRdStBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlA8FB3XCAxwgDjFJsiFiFuTyjZ64l6OeN5agero4ToCq5TU8mBzF8lcgMa+aM3ie
	 autugMIakkuYrAqS48HfPKGT26DtEG0yHCrb5zahZBgo/txX48sw6pGDALMHeZG99U
	 XOxqnVITNY38et6w9Se2Pb1Q8jb9xAJLrg9/fSYp31+LWikOn59swQkjwjB/YA7fkO
	 50Dx8NaKM1Vl/7dl4VYdPm63IWht95z+jMUKrbBqsScq79z11Lj2syNXPrHhNf/wo5
	 BGYvJF3FLJ5apx4yya+hExUtFVB+WaAMI0/iLNoPuo0IQlLvX3E4xABTO+vIhllpoH
	 NhUfagF9bBqhw==
Date: Sun, 3 Mar 2024 14:55:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Matt Ranostay
 <matt@ranostay.sg>, Stefan Windfeldt-Prytz
 <stefan.windfeldt-prytz@axis.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240303145507.25523b35@jic23-huawei>
In-Reply-To: <a5aa10f3-e487-4e70-8010-1604bea3a936@gmail.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
	<20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
	<a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
	<Zd9tApJClX7Frq20@smile.fi.intel.com>
	<45386f39-a034-4d70-a6d4-8804c27aadce@tweaklogic.com>
	<21ecfb62-30b7-4073-bad6-46a9e08e08b0@gmail.com>
	<ZeCJ3T8HVaQZC1Ps@smile.fi.intel.com>
	<a5aa10f3-e487-4e70-8010-1604bea3a936@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 17:35:01 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 2/29/24 15:42, Andy Shevchenko wrote:
> > On Thu, Feb 29, 2024 at 02:58:52PM +0200, Matti Vaittinen wrote: =20
> >> On 2/29/24 14:34, Subhajit Ghosh wrote: =20
> >>> On 29/2/24 03:57, Andy Shevchenko wrote: =20
> >>>> On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote: =20
> >>>>> On 2/28/24 14:24, Subhajit Ghosh wrote: =20
> >=20
> > ...
> >  =20
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (gain_new < 0) {
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err_ratelimited(de=
v, "Unsupported gain with time\n");
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gain_new;
> >>>>>> +=C2=A0=C2=A0=C2=A0 } =20
> >>>>
> >>>> What is the difference between negative response from the function
> >>>> itself and
> >>>> similar in gain_new?
> >>>> =20
> >>> -ve response form the function is an error condition.
> >>> -ve value in gain_new means - no valid gains could be computed.
> >>> In case of error conditions from the function, the gain_new is also s=
et
> >>> to -1.
> >>> My use case is valid hardware gain so I went for checking only gain_n=
ew.
> >>> Matti will be the best person to answer on this. =20
> >>
> >> I now rely on the kerneldoc for the
> >> iio_gts_find_new_gain_by_old_gain_time() as it seems reasonable to me:
> >>
> >> * Return: 0 if an exactly matching supported new gain was found. When a
> >> * non-zero value is returned, the @new_gain will be set to a negative =
or
> >> * positive value. The negative value means that no gain could be compu=
ted.
> >> * Positive value will be the "best possible new gain there could be". =
There
> >> * can be two reasons why finding the "best possible" new gain is not d=
eemed
> >> * successful. 1) This new value cannot be supported by the hardware. 2=
) The
> >> new
> >> * gain required to maintain the scale would not be an integer. In this=
 case,
> >> * the "best possible" new gain will be a floored optimal gain, which m=
ay or
> >> * may not be supported by the hardware. =20
> >  =20
> >> Eg, if ret is zero, there is no need to check validity of the gain_new=
 but
> >> it is guaranteed to be one of the supported gains. =20
> >=20
> > Right, but this kernel doc despite being so verbose does not fully answ=
er my
> > question. What is the semantic of that "negative value"?  =20
>=20
> Current approach is to always investigate the function return value as=20
> error if the 'new_gain' is negative. Or, caller specific error if=20
> new_gain is unsuitable in some other way. When this is done, the=20
> absolute value of the negative 'new_gain' does not matter.
>=20
> > I would expect to have
> > the error code there (maybe different to what the function returns), bu=
t at
> > least be able to return it to the upper layers if needed. =20
>=20
> I am not sure I see the benefit of returning the new_gain over returning=
=20
> the error returned by the function. Well, maybe the benefit to be able=20
> to not evaluate the value returned by the=20
> iio_gts_find_new_gain_by_old_gain_time() - although I'm not sure I love i=
t.
>=20
> > Hence 2 ARs I see:
> > 1) clarify the kernel documentation there;
> > 2) update the semantic of the gain_new to simplify caller's code. =20
>=20
> Yes, I agree. Patches welcome :) By the very least the kerneldoc can be=20
> improved. I'm undecided on benefits of having the error code in 'new_gain=
'.

It's definitely a weird bit of API and would benefit from a rethink.
>=20
> The GTS API fixes shouldn't be required in the context of this driver=20
> series though.
Agreed.
>=20
> Yours,
> 	--Matti
>=20


