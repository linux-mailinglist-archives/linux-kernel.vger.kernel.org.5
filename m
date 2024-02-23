Return-Path: <linux-kernel+bounces-78360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8A6861260
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5D1F240B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E67F7E5;
	Fri, 23 Feb 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6aJ29r6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E57E788;
	Fri, 23 Feb 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693988; cv=none; b=tcC6PNMJ4YWFOUYbRXZvZKeKeV9a9q5+yJpd8JL56Js7S6jM8gXUk9ZMfwsdxSvTVT5seUIiEJyOkl53JsVDhybKwS8vs+88blxiU4LcYi82o7lymjvhRrsLNUp3Fw3I2010az9LcIiEHRWTn7lpQA+lXjb7UWY8y5Jq5xvFqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693988; c=relaxed/simple;
	bh=Ia7B/FTNmnvsDKGGZT1idUgrWrwpUdfNfZY24Zv7oDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2tqI6tKis2q8N4mQ2p7gwMNaNz6H3m7vi4FZdAeLKWNUifllijM3GBzB3TkBSlA833CW4bO/RUS7MsPFCUmC/tXO7RWnXo50QvUVqCsMlX1uQRYCfeuqGm6YPuPTSFueunUwuJ/sAtKenIpKn5zT3BjIxQ9wwTEYLT05SIHjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6aJ29r6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E29C433F1;
	Fri, 23 Feb 2024 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693987;
	bh=Ia7B/FTNmnvsDKGGZT1idUgrWrwpUdfNfZY24Zv7oDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a6aJ29r6nAdNSOo01176zFTLT14uB9a8Hzs4cH7RkF5ocw1z80qpCd15z9vBXrjV5
	 UpNPBi0k9ZIOWQ4pR1VeFEbIIA/bSAE4CmWSLvC4kTgJkMwL2qxCnwAnVxfdF/2NYc
	 f6fTaCpEiDOV1fmgf+EPvNYTEXPdkPcR9Fq5920hGvHeqT+022mQSiD62gwgrpFk7H
	 kjFt80mBLystV/B/iAUDUkjLpxEoRaGbey4QEddOzzt7zRw+iPGdPFmSr1cdyhw1Kj
	 NdIXTDUBWbOPlm5jA9dSUlxWdwVzQbvS+bT12cCRsxZGvpt61tXfoxv6OCCg+ipRG0
	 u+m+h/1yhqm/w==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 23 Feb 2024 15:12:41 +0200
Subject: [PATCH v5 4/4] arm64: dts: ti: k3-am62a: Disable USB LPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-4-4b5854d17d18@kernel.org>
References: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
In-Reply-To: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Ia7B/FTNmnvsDKGGZT1idUgrWrwpUdfNfZY24Zv7oDU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl2JnQic6W1dmFUnWohl3Du6PlUiOwrkRvkqRwX
 hoBvVdq5GmJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdiZ0AAKCRDSWmvTvnYw
 kz9UD/0cevH5+QTgEEpTt9ewCR0vTKFFEpHjrEpAWuD6h+dlLH0g7ZLvkprg9yPtl3W/KJF1L7+
 xPuFFIqaY8VDYKi8jM1LLFoPFOozrC8lxDizkvZXN13pdJPoOUevQ5ecjO8vwIRFg6CsiJWJNlp
 FBhD3k4c3kNhg52YUcENxbxG+00TXztjko2tAEw5WWEqThWAAy3KoStSP5y2SjYybfWR7VSqwmg
 rrS2s3A9eO+eYOm7rBwW6FdF2R7nnDSwR99BKfOhT1Am81o5iJn1pZQAcCfqHIgrA+qAOeNv5Ls
 NVLWsAm4g7WuSx+MJpRS891IBPMNkNfeGrvGqoX+tVV4UYPbRf1RS5UF5eprNvijk9MWP/lY4zD
 xMtp4Y+FPz5rgIo0oY7wclqRRqq+D++xtKHYybkqtovXNvTZTa7eBLgi8mwucxwaG0g1vTw7Qic
 B0QtybIkP44LRmQ+I2prRvep9JNQPK1ndlimk072UaUHqyqx2ATYuo45qBDXIe/l8O1G8bmwB2R
 BQetzd6xFHV83QQvldm1DvdhHaCs4ph3HUmfpHieIfU7S9OODP42OSOpAYcsG3Vmb62ZzDuQ+f1
 SL+6HGALxrYuUk3LfQ2Nzfzrw0UkRHo1/8FXWIqv/PXvXV1KWa0PiJgO/DTztwCVZ0aub5l3mQl
 vqGHwhI088ZKRxg==
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
v5: new patch
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


