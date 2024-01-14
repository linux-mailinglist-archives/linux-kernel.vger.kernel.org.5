Return-Path: <linux-kernel+bounces-25549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E982D233
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB6C1C20A26
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04102C68D;
	Sun, 14 Jan 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mkwixnRG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D12C1A7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e779f0273so4070745e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705271825; x=1705876625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyCtxuiA2VvE4Fz+oM8sGxNPZlsi0nRvVQ196H2vya4=;
        b=mkwixnRGHLCyWrXlKaXGOjATqkepOzXWLoRQ5mTi7x6NwWSxAtdWPBZzfjO8MWeEvM
         wd0QMaxSovlCj/zR5P2pjdW/k7Ww2q2aOXpZhgGNVXY7LBsD58QAGf1kcWsuJBb96VqZ
         GTuCF7Vul6oMYs7Y5AXgM+JlgtSI8MGScOyise7u992UMXLdM+SXBPOqjZPH8N4VhFvf
         cBAI5Y00uyuV5uj6JTA9WUAOHu0klcAaK/hJVrq+l/FeVJTVr9EhG8HUhXuwuvUyG2bq
         L6bmetDvXVrHBmbWYGxvAqesXQUxlQ/beTlzBEJjI+5zB21MynON9tB5/s41yQUkx5yo
         sFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705271825; x=1705876625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyCtxuiA2VvE4Fz+oM8sGxNPZlsi0nRvVQ196H2vya4=;
        b=O4ZRW+RzPtp4WtSAwEVRNiZ3leao+yMIApbbkfG9IpXlN1EkaHvLHsifQToRc72Icd
         I1b2591ia5JA4PR7ndQmTWgy/v04VTQKUMEd1vx/8XPlvKjjwSVXetF0a88daDEnkmmX
         RrgfAPt1+FvdKo0qhccTtetGLWDck69HQpjAxeIQyB8p/gy3Uy87SZDnlVUc7om/jEw/
         K//FgJYRPBA6hsGPMYzED5I7Ry92+rT/wKEHqHcqWvapf5ugOnWuyJGfZX5aGZndYO3Z
         ai8l3XesfERpYQA5gPudhctWoE8lA4H/RyZlU5IVgUeor5MD5O/IEmlIYQGuuXo6ByVn
         E44w==
X-Gm-Message-State: AOJu0Yw1Ps+BGrA5MU+MZLl14+ClCbgBAcpfQfixpKK8u5WYsvW2xA7L
	wej57eYoBHO8oeprIKIn2HOpOwHckr9CnQ==
X-Google-Smtp-Source: AGHT+IHfTzhFsQAuTOZv9dzrzuL44Q0lc8K9g8JSdz4/vDiQzq/WmLjBnzhCltYKJKswjnc1I+p8Qw==
X-Received: by 2002:a1c:7503:0:b0:40e:657c:5c88 with SMTP id o3-20020a1c7503000000b0040e657c5c88mr2367018wmc.28.1705271825364;
        Sun, 14 Jan 2024 14:37:05 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0033719111458sm10158693wrt.36.2024.01.14.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 14:37:04 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/4] tsm: Runtime measurement register support
Date: Sun, 14 Jan 2024 23:35:27 +0100
Message-ID: <20240114223532.290550-2-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240114223532.290550-1-sameo@rivosinc.com>
References: <20240114223532.290550-1-sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some confidential computing architecture (Intel TDX, ARM-CCA, RISC-V
CoVE) provide the TVM (confidential computing guest) with a set of
runtime measurement registers (RTMR). TVMs can extend those registers
with their measurements at runtime, i.e. after the TVM initial
measurements are finalized and the TVM actually runs.

RTMRs are separated from the initial measurement registers set, and TSMs
typically includes RTMR values into a distinct section of their signed
attestion reports.

We add support for extending and reading a TSM runtime measurement
registers by extending the TSM ops structure with resp. an rtmr_extend()
and an rtmr_read() function pointers. TSM providers/backends will
implement those ops if they are capable of exposing RTMRs to their
TVMs. This capability is now described by a tsm_capabilites structure,
passed by the TSM provider to the TSM framework at registration time.

TVMs can configure, extend and read RTMRs from the configfs-tsm interface.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 drivers/virt/coco/tsm.c | 80 +++++++++++++++++++++++++++++++++++++++++
 include/linux/tsm.h     | 28 ++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..6b71650271fe 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/configfs.h>
+#include <linux/tpm.h>
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
@@ -50,6 +51,85 @@ enum tsm_data_select {
 	TSM_CERTS,
 };
 
