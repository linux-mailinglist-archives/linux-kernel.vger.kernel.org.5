Return-Path: <linux-kernel+bounces-16252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516D823BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFB1C24CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E121864C;
	Thu,  4 Jan 2024 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fM6Iz2rW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395715485
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d420aaa2abso708675ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 21:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704344780; x=1704949580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H33gCbmiCN5gguVTQt+3mux0fwghJWfcdcsWeLLveeo=;
        b=fM6Iz2rWnlkCnJ2AAGjTgFN77xMNaEFKhTPkisoahrqnVBg6205GZP2A2i8Nv8B27b
         8RL3MPCDZGBwHzXdpGABKQp+EdZa59l9/b8y/YnElU+xRc9MLjCnuz0iMx+gxYog9zGP
         gvwKPvyOdxW4OjdBta2bknVLIv+MtQVVu7iVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704344780; x=1704949580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H33gCbmiCN5gguVTQt+3mux0fwghJWfcdcsWeLLveeo=;
        b=sbV/N7odmNreN1/uu8cP7OrJA25boo9YwMrsIb8ZS2RNsiLhzvJic2tcUvyv+MyMJ4
         bQM9jeEUziw2hT9foDZwJ0MX3F2941HxjIJPt+IOWeXaTxgy0ITO25BfMoOKYcJy+3a4
         nQoRpKmnrNpgwVd2ptP2LSyuUd0C4WlY4WeJ7sy5JmnjgEUSh8oGmRq1B7Yl83P75F9M
         yj4/fGo0oKo1D4c87v99t6tKoJFP2cncrMlJuSIQqFJas0vYFIpBQyj1f7bdOIXB5PYC
         wG6zsbsQsxU0+ocXedIXGLzDV54ed+1I5AFDcviZCGZUOBAPWWimTnOLN9/YeW4ysGd1
         f7/A==
X-Gm-Message-State: AOJu0YyZG/xKOfb13jJJez1Qgqfb/zT348UkCJmkYvmQg1cHShnL0XNj
	05Nid3TYJqSRuLAaCa49//u5gDs6kxcP44QAzWugHUj13LIVmwI45SZeYXVqQVAPg5GB+p3Tfa3
	AFobWIcdU4YRKZkjekqg8ya7X8VfuFt+NyRxFQXMDgdHVNmh8XAYSsQmGqXZ/OcO9s0LniGMuDP
	6ZTi+EHN4rAD/RTtFG
X-Google-Smtp-Source: AGHT+IHdQ3rBdCb3bg8w5TC+VxhXor7lM+9/LrhJpYUxzr9md3RdUBzLpNMys63LFfx/6KH3Cw146Q==
X-Received: by 2002:a17:903:1210:b0:1d4:4ae9:a23d with SMTP id l16-20020a170903121000b001d44ae9a23dmr55700plh.57.1704344779784;
        Wed, 03 Jan 2024 21:06:19 -0800 (PST)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm24505803plb.82.2024.01.03.21.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:06:19 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Raul Rangel <rrangel@chromium.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] input/vmmouse: Fix device name copies
Date: Thu,  4 Jan 2024 00:06:05 -0500
Message-Id: <20240104050605.1773158-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127204206.3593559-1-zack@kde.org>
References: <20231127204206.3593559-1-zack@kde.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
plus an extra string, extend it to 64.

Fixes gcc13 warnings:
drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
drivers/input/mouse/vmmouse.c:455:53: warning: ‘/input1’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |                                                     ^~~~~~~
drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  456 |                  psmouse->ps2dev.serio->phys);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

v2: Use the exact size for the vmmouse_data::phys

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 8b8be51b4fd3 ("Input: add vmmouse driver")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Raul Rangel <rrangel@chromium.org>
Cc: linux-input@vger.kernel.org
Cc: <stable@vger.kernel.org> # v4.1+
---
 drivers/input/mouse/vmmouse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index ea9eff7c8099..74131673e2f3 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -63,6 +63,8 @@
 #define VMMOUSE_VENDOR "VMware"
 #define VMMOUSE_NAME   "VMMouse"
 
+#define VMMOUSE_PHYS_NAME_POSTFIX_STR "/input1"
+
 /**
  * struct vmmouse_data - private data structure for the vmmouse driver
  *
@@ -72,7 +74,8 @@
  */
 struct vmmouse_data {
 	struct input_dev *abs_dev;
-	char phys[32];
+	char phys[sizeof_field(struct serio, phys) +
+		  strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
 	char dev_name[128];
 };
 
@@ -452,7 +455,8 @@ int vmmouse_init(struct psmouse *psmouse)
 	psmouse->private = priv;
 
 	/* Set up and register absolute device */
-	snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
+	snprintf(priv->phys, sizeof(priv->phys),
+		 "%s" VMMOUSE_PHYS_NAME_POSTFIX_STR,
 		 psmouse->ps2dev.serio->phys);
 
 	/* Mimic name setup for relative device in psmouse-base.c */
-- 
2.40.1


