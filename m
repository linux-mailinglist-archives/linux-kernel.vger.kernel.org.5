Return-Path: <linux-kernel+bounces-142621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA28A2DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326B7B21FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8A56440;
	Fri, 12 Apr 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaiTwZtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3D57306;
	Fri, 12 Apr 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923336; cv=none; b=BdGbGCIgpYM0rVhFddvJzFxIokEResCwv8LyifqiIirh0sKrLV43yaIIzknMMooW63f1FNhbtqAEuzsroflWgQiAIv44gY+RZbmpu6PkPR9hH+3X3xbHiDGCsKVRyfnbRHdh3U7IKvwrNRGFHoeI/N4/EZeT9sqeohZkipKIiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923336; c=relaxed/simple;
	bh=3y8NvuBpN3GpgOBuBXKVR4zS66qIFVgEMZeU4j3UftM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9BPtN5IycPm1wuKXMLt/MuUfRcPMnP5kwm/5iKV4ZMRsPHjsQGbsBmGwBUVFS8NyFCa+avIBsrboiWm/X9Zew4gQlVNvPN+EC3GOq6ozDHf11KhmLkeY11AB/sIdHqaw62v0OI8MxTxXQsivSncAUnEVZ+2hiJ+QMT6lhfXMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaiTwZtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C99FC113CD;
	Fri, 12 Apr 2024 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712923336;
	bh=3y8NvuBpN3GpgOBuBXKVR4zS66qIFVgEMZeU4j3UftM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PaiTwZtq9AlP3mLK3Jr6OGT4piCSor4fdGvafBJo80qXDOHv2BZGITA5XolZ2Xp9b
	 q0TTnz6hB3tn9ChJzZVtYOjcDXQHkerYJLXgt+C7ilufqdak4pHNyJAlXP1vvlug2C
	 jvnZ2eGvoEfEHzxSzbrc/FVpq7LqD9CntHjrj3b11JeRtQi5sS6sl5qan0+Im5Q1vO
	 9taklG3Zuvc1jh9AKJX/EXs48jOtgU5eLTVrVMpcaId6UivZrS+UPiBmswzGP8KLtH
	 s8NB//xcl1XQvzDgrFNgQ+VcSYdt8WsvOuX/VOMQSiWBEUVVtofysCeKcNVrvsIWD+
	 1+Sgl/YRF24sA==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 12 Apr 2024 15:02:00 +0300
Subject: [PATCH v7 3/3] arm64: dts: ti: k3-am62a: Disable USB LPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-for-v6-10-am62-usb-typec-dt-v7-3-93b827adf97e@kernel.org>
References: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
In-Reply-To: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=3y8NvuBpN3GpgOBuBXKVR4zS66qIFVgEMZeU4j3UftM=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmGSK6md56hUKdg+S6qCjHbbACODTJaVIUfD96o
 y34Kc4rE/GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZhkiugAKCRDSWmvTvnYw
 k7dBEACxOUAiK+miJJPF39Z+KYGn7jWgNCb4uU9cEYH61MYdsfRpGQqAt6lCo+SdtciQ5j833oX
 Q/mXBbQq8j0/itQHzyJRwQRMRv5SDjeeKjYUMQiP2PePUPo1/lWHBp9QQFgpxHkUyGjVM9pzgp6
 nejEYc8YcrH9AwRpTCuTyIg8RoTUVNoz1IDaM+gH2gozlzwsPiEI9P1QHwd8jIlvX+xg4vFxEt7
 +fOpKcRG/ss59ZLK4P7jQY4B5F5RUZT+9QcKbDe750eT6W+By+rGNcm6Kgc3opyqtKm77tpB9/t
 I+aSJXLLGw+W9sd1s4uxpQxOSPblBIe241MiH/BGCI6YE+TP+Vp3ADz9BvXYI+CzIJE3WNqzLJo
 ofMiqBNDi/ZeJFeyHXoDk4INvTiW/kZgtO/UxQO2DmPQv7zGb9poziiJ5P00W7jTYX6d86LPZCX
 +xU5Jf+7133QvACKcsZKfHRYCr/8RADxm7HnJuoajv4IdIyHydMrGcksIc6UM53c9hu+S6+LUc1
 lOUtZLYrnnZXyPB4zVgaRqH+LyMRhu9BABs0LEa+70l1xBrAwccrE8z3p34Xqnuax4AUYUDgslN
 /lSWERiWZoPywtL1v6gTpgsdunoUO4RlOK/8W0gyKHb+MpJEdW4cy5wll8MuDYbLTyzOfbec3se
 QLA1m0yEU2Kqjdw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

As per AM62A TRM [1] USB Link Power Management (LPM)
feature is not supported. Disable it else it may
cause enumeration failure on some devices.

> 4.9.2.1 USB2SS Unsupported Features
> The following features are not supported on this family of devices:
> ...
> - USB 2.0 ECN: Link Power Management (LPM)
> ...

[1] - https://www.ti.com/lit/pdf/spruj16

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v7 - Rebased to v6.9-rc1
v6 - Rebased on next-20240226
v5 - new patch
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index a158df0d0ba6..adaf578280f9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -621,6 +621,8 @@ usb0: usb@31000000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -644,6 +646,8 @@ usb1: usb@31100000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 

-- 
2.34.1


