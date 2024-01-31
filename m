Return-Path: <linux-kernel+bounces-46597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A78441CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797691C2479A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B583CB8;
	Wed, 31 Jan 2024 14:24:32 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318E83CAE;
	Wed, 31 Jan 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711072; cv=none; b=hzv5uiEmznZYOkReYSdai2+Gy4W0b3kDmIxneW8x2o6/rpzL89yLY90pAVZq/2fZZnqHJA/lWSwRdExL2lR1Ld5uhRvZt0l/EcA4c5F5BXPzaeORbI55R9GCaGU5FsgjIfHz5AUzSLDW4UIFl8Knf5852SUuTu3EKwdQyNHWWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711072; c=relaxed/simple;
	bh=iedT47vJKD2Ze/to4+FVUGfcQmG45IynJ+yXhrNrrgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pntWKxai1YrTnA3D8OGR05Pe3Ar2J9ZuBCQHbnG8n/F4xEGuRp+ATKfuz5dMtjZb084+jZqQYd0uK1z1cGENS+8lUhEa65MZaDgHEjyuxwwV+PtgVZSzdi6TfxnahLqktCgcpFBBMj74nz0AuRKaqpB7z4rKIy6j1y0sb7utV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ab1.versanet.de ([83.135.90.177] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rVBVh-0005Ja-Ds; Wed, 31 Jan 2024 15:24:17 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>, Andy Yan <andyshrk@163.com>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for
 Cool Pi CM5 EVB
Date: Wed, 31 Jan 2024 15:24:16 +0100
Message-ID: <2179538.KUTt5R2Mg1@diego>
In-Reply-To: <1e98352e.2dd2.18d5f780043.Coremail.andyshrk@163.com>
References:
 <20240127092034.887085-1-andyshrk@163.com>
 <00ed78ea06aecde202a11a23c80f80af@manjaro.org>
 <1e98352e.2dd2.18d5f780043.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Mittwoch, 31. Januar 2024, 13:21:56 CET schrieb Andy Yan:
>=20
> Hi Heiko=EF=BC=9A
>=20
> =E5=9C=A8 2024-01-27 21:09:46=EF=BC=8C"Dragan Simic" <dsimic@manjaro.org>=
 =E5=86=99=E9=81=93=EF=BC=9A
> >On 2024-01-27 13:15, Andy Yan wrote:
> >> At 2024-01-27 18:36:40, "Heiko St=C3=BCbner" <heiko@sntech.de> wrote:
> >>> Am Samstag, 27. Januar 2024, 10:20:33 CET schrieb Andy Yan:
> >>>> According to the schematic, this regulator is used both for USB30 and
> >>>> USB20, so give it a more appropriate name.
> >>>=20
> >>> I don't have the schematics, so I'll need you to answer this, but what
> >>> is the regulator called _in_ the schematics?
> >>=20
> >> There are two regulators called VCC50_USB_HOST1 and VCC50_USB_HOST2,
> >> and they are both controlled by GPIO1_D5
> >> They both for two usb 2.0 hosts,  not usb 30, the schematics make
> >> me a bit confused.
> >
> >In that case, I'd say that renaming the regulator to vcc5v0_usb_host is
> >fine, but there should also be a comment in the board dts file that it's
> >actually two separate regulators.
>=20
> How do you feel about this =EF=BC=9F Or some other style like=EF=BC=9A
> vcc5v0_usb_host1: vcc5v0_usb_host2=EF=BC=9Avcc5v0-usb-host-regulator {

I think we're using such a scheme in some places already, and
yes I really like going this way. So that the phandles follow the
schematic names and we can still grep for things.


Heiko





