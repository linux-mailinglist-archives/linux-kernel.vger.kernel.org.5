Return-Path: <linux-kernel+bounces-57596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78984DB2A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EAE2877A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280B6A02C;
	Thu,  8 Feb 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPmeoT/1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C66A32C;
	Thu,  8 Feb 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380093; cv=none; b=idX3IcCjdrxrYGdOnYYVgrPOfi9qUq8K9LoZVW+VMDkLnPOtyExbrWdDlWUfWZne0TiMzbuedjQBp+lB6rEuhDakredMOetGVgE4fU3fkU1KdjExUb+YWUXnBjgA/lAE8fSzgVK1oPiupMuXuiC1c3adcrT0qHhopx1K/jc4h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380093; c=relaxed/simple;
	bh=jStK1E4B2H8Kp5WWPi/ZlguVHeg+cUTkm2pJCAqNY7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7FgQCuPUz80ffBM00pfvSmcncqd90+FbkO/mz/OjLYo6VrO9yvXcNnHo03obKF//C2HzTnnwRUNT6g3Wjwnjf6MYnXiVdvJmuKCdKBmARw3I3jFJd1ytHyQ/iY0fxgqJaeLQ08DU/JSdI1U3eIcqT+diVDrAiQIM/NhFSHFjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPmeoT/1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3884b1a441so161333566b.2;
        Thu, 08 Feb 2024 00:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707380090; x=1707984890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKUKf3BvCCQGdJPOJhG2nzrsLmyY/E+UafFVYZ5Q/bI=;
        b=jPmeoT/193JIANvYe7022SsCjQFmuHT2z/OdP0mLjdVKdF4oK21KQUYMCeRTehTHP9
         cCVYZP4WpSbDIbySPwQGP85Ue/Ei3Zf0jRsw4O7sjnO6aPUVcknowkdgH5tiky41Xn46
         c8zWyGfwzW/0JuN+v6qqJVqXU6ct1JQsGoa2dCDPyrnHr5uVGWsAVQ3VRIk3XqdUgIYY
         Gk46nPihTA4GbTVnWm7O15IVtfMYmmzZ1wJLO3j1sQr5iWiq9dCFbmCUuEgjZDjtU4bO
         PVYjdHvXamGR/2TjN46qYc86iTOswvKqEwm65NVcmGzrOAJ73fWQAVvIdEDr8/OCV3SY
         29XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380090; x=1707984890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKUKf3BvCCQGdJPOJhG2nzrsLmyY/E+UafFVYZ5Q/bI=;
        b=pbyy2w9WgigLHujaZ+fN/o2V3SKF/WMz7oK0UF3Zpf1m+LmcPGOMN+D0cwhgzWePSS
         xZcRb8g5NVay/NlgioPKz+Lffm/RbthWmk3yYHf67jUAsdOeD6lcSZ0KpGWm3mC1KMg6
         hiU3Rgrg60CFP6yP0RKqLHOGktFZvPSKv8utgu84x/Z+dy6YL6piuSVbo/af+1tKvzIl
         P5EpFjG5VZBvu50wpYo06CkUfO2eNgYDHkRjjypflui+x2kz9p//vzSNptJXRH9OjHsX
         KmmagDq3rq3Z0qnfwhx2oWQYS0BFsWfuRyXtCkiql5KqtBm3KyIITFLZCgTjlQHWkkJT
         wk1g==
X-Gm-Message-State: AOJu0Yw8REgw2EGyx/+lOj8neHnbG9uaHEi0hgNYvWwPMeJ24xz6hjqq
	HdGxdEi7/hUI7Ha6pyM1oQuJ3iJQwxwPXyb4AAENDEj4gsnSPZM1
X-Google-Smtp-Source: AGHT+IEJ2S/yteRZgInj+b959z6ndtyMadc40zq3ZF8cJmGkPO7Vi4jmi43dV5d+fPn/daLA7Qa6cQ==
X-Received: by 2002:a17:907:78c1:b0:a38:83b2:c955 with SMTP id kv1-20020a17090778c100b00a3883b2c955mr2604927ejc.30.1707380089523;
        Thu, 08 Feb 2024 00:14:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6pmCJMJknIOUI+rBAHI3up20E/S89sDCcHXY0H4o10JVxmV2vcSB/nzqnWgJVXg79ihX82bNAqvmO8i+Jv4t9YNpSGnJwy8+8AJ3vvGww17CC+Jt76F+g7IlHnKzStSpMTu2vcGYoIlF75BhR+66z4llbGqZ28l2PYSfrhMQ6vttDx/RYzfo26EIPqe3q2g9GqP4qTyOoEwqn0OeienriDm/InaJ5L4BILmIwH2CVb74hdjlBIR8/niByI4XUU31r0XmJvX65mwSnlyuO6wvAhsPGy+V6yEaZ/KVCPfCwe+97VHeMVpzlcQ1S6aCVEsvoZ9tkrKML6hEGOr4JXpksWc5gYUAcuTicHL3xqKbCX2bLieJV99ZLMeOqPT4gLkw6/VBrUp3HZ/kN3Xjy6M94W+jiO2S2
Received: from eichest-laptop.lan ([2a02:168:af72:0:7052:988d:a756:96a6])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709060b4300b00a381ca0e589sm1641383ejg.22.2024.02.08.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:14:49 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Leibovich <alexl@marvell.com>,
	Stefan Chulski <stefanc@marvell.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] arm64: dts: armada-ap807: update thermal compatible
Date: Thu,  8 Feb 2024 09:14:13 +0100
Message-Id: <20240208081413.7923-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Leibovich <alexl@marvell.com>

Use the correct thermal coefficients for the Armada AP807 dies.

Signed-off-by: Alex Leibovich <alexl@marvell.com>
Reviewed-by: Stefan Chulski <stefanc@marvell.com>
Tested-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
Changes in v2:
- Added me as last signed-off-by
- Besides that it is the third patch of this series:
https://lore.kernel.org/all/ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk/
- The first two patches in the series are already applied
---
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
index 4a23f65d475f..a3328d05fc94 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
@@ -33,3 +33,6 @@ &ap_sdhci0 {
 		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
 };
 
+&ap_thermal {
+	compatible = "marvell,armada-ap807-thermal";
+};
-- 
2.40.1


