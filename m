Return-Path: <linux-kernel+bounces-25552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8782D236
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E22817D6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB02C86B;
	Sun, 14 Jan 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zZ4jhtvz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947A2C697
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337984681bcso1917258f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705271828; x=1705876628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DErvdxXifc4ZYsfHy2kccc+/fn6lt3VcVEp4cbBEhRg=;
        b=zZ4jhtvzhNCKlkyxx8t8iRqGJ378iofJI+ASlsvf9Y3+M0EP6odj2/ksAV0FVWpwfn
         rjE8Gx3HFRdrKXL/GMazNzJbI/SA24316ow2G1l+Z9m+KyUksIhNO4yQhRm+PLxDNvNA
         0no8Co05G9qau8g/ASairON86N+q1zrJEQC8CL8IzM7wCq1gXGWzZCs0c+bIBrJeyB4m
         Bcd8XEmCK2oWnyJ8JuGor/7qQI/KbYzZ/0eBqyrQVaERf1ifPDZwLNpdAyb3oD05ULXN
         FxQOP7NolSFbhm+umZClZ4MRtQWXH3ybTSrOHVh8Lommzq/kLxQHcO0nL/AjHfo7kI1D
         ianA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705271828; x=1705876628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DErvdxXifc4ZYsfHy2kccc+/fn6lt3VcVEp4cbBEhRg=;
        b=bNgTiXtHPqu24A/GWGWXWAkik9tulyouBChE50BertBnUCugJ/UL6Lu6za0SF2bGg/
         qtJROoZ3xpz8TZc9PJEp8Hx1mmpm8g+DepZYz6yo/4l/GuEVaZ8enP4fI8jiU4D6EUyQ
         yeWZM3lUIygxzK+0WZMrw4SRCKcKh4Coqqie+2atObfMZQRMjwSpfLaS19Cscn2eP6tK
         i8LB8e6VUGrkEuQZ+NG3uAldiZ0CeTk8xhv++94Zru9HGq+iDIv0k+Ln2f72gz4UThTL
         8eSFxlFd+phCjpGNiVGJY78TSeahwIp2Z6APpyODvq7+ObNWgEG/pr9jrp6GU55tkNdA
         Sduw==
X-Gm-Message-State: AOJu0YwU4bq3LhBeF3e8F1wBSUwAXbgBrXZlcrDs6dnscVXQki+5YuDj
	AeArzPKqRR+Q0RI9hVRwXbkJObaUkZUrHlkMd60X1HidnWg=
X-Google-Smtp-Source: AGHT+IElqC0u3e6OTECDUSMUE2Ffq3st88V9s140J+yvbO3u3RIM/QG+b9JhU2BlLkP3CRbYGngjxg==
X-Received: by 2002:adf:fe89:0:b0:337:9343:2869 with SMTP id l9-20020adffe89000000b0033793432869mr1912838wrr.59.1705271828657;
        Sun, 14 Jan 2024 14:37:08 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0033719111458sm10158693wrt.36.2024.01.14.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 14:37:07 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] tsm: Allow for extending and reading configured RTMRs
Date: Sun, 14 Jan 2024 23:35:30 +0100
Message-ID: <20240114223532.290550-5-sameo@rivosinc.com>
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

The whole purpose of TSM supported RTMRs is for userspace to extend them
with runtime measurements and to read them back.

This can be done through a binary configfs attribute for each RTMR:

rtmr0=/sys/kernel/config/tsm/rtmrs/rtmr0
mkdir $rtmr0
echo 0 > $rtmr0/index
dd if=software_layer_digest > $rtmr0/digest
hexdump $rtmr0/digest

An RTMR digest can not be extended or read before the RTMR is configured
by assigning it an index.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 drivers/virt/coco/Kconfig |  1 +
 drivers/virt/coco/tsm.c   | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 87d142c1f932..5d924bae1ed8 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -5,6 +5,7 @@
 
 config TSM_REPORTS
 	select CONFIGFS_FS
+	select CRYPTO_HASH_INFO
 	tristate
 
 source "drivers/virt/coco/efi_secret/Kconfig"
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index f35f91cb7bd3..16fceed4bdb9 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -537,6 +537,63 @@ static struct configfs_attribute *tsm_rtmr_attrs[] = {
 	NULL,
 };
 
+static ssize_t tsm_rtmr_digest_read(struct config_item *cfg, void *buf,
+				    size_t count)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	int rc, digest_size = hash_digest_size[rtmr_state->alg];
+
+	/* configfs is asking for the digest size */
+	if (!buf)
+		return digest_size;
+
+	if (!is_rtmr_configured(rtmr_state))
+		return -ENXIO;
+
+	if (count > TSM_DIGEST_MAX || count < digest_size)
+		return -EINVAL;
+
+	/* Read from the cached digest */
+	if (rtmr_state->cached_digest) {
+		memcpy(buf, rtmr_state->digest, count);
+		return digest_size;
+	}
+
+	/* Slow path, this RTMR got extended */
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = tsm_rtmr_read(&provider, rtmr_state->index, buf, count);
+	if (rc < 0)
+		return rc;
+
+	/* Update the cached digest */
+	memcpy(rtmr_state->digest, buf, count);
+	rtmr_state->cached_digest = true;
+
+	return rc;
+}
+
+static ssize_t tsm_rtmr_digest_write(struct config_item *cfg,
+				     const void *buf, size_t count)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+
+	if (!is_rtmr_configured(rtmr_state))
+		return -ENXIO;
+
+	if (count > TSM_DIGEST_MAX || count < hash_digest_size[rtmr_state->alg])
+		return -EINVAL;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rtmr_state->cached_digest = false;
+	return tsm_rtmr_extend(&provider, rtmr_state->index, buf, count);
+}
+CONFIGFS_BIN_ATTR(tsm_rtmr_, digest, NULL, TSM_DIGEST_MAX);
+
+static struct configfs_bin_attribute *tsm_rtmr_bin_attrs[] = {
+	&tsm_rtmr_attr_digest,
+	NULL,
+};
+
 static void tsm_rtmr_item_release(struct config_item *cfg)
 {
 	struct tsm_rtmr_state *state = to_tsm_rtmr_state(cfg);
@@ -550,6 +607,7 @@ static struct configfs_item_operations tsm_rtmr_item_ops = {
 
 const struct config_item_type tsm_rtmr_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = tsm_rtmr_bin_attrs,
 	.ct_attrs = tsm_rtmr_attrs,
 	.ct_item_ops = &tsm_rtmr_item_ops,
 };
-- 
2.42.0


