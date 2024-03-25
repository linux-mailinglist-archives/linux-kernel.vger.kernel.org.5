Return-Path: <linux-kernel+bounces-117094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9088A6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D34C1C3C114
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4913C699;
	Mon, 25 Mar 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lW/8a70L"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E813AD2A;
	Mon, 25 Mar 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372416; cv=none; b=Hm06sln7pI5BHW4kM9djt+65p/Y/ZTemfrYv+Lj5F1LadFJU+bfM/xyXSTFMHg60a04dfSCVIRXGgfYPXs3btIOEb6K6A0lFwXrNnHqnnsKa/Fbs2U68u/mzDV0onc4D7Il+HjPJETO/Be1HwE+vT1CSp2X3O73MIa9ENF7HwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372416; c=relaxed/simple;
	bh=iQMayPEW8MBkybLIRcF8R/io8VmXpDXSND6ZUdlpDB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHfpQbk8pf1dnP2kD33WxUfeUYmHEqWWEJc00KB1CkCXLU637FhNOf6PVhJMSkbByq60kY0GZ5HxtSO7PkVWI/IKleBL1lfKHSNW0f+eL4BfoqYX+gXjXim8LrJ+OilbHtABSA6pDQGgaq92mSkA8AybK6YC0pPh5F2QA1kFsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lW/8a70L; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 96ad974033357c0e; Mon, 25 Mar 2024 14:13:32 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 736D566BCBC;
	Mon, 25 Mar 2024 14:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711372411;
	bh=iQMayPEW8MBkybLIRcF8R/io8VmXpDXSND6ZUdlpDB8=;
	h=From:To:Cc:Subject:Date;
	b=lW/8a70LWpVWb8O0S9M9/74eorT3V6uN/akKckrYJdq0gKflPZl/xo6YyS6qTgBfD
	 yVL83kB4dt8X8h/wrgjfe/jrbagDxFBKTvzmuG9lrRXgrE74j+VkDiAsyRqVAxhRRh
	 ayOwyV378u7nLDnc+xSrgCYiu8H1LUPoIju1m7nWqDOwMlSzEIsqXUXuOtnWeB/yGR
	 p4cZfT2mZEJ6N392ImgbjjQQdgHlHGu1j8GnIqPcE9F+6TQgkaed7Xm9Llzabi82wc
	 kKDxJd2PCzYURWyoWkVqe7xphpJbhXoUzJpmj/+eh8PQUjhwf/06CjnMFVuagzTjm4
	 U+W87IAzaCLQQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/3] thermal: More separation between the core and drivers
Date: Mon, 25 Mar 2024 14:10:28 +0100
Message-ID: <2331888.ElGaqSPkdT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/

which is a resend of the series with one extra patch added.  That extra patch
is related to

https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/

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

Patch [3/3] adds a mechanism to sort notifications and debug calls taking
place during one invocation of __thermal_zone_device_update() so they
always go in temperature order.

The series applies on top of 6.9-rc1 and I'm planning to create a test
branch containing it.

Thanks!




