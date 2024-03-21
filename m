Return-Path: <linux-kernel+bounces-109855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C4885692
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7611F237AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DEF54FAE;
	Thu, 21 Mar 2024 09:32:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382220326;
	Thu, 21 Mar 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013579; cv=none; b=ssPSOnfnYG9oJHo2G2VNJtChKa1zIX8Mt0iDonsFp34d3bzKNyMZlj1js4WQS1ldSlsuh/3DBNWTfAN8F9r9UqoE36dAcAD95FI6f8JPv+HkcVf84AX5Q+paBpFJsfU2EoYumxQPmon2XYatxKxJ2qMR1ulkI5ab6DMuhHKYesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013579; c=relaxed/simple;
	bh=iHMWBPP9KJVog54ihelmxgv7C4JSysp6R4W5sOgY3zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/bcW0wIkQDw44q7AfysNHqQMFwPDFBnAqYdbKKPrLX5EwKuK144pCi/zL9u4lmZbAJPg1YLIb5W90CQGPdjokZEcw0ytYOhe+itHJt9AZIKGHwrsZ2d+U3A3WD0PjrX4BTJFDzHcaeTbIS5podsMzYPY23zP6rcwzqmSASm2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rnEmn-000801-MU; Thu, 21 Mar 2024 10:32:33 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
Subject:
 Re: [PATCH 2/4] media: dt-binding: media: Document
 =?UTF-8?B?cmszNTg44oCZcw==?= vepu121
Date: Thu, 21 Mar 2024 10:32:32 +0100
Message-ID: <2798331.BEx9A2HvPv@diego>
In-Reply-To: <70439a01-7949-46bf-a701-c82ba961171a@linaro.org>
References:
 <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <855507987.0ifERbkFSE@diego>
 <70439a01-7949-46bf-a701-c82ba961171a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 21. M=E4rz 2024, 10:19:54 CET schrieb Krzysztof Kozlowski:
> On 21/03/2024 09:47, Heiko St=FCbner wrote:
> >>>      enum:
> >>>        - rockchip,rk3568-vepu
> >>> +      - rockchip,rk3588-vepu121
> >>
> >> What is 121?
> >=20
> > That is the strange naming of the ip block inside the soc.
> >=20
> > I.e. the rk3588 TRM lists a number of different video encoders and deco=
ders:
> > - VDPU121 is decoding h.263 and mpeg1,2,4
> > - VDPU381 is decoding h.265, h.264 and some more
> > - VDPU720 is decoding jpeg
> > - VDPU981 decodes AV1
> > - VEPU121 is the jpeg encoder above
> > - VEPU580 encodes h.264 and h.265
> >=20
> > Each of those are separate IP blocks with their own io-memory, their own
> > interrupts and their own iommus, etc.
>=20
> Thanks for explanation. Short introduction in commit msg would be nice
> (e.g. VEPU121, one of two VEPU encoders). OTOH, why not documenting all
> of them? Bindings are supposed to be as complete as possible.

We have a concurrent series for the vdpu121 running at
  https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gmai=
l.com

I think not all of those encoders/decoders are based on the Hantro IP
or at least at the moment we don't know this yet.
Hence people adding compatibles for the blocks they have actually
managed to run on their hardware.

Bindings are supposed to be as complete as possible, but revising a wrong
binding later is very hard. And the whole media part is full of binary libr=
aries
in the vendor kernel and has not the best documentation.

So I guess people are just cautious ;-)


Heiko



