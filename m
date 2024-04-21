Return-Path: <linux-kernel+bounces-152479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E78ABF12
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68461C2088D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA812E47;
	Sun, 21 Apr 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wIjgGGHb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7881CA64;
	Sun, 21 Apr 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699316; cv=none; b=cB/TY7CszmEqoM7LnSuiXdPyJLqsjjKAOo2GdkrEi7XAP/ymEUg7FS/Dy5Ok+JGlIE3fEH3KGHsKbgAxsjNkRi52vPN16HhubdM0hYGr8UCkFaxWBcnWE/qxCjYw3sofo+Ia5cAvooT8uHSmEsNUJxSvms+aElH3JY0hqOeuIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699316; c=relaxed/simple;
	bh=gFIiPhmmgfuZ4AluO6ea6nUBX++JinIRYsCeYqnuzto=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JxBu8+HafwlHbRJmXkLhuG7X9W532aIbCKUa7z5BBjFlCObnGrGJbXjU6irFd9KnYZeTTJaetYIwBhgfXb5KopXEgam9euAn4qy0CScE4Ruo7ykrubd0s25o1uOqOpWyG5PatMbVEtDI3KMPIhMy2Q7fDSweu/xEKqZgEAg0N3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wIjgGGHb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C7B9B1;
	Sun, 21 Apr 2024 13:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713699254;
	bh=gFIiPhmmgfuZ4AluO6ea6nUBX++JinIRYsCeYqnuzto=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=wIjgGGHbD/wo8+GMfWbYEFlS1VzbZ8qL7/j74iL88k7Xa5gZS2YFsd9nmAXCYT1YH
	 Be4iMTmlMMCLfjTATDp9SuY0yYNOlkKU2cZVS2F2T4Nbn9OUiXF6N2VaUUb/5lIbj0
	 8mktpLkGjUEqAFELGYbHqkaF7gbZUpDxyCj7k1zM=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <171361758199.1737874.11884706323295617909@ping.linuxembedded.co.uk>
References: <20240420011840.23148-1-zhi.mao@mediatek.com> <20240420011840.23148-2-zhi.mao@mediatek.com> <0cb44232-3be3-47cd-9e4c-f01f2839aff3@kernel.org> <171361758199.1737874.11884706323295617909@ping.linuxembedded.co.uk>
Subject: Re: [PATCH v1 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Heiko Stuebner <heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com, yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Zhi Mao <zhi.mao@mediatek.com>
Date: Sun, 21 Apr 2024 12:35:00 +0100
Message-ID: <171369930090.365791.12487523856935433191@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Kieran Bingham (2024-04-20 13:53:01)
> Quoting Krzysztof Kozlowski (2024-04-20 12:21:46)
> > On 20/04/2024 03:18, Zhi Mao wrote:
> > > Add YAML device tree binding for GT9768 & GT8769 VCM,
> > > and the relevant MAINTAINERS entries.
> > >=20
> > > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > > ---
> >=20
> > Sorry, there was v1. Please do not send same versions twice. BTW, use
> > patman or b4 for your submissions if versioning is tricky.
> >=20
>=20
> Whats Patman? google returns false positives for me.

Digging deeper, I've discovered patman comes from the u-boot project,
and is known as 'patch manager', and can work along side patchwork.

 - https://docs.u-boot.org/en/latest/develop/patman.html


For completeness, b4 (which I've already used myself) is more closely
associated with public inbox.

 - https://github.com/mricon/b4


> --
> Kieran
>=20
> > Best regards,
> > Krzysztof
> >

