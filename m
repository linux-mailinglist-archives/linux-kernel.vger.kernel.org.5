Return-Path: <linux-kernel+bounces-85232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BC86B293
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749881C22743
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3C15A4B9;
	Wed, 28 Feb 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKZLS+W4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DE15B10F;
	Wed, 28 Feb 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132550; cv=none; b=pnJyQVqCZoWV5xe0lXLwrdSqxbu6m3mVixqjClIezcm8piwJPldWDhOkg31YfubFls4KRxhse0p/y3R+8BabHSCNzz+j8KdpX6aMbdhyfvfY0DbkuupPV+LfA1NwbdQdqRyqYS/BkcZmb9AWxiDakTMTs397S/K6vnF/dXTKc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132550; c=relaxed/simple;
	bh=LLoZpEXZrb4qyUzIaxkmCot88D7QEoKCy9xtugExuUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWV0swI+nNNLIJ6RW999UBsSNbtB4XMlmowCQsbfZWaJnS79vRr4dZtG1HD7325n2Q0nhDzCb9lricqjt1feOFXZ/lWy2+7RNYCFO71blJTiOUwiPItbHJLe0ex+rKvrr1gJRfKhLb3cd7F6UJeRbu+5PLw/PY795skbzhzwclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKZLS+W4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5675f2ca2so410413b3a.0;
        Wed, 28 Feb 2024 07:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709132548; x=1709737348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3VCmmq+4eba1jx1BqMgmbQQgplh1rf6OaXgPK/1tuIk=;
        b=NKZLS+W4Ohc3C8PgkUKpiDErLM2YCpo6iZ9BzqSTK5F3z3lsYwiciAQBwiGQL8jN7a
         R3m/BbGdLHxbWz3hyRfFB60lWFgYlapzgqJyIQD5aSJsLpJqLqWRCVFN19eMTJKce4DZ
         1NUFM5bwoUIzv4BTGNpIPA7GSexNhkd/nAjENWHdv8OAz9n+S0gEO0m9MPmTc42ptLZB
         YKHyVbvRzlhNhbBZt7MaAGBl1JXBlLGxywrGDqmqQH6ndq29hJ5MYK1EWuCutdnwwhds
         hnKLVTbjSBs7AqL/rP1oXOvdFxg2KxA/pqNxMVvZPA8efQB1sErrkBur6MUxVr+5p6IL
         2YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132548; x=1709737348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VCmmq+4eba1jx1BqMgmbQQgplh1rf6OaXgPK/1tuIk=;
        b=A2p2cAr885aNCR0B1Hbt4LxJusoHNgv/bv9mU8j10Qgz6ML+ypsBelIR2i68ThuiAA
         bto0ql6FzCjEtnz+qC8+2fnbUed+6QgG9Kt/iBN22JWTXAz6f40URj2BX5cqzfao5HrS
         AFh/nB8upRXzXfM0M/K9XUGJPdz73ryxbWP/G+ABN26n/lNEMM/YS/i8ztP5onX2rXj2
         DHPm7CRyEplvRYTNwkA7NCZFVRLz2Ojs2LUO+Rs2jNnccIydr8YFDZGg2AFDrPuBwqzG
         Ic/kKSykNJZyOf/ycyllJHlc7lVqRXQrvWLhVoR3yk9jz+5tBuUusQ+OzJkm9ZiUZaWd
         KpYg==
X-Forwarded-Encrypted: i=1; AJvYcCXGPFqjmU6LgRracguEMyAfPbs8oY7immjLB9pmk3dOGgY0DYc+KDbN+55ukowo5AvXjgCGFWvQHjvREcjQHXuNyjmk79axBF47sqjg
X-Gm-Message-State: AOJu0YxHsJ9XFIfxEhmxBjc2zv428ZPWE242Vtn2eQFCb0FZLuB+shLw
	hrwAPWTKOgsnd6+hCT49Won+GBJ+gOK1eSUoA4PgI/ite2tPCP6ViTTq+iGvM9w5Dw==
X-Google-Smtp-Source: AGHT+IHGKFPM11qIWDMaFIJA2bwG1vA4MS+XF5h1c2dKAXwKA32pFTvWuXUxR9dQ1E1iQSXrfA1vng==
X-Received: by 2002:a05:6a21:1394:b0:1a0:ebbd:9aeb with SMTP id oa20-20020a056a21139400b001a0ebbd9aebmr5964504pzb.5.1709132547845;
        Wed, 28 Feb 2024 07:02:27 -0800 (PST)
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:d1cb:3c04:cf19:22d9])
        by smtp.googlemail.com with ESMTPSA id o30-20020a63921e000000b005e49bf50ff9sm263602pgd.0.2024.02.28.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:02:27 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Add more ThinkPads with non-standard reg address for fan
Date: Thu, 29 Feb 2024 00:01:49 +0900
Message-Id: <20240228150149.4799-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more ThinkPads with non-standard register addresses to read fan values.

ThinkPads added are L13 Yoga Gen1, X13 Yoga Gen1, L380, L390, 11e Gen5 GL,
11e Gen5 GL-R, 11e Gen5 KL-Y.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5ecd9d33250d..23b2abe44a5a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8767,6 +8767,13 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
 	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
 	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
+	TPACPI_Q_LNV3('R', '0', 'R', TPACPI_FAN_NS),	/* L380 */
+	TPACPI_Q_LNV3('R', '1', '5', TPACPI_FAN_NS),	/* L13 Yoga Gen 1 */
+	TPACPI_Q_LNV3('R', '1', '0', TPACPI_FAN_NS),	/* L390 */
+	TPACPI_Q_LNV3('N', '2', 'L', TPACPI_FAN_NS),	/* X13 Yoga Gen 1 */
+	TPACPI_Q_LNV3('R', '0', 'T', TPACPI_FAN_NS),	/* 11e Gen5 GL */
+	TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),	/* 11e Gen5 GL-R */
+	TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),	/* 11e Gen5 KL-Y */
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 };
 
-- 
2.34.1


