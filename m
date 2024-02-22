Return-Path: <linux-kernel+bounces-77358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B486044D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C15282DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739273F05;
	Thu, 22 Feb 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kj3niGRs"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172A10A05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635896; cv=none; b=Y9NZjXjCcufen8gKtR/WSopab1ttwALrLSFDlDNdi2Dcw13CoK/eqnSLCCBf7CnjqzqVZqsyzdcpVYwLGfnLv64f9mnsFES1Igw5/AIP5rIhaQ2Vf+teNaH0fpoYMXNyAok44HMLVmA881hJ6K649L6lM7LS6sOcYYpagAWUIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635896; c=relaxed/simple;
	bh=ran8Je2iMoBhGTmTE0156DaLQN4qGsGHL9nwmBGcRnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rh/MbeqgiQCpiH0TOn2RgrJ222/Qz9fnha+WMFYUaaECEG61S1obSXDxLDHyLEVcCX5N/XYmU4aEAVSVA48zZuasggMWZCgwXtp3mPTykcKtM7kW+guOR7rrjjph4+9SdV4DFbK56IBYf0E/QgPGJLdW7ILxBzMBwkKV2xVAuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kj3niGRs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4128cfb6b6fso1490275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708635893; x=1709240693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOQLFsiqb5qCymG8P6e7uSuK+7t+6bDXL1THgZ9mI/w=;
        b=kj3niGRspx0IkX4hEi5tacLhVBW/Um2QFD8raxBUe6RPhJPG4EVfyqXCC9fYlP/oQF
         4kXS5E4Tffic91bZzDeavuuMYLgMIUBOtPVTVG6Y0/aqno6Gghock3YDqSYtM8lU36Ht
         ETkTJQKOyrpM+8G2BlItvQJ2Sen8n3EY5JJtSe99+KaFp2nkKMRSKI6qskMj3AIoICRq
         BKxRz75l9u80ULhVV1KurTMjMK9QkRXP9X7wHlO5+ROFj38pMDJCa53R7LscX3osYC4U
         xx6Av9E/U9njf8OGumgr+6wb9u72g1FVYkpjuKnt71acRHV8pXyZVq9X/m6Jmk+KgAvX
         CqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635893; x=1709240693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOQLFsiqb5qCymG8P6e7uSuK+7t+6bDXL1THgZ9mI/w=;
        b=Ieudb/qfWpAYdLjfi6UH0x+WYvv2YGY4UtNSrnIB26vB8iG35rYxauohKQuNb4Botd
         MAP4z8dhzFQRdqVd8PUtani32keziut2nMa5XndL/Vc3KIPkAScGNbLFr13hR/7Y17Xq
         UWFEbwFq/+q7SsAXfr2lxnTRut7sw2f1zrHcQLrf4GDX+7J2ja7eSGWnUEjeBrDs1DCv
         4kPyZ9XbNVKRxEgD4qET4iN4iJTcMnTwyY51kX5oUKdxjfEZyK23GhbGpSGjRgHTAyGa
         zx83Bens2c5NnWiPqC2TNs3O/k0+7txYv1PsJQY0wpRFaswFwl0dlDPYGDoZhhUQ8O90
         R0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXToqtu/u/AhSaQYy9QZsOUnHeUrA1cA0Nj43zjVVbeMtT2ap7vfbxRpwybPKwXGlmOMPJMEEqBNdlun8OZSeZ0P1b8nW1N2eJ/ouzG
X-Gm-Message-State: AOJu0YyRywgCUfv0nnMzwrMmebTm0yMuveyW4P/KGXKTAc8w7Dq+9AxI
	M8w5KVzg3LsrxjOwiEIHbPIjzvhJAGSPcMNS2u5tEkv+3R2DU6ugqQ2KSQIsuTg=
X-Google-Smtp-Source: AGHT+IGcEIy0aRkgnqgPKoNYu2q1ZmfqggYnA/rqAOy/ngPCFdYHUZXsRoDVfrh6yOEMsPHbIRNvYg==
X-Received: by 2002:a05:600c:4f11:b0:412:681a:1eaa with SMTP id l17-20020a05600c4f1100b00412681a1eaamr7886492wmq.26.1708635893035;
        Thu, 22 Feb 2024 13:04:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:465e:5c78:c1d5:890b])
        by smtp.gmail.com with ESMTPSA id jv15-20020a05600c570f00b004125f34fd7csm7328136wmb.31.2024.02.22.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:04:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] arm64: gitignore: ignore relacheck
Date: Thu, 22 Feb 2024 22:04:41 +0100
Message-Id: <20240222210441.33142-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the generated executable for relacheck to the list of ignored files.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/kernel/pi/.gitignore | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 arch/arm64/kernel/pi/.gitignore

diff --git a/arch/arm64/kernel/pi/.gitignore b/arch/arm64/kernel/pi/.gitignore
new file mode 100644
index 000000000000..efb29b663e85
--- /dev/null
+++ b/arch/arm64/kernel/pi/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+relacheck
-- 
2.40.1


