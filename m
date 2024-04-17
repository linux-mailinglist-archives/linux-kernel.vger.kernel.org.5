Return-Path: <linux-kernel+bounces-148525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD68A83F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0AB1F25A50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5013D53D;
	Wed, 17 Apr 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="j+dTTMg3"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BF13FD84;
	Wed, 17 Apr 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359530; cv=none; b=HxWHL3WXvVHUdb6Ft34bgsL+EgBnF+TmSJwdiAUwNEhtF2eOC+78Eyu0yshyTk6h6nRVcYxxTSRA1bYABWnLol4R3ysbHHm8J6vZkw7nW5T7zg8i1NZJH8Trctc9sm5Ya52esY879hfGcJk7CtLDiEkTZiCGSN3wtPk1QworxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359530; c=relaxed/simple;
	bh=/UItrVhtEpZok9gejkBmtkpTQ00qFXhKxDfhAeFE0uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDJmyYnD7GltG0pKu84PMcy5M3bQDfgbo2eT9gkM/Jp5edqA59Ee+8XVw3OEsKygRL8T8HKQ94iwNth3OWKYBihzqWyZSKWAZ79MqCJQeFVWUjedCUt33iKc8/Hz2DJ5zR4+ynY2jHhG/0QSU1ykWxhWegu1ZOptlKX7uHr5rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=j+dTTMg3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 8cabd5d5eb81c915; Wed, 17 Apr 2024 15:12:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A0AA366D262;
	Wed, 17 Apr 2024 15:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713359521;
	bh=/UItrVhtEpZok9gejkBmtkpTQ00qFXhKxDfhAeFE0uY=;
	h=From:To:Cc:Subject:Date;
	b=j+dTTMg3Jk9GehRhmNnzIHQYWX/2Ok+girx82EponB1Jxpssn/TXRDoxYiLSlXD8y
	 zktJGY6o5yvq2F41LUxJgh8lCV3mL/GvQktrcudPNi89AuEw5Yo1wouBOdFjuQma3s
	 5Sa6on6zei6eadF1i96MtPzrquJIa3qn6GscJ7LCBRs8HF6dobnO7d2WW8B8ZGDF93
	 2rCrCK5wtj150GZex4pD8U5/kUxnScJlalq8+agwuOGw2d8QHgjBupcIykihqgEVWR
	 A+wJYvNvSo2sqlbxz5Ufd9o6/YhB0+LpH54fbWpwexzd86GP/Bk+M5D90g71o5rUnA
	 T0sm7rKjxLNkw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point statistics
 updates
Date: Wed, 17 Apr 2024 15:07:19 +0200
Message-ID: <4918025.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

The first patch in this series addresses the problem of updating trip
point statistics prematurely for trip points that have just been
crossed on the way down (please see the patch changelog for details).

The way it does that renders the following cleanup patch inapplicable:

https://lore.kernel.org/linux-pm/2321994.ElGaqSPkdT@kreacher/

The remaining two patches in the series are cleanups on top of the
first one.

This series is based on an older patch series posted last week:

https://lore.kernel.org/linux-pm/13515747.uLZWGnKmhe@kreacher/

but it can be trivially rebased on top of the current linux-next.

Thanks!




