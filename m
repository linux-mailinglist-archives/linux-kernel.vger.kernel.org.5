Return-Path: <linux-kernel+bounces-155252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56C8AE77D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB922288F70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D113699E;
	Tue, 23 Apr 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DbElU/od"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50282135A6E;
	Tue, 23 Apr 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877698; cv=none; b=g6kiTwmFkbyCc/QZr/KQnb+jw09YzqXhN/ktrFVB4xULRDeNtT6LdQbPCtbzB3eLI3VtSnnaJdDs+4E1CUm4SzOsdPxz2Kd3v9X7ourzFm8bGdbXyElzZ9PRPQ8wgbXIGTMBqPapwxjigE/4Dn3Sdx6XaO+DP3pq2gDNBPjIRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877698; c=relaxed/simple;
	bh=dlhH2ikJL+CjYyT5tXlg1eD1GvZPgftjtRMAdq5xhKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=YWx2AxkgCQTkriIi3GXNJySIRH4i1CJKUUlJMrVJm6zr9G3eeQtxcR8KBu5g34g9h573Ys/Wz1Ic7VgfHprbf3rxYUzlg4dRhpwbcngksdXextZIUEwyVn0kn38K17NGPpIYHqU5Qz4PgxZzt5CwkbPkm4sFd76Vd9hxA06YYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DbElU/od; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BFD7240002;
	Tue, 23 Apr 2024 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713877686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkEpdkG026UGxnP+K6Y14R8MUybzKxtIX1NVxXz3z98=;
	b=DbElU/odY8l5M8g9YDeNsim7YMAfn5f6facsnHHOshFQExqhgFztKsG8IWz97QrGxydv0j
	U13+KtzqtZOvO+YsuFabrlIfBWZUh7bKbJwU83vgryN2U+7tyGZZd/4CN1jA9r6+1Zsuou
	oKzkIAxED8RTiRxCyu5vVWrHW69QraZfnT0TU79tLywPPkcQQVmiy9WZ0muAG2JuR/ShII
	oUMHYHOH7+clvPjVKNEA1l8svyYL3dwGHE3jC0CabRhsbuaQWzxxi8E1hUO3fHSMkj4CJs
	7sJ4YKhwuhzVkSEbKvQNedoo/GajcAxkMgtAIAfl81qQXV2cACcux2R/Cg3llw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Apr 2024 15:08:05 +0200
Message-Id: <D0RIXN4JG6ZA.4W4HN68M9U6I@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Mark Brown"
 <broonie@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
 <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
In-Reply-To: <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Tue Apr 23, 2024 at 12:25 PM CEST, Krzysztof Kozlowski wrote:
> On 23/04/2024 12:04, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Tue Apr 23, 2024 at 7:00 AM CEST, Mark Brown wrote:
> >> On Mon, Apr 22, 2024 at 06:52:47PM +0200, Th=C3=A9o Lebrun wrote:
> >>> All commits tagged "(no commit info)" do not show up in your for-next
> >>> branch. Is that expected and is there anything I can do? There was on=
e
> >>> pending -Wunused-variable compiler warning to be addressed for
> >>> example, see [0].
> >>
> >> Please submit any patches you'd like to see included.  If there were
> >> outstanding issues that need fixing then fixing those prior to
> >> submitting would be sensible.
> >=20
> > Seeing "Applied" followed by a list of commits, with some of those not
> > being applied confused me.
>
> That's a standard output of b4 and maybe also Patchwork, if some parts
> are applied.

Thanks for the pointer. I've created an issue over at b4 to see what
people think about this matter. Current behavior is not intuitive as a
young contributor.

See: https://github.com/mricon/b4/issues/26

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


