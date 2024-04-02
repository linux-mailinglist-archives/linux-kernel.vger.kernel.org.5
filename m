Return-Path: <linux-kernel+bounces-128535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FB895C24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261CB1F23AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F415B963;
	Tue,  2 Apr 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FEkWLYqt"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7515B542;
	Tue,  2 Apr 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084690; cv=none; b=WTKxJ1L9pF7Xf32xwhiNC8bS4gky07nCElRNeCIzh90bU7arkDGm1Bp66UixpqjRfMHewJjJvqGs0iGvUTeO7rrp00pg7Y5pUS7FR9nqM6dyYSEGde9EJ9LHV992a9KPehjLesr13TTOnnApRCdLilL+PtHd1v5gw4ZoIrHbzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084690; c=relaxed/simple;
	bh=Legyi8s1aj0iwNAVWc0C2wTLd3674Uc5QjKYYL+1Al0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q70lw7X6Z8cwZXJT5GYVa3Q6JKi/9xt+t1v9EksXZO2ZawaY6nDcUD2qw6d7lI4qsLj39q/jOjbPg4e9Sv6lkLKRSEv4m2mwELk7a1VqgkXpqqzdYobHyGYRqMC1CnBei0MDc4dt86W/9I0Jrv5JbNbOA4BmyZkZHwjMfU8teSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FEkWLYqt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id b02708ad7978d327; Tue, 2 Apr 2024 21:04:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 042FE66C5C5;
	Tue,  2 Apr 2024 21:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084686;
	bh=Legyi8s1aj0iwNAVWc0C2wTLd3674Uc5QjKYYL+1Al0=;
	h=From:To:Cc:Subject:Date;
	b=FEkWLYqtD2wI5oe7DgTOvmUjX6ziE7c/PAnAZnEKCTw4IxRygARUa+0h7Gokhh2AO
	 99AwTowzRQelDFH6ZAM8YyQRrMdmEOeCahQONhZFjqpbydzhb8NYakun3strdeNz1n
	 +7nzBix6dYuk8ul3y7mVhOkkeK8mEPzD6TTfx1cz3KUr76tKhk57OMYeE+1E7XqhhG
	 UhkMzzA+8GffRtNT08P2Ne+Du5mkO/ZSCgRNzt9nH7ezJ2RH2yVtRlSiQFlSRoAWdF
	 MY/NF5p7Xb667gRcGTPOBEY5mKU7U5GSD9LjqKlAePkiD8h3rFdYtvQGs14E9M5jpO
	 PUevZPzjzQ+cQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/6] thermal: More separation between the core and drivers
Date: Tue, 02 Apr 2024 20:54:31 +0200
Message-ID: <4558251.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggr
 nhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/

and

https://lore.kernel.org/linux-pm/2331888.ElGaqSPkdT@kreacher/

which rebases the first patch on top of 6.9-rc2, adds 3 patches and adjusts
the third patch from v2.

The original description of the first two patches still applies:

> Patch [1/2] is based on the observation that the threshold field in struct
> thermal_trip really should be core-internal and to make that happen it
> introduces a wrapper structure around struct thermal_trip for internal
> use in the core.
> 
> Patch [2/2] moves the definition of the new structure and the struct
> thermal_zone_device one to a local header file in the core to enforce
> more separation between the core and drivers.
> 
> The patches are not expected to introduce any observable differences in
> behavior, so please let me know if you see any of that.

Note that these patches were first sent before the merge window and have not
really changed since then (except for a minor rebase of the first patch in
this series).  Moreover, no comments regarding the merit of these patches
have been made shared, so if this continues, I will be considering them as
good to go by the end of this week.

Patch [3/6] is a rewrite of comments regarding trip crossing and threshold
computations.

Patch [4/6] updates the trip crossing detection code to consolidate the
threshold initialization with trip crossing on the way up.

Patch [5/6] ([3/3] in v2) adds a mechanism to sort notifications and debug
calls taking place during one invocation of __thermal_zone_device_update() so
they always go in temperature order.

Patch [6/6] relocates the critical and trip point handling to avoid a
redundant temperature check.

The series applies on top of 6.9-rc2 and I'm planning to create a test
branch containing it.

Thanks!




