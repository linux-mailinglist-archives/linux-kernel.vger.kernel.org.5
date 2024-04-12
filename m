Return-Path: <linux-kernel+bounces-142908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1758A31E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8631C2209F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01C14900F;
	Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="exoCXUQI"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909A1487C4;
	Fri, 12 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934804; cv=none; b=VUVg9ISaj/tsuixMYRys08jbE1Xc+mWVOjBVrSBvBMI1Qlzszd6guEjMFe1fFjBZXmaYuKHC1Y2u2vAAzlmnplTucvAtlNBVOTSi3Bn5H9jLr9M2+JDyEpUcxjivANvIFTheaqdA7jNlqcF52CrnBToRHpyKJIY19zdHRYZka9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934804; c=relaxed/simple;
	bh=Hs9biZqLKEfTkKiiF95DKblDQ5tMVujTw07s2sLFZhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqQ4F/sbDaTWGV/k7NJwvyFmkGBRcvsqB2FZEjM+sYdrEhO9Jv2XRCIR1dmzmxIbVNGfiuak15/RSaqqJj/gZn+oS/GKVR//G4sxHrxTLq6znxpU4lkzzrs9jMREhwu9upcl3YzerbDo9OXVZnEG5pIof1iBWwNLCadVZKi9F3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=exoCXUQI; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id dc1f162837375e90; Fri, 12 Apr 2024 17:13:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5D56D66CC48;
	Fri, 12 Apr 2024 17:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934799;
	bh=Hs9biZqLKEfTkKiiF95DKblDQ5tMVujTw07s2sLFZhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exoCXUQIlavw70iTMGN8Amu/8FmN8Ho5ix9+TnNpmKYb4W/V6QKvl6iByOv/F7u0u
	 NDEf62uA8Bw6dObauWFRbssjBO6d2EwAmmfpq50spCtScH74votEmESSEql4r01jmM
	 tjOEFwlZjpKxZeQcxZYYb81RrPTJQxDcTJYCX8zXNK3zI40XhyJ3ekNXBLrb8lk+xb
	 cQho2HIDwkTnDdgTARQGmqoUu7pEYMXKBo7f/SlNX2iX0MyyntyTlxMUsEcDmKJHNH
	 cmXXMlyyOExK4sxQXyvQY/y2E+aPY1iPktXFFg9JBPKOzY4Pd+9DB7KNl0klZJqoSu
	 WpHEHf8gnCS9A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 05/12] ACPICA: Clean up the fix for Issue #900
Date: Fri, 12 Apr 2024 17:07:17 +0200
Message-ID: <8368629.T7Z3S40VBb@kreacher>
In-Reply-To: <4920972.31r3eYUQgx@kreacher>
References: <4920972.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit b6b38edb0c18017af0bd2aff4eaa502810c8873f

Link: https://github.com/acpica/acpica/commit/b6b38edb
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdebug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 2f37d673e285..98027d2f7bfb 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -42,6 +42,7 @@ void acpi_ut_init_stack_ptr_trace(void)
 #pragma GCC diagnostic ignored "-Wdangling-pointer="
 #endif
 	acpi_gbl_entry_stack_pointer = &current_sp;
+#pragma GCC diagnostic pop
 }
 
 /*******************************************************************************
@@ -61,8 +62,12 @@ void acpi_ut_track_stack_ptr(void)
 	acpi_size current_sp;
 
 	if (&current_sp < acpi_gbl_lowest_stack_pointer) {
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 12
+#pragma GCC diagnostic ignored "-Wdangling-pointer="
+#endif
 		acpi_gbl_lowest_stack_pointer = &current_sp;
-#pragma GCC diagnostic pop
+#pragma GCC diagnostic popmake
 	}
 
 	if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
-- 
2.35.3





