Return-Path: <linux-kernel+bounces-168496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756D8BB943
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05391F23C9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBC17996;
	Sat,  4 May 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="Vz3sRLDC"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FC7484;
	Sat,  4 May 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788924; cv=none; b=YOxuKPBqiLlEixyCGus+ZoGT5goP9C+PLmWuU1JDQBzmhAWJBSHIC0rFjp73lVebDfbN9SAoOQFITap5GMU6jA1EYon26oDO7lq9McD68jk/ih/jadB8HVfaUHDSp+wee7CvolpYHKcQT5u8pTLp6sDJPXNDG4DMtbpp7SFaNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788924; c=relaxed/simple;
	bh=p2TszyFmu2FkHsRRzAxyX9QqovN3gTcmuT+Tg23mkSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfQOjEVth6WLWrv3phkDdma5bOji+0gyV8k2vrfMD31umhWx34uqA1UmwsZjaOQNjugUNu/DfmvovYS3i83MFO89zmedHlyioLoKe4LLBdgdOwqqZPZbcUx2BglZqD0JJEgDajomoCOMyEjvZYsXvmH9MJFfEq3+7buAnpTlMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=Vz3sRLDC; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DC7CC006A;
	Fri,  3 May 2024 22:08:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788486; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uO4vCIsUirzrH7yn6QZzygawT9UuLKwK+60u/xACvr8=;
	b=Vz3sRLDCuP6ShnFA89j3+M8pLX9GRZs8qttQTFhg/con9N4mvuHqD1Khi/MWxSOdJEGol4
	aQCJupFSQBXLdCZ3e/omrj8DtCKnLSAbSxrrm2LVVzf7IGewzjdvOpaTHVfIZRflD2L7CG
	wkTK2lXBDQYuH4fw1SdbM597jZLQeN8=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: input: touchscreen: himax,hx83112b: add HX83100A
Date: Fri,  3 May 2024 22:04:40 -0400
Message-ID: <20240504020745.68525-2-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504020745.68525-1-felix@kaechele.ca>
References: <20240504020745.68525-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds a compatible string for the Himax HX83100A touch controller
including the AVDD and VDD supply nodes used by this chip family.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 .../bindings/input/touchscreen/himax,hx83112b.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
index f42b23d532eb..5809afedb9a2 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - himax,hx83100a
       - himax,hx83112b
 
   reg:
@@ -26,6 +27,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  avdd-supply:
+    description: Analog power supply regulator
+
+  vdd-supply:
+    description: Digital power supply regulator
+
   touchscreen-inverted-x: true
   touchscreen-inverted-y: true
   touchscreen-size-x: true
@@ -54,6 +61,8 @@ examples:
         reg = <0x48>;
         interrupt-parent = <&tlmm>;
         interrupts = <65 IRQ_TYPE_LEVEL_LOW>;
+        avdd-supply = <&avdd_reg>;
+        vdd-supply = <&vdd_reg>;
         touchscreen-size-x = <1080>;
         touchscreen-size-y = <2160>;
         reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
-- 
2.44.0


