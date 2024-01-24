Return-Path: <linux-kernel+bounces-37348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87083AE95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61C31F24A70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070357E56E;
	Wed, 24 Jan 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gBZ3tQKw"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007122F0C;
	Wed, 24 Jan 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114682; cv=none; b=cf6LJcs9OI/BI5dgcffxoMvHJPkdawP8KxnOtSCltqGOMNJGN9ZcAYymJRrBfZ84wsMfMoqRda3io+cTJz2ER3AsnLa+ZngzPILmVkmQqf/ABmqmMydDNtMif/kIMbMVqw1lfTy5IBhTuDFJpc52regcxIb/Zq+sg1OasHL8jwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114682; c=relaxed/simple;
	bh=s++RLXYfau8VjSaMChjt8gH8ZMxpb82bFr/pLJZg0eU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=I+pag8+44N9v3FUyax3QItyO8XC8+GS1Z4s63D5XUYsLB1a9ObhfettyFh7ESsU94yA+L1henhjLBqjv6PmPmEUhq3MP5lkwQ/+DRGkt9RGMjwLW/WepalzvMMxMj/ceh62yh54LKy8X92M4WYLeVp7Z7FzlFILwIugC0bQDE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gBZ3tQKw; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82BA520002;
	Wed, 24 Jan 2024 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706114672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s++RLXYfau8VjSaMChjt8gH8ZMxpb82bFr/pLJZg0eU=;
	b=gBZ3tQKwj6a+lYMKDFd7LpQF3W/irfJ5AyHiP9lVhdrY6TuVTlgKt7R8WzdgUUCaEMhlwc
	HA0zpg+GwFm5i0V/87rYA0U71B1QdhfewIBmHH/w09KuwQtk5O1pwY/XcDS7MtEgV8Xhdp
	gZBCxIiQdwxJ9RUMdJHaDI7zNXhfeCgcHLDGhKUa/TS/7PVWQLjG5zJoPGWLTajGBE1X2y
	frD7ctHJrJpzAstZYBR7uiUhvMzHwYROOMEb6ZkM8lg/lZFF0gA6hkgBi/cXwRMnEx6cAZ
	v3Bk4sKtMTdKxDbi3IlFGcPkoc/ewKpUFMmQtk6Wz7rLBMOjqvczyI+qiIiTow==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 17:44:31 +0100
Message-Id: <CYN36BPTWFG8.TQP62JW6C3UT@bootlin.com>
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 00/17] Add support for Mobileye EyeQ5 system
 controller
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <407ffaf1-d16d-4035-9566-866f44411fd2@linaro.org>
In-Reply-To: <407ffaf1-d16d-4035-9566-866f44411fd2@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 7:43 AM CET, Krzysztof Kozlowski wrote:
> You miss here, in this place, the most important information which I
> asked previously - dependencies/merging:
> https://lore.kernel.org/all/db9b2786-29f7-4d45-9087-a9f85b770b6c@linaro.o=
rg/

Clearly I still forgot some dt-bindings dependencies. I now get what you
meant at the time. Those explain the robot failures btw.

Should it just be me saying "hey patches X depends on patches A, B, C?"
Or are there even Git message trailers to mention dependencies? Care to
give a patch link that does it the right way?

Sorry about that,

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

