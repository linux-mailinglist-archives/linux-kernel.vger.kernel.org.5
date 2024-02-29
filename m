Return-Path: <linux-kernel+bounces-87374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20986D391
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF20B23043
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD98142901;
	Thu, 29 Feb 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u9Z5W72H"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25491428E0;
	Thu, 29 Feb 2024 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235897; cv=none; b=gRZxp/86BWBzKmpKxSALGHWm6SLz05fXuiGQtwZ4CMx2k6/ya11bkVw9PP7nSFjS6/JlcN+uZpdwVCYMG3BU42rDrDBM3lvZ4fUX1z6QqfMotS+ReDFTTuZ6HMkxWLMAP8v4o2WqP+UzJaqdw6h7S8qsmthqoV/+OMIPsz8izso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235897; c=relaxed/simple;
	bh=EyvPm0SXhcvriUDncncMFebQg0lQMcMsL/UTspQPx/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=il3lmZj45Vm66MCgfwEmNC5THTzFJN5tnpVR07ofqQxBXIaymwFESJ9rBUHm90k8SXCsZarJmctbrtZRJRPKy7nbp73SVPx5vNodHB2FhtLvN2ASXHLOSinjcX0fuUS7tJxzr86MXhXo7H+yfyd32Fv/YDxITfoM1tjDC7rOcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=u9Z5W72H; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709235893;
	bh=EyvPm0SXhcvriUDncncMFebQg0lQMcMsL/UTspQPx/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u9Z5W72Hfbqdc4elUBeUYU8z3Q7CvyoJ0tkniAgRzd2Jyc6YZmaGYlrObvcR9I8Fz
	 lGfz5GHesiPMNEgb1TyiEoFhT8b37z2dN7GtAPddYLDb/yYsaB1wxwOrwfO1fCvWyH
	 0O8znoqy3Zu+gNkir+fMos8bu5lsPnti4RzTP+eEcfD5LrxRbs4N+e9HoYT247+Qd2
	 1+DaK8iZxDAeU93QVhXCUwidCQaJEPTqCpZe1q5JV5X/nTD02QEwQYAGYDhjC1O/zy
	 5+CivC5a6kc70UmJsMMqzaFDEAWNdOWLrFvv7gS6I7W8w21COc2RwYcbI0TP8v9Coj
	 6UjdJXAtpZd9Q==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9554237820EE;
	Thu, 29 Feb 2024 19:44:51 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 14:44:29 -0500
Subject: [PATCH 2/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to vpp/vdosys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-gce-client-reg-add-missing-mt8192-95-v1-2-b12c233a8a33@collabora.com>
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
In-Reply-To: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, 
 Tinghan Shen <tinghan.shen@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Add the missing mediatek,gce-client-reg property to the vppsys and
vdosys nodes to allow them to use the GCE. This prevents the "can't
parse gce-client-reg property" error from being printed and should
result in better performance.

Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index ea6dc220e1cc..f2912e1a0e49 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2028,6 +2028,7 @@ vppsys0: syscon@14000000 {
 			compatible = "mediatek,mt8195-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0 0x1000>;
 		};
 
 		dma-controller@14001000 {
@@ -2251,6 +2252,7 @@ vppsys1: syscon@14f00000 {
 			compatible = "mediatek,mt8195-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0 0x1000>;
 		};
 
 		mutex@14f01000 {
@@ -3080,6 +3082,7 @@ vdosys0: syscon@1c01a000 {
 			reg = <0 0x1c01a000 0 0x1000>;
 			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xa000 0x1000>;
 		};
 
 

-- 
2.44.0


