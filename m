Return-Path: <linux-kernel+bounces-87375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7229286D393
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E9E284BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10C13C9F4;
	Thu, 29 Feb 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dp/5TFnP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0D142905;
	Thu, 29 Feb 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235900; cv=none; b=k208jKDlQrZNkf3VPChPJU8dOTgHLIULzq8GoeSAs8XgcjgNAehqsQDqxxSSrXhYLBd9WpZ12V6zWeYMdeey48L8wAFO1X4S/U5ZrVancGx0aBqkyrcReCZQN5AivpSCyfeCOp/jzov/CalKhC1ZV8uuL31dwQIGef9LiWs76/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235900; c=relaxed/simple;
	bh=JoI5PzB7Uwtf6ghTh18wTJK5kDEzfk5MGVMmMtia5Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4jCzIY5XhTHSOI4rcWhGL5Z2yqUIHaUSal+CtVduHr8wWd/VCi5eKu9ZhZAED4LrG8S2pVrV06B4tJuGjJZf0gY21OnTfmlhKJKhTouuhC6Q0yiTqA832OzGvOdONadcUdXlbQiQjbyj1+qFwgPEcZ4kvv85ntxWgSNmnLjzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dp/5TFnP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709235897;
	bh=JoI5PzB7Uwtf6ghTh18wTJK5kDEzfk5MGVMmMtia5Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dp/5TFnP7UOdtnGJW8/TQMfvjgLPg4yy6tySuLfjJIMC6wjw3cM/XUAsD8YK1Slvw
	 MOTLIUCao5kr0+nr7QllK64+yFb4pxqHK4LaKNypcXxD24RzfPV910iDKcy2rTJM48
	 vz5frg+YsAlllNsQPvSkQb6HKiVhRleyt/C0Qq/Z10Y+WVwgYi1ziTcZwXX9JynE3i
	 NjU40S5hWB7i+T/RcwJ6N772gEH4pnUSKITAAsdBFqi3qm2P/QKQjOY0PdjliP6zUk
	 zlKB8Konnv9eC5adgQi54Ez/x8nj1Tfe8HJJlWbPLO9i/jUeMuk9U3FGuLYwfCJddS
	 fmHyXg5rK8xBw==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 42EE737820ED;
	Thu, 29 Feb 2024 19:44:54 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 14:44:30 -0500
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-gce-client-reg-add-missing-mt8192-95-v1-3-b12c233a8a33@collabora.com>
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

Add the missing mediatek,gce-client-reg property to the mutex node to
allow it to use the GCE. This prevents the "can't parse gce-client-reg
property" error from being printed and should result in better
performance.

Fixes: b852ee68fd72 ("arm64: dts: mt8195: Add display node for vdosys0")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index f2912e1a0e49..fd074103979c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3264,6 +3264,7 @@ mutex: mutex@1c016000 {
 			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0x6000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
 		};
 

-- 
2.44.0


