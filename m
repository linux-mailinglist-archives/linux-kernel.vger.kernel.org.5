Return-Path: <linux-kernel+bounces-153755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA828AD2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18601283948
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE39153839;
	Mon, 22 Apr 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVbbHamD"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19221DDE9;
	Mon, 22 Apr 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804773; cv=none; b=QIjOchrkQOaU1Vq+MMm2IcHW8xhhPuAheCZZ8PS88B0cz9rXknVw9bStuJgvMReptvWNmve2O/KG6O8x00aGCe6Jdo86OQSHE1ZiE0mDJvhbbgIEjT8Bd8AOwDtzXrMyw17tC2G+YAZg2US8q6xKOd/cYKUTourIRQBEi6uQs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804773; c=relaxed/simple;
	bh=3/GWBoMvjgEOep+U+PUV0wTmJjwtNpbj6ntfK4jNUks=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=a4BhoqZ8XyZnH487v7gkhUgiszZUxVWFf3z2YGqHiKoAnk77JZnoVYH1TAJuLJsAFfNl9vgHIkl9Pf7dzZk+MY+hPT4dmG8U50j75NaYLPqtmAEYJ0DSsccUtCnWTQVunvUIUCee/4NFZdLddS0Sk7qDmYtkWK4I354xWlGHWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVbbHamD; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D60240005;
	Mon, 22 Apr 2024 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713804768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bdZjyK+cz4gPmCanhUjDaq4XaZFBYb3A0dLn9Cm1x8=;
	b=SVbbHamDIX+Ww/Itls8kkhQCUnzjTqVQ3QYkJRK+jmV7MbWq/nwSJmjoE2pFg6c8O13//U
	e0UxUzw/pR/hQrHzqzX4add5r8vrS35AwF04slxe2FMpy81QpXwnpiXIC9SLMYu46y1FUO
	zdNc6FhULzaP0VRMdTqgUuY3kzlwygFf9QQkxv8GcllV++vPNsZ1EWabZXKoMTpd9U8JFw
	gwO7Z2fZwBDI1jjKs+wbGSADSKTsjWLpHaBZeZj2JKDtqkUu+t6JrM+zlOVHyrAjwApYvo
	PI3UDOXquh2kgrLGavBOssYoNyPl7MnuBM4HUZqueLSpxCq+x3yyhC5rcgo8sA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Apr 2024 18:52:47 +0200
Message-Id: <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
To: "Mark Brown" <broonie@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
X-Mailer: aerc 0.17.0
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
In-Reply-To: <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Mark,

On Thu Apr 11, 2024 at 2:03 PM CEST, Mark Brown wrote:
> On Wed, 10 Apr 2024 11:29:03 +0200, Th=C3=A9o Lebrun wrote:
> > V3 of this series adding octal SPI-NOR support to Mobileye EyeQ5
> > platform. It has been tested on EyeQ5 hardware successfully.
> > V1 cover letter [5] contains a brief summary of what gets added.
> >=20
> > There is no dependency except if you want zero errors in devicetree:
> > system-controller series [3] for <&clocks> phandle.
> >=20
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!
>
> [1/9] spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
>       commit: 002514d91fccde2adbe750c9ec5c6207d56c890b
> [2/9] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
>       commit: 52826aee484b3ebb6ed94c1ae89c0944110ed8b1
> [3/9] spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
>       commit: eb4fdb4bf46f875eac3c093f7ff43a223985f7b8
> [4/9] spi: cadence-qspi: allow FIFO depth detection
>       (no commit info)
> [5/9] spi: cadence-qspi: add no-IRQ mode to indirect reads
>       (no commit info)
> [6/9] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
>       (no commit info)
> [7/9] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
>       (no commit info)

All commits tagged "(no commit info)" do not show up in your for-next
branch. Is that expected and is there anything I can do? There was one
pending -Wunused-variable compiler warning to be addressed for
example, see [0].

=E2=9F=A9 git log --oneline --author theo.lebrun v6.9-rc1..spi/for-next
eb4fdb4bf46f spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
52826aee484b spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compa=
tible
002514d91fcc spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetical=
ly
563f8598cbc2 spi: cadence-qspi: minimise register accesses on each op if !D=
TR
dcc594aef1bf spi: cadence-qspi: store device data pointer in private struct
708eafeba9ee spi: cadence-qspi: allow building for MIPS

[0]: https://lore.kernel.org/lkml/161eebc1-9417-4ab0-ad8c-c1b17be119b4@sire=
na.org.uk/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


