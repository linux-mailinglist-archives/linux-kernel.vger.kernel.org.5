Return-Path: <linux-kernel+bounces-93096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B45872B06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A101F28B00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C8512EBC6;
	Tue,  5 Mar 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="74jOMO84"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05C12CDB5;
	Tue,  5 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681209; cv=none; b=JzHT6AmkiN9hwWwFdh1wa/vT5AZ797RZhn++ml6qQpNVluA0sOshQJxPyllFQAD0o3XKAxSbHPRpbOWP+IXELzaTjwVBaamW+cUIY/vfB/WU6q+LYtR3VukhZsp2wj0xI17geCIj0X9vSZmFzT0tN/pHms1b4tTZHxcwXG6EUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681209; c=relaxed/simple;
	bh=x9Y9xwhGkS+LUjC9Tovi4kF2u2FKvyUY6KkNZLsfsDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXknNmGhyt6A4ZY5baqUPxgak0SjO4GF/gryA9KEUc+r0CscHtEn/GSOzm0Dup522173fAGtd4JiUbF7Zs7dlch7Szfurmn81wYFy3Kd34EjbeGF/bev39vXWDjpLJm7Mxy2NKlwBmQKru0XEGv25qtfjEM4YoE97aQycMRtNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=74jOMO84; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680706; bh=x9Y9xwhGkS+LUjC9Tovi4kF2u2FKvyUY6KkNZLsfsDk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=74jOMO84QrDCSHxsak6DHbDY/ThEHp6Hr2HMdcDEmgW5BQ3FALinfCpD+qciY030i
	 I6H5KeofgfA6R2rJ49uF+ibX0uhDmS/GsAdFI2hJUNPVakuARLzAI7YEgF6k3vZpfn
	 ovJePfVKzY/K+fNExCkkJZ+1XrZC9fKlal5g7z2c=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 06 Mar 2024 00:18:06 +0100
Subject: [PATCH 3/5] ARM: dts: qcom: msm8974pro-castor: Remove camera
 button definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-castor-changes-v1-3-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=x9Y9xwhGkS+LUjC9Tovi4kF2u2FKvyUY6KkNZLsfsDk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56g9PrxAuZFa4AyvTXxOy25WvQjQY/lFQieDE
 R956vCcXTyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoPQAKCRBy2EO4nU3X
 VrOTEAC/YZwp8VNwuXdews+YsEVRSc5aXsmDiryjUvjAvepWBCa31qutCZbgI1S4JyHROjvVnwd
 ahjm1Omo9emOenigrezRSbUCUr0l+eWNNyHCs1kyNHjNqCgH8KVxQpGQ69SAc1ieRCSfKYaaoW8
 ymYf/HK866XmRuceBDSMjhxRy8d7vS8ybL1uWJACzveirCyPM77JgBT20KR0m2T9LwsZBsLBHN1
 fJ+OsqdBtyky3tuY55Mz3jnUd21n1MyTSpleGUHhaw2GtNjVfePV4olXiUUYTUcJEV2qDwSXz0x
 /n4wJOCSSuMuvn39GF+7Zv/qvYuEPJPl9w+TCqezBhnjSZ031gm6sTkFBBb+BZoUC1cr8pHyb4I
 aRYftiEuX45kGeD+kiUVxluA1D5W9ZLUyqHznI9dY5z2Kp8tCXvxyOAUuzl/zwzcVsO1Jxrrv3u
 ZzYWeulVsRADrTit2zRk6UwNJi9nueFL3H3c6ZwkXIo9PEtoIAv81tzQHLDzw4Xp30uY8W+h/Vp
 RgH4xrcl4FYWgJKPYGojZSQDk91/XPxRljVb+yOu/9DQcV0PAfHOgqLw0eyj9uy3oMmLiFl8NUH
 oQUgNqfq7VQobQzjyu1zFZtkKowlXKK5HPpvh9k5lEG3y837SIS0W8GlwDwtbLk1ZDqMzzSSpkA
 POIXc7cawmHmH8g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From what I can tell, the camera buttons are not part of Z2 Tablet
hardware even though other devices based on 'shinano' do have them.

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts  | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index da554f72528a..97b55bda9189 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -34,18 +34,6 @@ key-volume-down {
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		key-camera-snapshot {
-			label = "camera_snapshot";
-			gpios = <&pm8941_gpios 3 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_CAMERA>;
-		};
-
-		key-camera-focus {
-			label = "camera_focus";
-			gpios = <&pm8941_gpios 4 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_CAMERA_FOCUS>;
-		};
-
 		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;

-- 
2.44.0


