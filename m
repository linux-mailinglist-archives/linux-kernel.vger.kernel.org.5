Return-Path: <linux-kernel+bounces-64925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4B8544BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3381C20D78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894511CA9;
	Wed, 14 Feb 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4lhTf+M"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003112B61;
	Wed, 14 Feb 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901948; cv=none; b=T6rRHTl0oP/dmVHVnabVBd0Ybp6ucpdeMnVFyyCIaP0TE8XW4y33qgu2aC4Oi8Z13Hze+S25d35iClfQY4uYsP4ZGCru6YuQ8ec4Yu9MKgZQ+/JHbSxFlUCrU+semPHD/Z+Ym3H8yihEEijlAibnqd2AM7XvMo8M3sSd6eaM6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901948; c=relaxed/simple;
	bh=F9YHKt7vlCOx2x3TIANU6dgGdN4C9EWaFM6RKZfh7ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6mqVaRhB5MBOcsIFXXr7TmaveejPJAR1aadrLc60gKloQrQzXBwB7Ewbls6YtlLyCgCiIdx8CRjHR3C8CHnKPTvIYQVpLuQPOOzH4TOA5iRai/Cb6VfUzPlVPClFU6rrtvlsAJKl3lH+YP5Z6jFedoTCkUM31mzvkiTWm3m1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4lhTf+M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so2934845e9.0;
        Wed, 14 Feb 2024 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707901945; x=1708506745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I08sVNnQTI0Ia1/oQu2yuFjR+ZMqJnMvnSDXwosq+50=;
        b=b4lhTf+Mcf31xNYVW4LqvE8B9hpme7qVQD6dh+nkOdJz/gChP6CIJPrA0ehSmY3Xnx
         GLcxiqdr4o2qJFPXw16YcB86d9GOoUHutcLD7gXmcjP+txfvZB3dqtt09irCreGuxFee
         i8KQyV3iV3MudpkxB4B9zgfxeteApJHaBw3npFdKdyP7ht2deiMprIrt+HOFyW86uq7/
         sAfBCN2PFF9G0ugBzEeaGX8s+6afk5wVSI5XzB9RLaZLNlNTGd8hVW5c+CHoDFAend0P
         e5sTldbtIU1e26xCN8STJ1yEWEe/xK8FvDXHnJJaKB+3bPCDtIupC3Zt54lXA8EFXOB0
         ATwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901945; x=1708506745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I08sVNnQTI0Ia1/oQu2yuFjR+ZMqJnMvnSDXwosq+50=;
        b=r4Jhd8eC5NRU0wsEJ/X9F28w8282tpszEMVOCY+MWQYjGSi1P7LlyLQlW5rtvo5Gz9
         3vUZ6PVBkz0mUYvDxAH99FWNdahyTlNIVhjlYTdi3WGH23rm4f8pWgBJpcAmeqDyA4Fm
         LK+bD0EGLNCjExtUwTNuXZijt9kX71ixf7TdyaGJtAWvX04W6AqoqIXkFH7MV2A6WEbS
         A3EwqgJUXAmPV+Covya1UTH26xwuOW0Ye2OjV4rlog401wHWdiOX1cvxyGJB3B+zHXsC
         46kmdpsvrMCWvp3O+ROgPM4BAMzw2aiPETVZjgsNIWXN0uiV33MCSBvf2B93kl774h1v
         A5CA==
X-Forwarded-Encrypted: i=1; AJvYcCUwq1DOpSkAw9oYBqALsV8hAUYQ4lqgCj2nyUbdN0GScQAxvRVtYSeFduSI2BdQW9vQ4QLzp3RL+LowbmBa50yfKXkH0YBgCb1Fw8nddQKg6QetdvovXQdYZEEOMFU/Q4iHwoiQ5Gn6d/4M1JA1R+AHsR5kq7wGx7YpWGi4h1fbMeeYh20MRKDHR/o=
X-Gm-Message-State: AOJu0YwsNJ7LSl3Dq1zrT6yMtJ14J6Hw2/F/PgnkruhWH6gNHMZj7J30
	KdWto2r/Stp6wdGJqH6joqF/Q2Qrk6UH2UqMlgJVBxtNY4bPzBRk
X-Google-Smtp-Source: AGHT+IGc2a/pariFjVnhGDzMwNj8lX/FQ1kuJbdji4LsUJU9eT6elEttg6ZSO7TQO+OTN+tXcOmZaA==
X-Received: by 2002:a05:600c:358c:b0:411:e0cd:9916 with SMTP id p12-20020a05600c358c00b00411e0cd9916mr1178198wmq.0.1707901944923;
        Wed, 14 Feb 2024 01:12:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJo0+d5Hgk3kbtsdsvu6OvPT7Q9R80TRmclN2RqNc/5xCqSMHWcYYi3RONwWwETsUSPRP/ochVNhrCda++8M2A5Eja9eKDWIFdG4PrE3rDJfcoxSUfiAmtcps59X52MlRPCV0yLXnIQe4HXhJIfjX1OqDGUwRC34SbI/z2tYKHb+IYtx4DEd4I/8W2WT4asQs9/HJ8rK51JwmfqOKppG/Z1HrVpi+ElGBkBCFQaKqgJQcKeRjPUWR4tGNdacZl52PmzYSUzLVIUUpXTDCcTHC5sEHPnPRPydg/DdShqDCbBP+StfKJ56QLIHwwVnvyRSAWA7OxQoYb6Ly3PHwXoEUgRB8RQH42f4nSL9AbzL4UNY98n/A+KyTMJVwg7ZhA/KR12Q==
Received: from xeon.. ([188.163.112.53])
        by smtp.gmail.com with ESMTPSA id ay7-20020a5d6f07000000b0033cf053fa1esm738376wrb.106.2024.02.14.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:12:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/3] Tegra30: add support for LG tegra based phones
Date: Wed, 14 Feb 2024 11:11:58 +0200
Message-Id: <20240214091201.17636-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring up Tegra 3 based LG phones Optimus 4X HD and Optimus Vu based
on LG X3 board.

---
Changes from v3:
- set max77663 ldo0 to be always on since it is required by the SOC
- adjusted bluetooth module comment
- added enable gpio to dw9714 focuser

Changes from v2:
- switched from _ to - in node names

Changes from v1:
- switched from prefix lge to lg
---

Maxim Schwalm (1):
  dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880

Svyatoslav Ryhel (2):
  ARM: tegra: Add device-tree for LG Optimus Vu (P895)
  ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)

 .../devicetree/bindings/arm/tegra.yaml        |    8 +
 arch/arm/boot/dts/nvidia/Makefile             |    2 +
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts  |  489 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts  |  496 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi   | 1812 +++++++++++++++++
 5 files changed, 2807 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

-- 
2.40.1


