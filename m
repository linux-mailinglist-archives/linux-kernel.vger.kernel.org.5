Return-Path: <linux-kernel+bounces-57002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7284D29F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409781C245F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38346126F1E;
	Wed,  7 Feb 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vIkO2YUq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726A86AFF;
	Wed,  7 Feb 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336548; cv=none; b=sZARsVrw7zE8dhGvV8/YJ0Atz5/p6feMNIkUvG3eiBuVfTW2qSyHPLof1upO9HTsZxPWl9Oo+FXqx/jcWVMAui5V8XYxfXBmfwK1OQrBTOLhIKrwo6udtHdA/8K9wHVpSFREm8z/W3YOP0EVqrIjq0UhI3pTojqpuuNI3G5sp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336548; c=relaxed/simple;
	bh=5PzECJm0CObzRT3GachtnhewUzsyt5UC6ouVCFeWJAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LH1FTV6Owzv4TvQEWZSZDdPyek773wDprAdpl3GGjkYmt4AXI9KXGkWZEUh2ckX6ZaHvLrxExnZde7ozBSvv92H+R0Lo6xHtmxxVgJf/KnZ3W2AVBpj9sez8k20ZSXlJ/VdLJhdRFv7cncOyFFiivNvB0TsQo7XGgmY7YQ8alXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vIkO2YUq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707336544;
	bh=5PzECJm0CObzRT3GachtnhewUzsyt5UC6ouVCFeWJAo=;
	h=From:Date:Subject:To:Cc:From;
	b=vIkO2YUqLigxb5vwOJzXDLfScVqxvRhguAs0B1dAJ7rLb/rcNbiNjvTs8Tv1wKaaE
	 h5VAlF++5pN6jSSQ/e4ga1ZKv4Vt2Iz0wGu8t5lpCMqvaqKbWWMbR7KF7TJvMNcpil
	 uCo7h0rT93UulZKHU/JjTvPOCd+1Mmj/aBO9w0JX7qpzWIZzy2rBdaZm6P8KwK58Mb
	 AzAX8c4FolpSu/8zj9PpX5/gUmibOwUrR/ICsgwR3juNNkdz0bv0e0+1BHyuvkBFz1
	 qkRhXxwJHSp2wk2xOv6MEN5Uk7wstoiwrYA+f9DGAMxGtwEuH2QaDF+wSPBQ6DBYRd
	 4SU3s4o3tu/WA==
Received: from [192.168.1.249] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4FA9937811CF;
	Wed,  7 Feb 2024 20:09:02 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 07 Feb 2024 15:08:42 -0500
Subject: [PATCH RESEND] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC
 base detection node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240207-mt8192-asurada-cbas-remove-v1-1-04cb65951975@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEnjw2UC/zXNMQ+CMBCG4b9ibvZIW0TAyUFWBx2Nw1EOaQKUX
 JGYEP67jYnj+w3Pt0JgcRzgtFtBeHHB+TGG3u/AdjS+GF0TG4wyB2VUjsNc6NIghbdQQ2hrCig
 8+IXRUsa6sUVZZwQRmIRb9/nhD7hV9+p6gWfcW/EDzp0w/elUK53qTOWmTPJMHVWJGsdWaIon/
 mx931PthRLrB9i2L+jnpzu2AAAA
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

The commit adding the ChromeOS EC to the Asurada Devicetree mistakenly
added a base detection node. While tablet mode detection is supported by
CrosEC and used by Hayato, it is done through the cros-ec-keyb driver.
The base detection node, which is handled by the hid-google-hammer
driver, also provides tablet mode detection but by checking base
attachment status on the CrosEC, which is not supported for Asurada.

Hence, remove the unused CrosEC base detection node for Asurada.

Fixes: eb188a2aaa82 ("arm64: dts: mediatek: asurada: Add ChromeOS EC")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 6867c4ad04a9..9b738f6a5d21 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1337,10 +1337,6 @@ cros_ec: ec@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		base_detection: cbas {
-			compatible = "google,cros-cbas";
-		};
-
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;

---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240207-mt8192-asurada-cbas-remove-ca5e1dc89b5a

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


