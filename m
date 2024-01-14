Return-Path: <linux-kernel+bounces-25550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20F82D234
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3371C209ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30182C6A4;
	Sun, 14 Jan 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TqQDoBBe"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3C2C1AE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so7621386f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705271826; x=1705876626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ygW96R3bKlZNzEyZDoQ1g52ofKNAtoK5Eb0X+uvffE=;
        b=TqQDoBBe8pRcfNV+XT7fPeFkJj+MAceGtC3qja1KFGZ+yOdaDAGg57kPQAKKskyBt8
         SJ5a7XU5dnEcF7sBFr8Jm/9m60TppOZX9n6dYEoPGoEJBWPjbe6D0YP5iCZrfU733S0M
         ObwFsztD9G3Q5UPWoYZge1ia3m0tQI1qT2GzxFUsg+0a/Dy1qwLwfItT+OLwS7eTILwG
         3mObtpNtNmsey0FG9y15KEGayXJMwrkiBlW90EcXZOJvPAnauRSHaHAL2kEVIqchioSp
         ZQ4VdU0541CsQfcyFzCUjC2Lh9Sb/YfVDIcbaJPLpRHbbPcv/2/D775c6BUYHfrfXC/7
         rtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705271826; x=1705876626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ygW96R3bKlZNzEyZDoQ1g52ofKNAtoK5Eb0X+uvffE=;
        b=epHi5xPqk2raSAHvCB1uT5yhoI2pqRjCdAsjeqA8C/q/7aXIYSeFntGpzvCkmXt9JI
         RkGEPoj9fmkwS0nFObQnoQ6MVF/oyep0fdZ6nyG+B62jxS/2Cro0tDTRRmah79ZGlq4l
         VGcnenhytMUpVXTMsHrYxyuJ4v7DvowUWm70dbyWdX6l3vQTYbWE0E4fi3/mLzT+B72q
         ZuRWPyYEB3gDlEysB6zxmy/ZVQ/eutPZYhe5cLEppStRP/7hcHgbkESv+jTzqRTqdiZb
         M0Vi2qXovLrkF9w7CoDebmz5QIRG3z2VCs98yKgq709jMYwtjmFCPjZB9SqMi8bq4DuA
         EUyQ==
X-Gm-Message-State: AOJu0YxHc8cZ1QIwBdbFzbIJxVxeiYHh+KUaBiaWJPxXSOW/6PdhFXcy
	OCYxjN+O0hxQYjCVi7phaGvp0syvKZiI4AaSV2muHmShja8=
X-Google-Smtp-Source: AGHT+IE0oyL57ccbGPEhVs5ZshLtT+WGinpXpMefY5nz2k2cFzEj90TP49y5wTJWdT274NqByTgTjg==
X-Received: by 2002:adf:e712:0:b0:337:eec:62e3 with SMTP id c18-20020adfe712000000b003370eec62e3mr1281529wrm.17.1705271826443;
        Sun, 14 Jan 2024 14:37:06 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0033719111458sm10158693wrt.36.2024.01.14.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 14:37:05 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/4] tsm: Add RTMRs to the configfs-tsm hierarchy
Date: Sun, 14 Jan 2024 23:35:28 +0100
Message-ID: <20240114223532.290550-3-sameo@rivosinc.com>
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

RTMRs are defined and managed by their corresponding TSM provider. As
such, they can be configured through the TSM configfs root.

An additional `rtmrs` directory is added by default under the `tsm` one,
where each supported RTMR can be configured:

mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index

An RTMR can not be extended nor read before its configured by assigning
it an index. It is the TSM backend responsibility and choice to map that
index to a hardware RTMR.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 drivers/virt/coco/tsm.c | 164 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 6b71650271fe..15b67d99fd54 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -419,6 +419,108 @@ static const struct config_item_type tsm_reports_type = {
 	.ct_group_ops = &tsm_report_group_ops,
 };
 
