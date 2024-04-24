Return-Path: <linux-kernel+bounces-157455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7268B11DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA09F28461C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB316F28B;
	Wed, 24 Apr 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9ZJIpcv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3F16E888;
	Wed, 24 Apr 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982492; cv=none; b=ruKynOssVe8wGVpQeN46NkGDWNvtH08zA27M+mhgcktqS3cKr/ckXGZ1FYWO3ddJ7w0cG7R9rilj6PvDThvNmZ2U/w3vYcEwnfzV7RpwO5pjZVyTLOqLbtD/Qo2LqC4MlEaCDAirvc9zAaywP1ZyVFMd0tnNSMzWG4PjB96XHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982492; c=relaxed/simple;
	bh=khsp430wCZF85FG8u7FCOLvv9K3w859TzG0TQy2mIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8npXbw9fa0NcnJEdmULqDGknqow6ebHVJNLwwH8DqW5YOsArSOWfnXOqycJo9ICs3iWz1uHVergVl3wDwJR48uoji+dwDjjjJi+xAmha8woNeQjKS/872r9Ic5l7xmgZodAnnaqpngQsAFtIgjkarPfCIKdfN48O747ksCUaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9ZJIpcv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982491; x=1745518491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khsp430wCZF85FG8u7FCOLvv9K3w859TzG0TQy2mIZU=;
  b=C9ZJIpcv5dnzUt8fzmw8Rt9cy9TcqD8x36qtZQ+Jx0cnEgkWg+Xk76Sw
   LBRsB2SDQGrg7zyc19o3OWzkcX7eaMT/+jQF/FXixik3tIaMqApkc53lG
   PEBAQC5uD9yQClUE53EFpzxKz3eVoB6mbL5ZSlxUiw9fHPOgSShpbi12Z
   orJpUBwvXzDa8IS5Yb00YxC/nn3R5+wb/T1RGIYW0L3DtvsEcddUXTe9Q
   +JpP0hp5ZUjbhl5liNlKxeei69opYZ3pFSbU1vNGsj6kZX2Jl4BnmrQck
   6uwpNGDdU1tFXuMSwU8GsQ2woJUgxb8IMaGp2/4JZ8mRR/tBPYKXSzeaZ
   A==;
X-CSE-ConnectionGUID: Kap8YXqORs2mBzVRJpUhhg==
X-CSE-MsgGUID: GVt4/XxqS5++bKsdiB4j6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481756"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481756"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:50 -0700
X-CSE-ConnectionGUID: ArE35bv8SxStrrmql8SDQw==
X-CSE-MsgGUID: PiYV0wPNTq6UdpwkazL6kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262553"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:50 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Marius Hoch <mail@mariushoch.de>,
	Tony Luck <tony.luck@intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	linux-acpi@vger.kernel.org,
	patches@lists.linux.dev,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 06/71] ACPI: x86: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:49 -0700
Message-ID: <20240424181450.41270-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/utils.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 90c3d2eab9e9..2d8203f7bd98 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -45,37 +45,37 @@ struct override_status_id {
 	unsigned long long status;
 };
 
-#define ENTRY(status, hid, uid, path, cpu_model, dmi...) {		\
+#define ENTRY(status, hid, uid, path, cpu_vfm, dmi...) {		\
 	{ { hid, }, {} },						\
-	{ X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },		\
+	{ X86_MATCH_VFM(cpu_vfm, NULL), {} },				\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
 	path,								\
 	status,								\
 }
 
-#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_model, dmi)
+#define PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, hid, uid, NULL, cpu_vfm, dmi)
 
-#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
-	ENTRY(0, hid, uid, NULL, cpu_model, dmi)
+#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_vfm, dmi...) \
+	ENTRY(0, hid, uid, NULL, cpu_vfm, dmi)
 
-#define PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
-	ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_model, dmi)
+#define PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, "", NULL, path, cpu_vfm, dmi)
 
-#define NOT_PRESENT_ENTRY_PATH(path, cpu_model, dmi...) \
-	ENTRY(0, "", NULL, path, cpu_model, dmi)
+#define NOT_PRESENT_ENTRY_PATH(path, cpu_vfm, dmi...) \
+	ENTRY(0, "", NULL, path, cpu_vfm, dmi)
 
 static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
-	PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
+	PRESENT_ENTRY_HID("80860F09", "1", INTEL_ATOM_SILVERMONT, {}),
+	PRESENT_ENTRY_HID("80862288", "1", INTEL_ATOM_AIRMONT, {}),
 
 	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
-	PRESENT_ENTRY_HID("80862289", "2", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
@@ -84,18 +84,18 @@ static const struct override_status_id override_status_ids[] = {
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
+	PRESENT_ENTRY_HID("INT0002", "1", INTEL_ATOM_AIRMONT, {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
+	PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
+	PRESENT_ENTRY_HID("SYNA7500", "1", INTEL_HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -112,19 +112,19 @@ static const struct override_status_id override_status_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
+	PRESENT_ENTRY_HID("KIOX000A", "1", INTEL_ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
@@ -137,7 +137,7 @@ static const struct override_status_id override_status_ids[] = {
 	 * method sets a GPIO causing the PCI wifi card to turn off.
 	 * See above remark about uniqueness of the DMI match.
 	 */
-	NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", ATOM_AIRMONT, {
+	NOT_PRESENT_ENTRY_PATH("\\_SB_.PCI0.SDHB.BRC1", INTEL_ATOM_AIRMONT, {
 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
@@ -149,7 +149,7 @@ static const struct override_status_id override_status_ids[] = {
 	 * as both ACCL0001 and MAGN0001. As we can only ever register an
 	 * i2c client for one of them, ignore MAGN0001.
 	 */
-	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", ATOM_SILVERMONT, {
+	NOT_PRESENT_ENTRY_HID("MAGN0001", "1", INTEL_ATOM_SILVERMONT, {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
 	      }),
-- 
2.44.0


