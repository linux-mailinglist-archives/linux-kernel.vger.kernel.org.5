Return-Path: <linux-kernel+bounces-110599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD9488611C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32EC1F21DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8453135A65;
	Thu, 21 Mar 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FNpaZYZ3"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE41350D8;
	Thu, 21 Mar 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049668; cv=none; b=Cn4VUBjpmybpLL+H1xCOSCoFlQ0sULuXk40cNscIakrVX1+RnVd7TmaFYa0lJPK8NqLiXevbGlzlmwnDMByd3ZS3dxPYdt+rZF1cD+rcnrV6GqAWfSjEKt8SBo83T7mKJHhGA0W/6UTkdq6FKmvBmblbeaesvN/XQQApsXqFGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049668; c=relaxed/simple;
	bh=2TGyXt9LLGvKUhdncEm/RUgIXkLTtUF74W253pT6vZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQQrtP5ly6sr2KhmjM6wWt5g7mPzRgv8UBck3ds4o/JuZbG4bSC6bLoz99alrBqCguoVervIVYqyTbj6TFWdhBxD7IiUQUFettH1nI0oUO6kVZxI2QtA2WCayEhT9W70GFHmzVG2wG6zIE/8zMaSyIpiEQkUWjLp75+2BFD/nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FNpaZYZ3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id a12ad0389b7fd623; Thu, 21 Mar 2024 20:34:18 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 53FC766B8D7;
	Thu, 21 Mar 2024 20:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049658;
	bh=2TGyXt9LLGvKUhdncEm/RUgIXkLTtUF74W253pT6vZs=;
	h=From:To:Cc:Subject:Date;
	b=FNpaZYZ3no2oxb91IyuC80QoQKzdpU0SQ+4cJc2vlCgZJng/fZGhNIs+tQXwuUtNX
	 noRUo1eHW/ots+l/uub6pP3Nt/bV7wqGzOGcJ+BEf6NizjhhurCV8sZoXr5PkEn2N1
	 MN3faStNm7zvZ7zbW3BrmdWrgA5a7BtiQuud+CO9/tDz4RLI7jmyhxOuKavOHfPmLQ
	 Ws9+v/zZiHxyn0NPuKF91c4dwt//9G5DMVja2ouUyJBLSYedogvxpeI9ZRiKgz29xu
	 vLI6HPAcIpx7l+w3NA5Qq6O451lXMxT7laTwIffOwPZXFAoqNPOlOZkSJ6r1y/fV07
	 QKeXv+uapvZlA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/5] intel_pstate: Some code cleanups,
 mostly related to concurrency
Date: Thu, 21 Mar 2024 20:28:25 +0100
Message-ID: <12409658.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Everyone,

This series consists of a few cleanups of the intep_pstate driver, mostly
related to spinlock locking and synchronization.

The patches are not expected to alter functionality in a visible way.

Please see individual patch changelogs for details.

Thanks!




