Return-Path: <linux-kernel+bounces-98200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B80877662
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3231A1F217E1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818192030A;
	Sun, 10 Mar 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="xLljj0e1"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DB1DDDB;
	Sun, 10 Mar 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070920; cv=none; b=VLO/P3EVatuPp5m1VG61GNVBRfAekveRfzr5RRKYvvJQk1IlLOfAAJqx/DNXhSooTcl+SGTQ0YC7arQkuKA/WT6sNbQ0VX9TWR0boStjRjEKJxEgB4l4vrdQT7c8+vfiSCWD06nFCrhkcHOKJWLah9jjlvhJI1+L9jJZ9maQT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070920; c=relaxed/simple;
	bh=AgJRUGq8reZPMsQEkwJy5L1RC2vqHFoXplg91ZNU2Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L42BW1hAbiqehrhdrAadrHJcon4kp1pwtxLpE+O4R/scwt2ueC2gOxj06xxRnV1L8jIzsWZy3hIDax75SbC6Um39Umag93/9y64Fta57k60elD5iSIpou8hcQFo5rEj3Bm+UxNDkP3gGzEJSnkIaeJ4MfLrETYL/lfH12O13FW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=xLljj0e1; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710070912; bh=AgJRUGq8reZPMsQEkwJy5L1RC2vqHFoXplg91ZNU2Z4=;
	h=From:Subject:Date:To:Cc;
	b=xLljj0e1OF20LrLSz8RgYDMqcp0J7Kc4WQu2MWnreF26V/ZHh8Lwk7RhSTGAnZIdi
	 b5rFuVylVbMYEh39F3MQictrlcvh15JqCfj5aNm/+8tN/g6h9nYpEGEQqCV4bZj6UO
	 jvAb25DWWCNedSiRe0eIFY4CGqhdIPsQHgGXC/D4=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Split sony-castor into shinano-common and add Sony
 Xperia Z3
Date: Sun, 10 Mar 2024 12:41:06 +0100
Message-Id: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKc7WUC/x3MTQqAIBBA4avIrBP8qUVdJVqIjTkLx1CIQLx70
 vJbvNegYiGssIkGBR+qlHlATwJ8dHyhpHMYjDKzslrJGokdZ+lzSpmlWm1AswS0TsOI7oKB3n+
 4H71/zX+Mj2AAAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=AgJRUGq8reZPMsQEkwJy5L1RC2vqHFoXplg91ZNU2Z4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7ZxnJ8I/hSb+nyOF1cGR2dpGm477ofrx4YSbR
 9OQYJbOfPKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe2cZwAKCRBy2EO4nU3X
 VgtID/4jJXu27eWPRSTuiMeYeCsOxmsF8Eu+BqP6uWADJTl27/BerWlAdC8d5Nn607ZqUFTmmuc
 7F42asa9VD82H5KrpdSwDfE6+mwpnLOjH1VLwDzkhit4VM42zVbVaBvGpewc7iru4AgSBn+PXNS
 CLd4Ja6Rii99rYRdUioNR2QRfO2Dl9VSaemHwvlnGuDF1+tdFbPKlzLYgebigHNPF5XBQSvFFcE
 K3eUwpJskRH8xpeIP6R0aSQ+VrZefldd0fiM46tUAUEeM1FoOzSELJzAY3HGyyTNb1WTPnnwE9G
 TW9Hp9zT1j3tHne0xawbSnfdA+vokn7TPHDoALfipaSaZIRSLDFnqvUk1W+6TYS72yceJMPGYuK
 w/ot/fuJil+zhgN3YLNQrqELKeUusg4qKgErHKF7y9T2VUJP0mEU0bu2Hq+zFnyp6w9K2lZiyJ7
 PXvSbJ+9+D9GGn0ih7cmG0McJsSL+b1vcSny+EcyiORoxDfvyxtQsYk4QopmvtPZCTz8MD4zV0m
 VZ40GKhWIafqyKU6zKFDx9FMmAFGx9kIvCSG0+IkwpjTiMAKSGTeYj66muwmKgwpwohkoQjcoQ6
 y4U6aF3wLtcY/5ZO3kba8MwrgJjm1Y9IkS5Bw1ffHTzpOOaj5Vf3Y8IltHrg6sT1DbpQqVbtq22
 VIJSbwRnGKDOaOw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Prepare for adding sony-leo dts by splitting common parts into a
separate dtsi file.

Then add the dts for Sony Xperia Z3.

Depends on:
https://lore.kernel.org/linux-arm-msm/20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz/T/

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      ARM: dts: qcom: msm8974-sony-castor: Split into shinano-common
      dt-bindings: arm: qcom: Add Sony Xperia Z3
      ARM: dts: qcom: Add Sony Xperia Z3 smartphone

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts | 541 +--------------------
 ...qcom-msm8974pro-sony-xperia-shinano-common.dtsi | 535 ++++++++++++++++++++
 .../qcom-msm8974pro-sony-xperia-shinano-leo.dts    |  44 ++
 4 files changed, 591 insertions(+), 530 deletions(-)
---
base-commit: bee52eeb37d8124a07711657d1650bf3b467e7dd
change-id: 20240310-shinano-common-093fe25fe3a1

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


