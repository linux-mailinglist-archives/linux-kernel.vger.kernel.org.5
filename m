Return-Path: <linux-kernel+bounces-134151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DE89AE4A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDBB1C20CC7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BA1879;
	Sun,  7 Apr 2024 03:25:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D71C0DD2;
	Sun,  7 Apr 2024 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460309; cv=none; b=iCgToSAFx1anhbZwUe5aX57+AmkLZdwG5WPa7/FyHj704jVQwXU3/Fbnkwo3x7mfwyU59gRFn0LEz4FiQEKe8Lw225bOYmTaRDFbuSyMbN8eBDZ834HWlKav+TTCDMLgIUGmj3Ea6fuFNXx7MD/CtQgrHsC+X3OePoyOVXQkxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460309; c=relaxed/simple;
	bh=RCw/giiHxgF8h5cPiraGo8muTZHc12ESXyVaUjXcD3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjz/a9qa80hCRMDVAWqeuyMMAMcXjHSCJnSRMbiMizNPG+C+p6Jf5udfKzSqIS9HJOBPhhRrnD5g8pvfmnD6ibZA2ZXTkse9P5DPsxmIPxsg1hU5mDdgQkzxOtYcjUR+YPpDbnAeNSKSAkibm4fAV8OGulHhEMYafbPmwA2wBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64432c2cf48e11eeaf09c5092e5928d1-20240407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ce72e07d-5b24-4376-b6cf-4784bc6a80ba,IP:-13
	,URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-18
X-CID-INFO: VERSION:1.1.37,REQID:ce72e07d-5b24-4376-b6cf-4784bc6a80ba,IP:-13,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-18
X-CID-META: VersionHash:6f543d0,CLOUDID:12f5df7d6b639c2dd02030c52d827b5b,BulkI
	D:240407112451I7G0K7XO,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,TC:n
	il,Content:0,EDM:5,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS, ZHF_RECV_LOCALHOST
X-UUID: 64432c2cf48e11eeaf09c5092e5928d1-20240407
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 71539736; Sun, 07 Apr 2024 11:24:49 +0800
From: lijun <lijun01@kylinos.cn>
To: robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org,
	evel@acpica.org,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	rafael.j.wysocki@intel.com,
	lijun01@kylinos.cn
Subject: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
Date: Sun,  7 Apr 2024 11:24:56 +0800
Message-Id: <20240407032456.4079002-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify 4 macros:
ACPI_OBJECT_COMMON_HEADER,
ACPI_COMMON_BUFFER_INFO,
ACPI_COMMON_NOTIFY_INFO,
ACPI_COMMON_FIELD_INFO
they  cause  poor readability.so del the last ";"
and when use them in a single line with the ";"in the end.

Link: https://github.com/acpica/acpica/pull/924
Signed-off-by: lijun <lijun01@kylinos.cn>
---
 drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 1bdfeee5d7c5..0cd1769022aa 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -48,7 +48,7 @@
 	u8                              descriptor_type;    /* To differentiate various internal objs */\
 	u8                              type;               /* acpi_object_type */\
 	u16                             reference_count;    /* For object deletion management */\
-	u8                              flags;
+	u8                              flags
 	/*
 	 * Note: There are 3 bytes available here before the
 	 * next natural alignment boundary (for both 32/64 cases)
@@ -71,10 +71,12 @@
  *****************************************************************************/
 
 struct acpi_object_common {
-ACPI_OBJECT_COMMON_HEADER};
+	ACPI_OBJECT_COMMON_HEADER;
+};
 
 struct acpi_object_integer {
-	ACPI_OBJECT_COMMON_HEADER u8 fill[3];	/* Prevent warning on some compilers */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 fill[3];	/* Prevent warning on some compilers */
 	u64 value;
 };
 
