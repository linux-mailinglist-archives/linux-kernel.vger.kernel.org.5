Return-Path: <linux-kernel+bounces-89449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82F86F080
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0E1F21976
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022421757B;
	Sat,  2 Mar 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2+z2qUS"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49C17981;
	Sat,  2 Mar 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709385020; cv=none; b=gFyySlxXvAExUM0dx5tdM/6vyyvIDuBn+tbSQRTkugk1Ad0WFecnqK28M9CFn0fRxLgnJueDebHKpaC3ixSDVmCHcN1YiLdU9Ed+EEVcl97IU821PCpnklVNpGfxemGeLtHAzxf5h9o715uv2GxLrUMY8w0M3cul+ffORUb4dCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709385020; c=relaxed/simple;
	bh=x/1N1H133E2sziauvMVCmgyf1SdDcb75X4JaidNMP+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIAG6DO8Nq+QczSqJc3U8HrpAAYG2VFzSxV8GGb+wrrJkLjWKBmCBV6NQ3N5GMNmDgX/4bxCxfdC4mV2w16pcx9GCKpe8S/qgiRdfJ9OwRGIIVsW/Ud/me/sjtuM7dknpazuYm0Brtw5j3tzGMU+6BWG2hOkrJx3ZF7Vg0W8lvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2+z2qUS; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-365b3d92354so17571065ab.1;
        Sat, 02 Mar 2024 05:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709385018; x=1709989818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+3zax9Ae+5S2Sw//698s5mgfIh6dzBPKe0NmMEjHJk=;
        b=A2+z2qUSl5bwrS/icnqw+k1XvfGdnXxZY1jn8JECAwxy81HKAPuebTu9Asl5NMnEaN
         OxnpFG3sgTh62oEafbKUo+Wl5LlK64eL7kvgeLMxJEQiUD3qXiHn6IvINhOQS+jETSHh
         8akrYLD7I6S+ulecr4ojlt+xfWlTUZzKatplqsYlXRnWk04tyjxJT+v/Z2uN22E5hWna
         5nmmsjYbVGqUMlGoY2yvRljTeDb8nU/WfEJM4tzXGBe7J3MPp0ZoSSWm1TuK8nSxecpy
         ZpTaHnEcb4zG4sOAhM6YA2We2/iVToBixvEKm54MlTxaWg2BaC83JscAQ9vEP+oyc7NT
         hAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709385018; x=1709989818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+3zax9Ae+5S2Sw//698s5mgfIh6dzBPKe0NmMEjHJk=;
        b=VRpIOw3hgKWozmq9fuFYOLL4UCshk1qqgdv9yXN+brHtXbgh+XdQHcXtN03OCbyXmh
         0gZZXcnccjAoETWYUBcxHVSeC0OV9/60rO65vD186aBmhW/+xI7qtgKg8Jrxev9iQDtv
         BMLmqSfLyyeo4tkK9rAGcsg50U5R0piXWEH5uUqaIm1H+Zbuv6RzJi5wUcLOFc7fs3Al
         q4QJs2sxYkcwSAz1y7qecRKIOqwCf3Oncs+V8nwo4MVjRIluOYWV70yS1waqWuTduJZF
         SYy1VhPP9/LPuLm3yS/ZLI2S1LR6NyCnUkiNI5qLFjDPKT9/xkKI33BOYGD8AvU8ILcK
         lVOw==
X-Forwarded-Encrypted: i=1; AJvYcCXpqLjSzOPF8Y2xtM1QkEKEdKrtLjO76f/g5Wi0E7cKsDchW2RW14/GD86qdsutW0kA3WCo2XBIaq7hlMoV3UD1j/5QUAcj+DN79xXYZAZfxhYoMSRpicgCMIbvUVtmF09ebB7fqMr/bQ==
X-Gm-Message-State: AOJu0Ywd8Gu0pik6M00xnMP02vUd2CAXYZBIgnE0bpNZJazt8PW5sAG+
	0C7P7q/CV0FsD1XF2VkeQmWbNQzqStxDN5b6ea+WVRCOyOegsSjdiOZpKARIbNk6ew==
X-Google-Smtp-Source: AGHT+IGp03+Ktmt6hq1uXymoLsMk09+TCaijjsNgHZnFpfE3tNd0hdnqD3CXW2IkfbgsNlwOur/VXA==
X-Received: by 2002:a05:6e02:2145:b0:365:75b2:a338 with SMTP id d5-20020a056e02214500b0036575b2a338mr5688342ilv.24.1709385017961;
        Sat, 02 Mar 2024 05:10:17 -0800 (PST)
Received: from localhost.localdomain ([103.149.249.227])
        by smtp.gmail.com with ESMTPSA id q1-20020aa79821000000b006e4d336c420sm4472549pfl.69.2024.03.02.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 05:10:17 -0800 (PST)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation support
Date: Sat,  2 Mar 2024 21:10:25 +0800
Message-ID: <20240302131025.13741-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usb pd negotiation, but charging is controlled by pm8150b pmic,
so it can only charge battery with 5W,

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 6f54f50a70b0..2042020eb0dd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -636,7 +636,8 @@ &pm8150b_typec {
 	connector {
 		compatible = "usb-c-connector";
 
-		power-role = "source";
+		op-sink-microwatt = <10000000>;
+		power-role = "dual";
 		data-role = "dual";
 		self-powered;
 
@@ -645,6 +646,12 @@ PDO_FIXED_DUAL_ROLE |
 					 PDO_FIXED_USB_COMM |
 					 PDO_FIXED_DATA_SWAP)>;
 
+		sink-pdos = <PDO_FIXED(5000, 3000,
+				       PDO_FIXED_DUAL_ROLE |
+				       PDO_FIXED_USB_COMM |
+				       PDO_FIXED_DATA_SWAP)
+				       PDO_VAR(5000, 12000, 5000)>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.44.0


