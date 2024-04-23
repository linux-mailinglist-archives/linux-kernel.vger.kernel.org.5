Return-Path: <linux-kernel+bounces-155791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445848AF727
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007CC2892B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80E140E40;
	Tue, 23 Apr 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="B1M1F0Oq"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9713E031;
	Tue, 23 Apr 2024 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899981; cv=none; b=YpUb4aTNIbsghc7Ge9CLwbeiTB98w66q3APzhAtr4RZmaFRp59zIzcTWjWf16mShAVi6Ljqn7Ikkean+3A5g669kksiTte7QfUcv6i1jcptkBdh9wy/+CkyNRms+DkDTs7fZ3TNSXzGeHVzi3eS0rdbdglQL0BDMpBJrCPVZznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899981; c=relaxed/simple;
	bh=yC2sOTTLKyjJya0KuXGRtrG/1u1CmNweM0g0qgRcqSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/SUQSFQpFgqpnwd4VaQSUqoOFd13kokdc+o2uyiCO5CCXIZl7Mc2PuzMk4mUXwvW0UY5d7JyIOiSANuOxbuFrn8R3QBGFWGAB/7+NAdIggIyBlOkfvOjZdu7/woth3RNyuWv8KhhJEfCwl+9NsF7pnBkO0YnMs/sJjADqcAToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=B1M1F0Oq reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a5cb8043b5e3b96b; Tue, 23 Apr 2024 21:19:37 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8495166DB89;
	Tue, 23 Apr 2024 21:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713899977;
	bh=yC2sOTTLKyjJya0KuXGRtrG/1u1CmNweM0g0qgRcqSQ=;
	h=From:To:Cc:Subject:Date;
	b=B1M1F0OqPpQQiiQgT2mmEhAYfslKdNrdpPnHQu0LPunY7P+pXVPPbsB4RR1cH2F/e
	 AGsfYjEzhikU19woCDE/6YcHZiE4sm33ojOzwSSP1I/tudbSz6GhvnGKKGiyzNurXZ
	 beyTCmrz+gefST5kEEk7foU78SC0wcyso3AvwRXN+hk4iDb8BKCoHwWU9E3hI172av
	 5RGqiBS+jWEhv33h471J5zz5sQ83J68a5+Q/s9GFJVFLQoYlOfKKbS1AxgboZngB0o
	 YUsGznCPpAuvAdmj9MvPkulw2O6StLov95qAI8mEPJXRt845A8NEqnZjb6GXBa4R+e
	 Q4rEx3lromdRA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Mark Pearson <mpearson@lenovo.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM functions
Date: Tue, 23 Apr 2024 21:19:36 +0200
Message-ID: <12427214.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgudefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmphgvrghrshhonheslhgv
 nhhovhhordgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT
UUID for non-AMD systems") attempted to avoid evaluating the same Low-
Power S0 Idle _DSM functions for different UUIDs, but that turns out to
be a mistake, because some systems in the field are adversely affected
by it.

Address this by allowing  all Low-Power S0 Idle _DSM functions to be
evaluated, but still print the message regarding duplication of Low-
Power S0 Idle _DSM function sets for different UUIDs.

Fixes: 073237281a50 ("ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID for non-AMD systems")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218750
Reported-and-tested-by: Mark Pearson <mpearson@lenovo.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -492,16 +492,14 @@ static int lps0_device_attach(struct acp
 			unsigned int func_mask;
 
 			/*
-			 * Avoid evaluating the same _DSM function for two
-			 * different UUIDs and prioritize the MSFT one.
+			 * Log a message if the _DSM function sets for two
+			 * different UUIDs overlap.
 			 */
 			func_mask = lps0_dsm_func_mask & lps0_dsm_func_mask_microsoft;
-			if (func_mask) {
+			if (func_mask)
 				acpi_handle_info(adev->handle,
 						 "Duplicate LPS0 _DSM functions (mask: 0x%x)\n",
 						 func_mask);
-				lps0_dsm_func_mask &= ~func_mask;
-			}
 		}
 	}
 




