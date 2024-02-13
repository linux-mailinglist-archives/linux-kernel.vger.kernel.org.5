Return-Path: <linux-kernel+bounces-63389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE6852EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5301C20C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B62C840;
	Tue, 13 Feb 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="EAtzSn9r"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E511C687;
	Tue, 13 Feb 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822120; cv=pass; b=sT0RmKD64JNRRxLOulXpo2eg8dfLrxhNapwDJJ1MIBaUpPQewzkqGApeo/29VJa4sYkbyT1j5dVT9PlotVDSkUnI06P9HwBpLQ/aKziAaFQ2PcXUS/ndsm4oYunN5XYLfmo44JBfqbXjVlJIclJBH0CPZWd+NV8nAPg4H7D4VNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822120; c=relaxed/simple;
	bh=f4AEw6JtPd+YXQjqhXGB59pRO286WMZxRukNCFc/v/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGXKUeb6QbdZArKL1PPhABwfEYFP/cLpcc0dEvWBcfLbEQS51i5321xc7852rny3e+OObM6wqXeglGcFv44bvY+/x42vh6lZj/eTvFzLYX487ou8A7Ib5rtlhwpzHPNRGGXvCftpIl7IbVJbpHFKbwq8XbP6wQPS++54QsqJ/S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=EAtzSn9r; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1707822112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FXyuTRe9yCy7BfKVVddph7eJknXcyEe9JaKzXrQVWU91Y2oJMzi+fnqPLyzpbiGcZRPlMCXhMMA7V+GanidJnSJ1iDddXsDhawfYrVG3Pik8HcePXs8dgTFE7HNgk+rgWhmP27Nd1Mihct8M9hfc+hkjbHX8qIvDpQIZjyCCVHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707822112; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tKORHJW9ZJ+RKaYm7ZjJh+PgSp3vc2jvm+w5YVR/ZuA=; 
	b=FpNmfhJs8XXADoEOcluyGgHqOVB1jlV58S+TPErbrT1oBE4prTjiIu5kkNPoWDshXUq+loIMIQFn6HOEbHvpDgXlknVwOU7qqWjDPpY5HBWA1CS4eVCwg0vgWit2xr1Odxw5i7IO+7l8qKjP3cXXOc8dLc7koiQahcbD1YaYehk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707822112;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tKORHJW9ZJ+RKaYm7ZjJh+PgSp3vc2jvm+w5YVR/ZuA=;
	b=EAtzSn9rhpqmCUvJXJ9p/v9/S0L1J+vOTK4avcAmroHqZqRXNLpfTEcgP5Z0hinF
	eTx5J9kLuPeQM4nG/6MSnT5I+6GNItFqtXNVRcD4SyrULuNNkfvyxSEoNhTboatkzGF
	5EHPUS6+1MuJlc/CCSqKybu2mr88EgB0dpapn1qY=
Received: from localhost.localdomain (163.142.242.182 [163.142.242.182]) by mx.zohomail.com
	with SMTPS id 1707822111321938.4238314459632; Tue, 13 Feb 2024 03:01:51 -0800 (PST)
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
Subject: [PATCH v3 0/4] ARM: dts: qcom: msm8974: Add Samsung Galaxy S5 China support
Date: Tue, 13 Feb 2024 18:58:35 +0800
Message-ID: <20240213110137.122737-1-i@rong.moe>
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
Changes in v3:
- Regenerate the patchset with code move detection (-B -M -C).
- Fix "changes in v2" below to state why a tag was not added.
- Link to v2: https://lore.kernel.org/r/20240127172155.63624-1-i@rong.moe/

Changes in v2:
- Split out the common part of klte DTS into klte-common DTSI.
- Fix dt-binding to make it consistent with the compatible chain in
kltechn DTS. In other words, make kltechn a subvariant of klte.
  - [PATCH 3/4] in v1 had received "Acked-by: Krzysztof Kozlowski
  <krzysztof.kozlowski@linaro.org>" but this was not added in the v2
  patch due to the change.
- Link to v1: https://lore.kernel.org/r/20240121154010.168440-1-i@rong.moe/

Rong Zhang (4):
  ARM: dts: qcom: msm8974: Split out common part of samsung-klte
  ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
  dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
  ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm/boot/dts/qcom/Makefile               |   1 +
 ... qcom-msm8974pro-samsung-klte-common.dtsi} |  13 +-
 .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 833 +-----------------
 .../qcom/qcom-msm8974pro-samsung-kltechn.dts  |  16 +
 5 files changed, 47 insertions(+), 823 deletions(-)
 copy arch/arm/boot/dts/qcom/{qcom-msm8974pro-samsung-klte.dts => qcom-msm8974pro-samsung-klte-common.dtsi} (98%)
 rewrite arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts (99%)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts


base-commit: c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
-- 
2.43.0


