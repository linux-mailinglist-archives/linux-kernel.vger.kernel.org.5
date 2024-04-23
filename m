Return-Path: <linux-kernel+bounces-154836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863628AE1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1051F25148
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E160279;
	Tue, 23 Apr 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W1uMtaua"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7621345;
	Tue, 23 Apr 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866698; cv=none; b=Fq7k2g2PUx3zd5FB54OWrkd+X2c88B6aW/HZdLA4AVDsHAxdJfb8Qr72UUgBJorC1OhXmzwqGDVSOsYAAmOjNiznUWfMACPE4IEJLi6odXKmcpPiC9qowTplOMl0KZjXCcI8qYeqJR3t4EGP94KJmGXBpGENVNtI0KWQLGuUmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866698; c=relaxed/simple;
	bh=gDZ7Fg+2Du1XJV+4T9CY1Re5MPPSa361YFz6hstJ+co=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=bgBhtigM0eu4aya16rFyOg9CTOkKnfzboT8vYebOCOmY/cwa/6eCjrF6BGNd71GNajJ7l8JBxJTw8PcrL+b3cJLhzJYt9B0plob5KodVkrpy4JbEHTmOA8R1OtChb9RJM4TfvLthix/c24I+C5x3Fz5zlw2LwWbQ93/2gHs8tx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W1uMtaua; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16DF02000B;
	Tue, 23 Apr 2024 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fazf5O5A2ZxTjJzqLaGo3q4eT3yUZXsP9mz193jSIY0=;
	b=W1uMtauaiXfA+1682z4WuTE9Zq5lYuRRnkZ3kdWUYFnS8cwCwy//wuD3RK3hej/CTiGd8k
	4idcY4JHmnj/M7/DpGr28eIt9Pdn/dZk97znBbV32pDuI+R5xykSUODFnZRdPCBGkdL1Zl
	xRgG+C2nijqb4DZgdgJBVWe2NR0QmlAvymCI9bpJqjpyYyzqGWqS3OS+CXHNf01GihJZUW
	pZot7rLmHFvuD6dO3SVN9bIrFUDJv6QYN7zPxz4BZ1yu4n3gbMfcJ0iCkcUYJSSHPoRqP0
	U7xYv6/Ig9DuVrLhGz1v557zejnodH8Xu/14egJpDnl05Ef3otUbWur0jMOw6g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Apr 2024 12:04:46 +0200
Message-Id: <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
To: "Mark Brown" <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
X-Mailer: aerc 0.17.0
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
In-Reply-To: <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Tue Apr 23, 2024 at 7:00 AM CEST, Mark Brown wrote:
> On Mon, Apr 22, 2024 at 06:52:47PM +0200, Th=C3=A9o Lebrun wrote:
> > All commits tagged "(no commit info)" do not show up in your for-next
> > branch. Is that expected and is there anything I can do? There was one
> > pending -Wunused-variable compiler warning to be addressed for
> > example, see [0].
>
> Please submit any patches you'd like to see included.  If there were
> outstanding issues that need fixing then fixing those prior to
> submitting would be sensible.

Seeing "Applied" followed by a list of commits, with some of those not
being applied confused me.

You received the latest revision!
https://lore.kernel.org/lkml/20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@boot=
lin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


