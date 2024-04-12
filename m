Return-Path: <linux-kernel+bounces-142917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DB8A3200
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA4D1C22693
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D514AD17;
	Fri, 12 Apr 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VMmrQF0I"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE582149C69;
	Fri, 12 Apr 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934809; cv=none; b=q2W4rWk+bJOtJpNlToBVzQ8dnQQG+S4jFciHpdVV68djypITWWj06GuXwJbpHkQfWzNeMphQ3VYxz+XpqCaNT4hdWxyxCWTyvd0MuPKpep2krPm8AALsSN03FJPZjLx5mgSFxdSlgVlyq5vWxRTOs8GyP1gvyakJM6ohILQ3jXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934809; c=relaxed/simple;
	bh=iy828oKVlqy5QYuzJ9LrPcNXklGl7u7M6Q8lvH1qjy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m6ZBKwrGxjtiENrVCmqlo8/dPvBNHhsaWwjhtXAZwXfNZC0KaUws4mnXzhoGxv5hGQKb1eZx1hQHWGgU9yT8nK161W6M76zFs7xKk3l7pn2je4QVqjl9jMGkpGfWz/8XM9pBUO7lzcmE0UGJtg9gtezlhtO3supGZgyYrG8aFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VMmrQF0I; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id bb10227b299c9ff8; Fri, 12 Apr 2024 17:13:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4E83966CC48;
	Fri, 12 Apr 2024 17:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934804;
	bh=iy828oKVlqy5QYuzJ9LrPcNXklGl7u7M6Q8lvH1qjy8=;
	h=From:To:Cc:Subject:Date;
	b=VMmrQF0IiwxzbvSSe5kRCSCXGKWuZOXJouTiUYCRugUpy/OfKPSJO9mA0Jt4IAjGh
	 NcutBK3jD9UboPwbOk18HnsT8n36Li2GJKdK2jOz2AAEAhfKkJMhyHybfL2uii4IfH
	 T+Qnu6BWTZo54w2r5w2HXr55PhSeQmUpgY/5UGa2kjeVesWBrTgf0lvdSUr44QThj+
	 aFYeFztj8JtCCq/bvkTiq7SWK0r+ZiDHQGon4ESWwI2QleCnjAsosEEkPh1egmcXZ3
	 ANPe7n9a1VdH5ZMQG9Cfc8IYsPUmikwNHL6koP1rew6nNmsevu/S4QKHeTN8OdBOEV
	 IHtXXzsa010Rg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 00/12] ACPICA: ACPICA 20240322
Date: Fri, 12 Apr 2024 17:03:13 +0200
Message-ID: <4920972.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepueffhffgiefhteeffefgtdeuudefkeejjeffteejvdegfefhhfefkeekheetleeknecuffhomhgrihhnpehinhhtvghlrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhn
 thgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi All,

This series of patches is a set of ACPICA 20240322 changes (described at
https://cdrdv2.intel.com/v1/dl/getContent/783326) ported to Linux.

It contains the following material:

Ben Cheatham (1):
      ACPICA: actbl1.h: Add EINJ CXL error types

Colin Ian King (1):
      ACPICA: Fix various spelling mistakes in text files and code comments

Daniil Tatianin (1):
      ACPICA: events/evgpeinit: don't forget to increment registered GPE count

Haibo Xu (2):
      ACPICA: SRAT: Add RISC-V RINTC affinity structure
      ACPICA: SRAT: Add dump and compiler support for RINTC affinity structure

Hojin Nam (1):
      ACPICA: Fix CXL 3.0 structure (RDPAS) in the CEDT table

Saket Dumbre (4):
      ACPICA: Attempt 1 to fix issue #900
      ACPICA: Clean up the fix for Issue #900
      ACPICA: Fix spelling and typos
      ACPICA: Update acpixf.h for new ACPICA release 20240322

Shiju Jose (1):
      ACPICA: ACPI 6.5: RAS2: Add support for RAS2 table

lijun (1):
      ACPICA: Modify ACPI_OBJECT_COMMON_HEADER

Thanks!



