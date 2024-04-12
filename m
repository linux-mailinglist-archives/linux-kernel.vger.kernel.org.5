Return-Path: <linux-kernel+bounces-142914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F38A31FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6711C22804
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340914A0AE;
	Fri, 12 Apr 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cVytqs01"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F9148FE7;
	Fri, 12 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934807; cv=none; b=LsnhMlKZfR89EVmyXQSTE3qwo3/Y5SpMe8pLSn2pQM0IhtWPcbW3mUDfCMmk4wNFikF9n0EsQKePvg/LIzNTTxdo5jcdgQUiBk4HHEK2Dem0+rWmp6/7DiEMq2XcXxatjjRPZaF+SxvOlM1yU60CYg/H6xNHznlUbKk35asPYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934807; c=relaxed/simple;
	bh=cVGtdaiupYjV8guLODOd/qTyWi620xz/uwHunw1pD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9HzqkiJF93WiUSRAlumDniWmKMlcFH/fXp2ofqRt1pQFT2mh7nvYpwN/h/xIuixBPhiYpDmYA7atYlCGn9Ze/zZjUmO9hES2ZbovKQ6l8bRtzW7h9gFWBC5h0zCEtBlNkElpt3NfEjntYMhi1lzXtB56lLpzNofjLsD49Sg3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cVytqs01; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 49711fe95accb72e; Fri, 12 Apr 2024 17:13:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6194566CC48;
	Fri, 12 Apr 2024 17:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934802;
	bh=cVGtdaiupYjV8guLODOd/qTyWi620xz/uwHunw1pD5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cVytqs01jJrVM6XHYQmvy5ShTl6BdjSEGVwN+H9WUVonuScSltq4L7UjfMMLFTbue
	 Phk9lDWE/tWjbnHS/HWbMev6N1WMWcfq07psXMlY+yQvD0DsTVBn2haIFAVypba+ux
	 qgHMfIBMEjKuO8lI05DFMGqu1ajelH2zlWFOkDCtDhuwXyCuC5Ih6mQ52ALxHQ6VPy
	 M1s+AnNYrM+NawvUxxPt+pJwAAAhdGJ+evu8tagXC5+R3bCtKHx35AdODef1h/KmIV
	 wD1+SNE7u2/cL8A0VxDwhxqX1yrAV1Neid/8zWruR9aNwIuDtV4RDAd7kNDjUKDdG8
	 BGyVTUD8iaFlA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 02/12] ACPICA: ACPI 6.5: RAS2: Add support for RAS2 table
Date: Fri, 12 Apr 2024 17:05:03 +0200
Message-ID: <1893131.tdWV9SEqCh@kreacher>
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

From: Shiju Jose <shiju.jose@huawei.com>

ACPICA commit c581606cf49b7574d29c02b1a3bc144650375e32

Add support for ACPI RAS2 feature table(RAS2) defined in the ACPI 6.5
Specification & upwards revision, section 5.2.21.

The RAS2 table provides interfaces for platform RAS features. RAS2 offers
the same services as RASF, but is more scalable than the latter.
RAS2 supports independent RAS controls and capabilities for a given RAS
feature for multiple instances of the same component in a given system.
The platform can support either RAS2 or RASF but not both.

