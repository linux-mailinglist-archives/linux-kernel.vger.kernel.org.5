Return-Path: <linux-kernel+bounces-81336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E740867467
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB91B2852A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088516027B;
	Mon, 26 Feb 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI3t4JJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0E60271;
	Mon, 26 Feb 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949273; cv=none; b=mIhvs65bZT0IDxQ7YDjYiHTGeHe+MNuNE65iWJVVc2JdeXHRgiPM5QScgiCDgwknsnjkKluMlUaHCFdrVKyJ1PIjIbLIubmbGfmuSTIkpuUyWQLNfwnwbhh+Ddi1JJzzPfPbVWTbmOYwaP7092F/h1kINDmoKOSP+0GPrb4RIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949273; c=relaxed/simple;
	bh=yhNQ8J3ezya7MzsJi4oxXaVl6ki5AxSw4uGOVzBJvnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQqR4LMpov3OcybmoQotpCOBdiygZn8P3MSWx5Ulm5i8eV9ycytyDMSARSkwu121k0C9vGwk2JIyaneCO05d0DFNnVWcSEYbm+WOMog94Edb0CucXOSB5ZvedK0ipWWfGWJblN6MzeTajfLZMYnqz2p/aLqFJFAFE/yaW+OOBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI3t4JJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA94FC433F1;
	Mon, 26 Feb 2024 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949272;
	bh=yhNQ8J3ezya7MzsJi4oxXaVl6ki5AxSw4uGOVzBJvnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LI3t4JJzX4NkiH5Mygn0RUawrLduN2S/Kx06qHbK45Vu4TD5W7Y/1JodeZnDUbRPy
	 eit1Lpgfpgj7rQTxUOsmCQNCgpBttNWobQdR+QUBBwGhUe+HmvHmItnpsovn3uCG6E
	 i8KTV9iu0Hve3bzpScOEkaIWnNCNxOhAUOk/akAMobFrutk2+PaEZkZy52u8/114AR
	 Qpu8Os25/MJcEt8sZoIOzszUbert+wP8Lt6zkOsZXvPk2PD7tMZYB6AlYdFyqH8+lq
	 oM3m82QSkPAQbDs+f+4P16dcTz67gga9/lXUb7BuG9/20/MvbD1WAiwW3DvT89ALFo
	 vnN3gwthQ/hog==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 26 Feb 2024 14:03:10 +0200
Subject: [PATCH v6 4/4] arm64: dts: ti: k3-am62a: Disable USB LPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-4-acf77fff4344@kernel.org>
References: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
In-Reply-To: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=yhNQ8J3ezya7MzsJi4oxXaVl6ki5AxSw4uGOVzBJvnE=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3H8GlZuvs1LgXW2hWF11aIrdETFf5xUjB0qFP
 WK4Tx3KxN+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdx/BgAKCRDSWmvTvnYw
 k3k2EACme9ce01lZ/4fRM5/UQEahEtSPvQwmjFPD/8hiesgzz+rjM8ndty1vc/7Juu8ekFB4GWH
 7gt1vzzhAOqsWwPUIO3dMUtGFwrTd5tAbZXikN8Zw+Mg0U5xsBDngTA8WHw/ixAsvf4tbsHum5/
 rjZcX6xzdOsVC7v7lrs3LyEY4A0DLU+3KCeRMjFc+PLehnHWV/mhTjgI7IfNw7SMZSdB3x+NOf5
 KurQxbSKOJyVNPqp8mMEeMQF+HIBF+8XToleMSYAyfKyC2TiliyEjOxfEkPHoQZN3anAzTCLYLZ
 Lfo6OZNHGz/PKPGMNcP6w1YpFpE0ms6hXNrKnu/elkhilTJQ89eA6Ynw5/XOM7eTVeFwcsIgDCa
 UTKGybEzf310tpOKMzZExM19PBH0UQKv+og17VxUMBBIirAYLhF9VWVrRhK6Zmzs7rAe+Rsx0Xe
 fZrSeeR7FG92cJH/ViN/aYJMm1qetJqEPlMjbju7caG99P5/4j3qz89b2zZG4cgORDPE48TyDbQ
 qzcfvbnQx9qcXwhvodLQUwK0PJrSpOE83UYpP80LPsho7Wcm2XpbGkPPq4HQRsxbaC2fQ1vZpsW
 Q51LWOmOjb3lUX14EuR8SbcGafdBWnLjzRQ6otHv9k5WRkl/y4EXReCBf8iSS4S6SMXHiw28sgY
 DOB9/PbpUNQwd+Q==
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


