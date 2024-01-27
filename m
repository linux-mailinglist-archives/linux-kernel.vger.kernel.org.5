Return-Path: <linux-kernel+bounces-41337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17B83EF07
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A976C28221E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF02D044;
	Sat, 27 Jan 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="zQNJPPra"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28E2D022;
	Sat, 27 Jan 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376195; cv=pass; b=LwyfmHa8KFyjoQ81R6gb2tVHbZO4uI0XJs6/6PhHWI7RaXrS9IMGD8KOnxwL3bSEUdlr4p0PWNO2OTNMXnDwUfRjqNhVtw2G087AioHoCzu+5+aRvqvdK2k9XoHI0xZJwLl8uCUjp994WW0b4dT71G2cUvavn7CmdAphUICV92o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376195; c=relaxed/simple;
	bh=nSUTtW7W3uVu6B4nU911N4Xf4JPfuRfgtoDUyJidACk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJpmPX3wIhCfS5WykYCJc+CbwySMuVB1dVxR1B/Mzx1iz/gIzF3R/v1e2ue+mnMblGsCOT4Vablbo6A39ogo7Abd8KIB4FsEGpHPgbJxWfkgmt4Qy3pIXssjl7y7s51ptxOh/1XriUl2Zbiy+JiXNhaWMJCL+qt434Y3U3ORH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=zQNJPPra; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1706376188; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Oc8x+3fKbXxTX1gTypBGckToinAKA4gjm5G1BrV9wJSD78vZf98CTkksggl09LZvbRacXaS085TzjAWEA9/zIpbTeZ0zHK8Z0AOojFYZKCHhOJUJJlBky1JuoUzp4cAw9emz9H+KUgWe5Q29o7cfZXAeJEm5nBhCsvFuRN+sSM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706376188; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YULYF2qWSm5w8MjN71TNrGtiU1ZfqFBbzCJSsRbJmQ4=; 
	b=FJ3qHaJ0Fx1Oz7rf4fFKOYQSeTedIBQGt1VsigZUu7LnOMBAZPsVldqYPywg5xafhJrJAzTfajaIe9G+grlgcU2iAX9krDsuA8pKv4wtNpE2MREqwCB8wVZflmNu6CyXQ8+KWWPMP9mGEOUYK+edf+Lm60ISHvfR9c0A03mn+5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706376188;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YULYF2qWSm5w8MjN71TNrGtiU1ZfqFBbzCJSsRbJmQ4=;
	b=zQNJPPrayCfd8G21/nbfE/bFM2MZCkWP0AYQiblaip5k6LSqUAbnGQ8RMRDIdam+
	CTidq4Svf8N3b2ozeSIAWpopyY6JnAQsgtupC62AzwhzimDAicJNTR4AozQKuMiLdbx
	8LYxSh1zxjOWSXwUYGHT2iRILsA342bPLy6EANG0=
Received: from tb.lan (182.118.239.249 [182.118.239.249]) by mx.zohomail.com
	with SMTPS id 170637618610421.554837416501073; Sat, 27 Jan 2024 09:23:06 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/4] ARM: dts: qcom: msm8974: Add Samsung Galaxy S5 China support
Date: Sun, 28 Jan 2024 01:21:49 +0800
Message-ID: <20240127172155.63624-1-i@rong.moe>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Samsung Galaxy S5 has many variants. Currently, the only supported one
is klte. Samsung Galaxy S5 China (kltechn) is the China edition of
klte, and it can mostly work with the klte DTB, with only LEDs and WiFi
missing.

This patchset splits out the common part of klte DTS into klte-common
DTSI, and adds DTS for kltechn by fixing up the GPIO pins for the LEDs
and GPIO expander connected by the WiFi module. A "brcm,board-type"
property is added into the wifi@1 node of the common DTSI to allow all
klte* variants to load the same NVRAM file.

Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Split out the common part of klte DTS into klte-common DTSI.
- Fix dt-binding to make it consistent with kltechn compatible.
- Link to v1: https://lore.kernel.org/r/20240121154010.168440-1-i@rong.moe/

---
Rong Zhang (4):
  ARM: dts: qcom: msm8974: Split out common part of samsung-klte
  ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
  dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
  ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 .../qcom-msm8974pro-samsung-klte-common.dtsi  | 818 ++++++++++++++++++
 .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 813 +----------------
 .../qcom/qcom-msm8974pro-samsung-kltechn.dts  |  16 +
 5 files changed, 848 insertions(+), 807 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts


base-commit: 3a5879d495b226d0404098e3564462d5f1daa33b
-- 
2.43.0


