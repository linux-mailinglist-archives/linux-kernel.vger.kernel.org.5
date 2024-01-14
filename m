Return-Path: <linux-kernel+bounces-25551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAAD82D235
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17B91C20A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B12C854;
	Sun, 14 Jan 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="J8+lkapW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197E2C682
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3367632ce7bso5695599f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705271827; x=1705876627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlF8fFJ5lqdqj/4fKpFf4I4E1M06YT+qzoTwfOt/slo=;
        b=J8+lkapWekTAcxtfCxtP6RM4Z8kiqfJTUngq37Lq6x65t/ST+LSTl8ej63ZKxqXG+w
         66KbRZqEWy9VqRUWvOYGa8emEa7N4tXqGhiEI/6B3qeADBBD8XO3M7W/TjRNv1uLMLUC
         iyzvXq7NPxIDkQwPZzHlu87KT2yqWrmmDisW0j2PWytDe1qn/FANWeUGo3HXUTDb1pMv
         DUgIr9zSQv66zmO2n8pn1dqoj72ZSqePSPz40CjN908C5b204f3SYhgwvxWDjzU8/8ZN
         0e9X7G8rCLgvR11omgtFHg6wL4OUC421jeeMjUQY5LMq03vCfVr5smYTVhZIHu/RZDqo
         +T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705271827; x=1705876627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlF8fFJ5lqdqj/4fKpFf4I4E1M06YT+qzoTwfOt/slo=;
        b=cGVUN5k7rW3hUA7169KYzc4t2Gzwjr9B1hqnR8OnV4f5coB7T96TdjgHogQS5KyXIR
         U/hFsnD3A1bwjIr0M6Iu2rlLCdkVw4YrPF9XEg8w3AUj78PmXH5Pgml+RBE4QE3MwUu7
         72lYArlG64FWpdqm9i8kjpwlIamj63omGZH+7p+KjSPvhOgNIq6BRQPuiFeJhizfwoXT
         9ARVh5A8d5PuwEujTemFPok4zwNw6vLRu7xGOaBLRRkUvQ13jSIFrkwgSDo31CBSB1MP
         9bCLvKvDu6N75tCLExsw+DQirvc8kbzHKPYEw6Lpnxtv5hhdFZpDbcJ3Owyn0kI9+3SR
         0gug==
X-Gm-Message-State: AOJu0Yz09s5aj8vsAaHvnPlnWFw3Q9V+7qOC9jUbDYnKdGiCJZAsHW2p
	N+fA78rOnjemYYOHCDBb2o7X13oheEO34A==
X-Google-Smtp-Source: AGHT+IG6q/j3g70xPA0ltpPIjT37LiZgSoTOxgq1MM+6wUv4JccEORQFTrOruEYEtorh5HqtpwVbbw==
X-Received: by 2002:adf:a18b:0:b0:337:5588:801f with SMTP id u11-20020adfa18b000000b003375588801fmr2716111wru.57.1705271827555;
        Sun, 14 Jan 2024 14:37:07 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0033719111458sm10158693wrt.36.2024.01.14.14.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 14:37:06 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Date: Sun, 14 Jan 2024 23:35:29 +0100
Message-ID: <20240114223532.290550-4-sameo@rivosinc.com>
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

Many user space and internal kernel subsystems (e.g. the Linux IMA)
expect a Root of Trust for Storage (RTS) that allows for extending
and reading measurement registers that are compatible with the TCG TPM
PCRs layout, e.g. a TPM. In order to allow those components to
alternatively use a platform TSM as their RTS, a TVM could map the
available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
to RTMR mappings give the kernel TSM layer all the necessary information
to be a RTS for e.g. the Linux IMA or any other components that expects
a TCG compliant TPM PCRs layout.

TPM PCR mappings are configured through configfs:

// Create and configure 2 RTMRs
mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index

// Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map

// Map RTMR 1 to PCRs 16, 17 and 18
echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 drivers/virt/coco/tsm.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 15b67d99fd54..f35f91cb7bd3 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -472,8 +472,68 @@ static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
 }
 CONFIGFS_ATTR(tsm_rtmr_, index);
 
+static ssize_t tsm_rtmr_tcg_map_store(struct config_item *cfg,
+				      const char *buf, size_t len)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	int i, pcrs[TPM2_PLATFORM_PCR + 1];
+
+	get_options(buf, ARRAY_SIZE(pcrs), pcrs);
+
+	if (pcrs[0] > TPM2_PLATFORM_PCR - 1)
+		return -EINVAL;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	/* Check that the PCR list is valid  */
+	for (i = 0; i < pcrs[0]; i++) {
+		/* It must be a valid TPM2 PCR number */
+		if (pcrs[i] > TPM2_PLATFORM_PCR - 1)
+			return -EINVAL;
+
+		/* If another RTMR maps to this PCR, the list is discarded */
+		if (tsm_rtmrs->tcg_map[pcrs[i + 1]] &&
+		    tsm_rtmrs->tcg_map[pcrs[i + 1]] != rtmr_state)
+			return -EBUSY;
+	}
+
+	for (i = 0; i < pcrs[0]; i++)
+		tsm_rtmrs->tcg_map[pcrs[i + 1]] = rtmr_state;
+
+	return len;
+}
+
+static ssize_t tsm_rtmr_tcg_map_show(struct config_item *cfg,
+				     char *buf)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	unsigned int nr_pcrs = ARRAY_SIZE(tsm_rtmrs->tcg_map), i;
+	unsigned long *pcr_mask;
+	ssize_t len;
+
+	/* Build a bitmap mask of all PCRs that this RTMR covers */
+	pcr_mask = bitmap_zalloc(nr_pcrs, GFP_KERNEL);
+	if (!pcr_mask)
+		return -ENOMEM;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	for (i = 0; i < nr_pcrs; i++) {
+		if (tsm_rtmrs->tcg_map[i] != rtmr_state)
+			continue;
+
+		__set_bit(i, pcr_mask);
+	}
+
+	len = bitmap_print_list_to_buf(buf, pcr_mask, nr_pcrs, 0,
+				       nr_pcrs * 3 /* 2 ASCII digits and one comma */);
+	bitmap_free(pcr_mask);
+
+	return len;
+}
+CONFIGFS_ATTR(tsm_rtmr_, tcg_map);
+
 static struct configfs_attribute *tsm_rtmr_attrs[] = {
 	&tsm_rtmr_attr_index,
+	&tsm_rtmr_attr_tcg_map,
 	NULL,
 };
 
-- 
2.42.0