+/**
+ * DOC: Trusted Security Module (TSM) Runtime Measurement Register (RTMR) Interface
+ *
+ * The TSM RTMR interface is a common ABI for allowing TVMs to extend
+ * and read measurement registers at runtime, i.e. after the TVM initial
+ * measurement is finalized. TSMs that support such capability will typically
+ * include all runtime measurement registers values into their signed
+ * attestation report, providing the TVM post-boot measurements to e.g. remote
+ * attestation services.
+ *
+ * A TVM uses the TSM RTMR configfs ABI to create all runtime measurement
+ * registers (RTMR) that it needs. Each created RTMR must be configured first
+ * before being readable and extensible. TVM configures an RTMR by setting its
+ * index and optionally by mapping it to one or more TCG PCR indexes.
+ *
+ * A TSM backend statically declares the number of RTMRs it supports and which
+ * hash algorithm must be used when extending them. This declaration is done
+ * through the tsm_capabilities structure, at TSM registration time (see
+ * tsm_register()).
+ */
+
+/**
+ * struct tsm_rtmr_state - tracks the state of a TSM RTMR.
+ * @index: The RTMR hardware index.
+ * @alg: The hash algorithm used for this RTMR.
+ * @digest: The RTMR cached digest value.
+ * @cached_digest: Is the RTMR cached digest valid or not.
+ * @cfg: The configfs item for this RTMR.
+ */
+struct tsm_rtmr_state {
+	u32 index;
+	enum hash_algo alg;
+	u8 digest[TSM_DIGEST_MAX];
+	bool cached_digest;
+	struct config_item cfg;
+};
+
+static bool is_rtmr_configured(struct tsm_rtmr_state *rtmr_state)
+{
+	return rtmr_state->index != U32_MAX;
+}
+
+/**
+ * struct tsm_rtmrs_state - tracks the state of all RTMRs for a TSM.
+ * @rtmrs: The array of all created RTMRs.
+ * @tcg_map: A mapping between TCG PCR and RTMRs, indexed by PCR indexes.
+ * Entry `i` on this map points to an RTMR that covers TCG PCR[i] for the TSM
+ * hash algorithm.
+ * @group: The configfs group for a TSM RTMRs.
+ */
+static struct tsm_rtmrs_state {
+	struct tsm_rtmr_state **rtmrs;
+	struct tsm_rtmr_state *tcg_map[TPM2_PLATFORM_PCR];
+	struct config_group *group;
+} *tsm_rtmrs;
+
+static int tsm_rtmr_read(struct tsm_provider *tsm, u32 idx,
+			 u8 *digest, size_t digest_size)
+{
+	if (tsm->ops && tsm->ops->rtmr_read)
+		return tsm->ops->rtmr_read(idx, digest, digest_size);
+
+	return -ENXIO;
+}
+
+static int tsm_rtmr_extend(struct tsm_provider *tsm, u32 idx,
+			   const u8 *digest, size_t digest_size)
+{
+	if (tsm->ops && tsm->ops->rtmr_extend)
+		return tsm->ops->rtmr_extend(idx, digest, digest_size);
+
+	return -ENXIO;
+}
+
+static struct tsm_rtmr_state *to_tsm_rtmr_state(struct config_item *cfg)
+{
+	return container_of(cfg, struct tsm_rtmr_state, cfg);
+}
+
 static struct tsm_report *to_tsm_report(struct config_item *cfg)
 {
 	struct tsm_report_state *state =
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..e912cd665684 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -2,11 +2,13 @@
 #ifndef __TSM_H
 #define __TSM_H
 
+#include <crypto/hash_info.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
+#define TSM_DIGEST_MAX SHA512_DIGEST_SIZE
 
 /*
  * Privilege level is a nested permission concept to allow confidential
@@ -42,12 +44,33 @@ struct tsm_report {
 	u8 *auxblob;
 };
 
+#define TSM_MAX_RTMR 32
+
+/**
+ * struct tsm_capabilities - Describes a TSM capabilities.
+ * @num_rtmrs: The number of Runtime Measurement Registers (RTMR) available from
+ * a TSM.
+ * @rtmr_hash_alg: The hash algorithm used to extend a runtime measurement
+ * register.
+ */
+struct tsm_capabilities {
+	size_t num_rtmrs;
+	enum hash_algo rtmr_hash_alg;
+};
+
 /**
  * struct tsm_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
+ * @capabilities: Describe the TSM capabilities, e.g. the number of available
+ *                runtime measurement registers (see `struct tsm_capabilities`).
  * @report_new: Populate @report with the report blob and auxblob
- * (optional), return 0 on successful population, or -errno otherwise
+ *              (optional), return 0 on successful population, or -errno
+ *              otherwise
+ * @rtmr_extend: Extend an RTMR with the provided digest.
+ *               Return 0 on successful extension, or -errno otherwise.
+ * @rtmr_read: Reads the value of an RTMR.
+ *             Return the number of bytes read or -errno for errors.
  *
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
@@ -55,7 +78,10 @@ struct tsm_report {
 struct tsm_ops {
 	const char *name;
 	const unsigned int privlevel_floor;
+	const struct tsm_capabilities capabilities;
 	int (*report_new)(struct tsm_report *report, void *data);
+	int (*rtmr_extend)(u32 idx, const u8 *digest, size_t digest_size);
+	ssize_t (*rtmr_read)(u32 idx, u8 *digest, size_t digest_size);
 };
 
 extern const struct config_item_type tsm_report_default_type;
-- 
2.42.0


