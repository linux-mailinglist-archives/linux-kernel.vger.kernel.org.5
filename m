Return-Path: <linux-kernel+bounces-4070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5D81779B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635DD1F23426
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F34FF66;
	Mon, 18 Dec 2023 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VkLscx5n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4A1E4A9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231218163602bdb7920dfde85601f9
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Dec 2023 17:36:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DGc09doAd9EHQec/Q+39r+r6A/SGkvCije7KVtwCVGo=;
 b=VkLscx5nIgXbmBts1drfS+MCOsPOmTRnw1QSIlR2R4AD/Q76bfbk2HxkdVphoOmRbgXamA
 IXfyWsxtq2FrmEaTqjkGWVfogYHCpcd2vJ5Ffmb4YMP6jkWZwTOgvkUc/l2ht0S3rwDvGA/N
 OOG6F59Tn7TvxR7shQDSS4SHKFYHk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH 1/4] dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant
Date: Mon, 18 Dec 2023 17:35:57 +0100
Message-Id: <32e9364eb0f95e94f3966a8988c37cdebfb8803f.1702917360.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1702917360.git.jan.kiszka@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Su Bao Cheng <baocheng.su@siemens.com>

This new variant is derived from the Advanced PG2 board, removing the
Arduino interface, and adding a new ASIC for communicating with the
PLC 1200 signal modules.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 03d2a0d79fb0..2cb3f6eb8a43 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -91,6 +91,7 @@ properties:
               - siemens,iot2050-advanced
               - siemens,iot2050-advanced-m2
               - siemens,iot2050-advanced-pg2
+              - siemens,iot2050-advanced-sm
               - siemens,iot2050-basic
               - siemens,iot2050-basic-pg2
               - ti,am654-evm
-- 
2.35.3


