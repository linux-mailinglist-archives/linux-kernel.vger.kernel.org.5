Return-Path: <linux-kernel+bounces-155779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D38AF702
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E2FB27FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA774142654;
	Tue, 23 Apr 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="v/uguod+"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369091411E2;
	Tue, 23 Apr 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899004; cv=none; b=iPbhl4F6USPRlDx0Jp87+qpDtIjX0TNSdCsDCZx9rSqRMAKUw87FxxqYQQyguZldh9pCsjR1rMp1cQBkI8xdgnE44xKMD3sJ4/SOaETvLqh1z0FMayVPGIxpmuYAc/jYDRdREOKdJvRYqkJzwNPLOD61dcbCTsrupb+ThLhrTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899004; c=relaxed/simple;
	bh=LFOOxpFh/7aFYWdR7UgyJwLunb9waVNBklnKzbvtBuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVD8TpdEl9VlosQeFVitvoexgMoVurqfev8dOKSLz9kdHmy1e24OKRzQHDyz2NLj/diquzdh/6NpDSQBXxOipMe+D2cXtcERa3MfSraxNX17CbULX4aeckZ7bSTwSjS3JeMCrSbMs9cPqnLPFIZmV0vVVsqVzE82jQo22yKjIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=v/uguod+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 1636d9c1730bdaa3; Tue, 23 Apr 2024 20:03:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C506A66DB86;
	Tue, 23 Apr 2024 20:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713895400;
	bh=LFOOxpFh/7aFYWdR7UgyJwLunb9waVNBklnKzbvtBuI=;
	h=From:To:Cc:Subject:Date;
	b=v/uguod+tmHQU6dEb+riDqvrdqlr6/IPwM9uPctXEzsVQglWV7mnItbghITeMXRqe
	 rKgORtWknISUrDctZyb+vBlDfa7V80X/cOsoUW9RDhx/r8QLaCYZrzz2wJxbuA0CO+
	 pSqzO6fF00qZT840InececX4cXICDJsTcjM3J3QCoyAq04TvDU9SVmJCLe0dfHC1Ed
	 qElv4AGmzq05gDsS8ic/1B3b5uiTShOCE2i/JrQ4I3szy0sBMOb0AYn0gAWtAUD+vx
	 1bJYXB0ownhSRcrvToeGLjPQr2K/vyWmACDosxilGyWYT/YsQvGD6TmzSxz6U+vZRt
	 1hDP1iQbSheBQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 0/3] thermal/debugfs: Fix handling of cdev states and mitigation
 episodes in progress
Date: Tue, 23 Apr 2024 19:29:12 +0200
Message-ID: <5774279.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggr
 nhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

The first two patches fix printing of cdev state residency values
for the initial state and for the states that are used for the first
time.

The last patch fixes the handling of mitigation episodes in progress
for thermal zones.

Please refer to the patch changelogs for details.

The series applies on top of the bleeding-edge branch in linux-pm.git.

Thanks!




