Return-Path: <linux-kernel+bounces-142911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE38A31F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33221F209AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4E149C65;
	Fri, 12 Apr 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CdOOC3Dh"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274014882F;
	Fri, 12 Apr 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934806; cv=none; b=P8ugJ4kHjcdm+n13bNjcT64xieRKCMOeW5JrpIoWfd6/nQIpkZzkkU0Abf57Lo0vsNSY1BqCU7ROJGE9F/2Q+MiJ7g4GKNhYN4c4Ygj9iEKd2iVr7BGgZ5tQwZt1pd8Z5a+GRf86rb2lxy/bauyI0yV0bQuow2wdxYyh1UpclQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934806; c=relaxed/simple;
	bh=MIF9L/LlgmqiISt/v6w3P6UAL0iVgvwXe4+kcNeKgxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBe4ieeH3EctlHXbmvCWQqBnoIDpMbmxbTk2K3pPGmjUPYJWwTXNers4DILcGWrLhfoUGDDw/wA/9z2LH5N8V/Z18PHXlyGqMrY+rK2e+1h0dww4Dv/GMBF5LjG0N2ismtpaGzlKp1xLJ0z9rfSSAglG2Otzc/lD9xbllBh7ZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CdOOC3Dh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2513efe14aaec706; Fri, 12 Apr 2024 17:13:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6AC7B66CC48;
	Fri, 12 Apr 2024 17:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934801;
	bh=MIF9L/LlgmqiISt/v6w3P6UAL0iVgvwXe4+kcNeKgxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdOOC3DhFxmy57GvltF0LY8b7hAO6c2327vNeBnoK3M7kEpHkZtAHWW3VbwPHt2be
	 9YMznT28g23bu17DCWzLweWeKhUtY59qJG2yQHoOb9pzdQ7ia70z3TnSchcWyGTK9C
	 2TZuiXnf1f5scb5pybrELYPXluYJmq16/7H3x9YqwYf4aa9v+TjcqH1dsQjTQz29Sl
	 j+6FzBNEShwErTquxSAdZiqdHNEp27Mx4PDZpOMEH8TD0vQYwRn5ggeZVdCy2CXPgb
	 sTk0aFvXjqpLUjMyfGlUMf9ZYcMJQq+r0RQNBNINLzQ4PT9EGxxa040RZttPSHCOCf
	 GUFuuxpCX2bZw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 03/12] ACPICA: Attempt 1 to fix issue #900
Date: Fri, 12 Apr 2024 17:05:43 +0200
Message-ID: <13500523.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit f5910dd1ab60780b95eed16d36860f18b01bc156

Link: https://github.com/acpica/acpica/commit/f5910dd1
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index c5f6c85a3a09..2f37d673e285 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -42,7 +42,6 @@ void acpi_ut_init_stack_ptr_trace(void)
 #pragma GCC diagnostic ignored "-Wdangling-pointer="
 #endif
 	acpi_gbl_entry_stack_pointer = &current_sp;
-#pragma GCC diagnostic pop
 }
 
 /*******************************************************************************
@@ -63,6 +62,7 @@ void acpi_ut_track_stack_ptr(void)
 
 	if (&current_sp < acpi_gbl_lowest_stack_pointer) {
 		acpi_gbl_lowest_stack_pointer = &current_sp;
+#pragma GCC diagnostic pop
 	}
 
 	if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
-- 
2.35.3