@@ -86,23 +88,26 @@ struct acpi_object_integer {
  */
 #define ACPI_COMMON_BUFFER_INFO(_type) \
 	_type                           *pointer; \
-	u32                             length;
+	u32                             length
 
 /* Null terminated, ASCII characters only */
 
 struct acpi_object_string {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char)	/* String in AML stream or allocated string */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_BUFFER_INFO(char);	/* String in AML stream or allocated string */
 };
 
 struct acpi_object_buffer {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)	/* Buffer in AML stream or allocated buffer */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_BUFFER_INFO(u8);/* Buffer in AML stream or allocated buffer */
 	u32 aml_length;
 	u8 *aml_start;
 	struct acpi_namespace_node *node;	/* Link back to parent node */
 };
 
 struct acpi_object_package {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;	/* Link back to parent node */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *node;	/* Link back to parent node */
 	union acpi_operand_object **elements;	/* Array of pointers to acpi_objects */
 	u8 *aml_start;
 	u32 aml_length;
@@ -116,11 +121,13 @@ struct acpi_object_package {
  *****************************************************************************/
 
 struct acpi_object_event {
-	ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;	/* Actual OS synchronization object */
+	ACPI_OBJECT_COMMON_HEADER;
+	acpi_semaphore os_semaphore;	/* Actual OS synchronization object */
 };
 
 struct acpi_object_mutex {
-	ACPI_OBJECT_COMMON_HEADER u8 sync_level;	/* 0-15, specified in Mutex() call */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 sync_level;	/* 0-15, specified in Mutex() call */
 	u16 acquisition_depth;	/* Allow multiple Acquires, same thread */
 	acpi_mutex os_mutex;	/* Actual OS synchronization object */
 	acpi_thread_id thread_id;	/* Current owner of the mutex */
@@ -132,7 +139,8 @@ struct acpi_object_mutex {
 };
 
 struct acpi_object_region {
-	ACPI_OBJECT_COMMON_HEADER u8 space_id;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 space_id;
 	struct acpi_namespace_node *node;	/* Containing namespace node */
 	union acpi_operand_object *handler;	/* Handler for region access */
 	union acpi_operand_object *next;
@@ -142,7 +150,8 @@ struct acpi_object_region {
 };
 
 struct acpi_object_method {
-	ACPI_OBJECT_COMMON_HEADER u8 info_flags;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 info_flags;
 	u8 param_count;
 	u8 sync_level;
 	union acpi_operand_object *mutex;
@@ -178,33 +187,41 @@ struct acpi_object_method {
  */
 #define ACPI_COMMON_NOTIFY_INFO \
 	union acpi_operand_object       *notify_list[2];    /* Handlers for system/device notifies */\
-	union acpi_operand_object       *handler;	/* Handler for Address space */
+	union acpi_operand_object       *handler	/* Handler for Address space */
 
 /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
 
 struct acpi_object_notify_common {
-ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+};
 
 struct acpi_object_device {
-	ACPI_OBJECT_COMMON_HEADER
-	    ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_block;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+	struct acpi_gpe_block_info *gpe_block;
 };
 
 struct acpi_object_power_resource {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system_level;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+	u32 system_level;
 	u32 resource_order;
 };
 
 struct acpi_object_processor {
-	ACPI_OBJECT_COMMON_HEADER
+	ACPI_OBJECT_COMMON_HEADER;
 	    /* The next two fields take advantage of the 3-byte space before NOTIFY_INFO */
 	u8 proc_id;
 	u8 length;
-	ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
+	ACPI_COMMON_NOTIFY_INFO;
+	acpi_io_address address;
 };
 
 struct acpi_object_thermal_zone {
-ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+};
 
 /******************************************************************************
  *
@@ -226,17 +243,22 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
 	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_length;	/* For serial regions/fields */
+	u8                              access_length	/* For serial regions/fields */
 
 
 /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 
 struct acpi_object_field_common {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	union acpi_operand_object *region_obj;
+	/* Parent Operation Region object (REGION/BANK fields only) */
 };
 
 struct acpi_object_region_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_length;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	u16 resource_length;
 	union acpi_operand_object *region_obj;	/* Containing op_region object */
 	u8 *resource_buffer;	/* resource_template for serial regions/fields */
 	u16 pin_number_index;	/* Index relative to previous Connection/Template */
@@ -244,12 +266,15 @@ struct acpi_object_region_field {
 };
 
 struct acpi_object_bank_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Containing op_region object */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	union acpi_operand_object *region_obj;	/* Containing op_region object */
 	union acpi_operand_object *bank_obj;	/* bank_select Register object */
 };
 
 struct acpi_object_index_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
 	    /*
 	     * No "RegionObj" pointer needed since the Index and Data registers
 	     * are each field definitions unto themselves.
@@ -261,7 +286,9 @@ struct acpi_object_index_field {
 /* The buffer_field is different in that it is part of a Buffer, not an op_region */
 
 struct acpi_object_buffer_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_field;	/* Special case for objects created by create_field() */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	u8 is_create_field;	/* Special case for objects created by create_field() */
 	union acpi_operand_object *buffer_obj;	/* Containing Buffer object */
 };
 
@@ -272,7 +299,8 @@ struct acpi_object_buffer_field {
  *****************************************************************************/
 
 struct acpi_object_notify_handler {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;	/* Parent device */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *node;	/* Parent device */
 	u32 handler_type;	/* Type: Device/System/Both */
 	acpi_notify_handler handler;	/* Handler address */
 	void *context;
@@ -280,7 +308,8 @@ struct acpi_object_notify_handler {
 };
 
 struct acpi_object_addr_handler {
-	ACPI_OBJECT_COMMON_HEADER u8 space_id;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 space_id;
 	u8 handler_flags;
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
@@ -307,7 +336,8 @@ struct acpi_object_addr_handler {
  * The Reference.Class differentiates these types.
  */
 struct acpi_object_reference {
-	ACPI_OBJECT_COMMON_HEADER u8 class;	/* Reference Class */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 class;	/* Reference Class */
 	u8 target_type;		/* Used for Index Op */
 	u8 resolved;		/* Reference has been resolved to a value */
 	void *object;		/* name_op=>HANDLE to obj, index_op=>union acpi_operand_object */
@@ -340,7 +370,8 @@ typedef enum {
  * Currently: Region and field_unit types
  */
 struct acpi_object_extra {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
 	struct acpi_namespace_node *scope_node;
 	void *region_context;	/* Region-specific data */
 	u8 *aml_start;
@@ -350,14 +381,16 @@ struct acpi_object_extra {
 /* Additional data that can be attached to namespace nodes */
 
 struct acpi_object_data {
-	ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
+	ACPI_OBJECT_COMMON_HEADER;
+	acpi_object_handler handler;
 	void *pointer;
 };
 
 /* Structure used when objects are cached for reuse */
 
 struct acpi_object_cache_list {
-	ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;	/* Link for object cache and internal lists */
+	ACPI_OBJECT_COMMON_HEADER;
+	union acpi_operand_object *next;	/* Link for object cache and internal lists */
 };
 
 /******************************************************************************
-- 
2.34.1


