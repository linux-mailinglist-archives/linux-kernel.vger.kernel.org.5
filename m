Return-Path: <linux-kernel+bounces-64547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343885402E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21081B2206C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B163111;
	Tue, 13 Feb 2024 23:37:34 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961E5FF09;
	Tue, 13 Feb 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867454; cv=none; b=Z34rzjF7HuRvjuUJCOxOTWD/z/t2CuOeLBfmJMjmMj0Puc1plnheNlyrIijwqADxdvfFAN7xtgHb85emN6cwkoQUX3sqmsz3M0xPwwllnaHYjKLMe4bT+1Ef2jhenH5sOS3Dibbf2I1uB4eGFc3Sf0PD/CfgyNB7FoN9SdnvUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867454; c=relaxed/simple;
	bh=l4zlABakHG1SEs5TKwTDVAnsPVbwPbPjfVKmGSFErxw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=efP6vtpX2l0f7oQYRBohdOAc+bBdGwtOVAvX3qLmPybfAROCT7wuBv50lYDVV9Fz/Qh+wSyU+7dKZ0kgPFud5TwGTsqcJ3tjYcb93CC6hrfhK72Xj12HavJegPDAJYERn+MESsXwtT5wOJOhcckwwbGx4A77PsFftNvCf6adj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 42F485FF95;
	Wed, 14 Feb 2024 00:37:23 +0100 (CET)
Date: Wed, 14 Feb 2024 00:37:23 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
Subject: [PATCH v3 0/3] ALSA: hda/realtek: cs35l41: Fix internal speaker
 support for ASUS UM3402 with missing DSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Index: b1DHXbQj7eN1w6/I0T0Clij1GRQ0gA==
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD

This patch set adds the missing DSD properties, to make the internal speake=
r works for the "ASUS UM3402" and does some cleanup.=20

Following feedback, I've divided the initial patch into three independent p=
arts and adjusted the explanations:=20
- Patch 1 : Add internal speaker support for ASUS UM3402 with missing DSD=
=20
- Patch 2 : Fix device ID / model name (no functional changes)=20
- Patch 3 : Fix order and duplicates entry in quirks table (cleanup, no fun=
ctional changes)=20

Thank you Takashi for your guidance=20
I hope everything is in good shape now.=20

Regards=20
Lo=C3=AFc=20

sound/pci/hda/cs35l41_hda_property.c | 2 ++=20
sound/pci/hda/patch_realtek.c | 7 +++----=20
2 files changed, 5 insertions(+), 4 deletions(-)

