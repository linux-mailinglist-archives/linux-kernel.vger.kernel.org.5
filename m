Return-Path: <linux-kernel+bounces-142913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713E8A31F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CAA1C22848
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F1149E1D;
	Fri, 12 Apr 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Yo6NiBpQ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF0148852;
	Fri, 12 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934806; cv=none; b=d31UITwy12hERVc1Whvl26X8ICrltcbhbpffQ90sOeAxheEi+4AXXo71X4YvsqhuZOoZgF88PfoyGvzeEVASJhAwGOnor2MKdV6qjNlCAahIwjS/dBqWKNnsi5qunyKOFEtOJZI4S/pB8Vtw0hbbFyuiTa6BBND9xFdwSL6S67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934806; c=relaxed/simple;
	bh=p4RQPeK0t0p2e2jCLxKSwbzqwUNfBGe8Sq+4GIgMmpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX0kCwEP9uBTdsLpNUYsTvCpjegvo2gDEFrD3DUSf+pRLK22XA6nhM8+iZX7cwymSq6QKOsl5yqjgaYE4BkYPtI4M+hjU+TSJLZJdLutG3vrbwXGy673siTBHCFDKfZd1GMY9ILkGultSwjN6k9CVQ2WUwHwuHeEKlBlgMuZ/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Yo6NiBpQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 78badbab5f534439; Fri, 12 Apr 2024 17:13:17 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 84BA866CC48;
	Fri, 12 Apr 2024 17:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934797;
	bh=p4RQPeK0t0p2e2jCLxKSwbzqwUNfBGe8Sq+4GIgMmpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yo6NiBpQEy0o83yG+bqFvdaxWxNKjVdqxSuVqzys0B+2veY6Chrc411w4+H9njz5t
	 J9QiFRtLaLHUizzt21p8TOPEWWLo22PgclHFpdjoQ6Aq9S5qzq7ZQZ7xkh3oC7ISO3
	 AUO5GoXa3NTCnz4ZjAygcZP3zZQT/M0pRFpGlbP1ljWHWKMGKVAZt7hHTwssgpxNHg
	 2kVLDz+qYi2mT/84n5CHGLy2l2coKsVlXx9n8iqoMveifyiOHaQnaBuUf1voJd5J55
	 CMhp0L/RGYs8JWULCHMvyRKMntuB6liTR0eQ0IriFuKu7kTj8oqZLWWlXQvwqkqmz/
	 h4RFSq75tHt/Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 08/12] ACPICA: SRAT: Add RISC-V RINTC affinity structure
Date: Fri, 12 Apr 2024 17:09:44 +0200
Message-ID: <3810933.kQq0lBPeGt@kreacher>
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

From: Haibo Xu <haibo1.xu@intel.com>

ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24

Add definition of RISC-V Interrupt Controller(RINTC)
affinity structure which was approved by UEFI forum
and will be part of next ACPI spec version(6.6).

Link: https://github.com/acpica/acpica/commit/93caddbf
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl3.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index c080d579a546..e32149d605dc 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -192,7 +192,8 @@ enum acpi_srat_type {
 	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
 	ACPI_SRAT_TYPE_GENERIC_AFFINITY = 5,	/* ACPI 6.3 */
 	ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY = 6,	/* ACPI 6.4 */
-	ACPI_SRAT_TYPE_RESERVED = 7	/* 7 and greater are reserved */
+	ACPI_SRAT_TYPE_RINTC_AFFINITY = 7,	/* ACPI 6.6 */
+	ACPI_SRAT_TYPE_RESERVED = 8	/* 8 and greater are reserved */
 };
 
 /*
@@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
 #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)	/* 00: Use affinity structure */
 #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)	/* ACPI 6.4 */
 
+/* 7: RINTC Affinity Structure(ACPI 6.6) */
+
+struct acpi_srat_rintc_affinity {
+	struct acpi_subtable_header header;
+	u16 reserved;
+	u32 proximity_domain;
+	u32 acpi_processor_uid;
+	u32 flags;
+	u32 clock_domain;
+};
+
+/* Flags for ACPI_SRAT_RINTC_AFFINITY */
+
+#define ACPI_SRAT_RINTC_ENABLED     (1)	/* 00: Use affinity structure */
+
 /*******************************************************************************
  *
  * STAO - Status Override Table (_STA override) - ACPI 6.0
-- 
2.35.3





