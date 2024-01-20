Return-Path: <linux-kernel+bounces-31661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC183322A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36925283C92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC420F5;
	Sat, 20 Jan 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="na3NjKgs"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D1A5D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714193; cv=none; b=B+ZPDhNLns1IAmC8oxOdaZjP1kSLI4KSn2lfc1b5DRZPYe+x6XOCFIXo+SO8mzIk/Td1U5kn6wa/FfKuareyeF5SSWM3udNRPdtbiXWFnNkmDV9fBNeDBJHgl1mezNG8UjiN3WmvIwnZzjsZikYqnqVmw6Wr9g/Qj2L9J9HJpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714193; c=relaxed/simple;
	bh=uAz/qiM8KY9BQJbZ7vUWlHhYlpLZ+LxFlHrcn3+fLyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAuei9Iz4r4aL6XhnkMmMFMH/rkrHN0ZofFt9bl8L0KMBs/2MEFNohf0mL/XggUVo0/rNVWZVncElvV+7WWRJKdiA+OgAxMFk4XPJPYD5Z17onfBv3RP5lMTPkYPdxASM0eIprkzAD69rDr4HjiUhOYRb03WLyUg42iBrOHXRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=na3NjKgs; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dd8cba736aso860680a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705714190; x=1706318990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbjnpB/QvIIZnh55u6BH3S806rvVmJVe+8f6W06lizM=;
        b=na3NjKgs/jwuBOxD5l3tKlQnCTV5iCkdrWOpDZFfGBsJbWnFLZ60WoKELG3cNrplql
         PBVhZN6oM7Gvf9uTxanAhoRLx1X/ZMOmMU8REdu1FTX0s5EKG4Ky49uaY3etGwvEZiCa
         VCuMFCl9BQNpUsuTDUx2bOMqGg+iXNaYsyYjjMblBczWX5FXERieyKkhbQiqF22S7TVC
         J8xpioJmJexPBAM0Z9rLxgbkExgutmkfGgpuAADV/5NxaBuoxASoemBw5XC2hdYip/mO
         5wkWaaHQNdg1AiwymnSqxaWRNKAisI1KgiMsz6rMiSEGW/h0szYE36nxdZb1ra5cHHK+
         ibDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714190; x=1706318990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbjnpB/QvIIZnh55u6BH3S806rvVmJVe+8f6W06lizM=;
        b=H89VBKZCM65RDGiSznIj4Qx3ZCa/KTIxA5CKDgVqF0GX1wsO65fHLT3/pPRpPQdWKB
         8hfPeaFvUghGLnEdmW8MBau2XBLWswozR7Qo5Kn8xNZnGCKTNgJRmqCXaJEnyLjGUE5u
         ZSJKUxuOMGYmhH9QaqnSFKI7N+F1Ir8gSx9UHzM5OAjaEr2FrEAc9YjZMcnWLZJC7EIK
         zx9Zvr728s1LJqFHvL6Gp5cDU7E06xExKaiPgcnQwaubKm5twYGYpQYeczASNuVmNGyT
         Z3FU9veG8w8C6F7dgrdcTS2g5e6hfoQe+Wg1FIAyLgK0K5ocJ8VQgyJRn2aPAZQgoxyD
         uuqQ==
X-Gm-Message-State: AOJu0YwAKmYw38x0FjICDysSLiG3nYQO8th6uIAZPAgsvWO03y9tQ5gN
	V4/RwZaQyAXMBmoBEqKLnmZ1zpHG6yQH+e6fKYQ7x57Z4NG2GthkPjWsbXcOKuA=
X-Google-Smtp-Source: AGHT+IHGP4PdfLfkL7ZWzlR9nwKYRBI8hB++4B6q+4YhnzloPkuEF1eJ1lqxDLS4X9BZdIg9kvlxrg==
X-Received: by 2002:a9d:4b11:0:b0:6dc:7512:636c with SMTP id q17-20020a9d4b11000000b006dc7512636cmr742641otf.68.1705714190721;
        Fri, 19 Jan 2024 17:29:50 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id c7-20020a056830000700b006ddd110e8ffsm751899otp.64.2024.01.19.17.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:29:50 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: spi: samsung: Add Exynos850 SPI
Date: Fri, 19 Jan 2024 19:29:43 -0600
Message-Id: <20240120012948.8836-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120012948.8836-1-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document samsung,exynos850-spi compatible which will be used on
Exynos850 SoC. Exynos850 doesn't have ioclk, so only two clocks are
needed (bus clock and functional SPI clock).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 79da99ca0e53..f71099852653 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
+          - samsung,exynos850-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
-- 
2.39.2


