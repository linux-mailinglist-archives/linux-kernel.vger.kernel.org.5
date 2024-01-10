Return-Path: <linux-kernel+bounces-22068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2038298B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F328646A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13047786;
	Wed, 10 Jan 2024 11:18:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F0487A3;
	Wed, 10 Jan 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaa.versanet.de ([83.135.90.170] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rNWbA-0002at-RJ; Wed, 10 Jan 2024 12:18:16 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject:
 Re: [PATCH 2/2] arm64: dts: rockchip: remove duplicate SPI aliases for
 helios64
Date: Wed, 10 Jan 2024 12:18:15 +0100
Message-ID: <3493720.ktpJ11cQ8Q@diego>
In-Reply-To: <48f1b3cb-0a98-4b14-89f6-e1ca6b858512@linaro.org>
References:
 <20240109-rk3399-spi-aliases-v1-0-2009e44e734a@theobroma-systems.com>
 <2258938.QZUTf85G27@diego> <48f1b3cb-0a98-4b14-89f6-e1ca6b858512@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Krzysztof,

[I'll limit myself to this thread, as we're essentially discussing the same=
 in both]

Am Dienstag, 9. Januar 2024, 20:14:38 CET schrieb Krzysztof Kozlowski:
> On 09/01/2024 16:23, Heiko St=FCbner wrote:
> > Am Dienstag, 9. Januar 2024, 16:16:15 CET schrieb Krzysztof Kozlowski:
> >> On 09/01/2024 14:35, Quentin Schulz wrote:
> >>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >>>
> >>> An earlier commit defined an alias for all SPI controllers found on t=
he
> >>> RK3399, so there's no need to duplicate the aliases in helios64's dev=
ice
> >>> tree.
> >>
> >> That's not what we want. Boards should define aliases for what is
> >> available, according to the board labeling.
> >=20
> > and the board labeling for spi2 has always been spi2-miso, spi2-miso et=
c.
> > In the last 10 years of doing Rockchip stuff, I haven't seen any schema=
tic
> > doing it differently.
>=20
> OK, this could be a case... but then you add aliases for things which
> are not labeled on the board.

On the other hand, we did this dance last year for some other SoCs.
And having to repeat the same list of never-changing aliases for every
board was a sore spot for a lot of people it seemed.
Most boards follow the reference schematics quite closely afterall.

Like very shortly after the last discussion I got patches moving the
aliases to their then agreed upon position. (numeric busses in the
soc dtsi, everything else in board dts).

And back in november we ended with [0] - Krzysztof saying that
"it is just generic guideline, so up to Heiko what to do with it" ;-) .


I also made sure to send the changes upwards way before christmas
to give soc maintainers time to complain if needed and especially did
point out that change in my pull request text [1] ;-) .


Heiko

> Let's bring Arnd again:
> https://lore.kernel.org/linux-rockchip/CAK8P3a0ALgbhTVJ7t3XRXALs9vBM=3DXB=
vkGhNKXxB+QTepo-3AQ@mail.gmail.com/


[0] https://lore.kernel.org/linux-rockchip/7b8a830d-42d0-4220-b9fe-3f5fff43=
e74d@linaro.org/
[1] https://patchwork.kernel.org/project/linux-soc/patch/3535836.iIbC2pHGDl=
@phil/



