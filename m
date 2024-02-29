Return-Path: <linux-kernel+bounces-87373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3386D38F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2658286EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1C13F455;
	Thu, 29 Feb 2024 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FDr5PBv6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3F13C9FA;
	Thu, 29 Feb 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235894; cv=none; b=eWJPiS+F/tQ/mtGvpPVIkNg1bqXh+lmNDe1T6DQTJj8bvX8YPBNJHl2nYa2lJArbXh/93zjauJzd51fOMHOosov0ejZZ4HDXWH1Q1zjBft7G57nKiRR2sDCMA+3H4Tvav6dKDHJbYNLCsqMsZgT+k206sISDLgQSEcAV5I37hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235894; c=relaxed/simple;
	bh=F1D1XQqErUovgpFctyBZ7KqIwFh5WtFb7Zk4L6KVxzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqHH/j8r4SQ4gsusZGfRMhFxW63ZmwQ8njtSygWmCVgNE6z8+VWoqjO2bQoZVXvLrUSUFhqajn+QYI82ESJWew6OnN5I23YIq7hFdUfKUMoeQqe0ARqERr7lZt67cuxI1TG8D8xCnA2bp4JMTlWOli8oRMyvynMyHC8xMtB5HUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FDr5PBv6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709235891;
	bh=F1D1XQqErUovgpFctyBZ7KqIwFh5WtFb7Zk4L6KVxzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FDr5PBv6c3BVvZlQWA7aOyKl4J9EVE3XNcBKU+AUNuiB/nwb2E/jYcv+uxENeYIO2
	 mRlJUJE3m8QFZL4I+YEx9CTg6hlwozJDNJvPXzT8WDmCexsJkIeL6tgFMpdqADvMSi
	 YYv2/Rq+yiVJxcxVO+SJwOxh6rudQ+WiFXO+Ir4M+vQEr/BhFgd3R3bSWon48CJT3N
	 Jtb1V/7DogQu+TxsnggdteqFRYTEGzGEKHVFSBqdBtP3JThekf2BTEnBGd/uVOiizs
	 xq2vWk9kIklQGGtJN5VdBRGrbgtgZuq2yKpDJHkGT1VdUGVjAGyfL9mTuy2AEzK7m3
	 7zVHKalN73BQA==
Received: from [192.168.1.200] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25C8637820E2;
	Thu, 29 Feb 2024 19:44:49 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 29 Feb 2024 14:44:28 -0500
Subject: [PATCH 1/4] arm64: dts: mediatek: mt8192: Add missing
 gce-client-reg to mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240229-gce-client-reg-add-missing-mt8192-95-v1-1-b12c233a8a33@collabora.com>
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

Fixes: b4b75bac952b ("arm64: dts: mt8192: Add display nodes")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 05e401670bce..84cbdf6e9eb0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1464,6 +1464,7 @@ mutex: mutex@14001000 {
 			reg = <0 0x14001000 0 0x1000>;
 			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
 					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;

-- 
2.44.0


