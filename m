Return-Path: <linux-kernel+bounces-139138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67889FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8A51F27132
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BCA199EA9;
	Wed, 10 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DNyc2YbK"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B51181D05;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771105; cv=none; b=d0TyOGuhTaVRzXFz7lhikf1neUe4wM9RkMQjIlxUJ9c3wad6lH+acMJYdKjMUZZi8h2jYGRzoug1qEhspMCL7lZPEchbHZn1nQaJ1q40bzw8S0VYwahCWA/bYsbX2qvSCjqwslIOnN6rZFXU44LzngEyjO2DLsTCkjGKCwk77X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771105; c=relaxed/simple;
	bh=mQxW2PWQ11zVSsI4swAlfOj60y4IUFGMgYMNB9KLmSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AssPSp2h0rfG5TySXJ06o6H4AmRjdl30mxFM43tnHW9cm55etkx58XmF/yEE1P2b5R8TE30QlPdgeCbHJqOX7tGjJMJ16kHAr7A+iJPddkPoZ1oNOrOs/O2yfjhE8nkVfZI/CZo7HtHQbbjkawEOdZk+J9mABHefBXAeOY/dEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DNyc2YbK; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 7dd0c63301b10db9; Wed, 10 Apr 2024 19:45:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2453D66C66F;
	Wed, 10 Apr 2024 19:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771101;
	bh=mQxW2PWQ11zVSsI4swAlfOj60y4IUFGMgYMNB9KLmSc=;
	h=From:To:Cc:Subject:Date;
	b=DNyc2YbK0tWd+cSV9ocn0brRz0jqZk/jQndzNt00fsLdx7PoQuUoYVvCEH0uV50hr
	 omvIp/EomgFHEgV1SyvEjfdD8crI3gEORbmS4gMzX2Jf5nF1AyXZVN12rNQDztcUt1
	 R8rKZ60yHE2fYvLI2BlahCjKQOVRhPK9mdvd9hsT2+EuhQ3wxlY99Nx021AyZ8DaYm
	 tsQKkTF2IksaA52IChm/UmU0WEpPTCvMWokc9weGhYx3PaYLPlHWnD9d/+7bw1RolV
	 eKltdY3AybEnSh6NL41ZmGlWt9gjixntVjgsWawrY0TUMhEk2yzi3NAXdPq2Cz9Zg9
	 8KVXAAAIMWumw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 00/16] thermal: core: Redesign the governor interface
Date: Wed, 10 Apr 2024 17:41:19 +0200
Message-ID: <13515747.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrges
 rghrmhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

First off, apologies for the size of the series, but I couldn't resist
throwing a few cleanups in for a good measure.

To the point, this is based on two observations: (1) that the existing
throttle() governor callback is not really suitable or convenient for
any governors in the tree and (2) that the majority of governors in the
tree do not take trip hysteresis into account, although arguably they
should do that.

Point (1) is addressed by replacing the .throttle() callbacks with two
new governor callbacks, .trip_crossed() and .manage().

The first one will be invoked whenever a trip is crossed at the time when
the netlink messages are sent (so the ordering of these calls will be the
same as for the netlink messages).  This is suitable for governors that
only care about trip crossing events, like Bang-Bang.

The other one will be invoked once per thermal zone update, after all of
the trips have been processed by the core, so the governors using it will
have to walk the trips by themselves, but they may also skip the trip
walk entirely if they don't need it, like the Power Allocator.

The .trip_crossed() callback is introduced in the first patch.  Next, the
Banb-Bang governor is switched over to using it (instead of .throttle())
and cleaned up.

The .manage() callback is introduced subsequently (in patch [05/16]) and
the Power Allocator, Step-Wise and Fair-Share governors are made use it
instead of .throttle(), in this order.  The latter two are then modified to
use trip point thresholds instead of trip temperatures, which they should
be doing.  Still, all of the patches changing one governor are grouped
together.

Finally, the User Space governor is modified to use the .trip_crossed()
callback instead of .throttle() and the latter is dropped from the code
because it has no more users.

In addition, the handling of critical and hot trip points is relocated to
eliminate a redundant check.

Please refer to the individual patch changelogs for details.

The series is on top of the linux-next branch in linux-pm.git, which by now
should have been included into linux-next.

There is also a git branch where it can be found:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=thermal-core-testing

Thanks!




