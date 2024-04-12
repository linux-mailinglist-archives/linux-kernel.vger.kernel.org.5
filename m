Return-Path: <linux-kernel+bounces-142927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3D8A321C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B11F2245E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6203149C44;
	Fri, 12 Apr 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hK+7XMub"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DF1494D2;
	Fri, 12 Apr 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934913; cv=none; b=c6g0NmQOl9peyGOizmfOr1GnMXNN20eKYYIRQcex3iVU7nUy4PhkHZN98upj9Q7rnXMVWJO9at3GS1yxPUuwHvQkwoJi2qUsyJMf/b8VfQ689GAUPYOxKqvOLhfHn5YrssduBKp6/cFlNd0FfWeyRD9bFLyTlFTp29OAp7wFyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934913; c=relaxed/simple;
	bh=iy828oKVlqy5QYuzJ9LrPcNXklGl7u7M6Q8lvH1qjy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7lA/Wv60MvO/RQmAmto6VdX50FDRstWztshqIXbIJHxQ5jZb4m/AenRSgKgi9BEB4m6bZfEb37tqvzj7ISCYQkIA7lnFCA04l0+rurqeUStkb6lPp9uC0I2vUdhwL1P7j30kc1jFyrQMK7uhcc6mwBYq5HcUe8JuHzqzQ6cA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hK+7XMub; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 5c93bcff7a742ab9; Fri, 12 Apr 2024 17:15:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AB0F566CC48;
	Fri, 12 Apr 2024 17:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934909;
	bh=iy828oKVlqy5QYuzJ9LrPcNXklGl7u7M6Q8lvH1qjy8=;
	h=From:To:Cc:Subject:Date;
	b=hK+7XMub3oYigTkcr8hiCCwooLvJfAIJ48F8ft67ncdrDEu6Y14gFciGVB02n4Wvt
	 BRiNLWekdzhybLXLmHFkwVFV68AnR+Ddk2FMkWU3Oyis6/fdXpmmKWLWa1PnxZ/lW9
	 0oced6puw94SVcZiAS5okooli4zCiVAXYuC8Rb55lXuu2H2Agccxaocu+8UIQbkX1z
	 FVDMbTzoK9nzaHQGnq7QHA1U4skM+Tw3z6V1lFcIvrFPirABKPC4Ajbug8gQuA3OAw
	 x5cwLjypVINouDUPhupwUrjQTpIs7OUC/BhcB3c9p+zCd+Eof1KwUpONpks1jFfoC7
	 LfLcMeRLWddtA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 00/12] ACPICA: ACPICA 20240322
Date: Fri, 12 Apr 2024 17:15:08 +0200
Message-ID: <23477713.6Emhk5qWAg@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

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



