Return-Path: <linux-kernel+bounces-117543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EE88AC65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13700326D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29812C552;
	Mon, 25 Mar 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ll/4bPUp"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804B839E6;
	Mon, 25 Mar 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386394; cv=none; b=PMqr5uQt7Sl0g8MBIVTuBaRjK4MSGPAhRVnT135whyvd5B+8Jq84TLBlU9Y5r8RdxwCTorSaKoQaoOeb5GD/pBeqO0KEuXY25bB3iI7Enaf81v64QN8vXMgW5Mh8tE2srvJhoDh+pUmxkD6DXDVWcSURvpmxkpbpB6ugkhAKvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386394; c=relaxed/simple;
	bh=GSajnlwWrqE+p7NlosQIl9nO0bwgqStfgwiwvKUF4Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlMjPsUpqIXhqfXiktAtacYhTfEDiQrKudC+ZjfJ1IiqW8D8RUdW+SJUWdiqbRwn1VXgeOnTva0rwFKo6japGCqPE/G0NX3x3Wlb3PxGjFZvME3whFdyq1ZBVbMZX1wuEyyx9CdGUo6U21ymRyHE+j5FcC5rurgv8UdV+4W/elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ll/4bPUp; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 47c27d20224fbfad; Mon, 25 Mar 2024 18:06:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CBC0266BCFE;
	Mon, 25 Mar 2024 18:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386390;
	bh=GSajnlwWrqE+p7NlosQIl9nO0bwgqStfgwiwvKUF4Po=;
	h=From:To:Cc:Subject:Date;
	b=ll/4bPUprboo9BWu6U3lYYSuvA2WNlvCupNif2Kxtne/ziT6D+78kXluhF1wIxMHe
	 PYzhMdZTGKdnC+6qqTGqLeQe046uKdZKKZNo7MOXcyxBIAoMU2DGx4LumBDNpbP5Zc
	 yUhNQ0r34P90UU/u6Cj5ldDJ9XGObC4TMLv8CRNFUoDs3VZTOmilWzdLn3za4dPLNN
	 ylcG/RNQ9Btji0+w1wcgpQoTaKGbNw+ehCPY7AorfcnLFd+20eMoIHMrUdXiI6JuxR
	 6PQMk5ZF65WT7AncT+HZDOaW4DG2LtUhy/WikHJ9GCZeTxN4oJhTY6atLkYPKrTt6B
	 ODpP/nLjZEtEw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/6] intel_pstate: Turbo disabled handling rework
Date: Mon, 25 Mar 2024 18:00:45 +0100
Message-ID: <13494237.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

Hi Everyone,

This series reworks the handling of disabling turbo in intel_pstate
on top of the previous series of cleanups

https://lore.kernel.org/linux-pm/12409658.O9o76ZdvQC@kreacher/

The underlying problem is that disabling turbo is handled quite consistently
in intel_pstate and basically it can get disabled at any time (through
MSR_IA32_MISC_ENABLE_TURBO_DISABLE) without much coordination with the
cpufreq core or anything else.

Disabling turbo through the "no_turbo" sysfs attribute is more consistent,
but it has issues too (for example, if turbo is disabled via "no_turbo",
the frequency-invariance code gets notified on the turbo status change,
but the actual maximum frequency of the CPU is only updated if the
MSR_IA32_MISC_ENABLE_TURBO_DISABLE value changes either, which need not
happen at the same time or even at all).

The first patch is not really related to the rest of the series, it's
just a cleanup and can be applied separately.

Patch [2/6] uses the observation that it should be necessary to read
MSR_IA32_MISC_ENABLE_TURBO_DISABLE after driver initialization to remove
in-flight reads on that MSR and turbo state updates related to them.

Patch [3/6] builds on top of the previous one to adjust the "no_turbo"
attribute "store" and "show" callbacks.

Patch [4/6] adds READ_ONCE() annotations to global.no_turbo accesses and
makes some related simplifications.

Patch [5/6] replaces the cached MSR_IA32_MISC_ENABLE_TURBO_DISABLE
value in some checks with global.no_turbo for consistency.

Patch [6/6] makes all of the code paths where the maximum CPU frequency
can change to do that consistently by using the same set of functions.

Details are described in the individual patch changelogs.

Thanks!




