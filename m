Return-Path: <linux-kernel+bounces-11982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D47F81EE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BA91F22E86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DA4439A;
	Wed, 27 Dec 2023 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smtp.mailtrap.live header.i=@smtp.mailtrap.live header.b="mi65+ORg";
	dkim=pass (2048-bit key) header.d=tomzanna.com header.i=@tomzanna.com header.b="hAcAYe3X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-200-110.mailtrap.live (smtp-200-110.mailtrap.live [5.181.200.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C444381
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tomzanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dnpw5703xzovsw6w.tomzanna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=smtp.mailtrap.live; s=rwmt2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:feedback-id:from;
	bh=sjZ5PCBt3D6/F+ea/52Yl440+MaFKi3LYeY4qE+sGwg=;
	b=mi65+ORg4i2xzRK2zfahumJwUlQab5pFAdf3t/ype3St49VcqTkhm15gPfC++3YrUJsiKLVZU5WHb
	 HoubKn5KIXl276IVVpnp+cI19BHncxCLNgRdcJI1aVHm2B4dc4qWgDnN0nUz+IquhMOXfHUTEMlFxQ
	 bOI918P365AevRlQRt1Tzuo7L0gXzLiGfcty4Dik3PEo8I/r5wZr6eEKfYSC4AMJA1zTTUeora3DCG
	 pmmuszcEv3IaO3waVnzxrE4bHLzd689gzizzzwr2N3uP/AzgSwZBGE65jKncCm8XLF014rntofJRZ0
	 7mG+rwJqEbALQ9REQpHqhrMUK7NHJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tomzanna.com; s=rwmt2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:feedback-id:from;
	bh=sjZ5PCBt3D6/F+ea/52Yl440+MaFKi3LYeY4qE+sGwg=;
	b=hAcAYe3XwPVW381whTL3e9fdc43hYKvr5VNGFEDD0vVtXxlXRRNk11Tk5dYSss7Ve+tUJqqW2lItI
	 yffb1XUBsXK1b/VYVq1egF0SZ8z6amzpEBQO9wmX2lhOzzXBCDHK3CPs8lE8a4wv3o1KuGRpNPwHq4
	 LKPzvJUAPsIgEvmJdVyuMDSsbh9R3gRWno0YLodtreLbXTfDiiJ6hj6SVPwnpaMwcB8b372ERI0rFg
	 PTg7FmIv8q1UmqgcC+cQDuFhyz2uKSXDVToEqZpFSvUPYcHHA23Hx2ApVMlWXaS4XCf7v3TCVUwjTI
	 GJ9EDbjzgs58nUmPE2k59107wLtlWtA==
X-Report-Abuse-To: abuse@mailtrap.io
Received: from tomzanna.com by smtp.mailtrap.live with ESMTPSA
 9a053d86-a4a4-11ee-9113-0a7c3e8c2873; Wed, Dec 27 2023 10:42:23 GMT
Feedback-ID: default:73696:transactional:mailtrap.io
X-MT-Message: 9ea3f0c0-a4a4-11ee-0000-f10c5eea18c1
X-MT-Domain: 6f3581fd-7900-47b4-af84-713a10caaa6f
X-MT-Account: 173bcdf6-cb1f-4895-a024-3acc438f33ef
From: Tommaso Zanotti <kernel@tomzanna.com>
To: broonie@kernel.org
Cc: Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com,
	Syed.SabaKareem@amd.com,
	Vijendar.Mukunda@amd.com,
	alsa-devel@alsa-project.org,
	bagasdotme@gmail.com,
	kuninori.morimoto.gx@renesas.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	mario.limonciello@amd.com,
	nicolas.ferre@microchip.com,
	perex@perex.cz,
	posteuca@mutex.one,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	venkataprasad.potturu@amd.com
Subject: Re: [RESEND] ASoC: amd: acp: add pm ops support for renoir platform.
Date: Wed, 27 Dec 2023 11:42:09 +0100
Message-ID: <20231227104209.6281-1-kernel@tomzanna.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <170267843699.316482.4350897389116089852.b4-ty@kernel.org>
References: <170267843699.316482.4350897389116089852.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc,
first time writing on a kernel mailing list here.

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix)

I noticed that this patch is scheduled to land in mainline on 6.8.
However, it was the second of a two-part bugfix for a regression introduced
in 6.6-rc1. You can find more info here:
- https://lore.kernel.org/lkml/87a5v8szhc.fsf@mutex.one/
- https://linux-regtracking.leemhuis.info/regzbot/regression/lore/87a5v8szhc.fsf@mutex.one/

Would be feasible to ship this patch already in the next 6.7-rc?
Because with the stable 6.7 some Huawei laptops will finally receive audio
support but due to this regression a workaround in user space is necessary.

Cheers,
Tommaso