Link: https://github.com/acpica/acpica/commit/c581606c
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 129 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..64a3f9ae2641 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
@@ -2751,6 +2752,134 @@ enum acpi_rasf_status {
 #define ACPI_RASF_ERROR                 (1<<2)
 #define ACPI_RASF_STATUS                (0x1F<<3)
 
+/*******************************************************************************
+ *
+ * RAS2 - RAS2 Feature Table (ACPI 6.5)
+ *        Version 1
+ *
+ *
+ ******************************************************************************/
+
+struct acpi_table_ras2 {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 reserved;
+	u16 num_pcc_descs;
+};
+
+/* RAS2 Platform Communication Channel Descriptor */
+
+struct acpi_ras2_pcc_desc {
+	u8 channel_id;
+	u16 reserved;
+	u8 feature_type;
+	u32 instance;
+};
+
+/* RAS2 Platform Communication Channel Shared Memory Region */
+
+struct acpi_ras2_shared_memory {
+	u32 signature;
+	u16 command;
+	u16 status;
+	u16 version;
+	u8 features[16];
+	u8 set_capabilities[16];
+	u16 num_parameter_blocks;
+	u32 set_capabilities_status;
+};
+
+/* RAS2 Parameter Block Structure for PATROL_SCRUB */
+
+struct acpi_ras2_parameter_block {
+	u16 type;
+	u16 version;
+	u16 length;
+};
+
+/* RAS2 Parameter Block Structure for PATROL_SCRUB */
+
+struct acpi_ras2_patrol_scrub_parameter {
+	struct acpi_ras2_parameter_block header;
+	u16 patrol_scrub_command;
+	u64 requested_address_range[2];
+	u64 actual_address_range[2];
+	u32 flags;
+	u32 scrub_params_out;
+	u32 scrub_params_in;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_RAS2_SCRUBBER_RUNNING      1
+
+/* RAS2 Parameter Block Structure for LA2PA_TRANSLATION */
+
+struct acpi_ras2_la2pa_translation_parameter {
+	struct acpi_ras2_parameter_block header;
+	u16 addr_translation_command;
+	u64 sub_inst_id;
+	u64 logical_address;
+	u64 physical_address;
+	u32 status;
+};
+
+/* Channel Commands */
+
+enum acpi_ras2_commands {
+	ACPI_RAS2_EXECUTE_RAS2_COMMAND = 1
+};
+
+/* Platform RAS2 Features */
+
+enum acpi_ras2_features {
+	ACPI_RAS2_PATROL_SCRUB_SUPPORTED = 0,
+	ACPI_RAS2_LA2PA_TRANSLATION = 1
+};
+
+/* RAS2 Patrol Scrub Commands */
+
+enum acpi_ras2_patrol_scrub_commands {
+	ACPI_RAS2_GET_PATROL_PARAMETERS = 1,
+	ACPI_RAS2_START_PATROL_SCRUBBER = 2,
+	ACPI_RAS2_STOP_PATROL_SCRUBBER = 3
+};
+
+/* RAS2 LA2PA Translation Commands */
+
+enum acpi_ras2_la2_pa_translation_commands {
+	ACPI_RAS2_GET_LA2PA_TRANSLATION = 1,
+};
+
+/* RAS2 LA2PA Translation Status values */
+
+enum acpi_ras2_la2_pa_translation_status {
+	ACPI_RAS2_LA2PA_TRANSLATION_SUCCESS = 0,
+	ACPI_RAS2_LA2PA_TRANSLATION_FAIL = 1,
+};
+
+/* Channel Command flags */
+
+#define ACPI_RAS2_GENERATE_SCI          (1<<15)
+
+/* Status values */
+
+enum acpi_ras2_status {
+	ACPI_RAS2_SUCCESS = 0,
+	ACPI_RAS2_NOT_VALID = 1,
+	ACPI_RAS2_NOT_SUPPORTED = 2,
+	ACPI_RAS2_BUSY = 3,
+	ACPI_RAS2_FAILED = 4,
+	ACPI_RAS2_ABORTED = 5,
+	ACPI_RAS2_INVALID_DATA = 6
+};
+
+/* Status flags */
+
+#define ACPI_RAS2_COMMAND_COMPLETE      (1)
+#define ACPI_RAS2_SCI_DOORBELL          (1<<1)
+#define ACPI_RAS2_ERROR                 (1<<2)
+#define ACPI_RAS2_STATUS                (0x1F<<3)
+
 /*******************************************************************************
  *
  * RGRT - Regulatory Graphics Resource Table
-- 
2.35.3