+static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
+				    const char *buf, size_t len)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	const struct tsm_ops *ops;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+
+	/* Index can only be configured once */
+	if (is_rtmr_configured(rtmr_state))
+		return -EBUSY;
+
+	/* Check that index stays within the TSM provided capabilities */
+	ops = provider.ops;
+	if (!ops)
+		return -ENOTTY;
+
+	if (val > ops->capabilities.num_rtmrs - 1)
+		return -EINVAL;
+
+	/* Check that this index is available */
+	if (tsm_rtmrs->rtmrs[val])
+		return -EINVAL;
+
+	rtmr_state->index = val;
+	rtmr_state->alg = ops->capabilities.rtmr_hash_alg;
+
+	tsm_rtmrs->rtmrs[val] = rtmr_state;
+
+	return len;
+}
+
+static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
+				   char *buf)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+
+	guard(rwsem_read)(&tsm_rwsem);
+
+	/* An RTMR is not available if it has not been configured */
+	if (!is_rtmr_configured(rtmr_state))
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%u\n", rtmr_state->index);
+}
+CONFIGFS_ATTR(tsm_rtmr_, index);
+
+static struct configfs_attribute *tsm_rtmr_attrs[] = {
+	&tsm_rtmr_attr_index,
+	NULL,
+};
+
+static void tsm_rtmr_item_release(struct config_item *cfg)
+{
+	struct tsm_rtmr_state *state = to_tsm_rtmr_state(cfg);
+
+	kfree(state);
+}
+
+static struct configfs_item_operations tsm_rtmr_item_ops = {
+	.release = tsm_rtmr_item_release,
+};
+
+const struct config_item_type tsm_rtmr_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = tsm_rtmr_attrs,
+	.ct_item_ops = &tsm_rtmr_item_ops,
+};
+
+static struct config_item *tsm_rtmrs_make_item(struct config_group *group,
+					       const char *name)
+{
+	struct tsm_rtmr_state *state;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!(provider.ops && (provider.ops->capabilities.num_rtmrs > 0)))
+		return ERR_PTR(-ENXIO);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+	state->index = U32_MAX;
+
+	config_item_init_type_name(&state->cfg, name, &tsm_rtmr_type);
+	return &state->cfg;
+}
+
+static struct configfs_group_operations tsm_rtmrs_group_ops = {
+	.make_item = tsm_rtmrs_make_item,
+};
+
+static const struct config_item_type tsm_rtmrs_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_group_ops = &tsm_rtmrs_group_ops,
+};
+
 static const struct config_item_type tsm_root_group_type = {
 	.ct_owner = THIS_MODULE,
 };
@@ -433,10 +535,48 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
+static int tsm_rtmr_register(const struct tsm_ops *ops)
+{
+	struct config_group *rtmrs_group;
+
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	if (!ops || !ops->capabilities.num_rtmrs)
+		return 0;
+
+	if (ops->capabilities.num_rtmrs > TSM_MAX_RTMR)
+		return -EINVAL;
+
+	tsm_rtmrs = kzalloc(sizeof(struct tsm_rtmrs_state), GFP_KERNEL);
+	if (!tsm_rtmrs)
+		return -ENOMEM;
+
+	tsm_rtmrs->rtmrs = kcalloc(ops->capabilities.num_rtmrs,
+				   sizeof(struct tsm_rtmr_state *),
+				   GFP_KERNEL);
+	if (!tsm_rtmrs->rtmrs) {
+		kfree(tsm_rtmrs);
+		return -ENOMEM;
+	}
+
+	rtmrs_group = configfs_register_default_group(&tsm_configfs.su_group, "rtmrs",
+						      &tsm_rtmrs_type);
+	if (IS_ERR(rtmrs_group)) {
+		kfree(tsm_rtmrs->rtmrs);
+		kfree(tsm_rtmrs);
+		return PTR_ERR(rtmrs_group);
+	}
+
+	tsm_rtmrs->group = rtmrs_group;
+
+	return 0;
+}
+
 int tsm_register(const struct tsm_ops *ops, void *priv,
 		 const struct config_item_type *type)
 {
 	const struct tsm_ops *conflict;
+	int rc;
 
 	if (!type)
 		type = &tsm_report_default_type;
@@ -450,6 +590,10 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 		return -EBUSY;
 	}
 
+	rc = tsm_rtmr_register(ops);
+	if (rc < 0)
+		return rc;
+
 	provider.ops = ops;
 	provider.data = priv;
 	provider.type = type;
@@ -457,11 +601,31 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
+static int tsm_rtmr_unregister(const struct tsm_ops *ops)
+{
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	if ((ops) && (ops->capabilities.num_rtmrs > 0)) {
+		configfs_unregister_default_group(tsm_rtmrs->group);
+		kfree(tsm_rtmrs->rtmrs);
+		kfree(tsm_rtmrs);
+	}
+
+	return 0;
+}
+
 int tsm_unregister(const struct tsm_ops *ops)
 {
+	int rc;
+
 	guard(rwsem_write)(&tsm_rwsem);
 	if (ops != provider.ops)
 		return -EBUSY;
+
+	rc = tsm_rtmr_unregister(ops);
+	if (rc < 0)
+		return rc;
+
 	provider.ops = NULL;
 	provider.data = NULL;
 	provider.type = NULL;
-- 
2.42.0


