Return-Path: <linux-kernel+bounces-84217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1386A3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032AF1C210A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE5C5A10E;
	Tue, 27 Feb 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaZ+GfUf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A275916C;
	Tue, 27 Feb 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076368; cv=none; b=SvX7i7Lzcz/P30jl82MvwUFvrL5oCo5Gm2f9FPtKajMHX4vK1FlENr5UK13ovih7tiwew2DCbSlye2RtuYdomqhpmutNTE2VN5lYIwFWAlAOcTRypovN13nkQYTH6KJkR3VbuK+nW0DyKqbc593r5G35E7MUHMYi1pDy+mMX0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076368; c=relaxed/simple;
	bh=oF5Lxf0zMNVHkTzefBKunIX9KjOnl48F57KVIfH1Uc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DISf2QLI7b0rHkFMl1m3aYpXUxImsYHkeHgr25oJD9Kel4AwFHf5r+OLKxQogYTQUYWesuBykSVpV6Y7tKW9BHvkNGvgH7yxINlxnVX2hYqX2M4rTcl4dDvi9hTdZX0uwi0Q4wS8/NlZhblKvBfzauESpXI3nUOukdYlhKmFhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaZ+GfUf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412b2b032efso1666855e9.2;
        Tue, 27 Feb 2024 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076365; x=1709681165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhEo3Syaw+1D/UqZTo0d5+c1XDDsjDM+0yQgqzieH6I=;
        b=PaZ+GfUfIcogmT2r5JImqJamKO6NCGGNO+IfduhEJG+AUjTkiRlYxIoo2H10Tq8mjM
         iNPt/5IbH+OCK+yaOYAozmXdG47GdowbypJ4CsZpLXVePDlKtMJ9EZofs7CfLZRuNIH3
         bpDIoIdewQ0086SF/Dwtlk1jKjyTKbcW5kfG9/nNEHLeVDTweKogFjFHYTowin+2A52b
         G10TrHNGGfTa4lnrXHdV4MXl17YBwZgtw0o+f97wQlgX7c5SRqhujsrKrTYysAt6I8qg
         p3b1b8+clSH64bt9j5U+c0BK/6So4+qos6BfXD1A87tRHuxmmCEp0BsPy+xTDlWLs7IF
         PLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076365; x=1709681165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhEo3Syaw+1D/UqZTo0d5+c1XDDsjDM+0yQgqzieH6I=;
        b=EYUC3rUzBA6v4QoPgS0px+sxgHHzGV/bcJ/2y5BCFdXNaAxYnKKxAjeN+XlN1TfU3a
         F8eq3FSv+FVP9L5xH8BxT05FKDrD7YpwbHxRl6YYOeRGIkuBpeaDJ0OB8Df19k0yAe9k
         AvRWXfbJozuVg0xqjIoOLOk/NeICFLMBdGGYV7eiHIoEOSCXlV+pV2tBckDoFbPHze7d
         LWyaNfVeeyPocikxM6GeOz5dxm/2NW0cyh/oG+YbD19gRw5Mpyeu256No0D7YJWf30G9
         f8aC2BxIxnLYOvBATdORC69s5ADGDf5ffJkGzv/RtmztedkvayemGhFTJEcN/XIDQTGh
         AFWA==
X-Forwarded-Encrypted: i=1; AJvYcCVUy5Dhq2G711zBdxbLdWOs7CvFvkxOcgNSE8apkcm32U/+KPTe+V/MSwA/zqNs3dvoBzytcZJqyIeekgtXQxHviPMM9ks5LBRLRpqfFmVHyRiUjndl53Qeoi+GKwXxNdqNF3MM8Zu3/dlGXr/plDITsi07QOGbm/uM7ODs9jON2KIX1kE51hyy+dkh
X-Gm-Message-State: AOJu0YzL7XdGgCH9OBdHolK0ue763KqevIby34WM9ynl9TupFU5SoET5
	GKMVaFrP7b/tEykH3oeCsQTR1uVfenMoU4iajQAi/VWo561D3Ub6
X-Google-Smtp-Source: AGHT+IE5cIYZP/pJspkNW0mFurBM2o3ODZa4zFnZfzPeGTaQE6+YzT3Cy/WJPNYgR/WrURSqQgOMVw==
X-Received: by 2002:a05:600c:4885:b0:412:981d:2889 with SMTP id j5-20020a05600c488500b00412981d2889mr7465933wmp.40.1709076365455;
        Tue, 27 Feb 2024 15:26:05 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d96b4efbasm13014444wrb.21.2024.02.27.15.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:26:04 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable R9A09G057 SoC
Date: Tue, 27 Feb 2024 23:25:31 +0000
Message-Id: <20240227232531.218159-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable support for the Renesas RZ/V2H (R9A09G057) SoC in the ARM64
defconfig.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2
- Included RB tag
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9cc5bff157c..5d51ab7d14a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1387,6 +1387,7 @@ CONFIG_ARCH_R9A07G044=y
 CONFIG_ARCH_R9A07G054=y
 CONFIG_ARCH_R9A08G045=y
 CONFIG_ARCH_R9A09G011=y
+CONFIG_ARCH_R9A09G057=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
-- 
2.34.1


