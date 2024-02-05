Return-Path: <linux-kernel+bounces-52867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06233849D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BCA1F24A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C92D604;
	Mon,  5 Feb 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U64wxXUG"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4B2E629;
	Mon,  5 Feb 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145175; cv=none; b=EKHLxgvHvUDNqcFjiG8GrwL3JcHfoO+G4oDl1jm1ncrzjg8LLDzB28QMJfL1JzI26lmg+jqmGM0hGImQxUFu9FCPnVh4yugdLVfuPn6C2bU1TSLf794QSwqmVgn1wZSzXHr5FkYmoQUctKQ6/gBhJcLZClSLfg6la+68CeB8KyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145175; c=relaxed/simple;
	bh=CyjNOwtxlSVa7OBG7E0Bp2hlmgZowX9ccOU7gtl0t+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qv5OCm33pytAgytQlXp5r6+/sKzuI/Z26fsLMoVOpBuoqf+61SC59141awKIe3+i60Ik2S4tfZGulZq+3g47s6NYDD55XvUsnkaKOBIIqkzFXnfTTicyC3uBv2d55V/7zQBv3CUWYJowQMaeX2U9GbVzimqQeXeWFTlZi9DdcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U64wxXUG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1EED1C000E;
	Mon,  5 Feb 2024 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyjNOwtxlSVa7OBG7E0Bp2hlmgZowX9ccOU7gtl0t+w=;
	b=U64wxXUGqvGXmARAf0uerbpGmfXM8Wj5pVw5k9ELtWlvuINv4u1g+6SFxkD/TLOqvcQGJn
	SQkU085REcikKFGz6lmL0vKvtlL5odZ5CCDJkJ+gRxicjyGd3k0H+OOYyYrri2/c6Jg/qt
	SCvV6cx34kPQQ9HVchYdDwTMcnwRIYBBJnL31ndeoiJO2+VyoRbUZXKFfqJcEkC8LLqdww
	qCUZzGUdIQ2Elo+IyvMXRiomIsDjzMRBmkXvOOcMhPSMvIhwvEXGoqpKv4rekBL/YDEIvo
	woxArfmP/EBpIEgzFzsu1DPC7/zRWKOBNaLfcOkFXZTlVgn76nJOqW+57CkEjw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 15:59:30 +0100
Message-Id: <CYX8GGLNXYJS.1GR11DNL2AOG8@bootlin.com>
To: "Dhruva Gole" <d-gole@ti.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 0/5] spi: cadence-qspi: Fix runtime PM and
 system-wide suspend
Cc: "Mark Brown" <broonie@kernel.org>, "Apurva Nandan" <a-nandan@ti.com>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20240205-cdns-qspi-pm-fix-v2-0-c59ac6996428@bootlin.com>
 <20240205144417.44jidulexgyccodv@dhruva>
In-Reply-To: <20240205144417.44jidulexgyccodv@dhruva>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi Dhruva,

On Mon Feb 5, 2024 at 3:44 PM CET, Dhruva Gole wrote:
> On Feb 05, 2024 at 15:22:34 +0100, Th=C3=A9o Lebrun wrote:
> > TODO: changelog below
>
> Accidental "git-sent" email? ;)

Indeed. :-) I wanted to share the series with a colleague for testing on
J7200 and messed up.

Looking forward to your review and testing on the V2.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

