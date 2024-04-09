Return-Path: <linux-kernel+bounces-136634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D532189D656
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323B2B24C19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAF81726;
	Tue,  9 Apr 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZzEaGpmR"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E047D3E8;
	Tue,  9 Apr 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657369; cv=none; b=Qtodnkk9CX/szB7J0QN9ltmcdPMd++yCWKKnnLrGDAHf2FyoABb/GRrm4+DIO/0QeDoV+OBt4BBdhlzCxuhbXj/mne3ShTNnFng49G0orwB8Ud5YYDgpzp8Ruf4idlr0/6to5M4yN5TnEzePZgsDdAchNQvIkGRLF8kSzPKUwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657369; c=relaxed/simple;
	bh=kPve59cg+kbjwFG+j4J1S4mcG9qBitt5lHcER6L38Vg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jw5VwuFeVlqOkW38J/U3vbtW/P59RuDgU2yPtBkpQ8qCbM/0qc2YwbOn+oVJpi8sGFznDzIO3EX2gDqv9su14QIFS3T7EpslS/n5fBOsd+VZCV44KFK4BGkCLcpN5cc9RfMsXFno3UopI/iuCGJrwn1Siw/HQ4nfl4KpoNLtVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZzEaGpmR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E25E620005;
	Tue,  9 Apr 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712657358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkOZRgZN7hbEc/8b8ArAg5uS4IlZ6EWpP5ZMcV/G7KA=;
	b=ZzEaGpmR+ztCVSdv0AhiewnxS8iPe15xzID6gNN68isgCoSYX+e9U+VXNluv2vXqlS3veH
	X/51oO3V9KHqMpO5EylWZ5BKbj7b+xNtq0IluWlOJjKfMOVKC8Bevot0b1xytcbAbNwTEl
	HIa8GAj54hZ258Q3QsYdUoH4HU/sxg6r+dmlH5TLlEHXMRwVkirZQAvFMwcwlGy6T/1aQa
	aJl9JfG58zDl+nB87GB9xMxXlvnyTFtPfRk/lYDmtD+1qPXOapm4ZEna/h32JizoB4Pd/Z
	FnkzI5Lm/VRCexTT2TMXmKtPjH3sLToc/qUz90Rud8UdLKafS5IuRHz5jp2fnw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Apr 2024 12:09:17 +0200
Message-Id: <D0FID4G7T4N0.194WATCMTOUEY@bootlin.com>
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
Subject: Re: [PATCH v2 08/11] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-8-956679866d6d@bootlin.com>
 <1f7087ad-824e-47fe-9953-ed5152c8f18f@sirena.org.uk>
 <D0ETJXNHOUKQ.C368FEZVM9DD@bootlin.com>
 <9cb48440-c71e-4a73-8104-4780f0e98e72@sirena.org.uk>
In-Reply-To: <9cb48440-c71e-4a73-8104-4780f0e98e72@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Apr 8, 2024 at 6:40 PM CEST, Mark Brown wrote:
> On Mon, Apr 08, 2024 at 04:42:43PM +0200, Th=C3=A9o Lebrun wrote:
> > On Mon Apr 8, 2024 at 4:16 PM CEST, Mark Brown wrote:
> > > On Fri, Apr 05, 2024 at 05:02:18PM +0200, Th=C3=A9o Lebrun wrote:
>
> > > > The reason is to avoid hrtimer interrupts on the system. All read
> > > > operations take less than 100=C2=B5s.
>
> > > Why would this be platform specific, this seems like a very standard
> > > optimisation technique?
>
> > It does not make sense if you know that all read operations take more
> > than 100=C2=B5s. I preferred being conservative. If you confirm it make=
s
> > sense I'll remove the quirk.
>
> It does seem plausible at least, and the time could be made a tuneable
> with quirks or otherwise if that's needed.  I think I'd expect the MIPS
> platform you're working with to be towards the lower end of performance
> for systems that are new enough to have this hardware.

Next revision will do the same busywait behavior unconditionally then.

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


