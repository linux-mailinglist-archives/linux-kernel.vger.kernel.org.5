Return-Path: <linux-kernel+bounces-18631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59F826042
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EA4283E46
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B1848A;
	Sat,  6 Jan 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTW3Fo9K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BE79FE;
	Sat,  6 Jan 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so526429f8f.0;
        Sat, 06 Jan 2024 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704556062; x=1705160862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKMLLD2ZxyA0kUaU9sIopyxyu3bVgkbt2roLK+GW/Zc=;
        b=HTW3Fo9KieSGr41owv+U5S/YF3euDRVkKkrZO6I/7uUKRj7IE7Lxp7vdwzWhXoWS5H
         apj6FO9RzghVMarBiXplIuPMvuC23V785JBtgJIGf/2Shvrop2A8lSXCc7VggTs6Mvhs
         yuK4dsjHW0t7BoOjrtWbICwGZUB/ziiEr3VQ7mCtwa8imR7dJGqB3jk4A6M7DQkvA8Nf
         AKs4QlkxSCc/o4cOx8smSILwfcoxKMouG2JWkGzo2wseLwYcnz17B+2P2qIAANpMEcjR
         up32mgpggxvkjB8pGdAtiwMG+2qFJscnQOfM0h4ZS9cL2f4ywalLx3Cvu6Wln6+MKjBq
         Qg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704556062; x=1705160862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKMLLD2ZxyA0kUaU9sIopyxyu3bVgkbt2roLK+GW/Zc=;
        b=ezzs2y7NMDqqjw1RsMaQ6aGzCy1iWnayYi6t4/rB+/9LVMNumJwW5CKmxq+OGMw7mk
         Dxcz/88T+o2HrS8rhDBkxZjeli3Y4FRyNinlRBNtd6LXoUUXDDiUqf2AerQhWmoq/6Wi
         OJHjDINbt/Rn9ictm6E1DgPkPCNL7rIuxgcjC54a40AYtHAyg/hSU8abgOB78BwIg4M+
         njaEfuwwjcgLlAnCLEpLyDNUf7InYurOtpeIsWqY6Q3F3Ztjk+Knm+kz9zyyi4jOvw0/
         axvqvCNbCpcbttJGIVjkCEJMDtoJiSwLiXgk47WWm1IdoQYRdw+gpt425xSroM3WEMuo
         IpdA==
X-Gm-Message-State: AOJu0YwqnPbJYwMtGwfdJUeWWqalFjFV9OxGOHloWiR7bz9XfQ4lJl1x
	ZyzRO/8AJ1OWoLzmJ2m4nXk=
X-Google-Smtp-Source: AGHT+IGVlZUFr7ve40PWM95dSxWGeu3aAnifrfL2vCyVtUxia66Gh2Z9Rm5K/5YvquVm7HGYMfgF6Q==
X-Received: by 2002:a05:6000:1971:b0:336:873b:6b21 with SMTP id da17-20020a056000197100b00336873b6b21mr629967wrb.33.1704556061797;
        Sat, 06 Jan 2024 07:47:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j1-20020adfe501000000b0033686e8f02dsm3585831wrm.45.2024.01.06.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 07:47:41 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/x86: thinkpad_acpi: remove redundant assignment to variable i
Date: Sat,  6 Jan 2024 15:47:40 +0000
Message-Id: <20240106154740.55202-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable i is being initialized with the value 0 that is never
read, it is being re-assigned 0 again in a for-loop statement later
on. The initialization is redundant and can be removed.

The initialization of variable n can also be deferred after the
sanity check on pointer n and the declaration of all the int variables
can be combined as a final code clear-up.

Cleans up clang scan build warning:
warning: Value stored to 'i' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..7bf91cfd3e51 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6208,17 +6208,15 @@ static int thermal_get_sensor(int idx, s32 *value)
 
 static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 {
-	int res, i;
-	int n;
-
-	n = 8;
-	i = 0;
+	int res, i, n;
 
 	if (!s)
 		return -EINVAL;
 
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
+	else
+		n = 8;
 
 	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
-- 
2.39.2


