Return-Path: <linux-kernel+bounces-41339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBA83EF0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531DEB2288B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398012D05D;
	Sat, 27 Jan 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="aRfIjO1b"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5092D605;
	Sat, 27 Jan 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376221; cv=pass; b=L6zk9qvccWc2c5M74Om1RaUwZn1uPn1n9QLUz+LuvDFXmUDGckwY8oe2vguHBeymCkMRK8/rd33bq3RBVr2xe5PvFnWSSwm8E/JuArW3Sf1QaV6lgeyCkFfpcfHX8EI6y35tYq46YaIjZeJ9ky4MxpOo6788P+seW40SCRAME0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376221; c=relaxed/simple;
	bh=8snw/S9bFuqeaPU/SR/M26e9RHX4wd3kkLrnrLkpZ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1pH1SSSEaUpWzu8ptVg2SPyv/fu4V9eBuOjTQWSslxcZAabDNAXSetUfxm5mX/Wrun8Nm4HE3LY+RFfIPzK86hIEN2eNfeHa55iW64rKI0yusSMZz8qUPt0tKbmxDZeIeV6XFvxNthLDM9IuTV8e6uykWv4yHPaSmrLYI3/Yyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=aRfIjO1b; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1706376216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cNejvV5U1TlyhM92+E9U4OXpdbQrEp5vGOaOp7+wSw2vmRo6GlpRq0lCG48VNP/j5AvCHDuJ9/5H5+WtruFgP2jyLr3bNaiKe8IZhlKRD+ny16M16aJZmCK/qr8bAofuDymkX0ciiU0hrgjL9PLLxv72AT109LmTYWVR+Jb+XAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706376216; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pauhXQflxiHTx3+ep5HdmtF4d2AedYZI1LAzRZrEGCM=; 
	b=fe2uBCRonxSTZbo88YOmWPATHYEVC/InjlTCr9keZracZJ7Uy+tN5laIey770k7o6IK1QLr8EPZSOZvLX9YRRmoGXP9Sv2gRCkcKK72H62yqQ4mwxDrKpMTCPiN1AOencAo0Yv0v26XD+K1uyqLtyUX3gefPoUo0/Kh5A/YLeGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706376216;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pauhXQflxiHTx3+ep5HdmtF4d2AedYZI1LAzRZrEGCM=;
	b=aRfIjO1boPnjL5ruaQmhOZgEXy6R756KDv7hwAYnT2vl8VbYGQ3Z6irjEfQCcILq
	MGwYXO/cvR6eH9AnfXuwBFB/4bYqvbUbQxSzz/QmL70/LoV0EfkPyKY74cPVEwl9+YI
	n82XH9OegE/fliJ+TnOoUuR2BWd9vOABqaTUfDYI=
Received: from tb.lan (182.118.239.249 [182.118.239.249]) by mx.zohomail.com
	with SMTPS id 1706376214914948.8399572552208; Sat, 27 Jan 2024 09:23:34 -0800 (PST)
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
Subject: [PATCH v2 2/4] ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
Date: Sun, 28 Jan 2024 01:21:51 +0800
Message-ID: <20240127172155.63624-3-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127172155.63624-1-i@rong.moe>
References: <20240127172155.63624-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

klte* variants have little difference in the WiFi part. Without
"brcm,board-type", variant-specific NVRAM file will be probed (e.g.,
klte probes samsung,klte). Pin it to "samsung,klte" to allow klte* to
load the same NVRAM file as klte.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
index 11e35b34ebd6..b5443fd5b425 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-common.dtsi
@@ -661,6 +661,12 @@ wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 
+		/*
+		 * Allow all klte* variants to load the same NVRAM file,
+		 * as they have little difference in the WiFi part.
+		 */
+		brcm,board-type = "samsung,klte";
+
 		interrupt-parent = <&tlmm>;
 		interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
-- 
2.43.0


