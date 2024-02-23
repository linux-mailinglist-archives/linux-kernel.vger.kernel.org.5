Return-Path: <linux-kernel+bounces-78356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFA861256
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212E8283928
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E87E78A;
	Fri, 23 Feb 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akSHjSLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652747D411;
	Fri, 23 Feb 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693972; cv=none; b=Ap9FqCIdJkvDq94cqX5zzMWteYBjpwa9/TijWYo/mbHKvp/cekFE61txn6pJ4nr8eyRVMdm6iLGFImNv7QAv3w0yT36MhC9hIH758+FDkOGyQLdfvNs9H0hlIVmdbWQNIIdz1OzSi7nw5q3GFPwmHQrQgLzZ2qLrrYg/U6elGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693972; c=relaxed/simple;
	bh=2SIXe075Sw3ed8GxgqbY7C51dZQTx4Z+wCjZhCZu2Bo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tAHNBzuvQYoZVILJC68Bmer3TSTRM6xOMnVjHijsK0DvEDbKvcDkIwpcm7G6HkJwYeZICq2SS6wpLeT5Gc/kTKRcG+rfx1PV8cgEHUF8WRqeCcmdG778oz1uGDLO+kgwFmR5MJmxxgDbnOOSMYMon9HmRrN/0nsTakhVgKO5IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akSHjSLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85028C433F1;
	Fri, 23 Feb 2024 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693972;
	bh=2SIXe075Sw3ed8GxgqbY7C51dZQTx4Z+wCjZhCZu2Bo=;
	h=From:Subject:Date:To:Cc:From;
	b=akSHjSLEWJFZ9lW2TTL/znls0ISFCWhaXcDnccAfc09E9FcjOEIHEx2XobXW3gAev
	 mZhjekb45ccNvG92WwDPSP1PmfcvgoMq0c3j4gbiy2hlr56aSc3Vi5ayUkFj2g1nvI
	 X/RxDTZqPBlVZN/mpKzaBb3VzVcmTnoKLSnEhiPaY9JtX2CcihT7vy3OpxxCqpDuEO
	 YCQQmrziu26UbSTCc/dbJ8AY5mRQJeypaqF3H6yVhXMq6QtnbtKIjHzKnt0lxjKstE
	 2na0t5l+4k2WCvWmj8F6QoEOFTB2Epb/eRApPdmN3HEdu778R1vBontT8HPHyDYFRo
	 VZ03xL9PWUrFg==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v5 0/4] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Fri, 23 Feb 2024 15:12:37 +0200
Message-Id: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWZ2GUC/x3MMQ6DMAwF0Ksgz/0SckOgvUrVIRgDHgoooQiEu
 Hujjm95JyWNpomexUlRN0s2TxnVrSAZwzQorMsmLtmVzHe0Dv0csXlUCB/P+KYW67GooFtR+4e
 qOGnEBcrHErW3/f+/3tf1AygNYRtvAAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=2SIXe075Sw3ed8GxgqbY7C51dZQTx4Z+wCjZhCZu2Bo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl2JnPzQuFDaW7cPuQ8iABwa7UFZfp3gSsHvRMB
 qfDarDNTBCJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdiZzwAKCRDSWmvTvnYw
 kxB6EACBMDYHp8ymY83yO/lfB1yd8wPfI5L1Sv2fvGPtHqO5DqGFn3rN1mQbhImx7Y1xE45Lx+1
 JIcdEndHlZCvTsJtJtOChLYvE88oj9g46PjRLcXJJ9QeIrTSqxtTsy81f71LlhV1s50CAZZQ+eP
 CuZneoj8HL8DKf9ZrFapWqh9mSRiOuMgq6oGovd3urWZ8822rnFredTndJJQZxA+vY8bMXU+R59
 G2haNFUdCSaUfzYpFPTVJnUXDsKq7jeswMr1q5lRZj85elYii+U46wNG1/FN56Voi2u0H90Ttmi
 bg4/xcF26otMoJvu+ZtYGlbUEx1bcpOIxFRoBkjLTinKMPt9u0lrELqZoMd0QOabo8Bda3dRIWV
 BToR/4BR4cs+7YVBL5bUikMyenXxO5/Ko0sncMrsJDqe0/UY4ZaQxW5HfD8JB8fVvp0Ah3pKNHU
 F4YZ1u3edWjtX33ramwpm6CbmvfqLL8M2rehxL5gVcPDdujCdwbRovT5P8VzBKN2mDY76cW2K0U
 pLZCfh8r7BVP6J1o2uqwVed5azz/Blpbp02Wt4HzGeVVxFu3QJ2jhM6jd5gDFjXDZird6bbCiwc
 q5pM20DXUs03AC75IRlg8F6T3DpOe3qQ9hoS8jmBk5pTFqkDtF7/yml/zXJPHYqBCdDb2T1aUxe
 WvwUz0olSFcM6VA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
in the wkup_conf node and fixus up the USB nodes to use the newly
added nodes.

Then it adds USB support for AM62P SoC and AM62P5-SK board.

In v5, we disable USB LPM support for all USB nodes as it is not supported.
Also Acks were added and To list updated.

Changelog in each patch.

cheers,
-roger

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (4):
      dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
      arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
      arm64: dts: ti: k3-am62p: add the USB sub-system
      arm64: dts: ti: k3-am62a: Disable USB LPM

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi          |  4 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi        | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi         |  8 ++-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi       | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi         | 50 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi       | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts           | 67 +++++++++++++++++++++++
 8 files changed, 156 insertions(+), 4 deletions(-)
---
base-commit: ab480b8036fde8c1ea628bb1027919bf399468e9
change-id: 20240223-b4-for-v6-5-am62-usb-typec-dt-769eec4c8c4a

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


