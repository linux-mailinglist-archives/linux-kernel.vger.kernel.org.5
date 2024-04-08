Return-Path: <linux-kernel+bounces-135535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2889C74B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DA2285221
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0313F00A;
	Mon,  8 Apr 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GywKzvNY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77E13E414;
	Mon,  8 Apr 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587370; cv=none; b=utTAvY6P3Mh+l2J+iiSb+oOfjLCWybbKA4k45OKH4eMDT5qnFeyiwPdtEPLqfKOo2Gg/u0PouqtAOdycXCyBsFJrzuzEO0A6QrYNK3KhSrAXRHS+9RUOXdFX3L6XIBJfnhUQ9Sfn0xbflHjOXPvwj0KYEUDzQTO6KDorAefnYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587370; c=relaxed/simple;
	bh=w1UE2sxyoFblN4SN6YPSdjZQv3UkhTWujwZEjiE2yx0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Hzht/lfkV8Ot4iLJLlG+UIt8KyKpt4i/+AKMu6tD56K61UPB/otG3R4U5H54nhkJkchiJ8zu7zJuYjMGGjZermddbj7KedItmixLqyyTrXBzvsf02bUh7YUXQLVkE8sgqhDY5MtmsdSVQP2omZ/INDA1diSr+/37wpnCbAowiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GywKzvNY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F16AF240006;
	Mon,  8 Apr 2024 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712587364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1UE2sxyoFblN4SN6YPSdjZQv3UkhTWujwZEjiE2yx0=;
	b=GywKzvNY2eDKgeW83ZxtzjtMfxXPMq5lMdUx/lrgACZHXRyFPFfgzFs2KtfiNtQGXBNw7M
	K2h1Nd2a12C3ujCjDrZLb7TlYYswQyE8O3gLkgr6oP4p/g/CWyMCla4KDWNf0+1gQGQUSL
	Xjk3dsXuPFPeNJYLQJhTA5lU+NBzUWc6Vr5E51foLHjY/uFLtTARCcheLfJGn/OadS5FP3
	+KgOF9Sb0WafHiyOx+zYBeys2g/jLpp0uYfTYghtQk0tkPOCh3Pfox2Hbrrx6e2AlT5Uv2
	0HLA2NF1TNhbXVJPF8CwHxVb9Ub35yZ9EI/ATeLv8cEDOE2VxFzyvAmrM6P9pA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 16:42:43 +0200
Message-Id: <D0ETJXNHOUKQ.C368FEZVM9DD@bootlin.com>
Subject: Re: [PATCH v2 08/11] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
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
To: "Mark Brown" <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-8-956679866d6d@bootlin.com>
 <1f7087ad-824e-47fe-9953-ed5152c8f18f@sirena.org.uk>
In-Reply-To: <1f7087ad-824e-47fe-9953-ed5152c8f18f@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Apr 8, 2024 at 4:16 PM CEST, Mark Brown wrote:
> On Fri, Apr 05, 2024 at 05:02:18PM +0200, Th=C3=A9o Lebrun wrote:
>
> > If the CQSPI_BUSYWAIT_EARLY quirk flag is on, call
> > readl_relaxed_poll_timeout() with no sleep at the start of
> > cqspi_wait_for_bit(). If its short timeout expires, a sleeping
> > readl_relaxed_poll_timeout() call takes the relay.
> >=20
> > Behavior is hidden behind a quirk flag to keep the previous behavior th=
e
> > same on all platforms.
> >=20
> > The reason is to avoid hrtimer interrupts on the system. All read
> > operations take less than 100=C2=B5s.
>
> Why would this be platform specific, this seems like a very standard
> optimisation technique?

It does not make sense if you know that all read operations take more
than 100=C2=B5s. I preferred being conservative. If you confirm it makes
sense I'll remove the quirk.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


