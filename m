Return-Path: <linux-kernel+bounces-115051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D210F888D14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDBB2FB88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C331C2315;
	Mon, 25 Mar 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyU9Zl7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CD131BA4;
	Sun, 24 Mar 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323854; cv=none; b=ItNmB7fOLIxi21z6KfpdzgLM2XRlvzobB1dd8FwDvYWCUsU8SUei3fkgtm4j6wTanekJwdsQBSM9sBLUo6Nk5Twd9P5fI5qXuLuVh8fwHuXKVAKSjIMg1VEZmfZNgoarY/M07qLMFLcx3SknT5heLWUr0UlKFZ1lT9GW96noPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323854; c=relaxed/simple;
	bh=8GM9iolHN0LIvjEWlW1XLRXNO4rpaQwrac+AxJ6OrMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdYnaLk4hE7hpeOBiTqf/NqVFbU9DUminKR6QFA1Z/G4ncfkzoe4Yul8xpHcGQ9IhVd6rXxw2MiUwpUANiIydPakN9RU04HFcFJjhCgONOrq5dtwP51W2qp1Lb90HSOAzeVG64pzvUMvk9rnRlUT23QzHABNu+vACkIcBIAqmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyU9Zl7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1A7C43399;
	Sun, 24 Mar 2024 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323853;
	bh=8GM9iolHN0LIvjEWlW1XLRXNO4rpaQwrac+AxJ6OrMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyU9Zl7Azsm9xbrm0M1ZiItRHRwiM1/7lPtCbwzkn2rV+0RgLRrrylsx/KzLxy+H4
	 jqK7lhrxvevGZ+0hlKUq4B507K0oyC6oVswu9mfOyQw+NB0wCeow/MAh3euq5nHoBj
	 BrixVVQ+/L25lg2a/+3DdnN2/eaXd1e5oSkApvBgB/lQihhLNuqTgwCIFjgfd4BdtP
	 0ViRAs4boe3EsiRlR4RN/y/xrnZTNvDMtfskag6FKKAcbTGUK8nnk1CZFJj8htoWT2
	 NbPPoASyC2LEvp0fe8zve49QjhetJ0pmkhLP2ah+FPJmOcotMXh8NLlv42V8k/Uy01
	 yOnaPQ0CWKRtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 231/238] scsi: fc: Update formal FPIN descriptor definitions
Date: Sun, 24 Mar 2024 19:40:19 -0400
Message-ID: <20240324234027.1354210-232-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shyam Sundar <ssundar@marvell.com>

[ Upstream commit 874163aab75a6cd7422e71f1fbc6db12977fcf1d ]

Add Fabric Performance Impact Notification (FPIN) descriptor definitions
for the following FPINs:

 - Delivery Notification Descriptor

 - Peer Congestion Notification Descriptor

 - Congestion Notification Descriptor

