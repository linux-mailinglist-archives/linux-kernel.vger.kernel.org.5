Return-Path: <linux-kernel+bounces-104490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F387CEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6DE1C21B67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64C38395;
	Fri, 15 Mar 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTGVxnfO"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343F374F8;
	Fri, 15 Mar 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512590; cv=none; b=d4TznIzuUjNzTjh9RM55iD096EOmHNTyH8mmbxjSwAImQzfrLpAjxopFjEpcxYp6F+gsgXWdF5HSOL1/xrKR5ugKEUStXw8C2TcSTWSXCemNbgym4IJYKurXFs9wGJD4UffGoDO3uyoxwAoZ+mITjM0xTp90lrgtA6qLD0uFsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512590; c=relaxed/simple;
	bh=6e+gaP78lU9Fm1Rb4+Nk+MtHDf+1Hs+s0bNEBb52MJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZvfJKOcrEIJj+KP8X2Nnz3lvnx2PNCH4BAbpkdDehiTZBGvfuWUC9iJilGEsRNtAdfb61xW3p56xo++FSdpMyxkgTb6OMp/xjcpBS68t290aY/N+kOLkfnuVr/HU+DrQ3MiB8MLMDAmOucim3QxW0HpvAJKZniww4RBG2yBoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTGVxnfO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso2442684e87.3;
        Fri, 15 Mar 2024 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710512587; x=1711117387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOftRtcb4G9B1HnShbJVcHJJXn8N/BLdxMg1OAlJdnI=;
        b=PTGVxnfOPGYPoij/dhVf9iakEORt6ybFGmAAGTRQ45V2k5Y67fRXj3BePrnwUSpBU+
         Mf1d+hdyWNUyJwzV7/H2p1biPFJP1C0Lt50/EbqbsuQ5XIfDmveUeIag8bfFI+87iCD9
         rtHUw/6p4dbt1pWzHAqtgK0Q70u3VISmBe+7NM+CDJQlRNWAID55qSCAapcyc/zCnGnj
         7CsxalY5m1w2OebjoLpux722raEFeu8sS7DXAlH8Fe6tet8tWHH2v/Da+zcb2s0GbRzY
         M0kJyS51ndyHCUFhf7MHVYKnAMQICIwRGPx8MtrfpAHhNhH28aiX6Xe2K9eY+naQrDyH
         IJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710512587; x=1711117387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOftRtcb4G9B1HnShbJVcHJJXn8N/BLdxMg1OAlJdnI=;
        b=WKWP5Mr29/lgfPm1TEntNscXYjxRLTEj/HOpqS9gzxXtuP+I3Q/EL0Vnf0abyNKOVx
         ru3dO7nb72x/EkOTGZP/SJVoVnl+zDywxjVO9xMZsv5jcyJrh/m3rd/dRmN4DPhhk2Jq
         TNoMRgy8vpaAHAtBC0K8qSSils54FpE09aXWInNFxanjWZnnFYoMZS0Z8FIUkfgt8WdO
         s0OXdWqERZ+9sMHumfKSuSF9C4Ni8YCNbOkriHSGDo4u06g7kcJvlKex3FNyJPChDxK9
         3nZEGEusRwRulBgL51991mVs4GmYYWBmlw3uVr2BAREiUvDf9EXLREEsYgKhezCwoM6i
         nadA==
X-Forwarded-Encrypted: i=1; AJvYcCVm8xUVL9BhxQCkWN7YxOwxMeKfVNp/xC9TSKjsAyK7W1T9jhmCpHDsI3Uw3Ar3ZJedUuVL3uEum7OK2GKYQIz5VzqtQ9FUzSBrZ/5f
X-Gm-Message-State: AOJu0Yxp6ybNhSFZDufNWSmdllaV5kxpQJXdGlSS8OZqp+zQJS34uThZ
	Rmn/+a/J41/BH+NuClZWA+6vVYeeQiV7oM2IYfxipBEdwvl4/sAZ
X-Google-Smtp-Source: AGHT+IFGVMxOzgk17OqUkrG+fP9ObvRfMExiaIt8PESwwL6szH+X6sT9ls7vTaI9WHiCaNkyjmQZ+g==
X-Received: by 2002:a05:6512:32a6:b0:513:cfa6:3ea3 with SMTP id q6-20020a05651232a600b00513cfa63ea3mr3934077lfe.6.1710512586745;
        Fri, 15 Mar 2024 07:23:06 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id r18-20020ac25f92000000b00513c82518fasm649651lfe.223.2024.03.15.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:23:06 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: add Forlinx FET3588-C
Date: Fri, 15 Mar 2024 19:18:05 +0500
Message-ID: <2c7a99673ab4840bc7052eb600363d5163c5cfae.1710506373.git.dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710506373.git.dmt.yashin@gmail.com>
References: <cover.1710506373.git.dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FET3588-C is an System on Module made by Forlinx based on Rockchip RK3588.
This SoM used by OK3588-C Board.

FET3588-C features:
- Rockchip RK3588
- LPDDR4 4/8 GB
- eMMC 32/64 GB

Add devicetree binding for Forlinx FET3588-C SoM.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..d87f4955f509 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -211,6 +211,13 @@ properties:
           - const: firefly,rk3568-roc-pc
           - const: rockchip,rk3568
 
+      - description: Forlinx FET3588-C SoM
+        items:
+          - enum:
+              - forlinx,ok3588-c
+          - const: forlinx,fet3588-c
+          - const: rockchip,rk3588
+
       - description: FriendlyElec NanoPi R2 series boards
         items:
           - enum:
-- 
2.44.0


