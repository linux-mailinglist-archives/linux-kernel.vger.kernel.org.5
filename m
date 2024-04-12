Return-Path: <linux-kernel+bounces-142931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FB8A3232
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994D5284788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107B1482F0;
	Fri, 12 Apr 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSaKeSH7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE33145B36
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935055; cv=none; b=ituj6lHSuleLzUoBneNKKLnH9wtSneaekM3TFV3BBchYv7z0yuZQr8iWlMLbQyy1GB7u159B2tFoqz4zsQzHh9Ik87pzIT1CE0Z+6wss0HXDdLAYCSCJUvQNiQVoqQO9Tx4ZlE3uDDUUmbMR9MW3eGT3iMduubLSjvn3YAyrUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935055; c=relaxed/simple;
	bh=qcMiL2ufsHXp7WFWbsB9/Gxuc3YOSuDXAu/2vPMjgG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EfL8dHLF8gmwOlEeEmp43tAkUbgc8Jfk6/2Lki3nxjjCyFhe8Enweinyo9b2+JnQTLoQPxkz9JGzC7Jrvu5xmCfAC0aKhK+qauya3OhmBvqNtiZQazBekpbuXX8yl+/BI2d10QHDyNY9mMFKrfaF/DnikxUi8FepjvlcffwTQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSaKeSH7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d32aba7eso301922f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935052; x=1713539852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVORJrtQBGCZetsXVvQsSiJEGSqOyrmNrkV1tAuNtSE=;
        b=iSaKeSH7sNcIAYy4nWS+EuXP8cszIXcbyw457FTuM40rzJ+BT70h2tBd0B2T3PZhn9
         +MSyWCa1qy42ZfcTGorVoTLj30k3grlyh3Eo+j2aem0c0aDp23JKC1xbIbAt3Jvq9xsA
         B9Mu9J4A3qNL12bJ6yt2Te2Oek3GbAVICj5h5UCV249uV2xEyFsBcY5dmfW1PLkj5Kx1
         r9z97nyp06XeXMeX6ZaJpMXBzLPmjXnN1PTpqnfNmb7sf91D7N1Pw+udZKufnMHjjcQl
         f/EeBIcxG+/cfCDAg4mLKT/x2T9HMrO+neU2m4HvAvMe7dFv/y/cV8m2Oo0L2IFrDZH1
         wqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935052; x=1713539852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVORJrtQBGCZetsXVvQsSiJEGSqOyrmNrkV1tAuNtSE=;
        b=A4YGygyn+dRUMJHJFL9DhX6Cjl14eHaRh8p4bRhTaR//bRbF7AzCbvXzTHkrT+Ancz
         h1esuOMeGusVedbCkdPMT0ow7ozAeniRVSHST21DKsjxIkKWGC/fevjsH1BfjBz0B/LO
         SYa6aW6swOCQkCsEDswRRsufHXpP1IsnfCOVEv/cYCpc/2psqbLtXTfsuA4ALHBOOSaK
         UOlbB7+w96rZ5f7NxMWCO9d3XIXEK8HrM/PwnKyItZniWDekROe/YjmOXHPG/m4I+Lhr
         TMH5eHZWulmZD6AJwLE9i8tYK+Wclf3bWIP8y9W3Mjff7ANMPN2SiNRATg9lZ9W9Z9D2
         nvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWqveV6oBayBBR9RPQ6LG2CbU+4C/CMjwQHgoZ+HSJpzWq0+qQTkZLRvXV0jWWxz1CDIcxYbE+ifwa44FLYX4a5vbtjAk+EJp5AQUxv
X-Gm-Message-State: AOJu0YxL89X5JMYRzb8FTAuG7U+7CGaafGm1Vzerg58hOYcAQASl+dQk
	B+Z3DKOOW1MYQd9FMMamAdxJfIyY7zWuiO2AVA3dH9sTWxk0YamxTCp1Fg==
X-Google-Smtp-Source: AGHT+IEv4YmJAi7c4JNV+frTjtshhbBZ/wuLesD2ZvAli872i2Xf2hKyjo7HlygcAY4V6H5bTvxStw==
X-Received: by 2002:adf:f308:0:b0:346:500f:9297 with SMTP id i8-20020adff308000000b00346500f9297mr1990455wro.2.1712935052186;
        Fri, 12 Apr 2024 08:17:32 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4cca000000b0034698307cf8sm4474332wrt.15.2024.04.12.08.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:17:31 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dca: make dca_class a static const structure
Date: Fri, 12 Apr 2024 16:17:26 +0100
Message-Id: <20240412151726.189030-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver core allows for struct class to be in read-only memory. Move
the dca_class structure to be declared at build time placing it into
read-only memory, instead of having to be dynamically allocated at boot
time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/dca/dca-sysfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index fcc83ede0909..b915c2b4601e 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -13,7 +13,9 @@
 #include <linux/gfp.h>
 #include <linux/export.h>
 
-static struct class *dca_class;
+static const struct class dca_class = {
+	.name = "dca",
+};
 static struct idr dca_idr;
 static spinlock_t dca_idr_lock;
 
@@ -22,14 +24,14 @@ int dca_sysfs_add_req(struct dca_provider *dca, struct device *dev, int slot)
 	struct device *cd;
 	static int req_count;
 
-	cd = device_create(dca_class, dca->cd, MKDEV(0, slot + 1), NULL,
+	cd = device_create(&dca_class, dca->cd, MKDEV(0, slot + 1), NULL,
 			   "requester%d", req_count++);
 	return PTR_ERR_OR_ZERO(cd);
 }
 
 void dca_sysfs_remove_req(struct dca_provider *dca, int slot)
 {
-	device_destroy(dca_class, MKDEV(0, slot + 1));
+	device_destroy(&dca_class, MKDEV(0, slot + 1));
 }
 
 int dca_sysfs_add_provider(struct dca_provider *dca, struct device *dev)
@@ -49,7 +51,7 @@ int dca_sysfs_add_provider(struct dca_provider *dca, struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	cd = device_create(dca_class, dev, MKDEV(0, 0), NULL, "dca%d", dca->id);
+	cd = device_create(&dca_class, dev, MKDEV(0, 0), NULL, "dca%d", dca->id);
 	if (IS_ERR(cd)) {
 		spin_lock(&dca_idr_lock);
 		idr_remove(&dca_idr, dca->id);
@@ -71,20 +73,22 @@ void dca_sysfs_remove_provider(struct dca_provider *dca)
 
 int __init dca_sysfs_init(void)
 {
+	int err;
+
 	idr_init(&dca_idr);
 	spin_lock_init(&dca_idr_lock);
 
-	dca_class = class_create("dca");
-	if (IS_ERR(dca_class)) {
+	err = class_register(&dca_class);
+	if (err) {
 		idr_destroy(&dca_idr);
-		return PTR_ERR(dca_class);
+		return err;
 	}
 	return 0;
 }
 
 void __exit dca_sysfs_exit(void)
 {
-	class_destroy(dca_class);
+	class_unregister(&dca_class);
 	idr_destroy(&dca_idr);
 }
 
-- 
2.34.1


