Return-Path: <linux-kernel+bounces-63391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB7852EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13FEB2783B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FF374C1;
	Tue, 13 Feb 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="sLUY8/ud"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009A36AFD;
	Tue, 13 Feb 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822128; cv=pass; b=JQ4PbzjCZ6LA2Sp6uRqe8rLenQsBnIp6lwik6rl5EC9nZXEJs3g91xFtq9bivPZoL2X0Pn5XkotgWpk3Lk24CmtJKNFRjIuxGuR5Z/5y9YbtI7IifLjxDUewKlkmpIKo4j/MAuQWCdWQHe6X3GSJ6VXzIk6YcKrzw43gXGfPvHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822128; c=relaxed/simple;
	bh=8snw/S9bFuqeaPU/SR/M26e9RHX4wd3kkLrnrLkpZ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQwjLUA4S9G+9Mogd6s97HR7IMwsMXJs0L77bkoKWQjZrGLSq7Z0Wp0xiK3nUiDdEIuNuX82cxh7xFRH5gsK6iHjxn+1ZyW1wygX7lRzzcceOf3CXXyfIeTJ4gduQ2KihKQXtnTmzJBh8RU2W95TZNwhpeLZsE7sfGKBYSVuzP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=sLUY8/ud; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1707822120; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YZMpTHWMBBTIfEzXCAeNiiMxDTqoknzKi0U3h5MPF18l2j6E/8TVi7e2Bdv/Y42Cphg96JggwYGUXs1I7HFnMA9OnVxoS0++SsxNi4ej3MhKJwQkOdA73c3PL3ePTnaLPSaCN4SryA7hpx6+Wq5/eGqfaMFAmytRNEXyzOeeUJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707822120; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pauhXQflxiHTx3+ep5HdmtF4d2AedYZI1LAzRZrEGCM=; 
	b=D+MV36OxvD/QRrYuXEcdG3FaFamRXV26CrEIRdPYWvUi+IOfbKYqUaHnxib1ChDUE/x4EWoaLfYNRBv5O2LYqIP/1wB224JbSoQ05bDBqYAsFXula4jvsSwga18uGxRQdKofphOfEVPX3OjAPKnJNhiCfEzxIOw3ER/N6+eSEa8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707822120;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pauhXQflxiHTx3+ep5HdmtF4d2AedYZI1LAzRZrEGCM=;
	b=sLUY8/udeY1f4P3pmePAoRWwsLnaP7z9+i444E0gcTEktohb9bl4iIZl2DOa1D0D
	9nx6vmJjvHxzS9unL/6Pm3llpr6GzVtZdawVPt7SgZ9hTYqA76zo5//u2J0hesJLq9Q
	LK/d91moDdOOkfW/GNuncJEeHYIAxy3vncBt++/A=
Received: from localhost.localdomain (163.142.242.182 [163.142.242.182]) by mx.zohomail.com
	with SMTPS id 1707822119295716.8504126918681; Tue, 13 Feb 2024 03:01:59 -0800 (PST)
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
Subject: [PATCH v3 2/4] ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
Date: Tue, 13 Feb 2024 18:58:37 +0800
Message-ID: <20240213110137.122737-3-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213110137.122737-1-i@rong.moe>
References: <20240213110137.122737-1-i@rong.moe>
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