Link: https://lore.kernel.org/r/20201021092715.22669-2-njavali@marvell.com
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Shyam Sundar <ssundar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 4a0e7f2decbf ("netfilter: nf_tables: do not compare internal table flags on updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/scsi/fc/fc_els.h | 114 +++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
index 8c704e510e398..91d4be9872203 100644
--- a/include/uapi/scsi/fc/fc_els.h
+++ b/include/uapi/scsi/fc/fc_els.h
@@ -916,7 +916,9 @@ enum fc_els_clid_ic {
 	ELS_CLID_IC_LIP =	8,	/* receiving LIP */
 };
 
-
+/*
+ * Link Integrity event types
+ */
 enum fc_fpin_li_event_types {
 	FPIN_LI_UNKNOWN =		0x0,
 	FPIN_LI_LINK_FAILURE =		0x1,
@@ -943,6 +945,54 @@ enum fc_fpin_li_event_types {
 	{ FPIN_LI_DEVICE_SPEC,		"Device Specific" },		\
 }
 
+/*
+ * Delivery event types
+ */
+enum fc_fpin_deli_event_types {
+	FPIN_DELI_UNKNOWN =		0x0,
+	FPIN_DELI_TIMEOUT =		0x1,
+	FPIN_DELI_UNABLE_TO_ROUTE =	0x2,
+	FPIN_DELI_DEVICE_SPEC =		0xF,
+};
+
+/*
+ * Initializer useful for decoding table.
+ * Please keep this in sync with the above definitions.
+ */
+#define FC_FPIN_DELI_EVT_TYPES_INIT {					\
+	{ FPIN_DELI_UNKNOWN,		"Unknown" },			\
+	{ FPIN_DELI_TIMEOUT,		"Timeout" },			\
+	{ FPIN_DELI_UNABLE_TO_ROUTE,	"Unable to Route" },		\
+	{ FPIN_DELI_DEVICE_SPEC,	"Device Specific" },		\
+}
+
+/*
+ * Congestion event types
+ */
+enum fc_fpin_congn_event_types {
+	FPIN_CONGN_CLEAR =		0x0,
+	FPIN_CONGN_LOST_CREDIT =	0x1,
+	FPIN_CONGN_CREDIT_STALL =	0x2,
+	FPIN_CONGN_OVERSUBSCRIPTION =	0x3,
+	FPIN_CONGN_DEVICE_SPEC =	0xF,
+};
+
+/*
+ * Initializer useful for decoding table.
+ * Please keep this in sync with the above definitions.
+ */
+#define FC_FPIN_CONGN_EVT_TYPES_INIT {					\
+	{ FPIN_CONGN_CLEAR,		"Clear" },			\
+	{ FPIN_CONGN_LOST_CREDIT,	"Lost Credit" },		\
+	{ FPIN_CONGN_CREDIT_STALL,	"Credit Stall" },		\
+	{ FPIN_CONGN_OVERSUBSCRIPTION,	"Oversubscription" },		\
+	{ FPIN_CONGN_DEVICE_SPEC,	"Device Specific" },		\
+}
+
+enum fc_fpin_congn_severity_types {
+	FPIN_CONGN_SEVERITY_WARNING =	0xF1,
+	FPIN_CONGN_SEVERITY_ERROR =	0xF7,
+};
 
 /*
  * Link Integrity Notification Descriptor
@@ -974,6 +1024,68 @@ struct fc_fn_li_desc {
 					 */
 };
 
+/*
+ * Delivery Notification Descriptor
+ */
+struct fc_fn_deli_desc {
+	__be32		desc_tag;	/* Descriptor Tag (0x00020002) */
+	__be32		desc_len;	/* Length of Descriptor (in bytes).
+					 * Size of descriptor excluding
+					 * desc_tag and desc_len fields.
+					 */
+	__be64		detecting_wwpn;	/* Port Name that detected event */
+	__be64		attached_wwpn;	/* Port Name of device attached to
+					 * detecting Port Name
+					 */
+	__be32		deli_reason_code;/* see enum fc_fpin_deli_event_types */
+};
+
+/*
+ * Peer Congestion Notification Descriptor
+ */
+struct fc_fn_peer_congn_desc {
+	__be32		desc_tag;	/* Descriptor Tag (0x00020003) */
+	__be32		desc_len;	/* Length of Descriptor (in bytes).
+					 * Size of descriptor excluding
+					 * desc_tag and desc_len fields.
+					 */
+	__be64		detecting_wwpn;	/* Port Name that detected event */
+	__be64		attached_wwpn;	/* Port Name of device attached to
+					 * detecting Port Name
+					 */
+	__be16		event_type;	/* see enum fc_fpin_congn_event_types */
+	__be16		event_modifier;	/* Implementation specific value
+					 * describing the event type
+					 */
+	__be32		event_period;	/* duration (ms) of the detected
+					 * congestion event
+					 */
+	__be32		pname_count;	/* number of portname_list elements */
+	__be64		pname_list[0];	/* list of N_Port_Names accessible
+					 * through the attached port
+					 */
+};
+
+/*
+ * Congestion Notification Descriptor
+ */
+struct fc_fn_congn_desc {
+	__be32		desc_tag;	/* Descriptor Tag (0x00020004) */
+	__be32		desc_len;	/* Length of Descriptor (in bytes).
+					 * Size of descriptor excluding
+					 * desc_tag and desc_len fields.
+					 */
+	__be16		event_type;	/* see enum fc_fpin_congn_event_types */
+	__be16		event_modifier;	/* Implementation specific value
+					 * describing the event type
+					 */
+	__be32		event_period;	/* duration (ms) of the detected
+					 * congestion event
+					 */
+	__u8		severity;	/* command */
+	__u8		resv[3];	/* reserved - must be zero */
+};
+
 /*
  * ELS_FPIN - Fabric Performance Impact Notification
  */
-- 
2.43.0


