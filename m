Return-Path: <linux-kernel+bounces-125695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D5B892AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D21F2235B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117A3A1CD;
	Sat, 30 Mar 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/P2MUSE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2136AFB;
	Sat, 30 Mar 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797881; cv=none; b=MvU7GFBXD1BozgoSiSSib6iSMJdGR+uuT//IaJ3ZHzX264QgXtGgSsu0pshE2RMEZg1FK4ARdgQ3g1GRhLO/imkVXeV5ZJbYtLRp3u6GhEOYV8q/4Tmz36hrM6Yc+Y0TTVaIu4+n78nfhMTdJKc05V/iLjpGnY+X6+sgoybqlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797881; c=relaxed/simple;
	bh=4M0cn1LIANsbQzZgwuwRdhQA0iuU5Uyoq/tCiz1Jl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds3b3PrF5rFpVbrqizOaqsq6Zp6385upDpclrr360SRVxtBJEaJ3A+sF4RYIfEror5xD/HDrhkymvH1WBn7sJm4p4sNe6tkcZvvni23QrXcytO8uTtZVx1bBXrZStYgPI78RcVfMvuYJ4CUFKQes5CZgTyGo8TAnpMvm/TX63Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/P2MUSE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415446af364so12782635e9.0;
        Sat, 30 Mar 2024 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797878; x=1712402678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkUnIQCMWeLmUQk2Dv7csyWsFi5xqg9xo2ZBjOEsXKE=;
        b=V/P2MUSEaSlJ1AWMnhc6DDLdRuXj5BVg9DmcNGgM8SjzNRSLHF5gVDw4DZCCAzg7Jv
         oeQ1WT8c58M4rwJvnGdaNukjM7+oi5qNzJ/WKDmrq7poTPGb9KulPynIo/KzK/6+9jgx
         G/7RD/gMcX8ffwfc9SUI1zec3alFkbx2nA5ucI8tbFvu+CIFCZ53euLj30NdC5k++dUh
         fLl2MxiXLWcVTmo1iJoBiM+CtYOgtjBx1NFzBeTRf0jmbZxHSpquawj0bO+0qLcomAyJ
         nShF/caF7ohZtGpTxEosavvFPSgtaVUGLWLW1f9TYm9+rTCDvCXsXZS6JEPh0m5FsJ2d
         Yb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797878; x=1712402678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkUnIQCMWeLmUQk2Dv7csyWsFi5xqg9xo2ZBjOEsXKE=;
        b=jK6ExZnMtgtJ7OqnepJlLfIj8a4xQCB0kRVDJvI5pZuCdENV2ZD6tNXY8wFvDATbIz
         yGPb3y9iHrpSfLvGsfRANcMnW89TeukwU3f9Giq5tuXfnSj7k8N6kEeznw5njZewjqbz
         RZ3z2uZ+vpuMpykWC7m76L8p9Q/FkiAV+5429L47C8GsIoSHa6V2up/0DGIIerj+ZGy5
         t5pfe6C2nnquB1s/D+h9yJQciHZgiv+yILHoRmpcnFwRPQhv45lJbesXjp0s4BW/F8Tj
         2I0dvDVPnGFM01jA8hU6HckKzcSaQn6R0Tkz+lgnd5Zqr4HeYTqGBfaw7Df6NDzZBGGm
         rw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEFn4ODqZPECv10QCjaKGn8ivr5qVfdRb96R//wapUmUIlJQC1yTPZ9y3BaqZoHhXaK0ILKZOzDkmZJSN71Icn0FLVXkPSs8+dFPxc9cicfua1tXFbi4pIZSKryj+FgJU1UPHnk+drmpPxI2+Je90hQEdwgmluKAQ8w8BTO0eyIVHLxTM+Or5NP+q8f7dA
X-Gm-Message-State: AOJu0YyB3OQjVzYl9BGTAM7mImaAMyhZM+wbGt73xTbCuWg/E8TRYHj6
	a3kDBewtSmmKYe2nFFOj2eVM2dm07jejlz91yc5TiSJRd1QEvptQ
X-Google-Smtp-Source: AGHT+IEttnNrIg9gDe7MSK3jlsdBvg6HUUXXHtJI2MgmKSpzaYVtUcUtw+haaE4rBUp6WQuPcOrtpg==
X-Received: by 2002:a05:6000:ca:b0:341:7295:4b8b with SMTP id q10-20020a05600000ca00b0034172954b8bmr6511502wrx.1.1711797878268;
        Sat, 30 Mar 2024 04:24:38 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b004146750314csm11441775wms.3.2024.03.30.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:24:37 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/3] platform/surface: aggregator_registry: Add support for thermal sensors on the Surface Pro 9
Date: Sat, 30 Mar 2024 12:24:02 +0100
Message-ID: <20240330112409.3402943-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330112409.3402943-1-luzmaximilian@gmail.com>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Surface Pro 9 has thermal sensors connected via the Surface
Aggregator Module. Add a device node to support those.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 035d6b4105cd6..c38203c00a705 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -74,6 +74,12 @@ static const struct software_node ssam_node_tmp_pprof = {
 	.parent = &ssam_node_root,
 };
 
+/* Thermal sensors. */
+static const struct software_node ssam_node_tmp_sensors = {
+	.name = "ssam:01:03:01:00:02",
+	.parent = &ssam_node_root,
+};
+
 /* Fan speed function. */
 static const struct software_node ssam_node_fan_speed = {
 	.name = "ssam:01:05:01:01:01",
@@ -311,6 +317,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_tmp_sensors,
 	&ssam_node_fan_speed,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
-- 
2.44.0


