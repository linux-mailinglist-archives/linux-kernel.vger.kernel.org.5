Return-Path: <linux-kernel+bounces-158656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E18B2380
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C0FB297CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EE14A4EE;
	Thu, 25 Apr 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Pi5AMVqZ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B3149E0E;
	Thu, 25 Apr 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053955; cv=none; b=Tvb538bMe5EB+0kYNiJ+5g2Btjgqisz4RsCVCnnj84W9gWsjXZjAIvurYgMczYxy5+APrlezzbykVnBVUBZRpH8qlh/kZ9x2JGepGLjCbuNiJNKeS9H50OivfDnzbb8bFlKsUReTiHuVjPh54btqtpONWN1ZzoRiy8d9pKBdwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053955; c=relaxed/simple;
	bh=EcBPIfrZC4hXnMGwfCWiJ1NkJ86U3Wp8hSZVK99lyj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u+YbsyQxbONLOzinLQv+guJYN9j7S8/XNBuJllP5ip7CGqzfEC4179oZ5iFJxzdQ5MlrPP8tGQDrkz8j3QpEALbXrFdDsUYlliG4vRL+c0rWYT7drDKJnRMCcqHfYGZevNOPfO9YlWwBs//5TGK+6ku1YwFLqwKXIRwhsJ/0VO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Pi5AMVqZ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 5c5e24a5af2b71c4; Thu, 25 Apr 2024 16:05:51 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CD60866DF23;
	Thu, 25 Apr 2024 16:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053951;
	bh=EcBPIfrZC4hXnMGwfCWiJ1NkJ86U3Wp8hSZVK99lyj8=;
	h=From:To:Cc:Subject:Date;
	b=Pi5AMVqZx2k4DrXG2XkxsLa8sCZwXF2PDxCws3qUSkXk7nx089Qm76OjDyD+lC+Sc
	 cQlrQwt+WKT4Vyvz+3OW3CZcHb+ZEJj/seUbBCnj/T4KCtdwB7blhGns8whwccWHxp
	 mVXxywZ+KjCRLY9UVUaqexm/cR0NDNxElcs8XFTqKNXk4b7qLF1zHhzIUGoCUtASG3
	 JqXediBrSdGWT7bwUVQj7ZBfz43aYqOv0KsB0NCsNm5C+ELJBmd0WDKEC4S6t8ivML
	 v+qAFvxIRGHcwJhOdDUCXyOA8Sw0G0K/HeGgmOWMnfMbjsM45ZnOaqhRpYXOREV4CJ
	 lZOJSrznpBPAw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 0/3] thermal/debugfs: Fix handling of cdev states and mitigation
 episodes in progress
Date: Thu, 25 Apr 2024 16:01:48 +0200
Message-ID: <3297002.44csPzL39Z@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/5774279.DvuYhMxLoT@kreacher/

and the only non-trivial difference between it and the v1 is a small
rebase of the second patch (the v1 of which didn't apply).

It generally has been based on top of

https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/

but it should apply on top of the linux-next branch in linux-pm.git as well.

It is present in the thermal-core-next branch in that tree, along with the
above series.

Thanks!




