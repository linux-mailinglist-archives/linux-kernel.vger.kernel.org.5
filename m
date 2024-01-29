Return-Path: <linux-kernel+bounces-43288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307F8411C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D170283C65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52046F07E;
	Mon, 29 Jan 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9vXL+QP"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5523F9E0;
	Mon, 29 Jan 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551877; cv=none; b=mn8i2jrEGH7dCT7jrwK19tscVBdX6bJEyL045oM41jB4mLISwCTvmkLFqxmnZa5DirB3l+MOrvkK3JWp05FnNc23RZ/9qEhX+iTkL4mMdsk0V4CvImDnNFfnHPWrZoesI4PhMCCH207bih9sB/84Seqsub1IX9sezpCHifro7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551877; c=relaxed/simple;
	bh=38VobFqUx6l9PMF9zm8mxpkHGsayw0PHLQISoEV2HE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbgYXfyjgF7VrUUpoVYmmc360t51xItawKN+D89ZdXg4hN1K+umub44aq/MxDH3fLl/WyxoIrDnU1mySHDAYxQ7hq5YLuafiKV8OxXiAvKkh2VR095145VzTZhzzhcO3Ff3JdBX6coj3b/5wxVdEgaDKnByprT7oFWP3YcxixPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9vXL+QP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51109060d6aso2355680e87.2;
        Mon, 29 Jan 2024 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706551874; x=1707156674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYQ+hC2S1+sJSH6fybbuYl6+SkoN1tHPLVhVLFYYIYc=;
        b=l9vXL+QPfE3NxWzeNSsdUIpuAjyvS5EiZOOdUESGzOerrRWdBpiiBcPBng2aVP1Cyf
         L/Xf1yGUsk+GYpIE271YQ2KfqsmlFgOC2/iK9mI07EgLKInXbrKo0XOywm1MM1JRzMDq
         C+oEh3huXbkS22x1PLAIoLqHU+fN7qCB6+TwxaGKPi/qrK0es/X/6M8vnI7W4l+Ac2WD
         w0QSYxyRAxO/jMqb2fMyH4G2EzcQxLj4KUuRlNqzyyvwSuiXXiKVRuq3xeWrM6lsGNbi
         7Y5WKJKV+/Q1/bzu53Flh5kwIiejKQXpXceFU2XSu4jNCTaT+HN45A7fIiJew1SoCVOk
         H6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551874; x=1707156674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYQ+hC2S1+sJSH6fybbuYl6+SkoN1tHPLVhVLFYYIYc=;
        b=YaXIwE58wkKWKFubXjmS6jz8xvKCm8zpILKgx2njFT0Me0IHWV4QE86vOTHQSKsLpM
         e9sn8Bf07ZP3NXqdhPz+po9uS3Lm7rJwGXCx07qZ1zCGvjeGy+qeUZk+I35spsVzRq1j
         ooBSPQFDDOPjhgcxFrn+NETj8eoO6fymqoYGFk+CmLDESKWriYxePdXSzLHKEgZXjENq
         nCDtkOT2megQAeZRVhQaOgX8VPfOI8X0Zy+HifXX+bSgYOFXftnyxxqKrjydVWEAbi7S
         SGSsIj2WGhnGeQp5ulWwRY+x/JJX7dFpl9ktPeEhbkSXpu7JBQWlmqp6u7fhGS8K29R1
         PQbg==
X-Gm-Message-State: AOJu0Yzzk+U0NnaQxLj3eFVyFCDtAhF0EhLK0lRHX1VNbvZu1JxmV6rT
	MpE2RBoZnM3SYHFNyVXZ+d8qNZzF1OGLyvXLORQ88wRj2gkYaBM1
X-Google-Smtp-Source: AGHT+IGYQc0+dx+ooZm0M9/XDxU2LsxZf+l/xc8uEkp5VFZuf8l6tMjb35vLF5SM+9tdNV7mYXzT0A==
X-Received: by 2002:a2e:9e81:0:b0:2d0:50c0:41f1 with SMTP id f1-20020a2e9e81000000b002d050c041f1mr1754594ljk.28.1706551873701;
        Mon, 29 Jan 2024 10:11:13 -0800 (PST)
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id u26-20020a2e2e1a000000b002ccc6f06e2dsm1231214lju.128.2024.01.29.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:11:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Romain Perier <romain.perier@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robert Eckelmann <longnoserob@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: tegra: nexus7: add missing clock binding into sound node
Date: Mon, 29 Jan 2024 20:10:49 +0200
Message-Id: <20240129181049.89971-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129181049.89971-1-clamor95@gmail.com>
References: <20240129181049.89971-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Eckelmann <longnoserob@gmail.com>

A recent rt5640 codec update requires mclk definition in the
device tree. Without mclk defined sound will not work.

Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
index a9342e04b14b..15f53babdc21 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
@@ -915,6 +915,9 @@ rt5640: audio-codec@1c {
 			reg = <0x1c>;
 
 			realtek,dmic1-data-pin = <1>;
+
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+			clock-names = "mclk";
 		};
 
 		nct72: temperature-sensor@4c {
-- 
2.40.1


