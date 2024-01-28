Return-Path: <linux-kernel+bounces-41970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B79E83FA23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520C71F2133A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8115644373;
	Sun, 28 Jan 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gqBmhocf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB903C6A3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477247; cv=none; b=oqKG7KuPRi3oCi6x+x9Ju/mlVgQZGEnyGLAHI/BJ6S8Dx1l6PKSEqn5JliTdLa06C+e+kuVretUDty2UPpeFh+kM1KZkuAUEsBV16hzm0bbU+jZ88OHZ8o94H9ondDH4R79z9ZmE4v9oKLvAW3vcAoPmLnrzYVETZethzruyhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477247; c=relaxed/simple;
	bh=Cdn7d+60o9Z2b5W5CTVwPHkjexWVeQnx20Mc20wdUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1aGBg2ADJEEA8rtWAPl5FqXAsQ+W3B4tTPn6ObSPHEsTuMd94zgZ3ze7DufA1vVQuQwI/ZUa4704Efj4EXJkJWCvePEotOYR8BjrgV3KYlpsfPxc46cgIjPd1t2XXPB1OvZdJ/+KUOYH3f5wOauVQfEhzSY0TrOipOoN5hDRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gqBmhocf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e800461baso36603815e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706477244; x=1707082044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOLVYYaf1UvrK+dMoL40KXaLx8e9ggkXqg3vK1jBmL4=;
        b=gqBmhocfEnOcHm+Ef3vW1SAh4wkufCryDVjYNuPsK82t3+MDKM6Z74wQQ3SZtZghwF
         GUPw7JFMY4sbFjO+qrCM215G2OVTQFpMoDai/AWOoM9HWmQIcUICNTo4pMVKKudx7E1a
         JgEWRctZEwY7Vg9QWlDZL2n9U1hKY4r58PQQpSSEUaRjdahNZTxO5vtK5UPRmI9j29ds
         zSgdgZgLvYdA9//ofkLIYBqI+mVRTlaS9rST/BteBBNC374cIW52eCAnvFog3WsQQtgF
         COAAVGeAVcO3sXCTBhrrpjWRyTfYQKD7fQelgmjVan+9MnSynw6frC4Cs6v4EV+eZiot
         hJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477244; x=1707082044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOLVYYaf1UvrK+dMoL40KXaLx8e9ggkXqg3vK1jBmL4=;
        b=ixN11dDiMVj/KisTIWEMHTeR6bPr+AOILTA9OjUOrqSwpxf9VoxaiM+vNN2Y8+kSRZ
         ltUC5m8B3gxtrNd7HwZ5g96jO2YV31wv6DoO2sWOqz+ymRpGVMAeePC7JlOqClMI2ztD
         PvVXJi9hfJ/DcGPk0hT3GIcaAw02ZJFEWQkc5hgZDScZv/cJlu1ADAG7v4IKDcheo/3M
         MxZq51i4vM51EIP+V5WnGdFjmZhrVf93DnRSNPA8TL+tMzebZeEHO8wCR+9VYh0YWfQ4
         4+D+D7jzjTpSR0VWVHXFc++vzb5RR94qjeFOhtNuaHhitIu0nCdWIFjkG/Ziqv7WdA7i
         GCSQ==
X-Gm-Message-State: AOJu0Yykmu1Fm1b1E6g9Pf2AbZJbm9JZUI4ZVziXdeHdORjOPqm9CDGI
	pavNnUYwH+DKOln4nbX2o2DnjRtPYEmSkyTUTAG8sRQ8/C95VUhE41eexyO8G3g+Kah9+APOOVp
	5
X-Google-Smtp-Source: AGHT+IHcccSLpqVa5Gax8fBJ+QP9ZYQIKEQzJv+EX6FX8D6Wnl0/1Io1Q3WQpGEhU1qry8Sut0xEhg==
X-Received: by 2002:a05:600c:458a:b0:40e:dbdf:9fb4 with SMTP id r10-20020a05600c458a00b0040edbdf9fb4mr2991157wmo.23.1706477244090;
        Sun, 28 Jan 2024 13:27:24 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d62f89381sm8218208wmo.35.2024.01.28.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:27:23 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	biao.lu@intel.com,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/4] tsm: Allow for extending and reading configured RTMRs
Date: Sun, 28 Jan 2024 22:25:23 +0100
Message-ID: <20240128212532.2754325-5-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240128212532.2754325-1-sameo@rivosinc.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
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
 Documentation/ABI/testing/configfs-tsm | 11 +++++
 drivers/virt/coco/Kconfig              |  1 +
 drivers/virt/coco/tsm.c                | 58 ++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index 5d20a872475e..dc5c68a49625 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -81,6 +81,17 @@ Description:
 		(RO) Indicates the minimum permissible value that can be written
 		to @privlevel.
 
+What:		/sys/kernel/config/tsm/rtmrs/$name/digest
+Date:		January, 2024
+KernelVersion:	v6.8
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) The value in this attribute is the Runtime Measurement
+		Register (RTMR) digest. Callers can extend this digest with
+		additional hashes by writing into it. Binary blobs written to
+		this attribute must be of the exact length used by the hash
+		algorithm for this RTMR.
+
 What:		/sys/kernel/config/tsm/rtmrs/$name/index
 Date:		January, 2024
 KernelVersion:	v6.8
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
index d03cf5173bc9..b4f8cf6ca149 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -551,6 +551,63 @@ static struct configfs_attribute *tsm_rtmr_attrs[] = {
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
@@ -564,6 +621,7 @@ static struct configfs_item_operations tsm_rtmr_item_ops = {
 
 const struct config_item_type tsm_rtmr_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = tsm_rtmr_bin_attrs,
 	.ct_attrs = tsm_rtmr_attrs,
 	.ct_item_ops = &tsm_rtmr_item_ops,
 };
-- 
2.42.0


