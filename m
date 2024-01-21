Return-Path: <linux-kernel+bounces-32097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDAF83566B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07A7B2192E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1293376F4;
	Sun, 21 Jan 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="1yQxYeHB"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9C2AF08;
	Sun, 21 Jan 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851657; cv=pass; b=N7FfEBSElyBJPm0pEEaZyKEcUW8f8EZWCzeCDH3vZ08lxj7fI3EW4+8flKl8qGQCv+4JDIW37ryIpoE7Yvx0hFs6XrRrugtadk/PctKeJUTJXngifL1R8BklpI2tH9v3isue+yF/XgbuLEM/yrXlRKd6b7wxSo07ic9/cmgzjAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851657; c=relaxed/simple;
	bh=mcendhX41sLs3hGLvmwWKBRU/OfkcRs07IVpU5ByxiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozee5k0bHuGFRoJQO1CMoAjWPP54Oi2TrId6POWATt1goeYO+tKyLOo7lkgRzWZTLl994IkhOz/h4HRgT7SweaDvj9LbYScmpG7hszoqXP3EWoKRoANXRTtO8Hb6RzaWU6KYT09ukpkGpV4tVSqIgjMtNMAzgIghZfaiyZLUvNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=1yQxYeHB; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705851651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mICfz4Sy6jTWD8NaaOpMpzZhluNbfajlV68oCHh+mRsYfrbHvXHTPM6ckzXmh5ZNRQjA1I0cnYuFzut4mS3q+CCq0vB6QrFxpg4Q70d9MeNJHuSjmO1V4iC1rD3LuSVJyzs1s4NbNLh/Zi09qu8C20/pffPh9X/qlJT5XD+tG9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705851651; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FaXSxE+DeKQ1uc12aiGNQ3/0/j+vJ58Dysn2cELGty0=; 
	b=auAtIJBzvcGlNt1ry9eybAOhWczJB+8Yccqjr60z+MEHLi8mohPRUORBZHgl4DUahKrjGOpeS4Wa6aThHcdcMFCZDSPr4yQP7iJlu0Dk9C4axW7KbcCCL5HGPGM2QtdL0SSKBk3NyDIrCsw+yCxMA0m9kpibrhdYlItQVy5KVp8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705851651;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FaXSxE+DeKQ1uc12aiGNQ3/0/j+vJ58Dysn2cELGty0=;
	b=1yQxYeHBvS4YwF4I9Jkz1pfbqJFXMqXcttGDzr5CkBtQlZizdSgezfy8Ma06bPhd
	kAm/qpYJeoSDVZf8jAp1YPvJ3wn4ssweCenGNkNZvwwnI1R53kBOlCpDhoCA1Sl+T6v
	/txWSJsjwc7O9Nj98EQ0PcFa+wDQ7uwszN7fjAWs=
Received: from tb.lan (182.118.232.129 [182.118.232.129]) by mx.zohomail.com
	with SMTPS id 1705851648585954.8646897778475; Sun, 21 Jan 2024 07:40:48 -0800 (PST)
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
Subject: [PATCH 0/4] ARM: dts: qcom: msm8974: Add Samsung Galaxy S5 China support
Date: Sun, 21 Jan 2024 23:39:55 +0800
Message-ID: <20240121154010.168440-1-i@rong.moe>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Samsung Galaxy S5 has some variants, currently, the only supported one
is klte. Samsung Galaxy S5 China (kltechn) is the China edition of
klte, and it has minor difference compared to klte. It can mostly work
with klte device tree, with only LEDs and WiFi not working.

This patchset adds support for kltechn by fixing up the GPIO pins for
the /i2c-gpio-led node (a corresponding label, "i2c_led_gpio", is also
added), and adding the brcm,board-type property in the wifi@1 node of
the klte device tree to allow loading the same firmware on all klte*
variants.

Rong Zhang (4):
  ARM: dts: qcom: msm8974-samsung-klte: Add label on /i2c-gpio-led
  ARM: dts: qcom: msm8974-samsung-klte: Pin brcm,board-type in wifi
  dt-bindings: arm: qcom: add Samsung Galaxy S5 China (kltechn)
  ARM: dts: qcom: msm8974: Add device tree for Samsung Galaxy S5 China

 Documentation/devicetree/bindings/arm/qcom.yaml  |  1 +
 arch/arm/boot/dts/qcom/Makefile                  |  1 +
 .../dts/qcom/qcom-msm8974pro-samsung-klte.dts    |  8 +++++++-
 .../dts/qcom/qcom-msm8974pro-samsung-kltechn.dts | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts


base-commit: 7a396820222d6d4c02057f41658b162bdcdadd0e
-- 
2.43.0


