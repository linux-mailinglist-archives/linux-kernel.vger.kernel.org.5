Return-Path: <linux-kernel+bounces-28043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC6782F979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AB11C2579D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BE5FDDB;
	Tue, 16 Jan 2024 19:56:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1173143769;
	Tue, 16 Jan 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434967; cv=none; b=Yk0OoOgZ6ya4a7xKCPOLAyU1tTYHSdKDhfCHRmAO0plRy/aB/rLAs/Rw24AzqkGv7OuHaIqFn34acsF22NWHJQsf2KD2zJQCyPgzBgDZ1zRx5HaQHm+HhLTqkIx4Cn3y3HwqC3XOrLKcDoO17ader5SFXK2ier1vlUoKIpqHFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434967; c=relaxed/simple;
	bh=veEWtFSf/h/Qhbh3udV1t3EzLmcqAJ1ER26QejgzaAs=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=u7flEUMLkjfNqvCAtbR3MU+MUv9uhuymFP22KFDbGsphVcaLqzGNJaQ6WyS0xcJz8o5YMfgjtwmSnZNPStKIvG4eggEY+tmWzTpjUzkyH2bS1erRMlRApl9tMghlSGwYqZtg9jM1KLnJm/Hj0RT5e9dlDiwjhhLYgdEOrDRgs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rPpX7-00076A-9P; Tue, 16 Jan 2024 20:55:37 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Cc: Tim Lunn <tim@feathertop.org>, KyuHyuk Lee <lee@kyuhyuk.kr>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board bindings
Date: Tue, 16 Jan 2024 20:55:35 +0100
Message-ID: <47795047.XUcTiDjVJD@diego>
In-Reply-To: <20240116192605.GA274661-robh@kernel.org>
References:
 <20240115145142.6292-1-lee@kyuhyuk.kr> <2421144.zToM8qfIzz@diego>
 <20240116192605.GA274661-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 16. Januar 2024, 20:26:05 CET schrieb Rob Herring:
> On Tue, Jan 16, 2024 at 09:31:35AM +0100, Heiko St=FCbner wrote:
> > Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowski:
> > > On 16/01/2024 03:00, Tim Lunn wrote:
> > > >=20
> > > > On 1/16/24 01:58, Krzysztof Kozlowski wrote:
> > > >> On 15/01/2024 15:51, KyuHyuk Lee wrote:
> > > >>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly wri=
tten
> > > >>> as rockchip. Fixed the vendor prefix correctly.
> > > >>>
> > > >>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> > > >>> ---
> > > >>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
> > > >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >> You need to start testing your patches. Your last M1 fails as well=
 in
> > > >> multiple places.
> > > >>
> > > >> It does not look like you tested the DTS against bindings. Please =
run
> > > >> `make dtbs_check W=3D1` (see
> > > >> Documentation/devicetree/bindings/writing-schema.rst or
> > > >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicet=
ree-sources-with-the-devicetree-schema/
> > > >> for instructions).
> > > >>
> > > >> The DTS change will break the users, so would be nice to mention t=
his in
> > > >> its commit msg.
> > > >=20
> > > > I notice there are a couple of other boards that incorrectly use=20
> > > > rockchip as the vendor also:
> > > >=20
> > > >            - const: rockchip,rk3399-orangepi
> > > >            - const: rockchip,rk3568-bpi-r2pro
> > > >=20
> > > > Perhaps these should also be fixed at the same time?
> > >=20
> > > What is happening with rockchip boards?
> >=20
> > Copy-paste stuff ... boards using rockchip,boardname instead of
> > vendor,boardname for their compatible.
> >=20
> > I do remember us noticing this a number of times on some boards
> > and requesting fixes, but looks like some slipped through.
> >=20
> > So I guess Tim is suggesting changing the compatible, but with boards
> > being merged a while ago, this would break backwards compatibility.
> > So I guess both the Orange and Banana Pies will need to live with that.
>=20
> You may get away with it because we generally don't use the names...
>=20
> Though there are some discussions to start using them to select dtbs by=20
> bootloaders.

Ah, that's good to know (both points) ... so essentially right now would be
a good time to do what Tim suggested, before the names get actual usage.

@Tim: is that something you'd want to do?


Thanks
Heiko




