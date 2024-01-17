Return-Path: <linux-kernel+bounces-29448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE32830E67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9699B2407F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEE2556C;
	Wed, 17 Jan 2024 21:13:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82846250ED;
	Wed, 17 Jan 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525987; cv=none; b=W48TpLGeLTQQFxQrUKPOTPq+c7hk67OxGiRs0FPxX4SWT68x3xYU2RZProINgSK9QzZOP8fvbv+AQ1/zASN34S1u+GO6r9U9zAdRO+StVbKb/LbC+t8pqOTB0jOYm+IXHNgzL7s6FqaI0qBB/KWwTtI0L5hZUqNUB+RPn/taPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525987; c=relaxed/simple;
	bh=edq1Ft2FanGk/R17dlBLWwkgbJC04NX6HQM3VN/uU2U=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=mR1rZnwYngeAQsR4MRJp0slGEbQ5BupdurYFJ60mt6UaFfYCJsUjLd2I9cV/YpW2hDCx27hQTmS8SWFVeevFp5OlGFXsnEj8ilTPMyR06cOkz+/Ghj+eXOdVOB4YMau7iXYCSCtSui/hJ0CcgNoUHjNGDm+wI9Tc1zs6v+T/3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rQDDH-00039N-To; Wed, 17 Jan 2024 22:12:43 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: sfr@canb.auug.org.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 sigmaris@gmail.com, knaerzche@gmail.com,
 Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v3 0/2] [v3]Add hantro g1 video decoder support for RK3588
Date: Wed, 17 Jan 2024 22:12:42 +0100
Message-ID: <2196595.7aRn1RRit1@diego>
In-Reply-To: <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
References:
 <20231231151112.3994194-1-liujianfeng1994@gmail.com>
 <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Nicolas,

Am Mittwoch, 17. Januar 2024, 20:16:24 CET schrieb Nicolas Dufresne:
> Le dimanche 31 d=E9cembre 2023 =E0 23:11 +0800, Jianfeng Liu a =E9crit :
> > This is the v3 version of this series adding hantro g1 video decoder
> > support for rk3588.
> >=20
> > RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 wh=
ich
> > is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is al=
so
> > found in RK3568.
>=20
> The only concern I have is that we rejected enabling this VPU on RK3399, =
since
> having two H.264 decoders was confusing userspace softwares at the time, =
causing
> the slow one to be picked sometimes. I know the selection is not fully
> implemented in GStreamer either, not sure for LibreELEC ffmpeg fork, Chro=
mium or
> Cros-codec.
>=20
> Of course, its not a problem now, but only when someone provides an rkvde=
c2
> driver that enables the much more capable HW decoder. Shall we hold on H.=
264
> mainline for now ?

hmm, reading the TRM the VDPU121 claims to support:
=2D VP8
=2D VC1
=2D MPEG-1,2,4
=2D H.263
=2D JPEG

So at least the TRM doesn't list h.264 as supported at all on VDPU121 .
Not sure what is up with that or is Rockchip also just suggesting that h.264
should be in the VDPU381 [where h.264 is listed as featured] ?


Heiko



