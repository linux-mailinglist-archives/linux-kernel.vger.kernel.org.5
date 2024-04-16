Return-Path: <linux-kernel+bounces-147368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B28A7302
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4424F284335
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABB135A59;
	Tue, 16 Apr 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1FdLamt"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F421134425;
	Tue, 16 Apr 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291679; cv=none; b=af5FyrUxs6+gWmVVk8X+yqNVEjy9cs9m0DvFxlU8XWbuZ5Yw/llxMF+afFOR17A1ltXjJNjayTaURJhuvcPS5rTwu+215nlOKd4W/pTIYhr4POjRoAaMaoODxdCC7GuFnD+QGRqHof8qwPjkkF3M0zPBtE0HbkREeVqNTe+oJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291679; c=relaxed/simple;
	bh=QcSDkA7ChgbUxoe7C0ogFHzjt1ZYJqaTtA3uVv9HgDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjH5AxQDH338ZzkQnBARp54jG7nuQaW8HBAV08H7t5iYs3//KqfSyRra6eKZ3KeCgQdsv9Fl2zGq7bYC+wsGOrQp8s1RUUTHADkyEft17D+4kP5SsXv+6R0jMjO5Sme9m0c8CQmN+YFwN1X5EL2vOh5/VApy1wHRzhOPHfYqm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1FdLamt; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa241232faso4225878eaf.0;
        Tue, 16 Apr 2024 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291677; x=1713896477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+S1+Bvs+KfmTiGOO6QBvwuAsVbMXrzU7cCY/wMWBHI=;
        b=E1FdLamtkWDqFgCoecHfCQ/NtXsBa/bNXU9Lcj4dWJSlnVIeWuVEzmgFp/6DdBZZ6h
         eFaBDVbY7za3WEdAEvp7CM2bK7s6yeM32F+WPIKGtMvN1i8I7qZmVF52H9Y1tQ5AigY2
         VtPD8sr2UA7HAosr9835Ew1aW6bSC5Fq7eLX40v0KczoJqWUQYqHKcKydtoqp84se0I5
         yOL+dz8Bl/AyxbOQIs1KTkR9Bhd0Xr3mte+uS71ExOHx+xuBBxr2xPwPN1ZkE036Jh0N
         bOjZUDSKC6Ql2CAkJO9px7pm2So28i7TFdP4W5fZWnelb7NBeeEtIp8pZEGbnMdvulOl
         c/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291677; x=1713896477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+S1+Bvs+KfmTiGOO6QBvwuAsVbMXrzU7cCY/wMWBHI=;
        b=CgJpel28ZgM1Xv1hOiUQdUGTGYM7aUr3/Gux1PUYVY702oVRaJoitYVNhkUeLMtEtq
         h4698YkZSC9ebQCULoaTjqmS9ntUpPJBk4/5eNON2EoSYhZRZbxwy1anlCI56v8+akkg
         GQnY45RaBEBSO7e5g2WEF4sDycU3pP6V3fsvgnLU9eaa5SBRPHUn+rSGqq+x2DA5Pq9B
         G8euKdL1R43KtawAktUPvlsa8AZeF5FqYTgb99dWZ5Z2SCfDQl6gBKl6d6MC65A4NWJ4
         BW9uiYFWvmM4l+8uYDg76ewEHFbt1ZuMwiH6wONoxrC/+dvZwu1hFBi13rrXPlAM6bTS
         XNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPhrMk++jicyACTbBAVlb0ouRR/yUlnYIn64uQhcbl1SJQ2YZ7+bVAPH1X0WTKWryrtAYSetlQ91vZ/28i5Wtwep+piFJ2ClSvwuhjkuUdGQYHcnC16Ms/aFwjmc9y7JYCzXm1CZvc7zy6aKiw6xc8rQ==
X-Gm-Message-State: AOJu0Yw36U5oZXqQNpD7LVxNgIrRMio+qlZg2n1V/OPR0pPDoHh49dfH
	raGWG/M/V5VmlfGkSnUJuWNEnNDive/LfO8UY6ktNi0EMAYdTLOV
X-Google-Smtp-Source: AGHT+IHar1Qp9jShy2P0mDMiQ6n+8tgVpCQrzeQfVJMhr4LLfzl2ihWdiFWwBmqm/CP1Zcm2+OXN9Q==
X-Received: by 2002:a05:6870:5486:b0:22e:bace:ed96 with SMTP id f6-20020a056870548600b0022ebaceed96mr16339280oan.15.1713291677399;
        Tue, 16 Apr 2024 11:21:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830151400b006eb77e42ff5sm1289155otp.26.2024.04.16.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:21:17 -0700 (PDT)
From: Mario Limonciello <superm1@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	platform-driver-x86@vger.kernel.org (open list:AMD HSMP DRIVER),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on non-server hardware
Date: Tue, 16 Apr 2024 13:20:57 -0500
Message-ID: <20240416182057.8230-1-superm1@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If the HSMP driver is compiled into the kernel or a module manually loaded
on client hardware it can cause problems with the functionality of the PMC
module since it probes a mailbox with a different definition on servers.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * use pm preferred profile instead
---
 drivers/platform/x86/amd/hsmp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 1927be901108..102a49c3e945 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -907,6 +907,17 @@ static int hsmp_plat_dev_register(void)
 	return ret;
 }
 
+static bool hsmp_supported_profile(void)
+{
+	switch (acpi_gbl_FADT.preferred_profile) {
+	case PM_ENTERPRISE_SERVER:
+	case PM_SOHO_SERVER:
+	case PM_PERFORMANCE_SERVER:
+		return true;
+	}
+	return false;
+}
+
 static int __init hsmp_plt_init(void)
 {
 	int ret = -ENODEV;
@@ -917,6 +928,11 @@ static int __init hsmp_plt_init(void)
 		return ret;
 	}
 
+	if (!hsmp_supported_profile()) {
+		pr_err("HSMP is only supported on servers");
+		return ret;
+	}
+
 	/*
 	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
-- 
2.43.0


