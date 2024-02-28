Return-Path: <linux-kernel+bounces-85447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7CD86B619
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6D5B260C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671A15D5D1;
	Wed, 28 Feb 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V7AkjmNr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1B3BBC5;
	Wed, 28 Feb 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141645; cv=none; b=ea3vbvxZDSF5oCqIzWZdRlqrrPAaLKXCIcBVDJnKMnl3UQOitki+bWF3xlOr3vWl/cHNw0cmTDD4AfthqKNoyNrzZZr6u4p7jNjMhZtCxPMAf8j64LyyxPElzvV9sjRHk/uAOYK6L3x5zN8+zPjepRlK4JV4rBrx9aWavuesS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141645; c=relaxed/simple;
	bh=gfZSTzrbni9TxJWg8G4wC5ho8ziwdAol+y1IPZGnU0g=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=uTNgzge8u7uMyT/6IMctKYE67BMJsDjy8l1sCA70PgXYYeQrM4/z//LJSrnsodkoU1yVIlgqL5mimHo9nqwsvq3gfDhVT2dfXsKAyyloBj3nve5VYXWFylHLaBb6gaDCCWRRC1rZWlbVmjR8g+ANIT9Hu06V0b2Tt9G0t/tDo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=fail (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V7AkjmNr reason="signature verification failed"; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 201416B3;
	Wed, 28 Feb 2024 18:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709141628;
	bh=gfZSTzrbni9TxJWg8G4wC5ho8ziwdAol+y1IPZGnU0g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=V7AkjmNrHtTrzHebM/j3cJguS2ziHleQ/cDEZ7Lsviaf0lxySR9uqeFxlaVaqyqID
	 gZHGHuNVXKbkXwf09J9s7GEzV02CWeW3z0g0TuNdV6n2tHnUl1kWbbk+OUvPOzLUxd
	 uqyzbMtX0jx1umwjsUKY3MVtAvnm9kK0aKapqg/o=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VfXY=Hv_o_CYe8sNYoBa1vtYWuk4Sz1M91XUp0cf4HjnA@mail.gmail.com>
References: <20240227013221.21512-1-zhi.mao@mediatek.com> <20240227013221.21512-3-zhi.mao@mediatek.com> <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com> <b4889fad324ec88eb3a22f51b0aa512cc93bd2cb.camel@mediatek.com> <CAHp75Vd=X9e4rOJabF4AbzGRZAF4BiNJa-C4ivOoQb7kAMy3vQ@mail.gmail.com> <Zd8g81wBXyfMvPhB@kekkonen.localdomain> <CAHp75VfXY=Hv_o_CYe8sNYoBa1vtYWuk4Sz1M91XUp0cf4HjnA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Zhi Mao =?utf-8?b?5q+b5pm6?= <zhi.mao@mediatek.com>, heiko@sntech.de <heiko@sntech.de>, tomi.valkeinen@ideasonboard.com <tomi.valkeinen@ideasonboard.com>, robh+dt@kernel.org <robh+dt@kernel.org>, yunkec@chromium.org <yunkec@chromium.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, dan.scally@ideasonboard.com <dan.scally@ideasonboard.com>, gerald.loacker@wolfvision.net <gerald.loacker@wolfvision.net>, Shengnan Wang =?utf-8?b?546L5Zyj55S3?= <shengnan.wang@mediatek.com>, hdegoede@redhat.com <hdegoede@redhat.com>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linus.walleij@linaro.org <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>, Yaya Chang =?utf-8?b?5by16ZuF5riF?= <Yaya.Chang@mediatek.com>, mchehab@kernel.org <mchehab@kernel.org>, jacopo.mondi@ideasonboard.com <jacopo.mondi@ideasonboard.com>, jernej.skrabec@gmail.com <jernej.skrabec@gmail.com>, linux-mediatek@lists.infradead.org <linux-mediatek@
 lists.infradead.org>, bingbu.cao@intel.com <bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 10572168@qq.com <10572168@qq.com>, conor+dt@kernel.org <conor+dt@kernel.org>, hverkuil-cisco@xs4all.nl <hverkuil-cisco@xs4all.nl>, krzysztof.kozlowski+dt@linaro.org <krzysztof.kozlowski+dt@linaro.org>, matthias.bgg@gmail.com <matthias.bgg@gmail.com>, laurent.pinchart@ideasonboard.com <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org <devicetree@vger.kernel.org>, angelogioacchino.delregno@collabora.com <angelogioacchino.delregno@collabora.com>, macromorgan@hotmail.com <macromorgan@hotmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, sakari.ailus@linux.intel.com
Date: Wed, 28 Feb 2024 17:33:58 +0000
Message-ID: <170914163823.252503.15921889437591940623@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-02-28 17:17:12)
> On Wed, Feb 28, 2024 at 2:03=E2=80=AFPM sakari.ailus@linux.intel.com
> <sakari.ailus@linux.intel.com> wrote:
> > On Wed, Feb 28, 2024 at 11:22:13AM +0200, Andy Shevchenko wrote:
> > > > Another, I also reviewed some other sensor driver code(such as
> > > > gc0a08/gc2145 and imx/ov), they are all the same.
> > >
> > > They are also problematic. So what?
> >
> > The situation is the same in a large number of drivers, also outside the
> > media tree. It's also not trivial to figure out which header should be
> > included and it tends to be that if it compiles without warnings,
> > developers won't bother trying to figure out what should still be chang=
ed.
>=20
> I spent about 20 minutes reading the code. Yes, for inexperienced
> developers it can take 3x longer, but still, much longer time was
> spent on writing that code to begin with. So, the headers are a part
> of the evolution of the code. And now it's pure technical debt with no
> excuses to not fulfill.
>=20
> TL;DR: It's (rightfully) assumed that the developer *knows* their code.
>=20
> > I wonder if this could be automated by using the C preprocessor and a
> > small Perl script. :-)
>=20
> There is a Google project coming from Clang people or so, but I have
> no idea of the state of affairs.

I've used iwyu (include-what-you-use) successfully on libcamera. But I
don't know how this would translate to working on the kernel, with a
more complex build system.

But indeed, tooling already exists [0] to do these checks, and is packaged
in distros [1]

[0] https://include-what-you-use.org/
[1] https://manpages.ubuntu.com/manpages/focal/man1/iwyu_tool.1.html

--
Kieran


>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

