Return-Path: <linux-kernel+bounces-152264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A38ABB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E86B21267
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C336E1A291;
	Sat, 20 Apr 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jiTvJmkN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1A12E73;
	Sat, 20 Apr 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713617590; cv=none; b=gw0hwLMQkYsgSRQWuwGxiRoe8Hj29OXR3BCUU/ZmZbou1yYekrIkO6ARZ0A4oqJA6fFTN5+XAFjGm6U/K5QPWXLwX71O5ouP3pgXB1plID9SoPxhzbmThs99L6FEkJcE7/zz5pbuduqxv086dla9sfAemSXn7fPvhvQdue7mC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713617590; c=relaxed/simple;
	bh=Ii39j1e9CG5HbIb6F+SPiZe/5HlLbwinhvOgR6qmVww=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CmVmsdecljktOTPkB7mRcvB09d3wXaZf9SxbbSF66nrY3Cf1ndJqlPiGv70eo+cx1ycukjmHDEhUbaolVjNDLSv6A+90kawcNfwCexS5shVjpY4anSm/SCGC7RhbdAtidOepKFbrt61qDUN+tnm7ZKeDBYftBIrgQ+j4SreAUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jiTvJmkN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id ACA63ABB;
	Sat, 20 Apr 2024 14:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713617535;
	bh=Ii39j1e9CG5HbIb6F+SPiZe/5HlLbwinhvOgR6qmVww=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jiTvJmkNYYq6gv/kT6jD5Mw23YOnJlyQ8PZChjvvyQDNKk/lxi7YlR4hR0gy/0uNL
	 wjaAOnlyt1t7esvN22C8otstTvVVubj1sSnzj1ZLZDays3vogkfwlH1F5f/SPXNBv/
	 //T6d3KdNDV1Q8sXEMl0o5snwJZLna3Yk/bbF7Zg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0cb44232-3be3-47cd-9e4c-f01f2839aff3@kernel.org>
References: <20240420011840.23148-1-zhi.mao@mediatek.com> <20240420011840.23148-2-zhi.mao@mediatek.com> <0cb44232-3be3-47cd-9e4c-f01f2839aff3@kernel.org>
Subject: Re: [PATCH v1 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner <heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com, yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Zhi Mao <zhi.mao@mediatek.com>
Date: Sat, 20 Apr 2024 13:53:01 +0100
Message-ID: <171361758199.1737874.11884706323295617909@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-04-20 12:21:46)
> On 20/04/2024 03:18, Zhi Mao wrote:
> > Add YAML device tree binding for GT9768 & GT8769 VCM,
> > and the relevant MAINTAINERS entries.
> >=20
> > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > ---
>=20
> Sorry, there was v1. Please do not send same versions twice. BTW, use
> patman or b4 for your submissions if versioning is tricky.
>=20

Whats Patman? google returns false positives for me.
--
Kieran

> Best regards,
> Krzysztof
>

