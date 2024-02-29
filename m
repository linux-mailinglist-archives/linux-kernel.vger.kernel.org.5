Return-Path: <linux-kernel+bounces-87376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228786D395
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228241F25F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0A13D316;
	Thu, 29 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JyRjACOt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E539144033;
	Thu, 29 Feb 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235903; cv=none; b=nDeN1jZJyshkgypSE3oxKor5nqlfFAMztUlUrN/XSFbGEU99w5JbqpF6SwUK0+Ok33TJ5gaSu9qDraTeMbIn3QCYoE2rvK/q/Pv21uoOpB3P+308gOU+hwzZE5bMDlJu0g/FMgkEoubhKFdgDXJoYu+uuD8+kdC1vVl3/UjZdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235903; c=relaxed/simple;
	bh=SG+BNB9V12ilA2yy6/wOnUl0q+5MszvwNnI3Q2lsT4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWIBWTYwdXXNSpOrHL4/6UfP4osWcJYfl9KClrW9hHkP5qfYgF1S64sGAE/pRfGEY+NtzU3OWgXDR9EsOEU3pw2eYOB73ZM0YU3G3Yp+5e0toHQ3q2kE2Tkx9i+FspECGeGjUDJokeROhQwqO0Vp9SQgt+SSZpT7dXnr6aYTg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JyRjACOt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709235900;
	bh=SG+BNB9V12ilA2yy6/wOnUl0q+5MszvwNnI3Q2lsT4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JyRjACOtVwRIDyFZBlm2b3Sl2LfyksB2Ms9fxLyNNItBrhnxr34d180RyVl6uUdfP
	 MhUQEdIH8Cg/gACRmnYYCkMPfc73kArD+znNzA0eG4+FpwxvapbgBJS9uPdy7xGrPk
	 u0YCMYSSUk9ymTM2pID6BI+mVpkTKowhhbzaiR//U2xl4Bu9uxErv734g+ABfwo/nd
	 X0PCPJ2m30eahQCpLxtRqqgzpjWZ/5iUSFSVXvQ8VKisJ6OlsKiTi9MUdmq5waCJ7/
	 I8aO8mGRrY64EuxqlGIzROi8GqdcN1bLw/qp0yT0tOBjsb1D0hasoy7ak6FPL+Jlcf
	 XIWu9Ak9T3Avw==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F1BF37820E2;
	Thu, 29 Feb 2024 19:44:57 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 14:44:31 -0500
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to mutex1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-gce-client-reg-add-missing-mt8192-95-v1-4-b12c233a8a33@collabora.com>
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

Add the missing mediatek,gce-client-reg property to the mutex1 node to
allow it to use the GCE. This prevents the "can't parse gce-client-reg
property" error from being printed and should result in better
performance.

Fixes: 92d2c23dc269 ("arm64: dts: mt8195: add display node for vdosys1")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index fd074103979c..5d8b68f86ce4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3335,6 +3335,7 @@ mutex1: mutex@1c101000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			clocks = <&vdosys1 CLK_VDO1_DISP_MUTEX>;
 			clock-names = "vdo1_mutex";
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x1000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_VDO1_STREAM_DONE_ENG_0>;
 		};
 

-- 
2.44.0


