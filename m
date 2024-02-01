Return-Path: <linux-kernel+bounces-47965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7F845560
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB44EB277EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F215B975;
	Thu,  1 Feb 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y04rIy7D"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11812BF1A;
	Thu,  1 Feb 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783452; cv=none; b=p6eniXXhGZfcGajMcIOWeX8x2k1TZF7OQkjDN0IliodL0RWATA981B77wBliuyVN2KltYZP/+WENGwz32gZez9VzCc1rvE6ULJK86xjOO+jxWqlFgF19lproJxnuGZkPV+boMGywHIcARGm2YBgvX6F9zE9TqHOF98+ulcOPXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783452; c=relaxed/simple;
	bh=V10jiNp+1d5/OUeFU4agGQsdLFrCHaLqzXvUjwN4SSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HuzMHph4VXcFmAeFnizxa1SgbUdeLlPv1gILrhLqWDhHzpAhL2Ta2e/ZQRbRANgJ/1eDMciXykNpLt2Jgys730vlP6Q8a4unA4RMlMtjyadAgPEeLveWJUEQSGqPjQ1jeqYLdoxhN1K7C38RbsZD2J+uPmcwEqxyPakMbXX4oAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y04rIy7D; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9C1D240012;
	Thu,  1 Feb 2024 10:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706783447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhGmoUORnBrHRJ896fcdbMRX4b2dejpoihgpDBpkoTY=;
	b=Y04rIy7DcVNW0stxCTvOK+tB5COaKPfsUWNuzUG0oTYtC5dbrhEcl19nyUR3LLAQJtQvcH
	oPgY11o9zUaU7qqgs6Bm1eXHpg6UpXV5xWVCORvX47+6gylG6li6gfvBj9pfp1HIr/z3Ei
	ZI4SyJbEhIJUMnweJcTzhT5HYgdHnjhSybCrrGIeZRBUGeal/zqFuJ3evuSos9NT0h8iP3
	ocp0r+Z/9n8O7jRGR84tiQzvkeWJhxPqTY/FWuk70GCjtFuuBcQuRSMWDVmGxIY50pk8jm
	WRBFsVclrVHRQbgXZeeevm7HSN/BAu3gzFzHcbVpbc4ZIAhQj6AA4fwydmi2ig==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 11:30:46 +0100
Message-Id: <CYTO8IR2MO02.GX591A9T57DZ@bootlin.com>
Subject: Re: [PATCH v4 00/18] Add support for Mobileye EyeQ5 system
 controller
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <CACRpkdb+aWL-NU36dF6urL3T9gUROQX=9-L7aUC=+GM8x+bArA@mail.gmail.com>
In-Reply-To: <CACRpkdb+aWL-NU36dF6urL3T9gUROQX=9-L7aUC=+GM8x+bArA@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Linus,

On Wed Jan 31, 2024 at 9:44 PM CET, Linus Walleij wrote:
> thanks for your patches!
>
> A *new* MIPS platform, not every day I see this!

Indeed! According the Wikipedia it got released to market on 2021, which
does sound recent from a MIPS standpoint. (The same year MIPS announced
the architecture would stop being developed in favor of RISC-V.)

> On Wed, Jan 31, 2024 at 5:27=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > Pin control is about controlling bias, drive strength and muxing. The
> > latter allows two functions per pin; the first function is always GPIO
> > while the second one is pin-dependent. There exists two banks, each
> > handled in a separate driver instance. Each pin maps to one pin group.
> > That makes pin & group indexes the same, simplifying logic.
>
> Can the three pin control patches be merged separately? (It looks like.)

That is the goal. There are two dependencies in this series:

 - MIPS stuff depends on the base platform support series by Gr=C3=A9gory,
   for devicetree stuff & MAINTAINERS mostly.
 - "dt-bindings: soc: mobileye: add EyeQ5 OLB system controller" depends
   on the three dt-bindings for the controllers (clk+reset+pinctrl) as
   it references them.

That means clk+reset+pinctrl can go in separately. At least that is the
goal, hoping I have not messed up along the way.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

