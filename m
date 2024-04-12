Return-Path: <linux-kernel+bounces-142907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934808A31E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCADBB25393
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F86148FF2;
	Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uajkZPHE"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778B1482EC;
	Fri, 12 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934804; cv=none; b=Zv9kdkIm6qJ9klBzqrGS2Xe4oj29ysDPI0ge2HsOHhfSXCXrK4rBudRgAPQojVHfIIxQLuP1YfUk1ne9Wie/Pm42y2AW+FRZQslPIk1FCXCkugcTa7Gatk2cTnH2RAAjopRr0IVV/tDjA99bLLb6Ot2ouY73A53IqpzLYI/qh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934804; c=relaxed/simple;
	bh=wsSXAxCERv7P2sWCk0/q7yMeWx5a3fu8XZr5NSXXZPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRM192GXTyVjN44rV2dORRbzPdWAXiyHt27AOmlBDL0XDESQjOgBxZt8vZFq0HG4wUeQjBGKlXgX0N74ZIBrReackiWY8W8xxpi0ehjT5bWHxgnimbAumPsjoP37xcM6Mm91+yZc4K28uQyxkElTIfemhZrkvFPNO90CpvQGfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uajkZPHE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 25fe0833119f93a8; Fri, 12 Apr 2024 17:13:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 75B3766CCA6;
	Fri, 12 Apr 2024 17:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934798;
	bh=wsSXAxCERv7P2sWCk0/q7yMeWx5a3fu8XZr5NSXXZPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uajkZPHE5tsNY1YyqXpX45UdjRGZxKOjpPQQ8zRvv5lVezy4W7ChZEq6rJ/AXbSfp
	 hIcVYo73nZ+0stE6S9qtcvlR/prUNL+7onaIxA7nq6b8vRij2NSBnD2n0m9jmp91QS
	 kFiZfFrPyctRTimOGyL4CAPIH5eDicsYnmzvAxjLto1dn3m/v/E2nanWz1a8RB3p/f
	 VXqESoX2HtnCAqr8bl/pqzVBTor6+L24BIWGWnpaEm4FhEgfBLAUJicAZvkVydqF8M
	 RhAeSuSXtrwAHNkA/+dzQAVsmD/+Ck6XJ8X6G7w4kpN5GYqoT8M+fADcdWsYwahS5i
	 mXL9Aj7IlRsLw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 06/12] ACPICA: Fix spelling and typos
Date: Fri, 12 Apr 2024 17:07:59 +0200
Message-ID: <2272660.iZASKD2KPV@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit a6a236c44c7d3eb54562fb5ddde4144d8347e0ac

Clean up the fix for Issue #900.

Link: https://github.com/acpica/acpica/commit/a6a236c4
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 98027d2f7bfb..3d71bd9245c7 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -67,7 +67,7 @@ void acpi_ut_track_stack_ptr(void)
 #pragma GCC diagnostic ignored "-Wdangling-pointer="
 #endif
 		acpi_gbl_lowest_stack_pointer = &current_sp;
-#pragma GCC diagnostic popmake
+#pragma GCC diagnostic pop
 	}
 
 	if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
-- 
2.35.3





