Return-Path: <linux-kernel+bounces-39697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E683D512
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787AA1C2502D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0B2869B;
	Fri, 26 Jan 2024 07:24:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141E1B5B2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253862; cv=none; b=DuRAMhmkBE7R33sH7bgQT36XACifdjcfmYte/TSMP92wcziMD/EFIzmebR4HrPjjfxMnBHuP7r44IS+TA19eHQz0bEZFbXqku4uw1vTEYkKYsBCU0pe1vFRgztOv/wc75kMHQ2Ogyj1QA3Y6H2b9Bp3zgWog2lk3TauAYv3BQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253862; c=relaxed/simple;
	bh=HJYFiKO9DwglCe7ISCM24dbTxJ5lIQjepvlFtkyqvbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfHLiZVdZjHhBdUheentIxEam9Rimzblx16uSvlS2luFXJ68plhVpPTXTPVf8nP3mzZxVhoblaDjhlDEipV0Ga949+JyELpLCgwXn4lDXMkLlIRQqWw9gnIYeoc2yHiSIwfqNsIi5YMrR1X5T9eSn2fX3eE1ZLwUE/6E1kGlTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGZI-0000o3-PP; Fri, 26 Jan 2024 08:24:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGZH-002SaR-IJ; Fri, 26 Jan 2024 08:24:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTGZH-008STv-1W;
	Fri, 26 Jan 2024 08:24:03 +0100
Date: Fri, 26 Jan 2024 08:24:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, zhaochen su <zhaochen.su29@gmail.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 1/6] pwm: sprd: Add support for UMS9620
Message-ID: <jco3xlugbnpfpl7xq7dagpvrp57wlqjvjff7mhuc2yynohu2xc@zht3pus4vfrz>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-2-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryuj6cclf4p2fcew"
Content-Disposition: inline
In-Reply-To: <20240125025533.10315-2-Wenhua.Lin@unisoc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ryuj6cclf4p2fcew
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 25, 2024 at 10:55:28AM +0800, Wenhua Lin wrote:
> The PMW unit on the current Unisoc's SoCs has 4 channels but has different
> address offsets. On UMS512, they are 0x0, 0x20, 0x40, 0x60 respectively,
> while are 0x0, 0x4000, 0x8000, 0xC000 on UMS9620.

I just sent feedback to (implicit) v1 of this patch and only realized
now there is a v2 already. My feedback given there also applies to this
patch. So I'm marking also this patch as "changes requested" in
patchwork, please look at
https://lore.kernel.org/linux-pwm/bvnhi4qeczrmlmaog6drlztg4x6ubozjzu57sukpe=
jme7xecqc@724g62vjgxrq/T/#u
for the details.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ryuj6cclf4p2fcew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWzXg8ACgkQj4D7WH0S
/k6oVQf/We+IgYNxslnBKJ7mVuD9ABywhi2Yxtsc06xGTYqLCPnVS9Toy2eDOC9U
MfoIJchFZd9Nv0KoLa2PhiparSak2Eo4wQDehmo4LODjDP09xwD0XqYdweUKoa6g
wKT8MuXw5D8zJ6nRCMYXJY/eHmbR/NUJJN1OxRawpm+GOQW3o6Ou/ciyQbf03vf8
rfa+om9MSR0bQnRFaZY3FmGmMJtz71UQSkvQ84wkbr/eOfWt52df/md4GPNcktLx
eZxyZfACh8VVGHHajB9JRX5D9NGEl/zrE40IllWH251l71u9/qDlTaqO/OVHab5F
zIMlKNF3FFI2cCjtg4rMO4mJ6NipQw==
=sE7Y
-----END PGP SIGNATURE-----

--ryuj6cclf4p2fcew--

