Return-Path: <linux-kernel+bounces-155125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CC8AE594
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01971F21D91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541B6CDCC;
	Tue, 23 Apr 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcFHVBNE"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76B84A57;
	Tue, 23 Apr 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874005; cv=none; b=BISDdx28QB2sjc0ueoPD3JI1HrvZs1YlCmzXB/Nr1+GbG7yZVh1uvhnnTnolfCBahcLefcgn8Jc6T1IfcLaeG0jBynCz0nOJpajdqobcNc24mguquW75MwXEEvwo9X1wRHpAe8Z8vqdUufhMc0BDGSJ/7mpjbyMUz43ux1ezF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874005; c=relaxed/simple;
	bh=ajZC6cEvHYNvJ8SO6tgTd6bVKe1SKBDBkNwECnqvnsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSKhgIKmQJ6b4IQE7cqsqOa94h4tprgbm7b/ALRzZxUF3GgZhNRF+XqBqSuTv/o3iZ3fZpYUWQVg0DyoqIC89oASkzGYXUufHxSGwYae1Rb2yiUK6Qow2ERf5KO8GTNq/n72VMDEnn/Uc0JFem97TOBqQPPOvQ4Yi73b9qWpRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcFHVBNE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ece8991654so5264597b3a.3;
        Tue, 23 Apr 2024 05:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713874003; x=1714478803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePJTfpMJV0l5uaVpMu2YHr5onOMWSJ3SSOtuwyaujt4=;
        b=AcFHVBNEiJgrMvCo7KDVOTodC8j2d2mbo56pwsAXYj6uwqbgD6w0fAZ7Bj6scfllF2
         NUScMyCiRJAP+ShGKs0UkDFJ+vHzizdtHOLZs98cV5qHdZgGUMi53hzfAWBTzd5H5igw
         mFqmQwaVXZjN6oixWJ3Bm9xjcosFAFg4j7D3tNCHtTgYkLPeET4/+ZZ/YIsVClZu31U1
         MfjsWaJ+zaU8wvlLhLkIF/C5mFpnlL2JMvWpc7IYAcHBgUsHrZV+OPRT6Qtmy3OEToUq
         +PkzOoPN/xAdWmq6vKO21myONjqSusdXqjrgv61uB9aoiQZ9faConT+r8ZNR2QlIXodD
         8UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874003; x=1714478803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePJTfpMJV0l5uaVpMu2YHr5onOMWSJ3SSOtuwyaujt4=;
        b=tH/SXsiKg5vBfAz52zebLVL1aC1CFZGgol3vJGHiSvdqGmB9XQ0Mxey6v04OGsJm+c
         vz4/zF5VwVb2gl7ztrgDyX0TGyyVAGgFxv98q5nF9VXpnEUEj6ASmhDMvUyHLfboItF6
         hCH70qdGJuOBSpt68fl0v0QkUvaSWlXyB/BqtL09Bt0A6JxyIP/0Zh6iCBhmK0Vg4/Kz
         RcuOmmI+MkwV+XRC2a9C1qbQBgCKDdfhebY2ON3J0Cyair8H9Myjjzy51GDxhCT4zLK0
         9s4+SSlUdVtv+ePM7cIRnQ5TPXi7J7v50MHV6SgvBvLEM7AhS1JfDH4LrXQ6UV9Z7I3+
         0hzg==
X-Forwarded-Encrypted: i=1; AJvYcCWwSn6ee0mj/GE3qk/VzxmIZ5CD8oyzbjMDJ+DeSXvSTrpcVS/EYBMtudqIOAUaUveRVa9s22KGEAvSdK2IEp8DEt9wpO83Kgbd3Y7IbQHPRJN413leYgYhWXjfY4YNCJ6hu+HiP/jgel9cldM9zlipJjNoMcfdpszDhJGD0TdM5df8h2Kv
X-Gm-Message-State: AOJu0YzQS4FEZ5baq12LmAaNw76PGbKIPWDZ0VK+od2Wc9QJh3Nt036Z
	vXUCtsiG6AtudOt6rc6lr9CYZnTccyl9pkIcuhltFFaWXCgLQnaO
X-Google-Smtp-Source: AGHT+IFqX2rRYiMJDG9zp/0IvP4eq4wPkxF7OSgheRQRi9yiI56t756YFxNQtWrwlHJAIJhXUetBbQ==
X-Received: by 2002:a05:6a20:1054:b0:1a7:4f8b:6439 with SMTP id gt20-20020a056a20105400b001a74f8b6439mr16348930pzc.34.1713874003535;
        Tue, 23 Apr 2024 05:06:43 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id u11-20020aa7838b000000b006ea97dc8740sm9454786pfm.78.2024.04.23.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:06:42 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: tegra20-ac97: replace deprecated gpio suffix
Date: Tue, 23 Apr 2024 17:36:29 +0530
Message-ID: <20240423120630.16974-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "gpio" suffix with "gpios" for tegra20-ac97 dts as gpio
suffix is deprecated.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi b/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
index 8c1d5c9fa483..2ff7be8f1382 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
@@ -445,9 +445,9 @@ lvp0 {
 
 	tegra_ac97: ac97@70002000 {
 		status = "okay";
-		nvidia,codec-reset-gpio =
+		nvidia,codec-reset-gpios =
 			<&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
-		nvidia,codec-sync-gpio =
+		nvidia,codec-sync-gpios =
 			<&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 	};
 
-- 
2.44.0


