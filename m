Return-Path: <linux-kernel+bounces-94469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BB874044
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74B31C232AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579813F45D;
	Wed,  6 Mar 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Q/3BsQRb"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAC13EFE8;
	Wed,  6 Mar 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752840; cv=none; b=ksKtct/lJoDt2+UkmmP4nZsTwBuOMrLlD0O/KxF3UFg0qX9ncqCfGjiIRO+1ZaTghV0c7zzUEreQh1wi1219OYUx2Y7JHryAbqSKy9uZ+2GS/2q62zYyxeKioa1elExr+3VuOEZpCerxJMylTcqiUUWHveVcBqjy2RkPfE1BEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752840; c=relaxed/simple;
	bh=4fMhiw3tE5WZcMRLKuvfLPC66ljmwpev+Ytbx/U5IgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAseM0iREhSDnQGjjMw8N6KxNu7bQFYZYarEko39L5LcMqiNx7hxS9V4vXQk2rB7joXJqb8xwz9z1YpHEquDO57hLLPVteQGvuQuYoGMtN70xAJn2bHRWgy49esRMIzr/auujazKfVKqbPdjBEBrRYpmwB2fP8zSTMH/NigzyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Q/3BsQRb; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 9ce8f26884046da2; Wed, 6 Mar 2024 20:20:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0A4E366AB8D;
	Wed,  6 Mar 2024 20:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1709752830;
	bh=4fMhiw3tE5WZcMRLKuvfLPC66ljmwpev+Ytbx/U5IgE=;
	h=From:To:Cc:Subject:Date;
	b=Q/3BsQRbhGChIMmpAwxcFOXMrGCyIpHpVpjGKr287BkQfpRkfiB8xLz8VZZxqnbFW
	 2y+BnfUW49NXbl6ZoTv5aDlVg90lGuOM3d1eTXOI+nbIVQqobPxbHR3DauEQskHi4e
	 X/dbTuYUhqSIEr7Kh6N9PMkffp34zJxjG0SMhtEOvNMX1m2h9wr+UKf4sz4mMjfa4Z
	 Yhi2kMS17FjTlSV3CxkpkjSTVNoAxwYZJSDC94YoFzgSHuiQg/y1+inf+SENYeUmBF
	 +ETjL6bFJ9DYYcwQG2ZCxhqrLkYndCTN3a25JfSxQJvcP3Vx/Z3hhcpEGPmHvvbF9U
	 K83VKxA6OZD3Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 0/2] thermal: More separation between the core and drivers
Date: Wed, 06 Mar 2024 20:14:15 +0100
Message-ID: <4558384.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledriedugdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This series is for the next kernel development cycle and I'm sending it
mostly due to the discussion regarding the ordering of trip crossing
notifications:

https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/

because the solution of the ordering problem I have in the works is
based on it.

Still, please review it and/or test it if you can and let me know if you
discover any problems related to it (I'm not seeing any issues with it now).

Patch [1/2] is based on the observation that the threshold field in struct
thermal_trip really should be core-internal and to make that happen it
introduces a wrapper structure around struct thermal_trip for internal
use in the core.

Patch [2/2] moves the definition of the new structure and the struct
thermal_zone_device one to a local header file in the core to enforce
more separation between the core and drivers.

The patches are not expected to introduce any observable differences in
behavior, so please let me know if you see any of that.

They are based on the thermal material currently in linux-next and I'm
going to create a separate test git branch with them.

Thanks!




