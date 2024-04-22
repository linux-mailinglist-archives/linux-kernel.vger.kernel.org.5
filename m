Return-Path: <linux-kernel+bounces-154104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D238AD76C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328991C208A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF472E3EF;
	Mon, 22 Apr 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HANMH1SH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGkRH+ni"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0662110B;
	Mon, 22 Apr 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825911; cv=none; b=KaTQPnODNNAzTIyeSUgijoa1QOB919Jv9hOfWAmvw9ANgQ0T9MR0Br+O+Ar+hnFfzdBU43P1nhc/FGDnJrkyLfhtcrfdoDA5Yln68K3wiBEWuiQm09V6RyuapQAdwdWZUs/3p+6+PKl4havbMmyU23ekvOrQn+dMQG8gIUU8v0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825911; c=relaxed/simple;
	bh=XmVDurSz7CzJEEwsk4gQwZ9HBbdVzFzvwBJQqIl+a80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dDWMw9WGfT8ipae262Ks5MvZBBnFpfUZU5uBYTnilScUuPZvaPVSQAZvpnbH9sHnEZnKED6BnYJdmCeDiSVMz59sOoL3BxJ6ov6e6N/lVSEbxT5YcCmZtGyjZIWleeRwQZTRg08U7Gm0h06datgnL7fCpSfIBDypydF/a/dDAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HANMH1SH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGkRH+ni; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825907;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfrjJYABQC1nNFqKy4OHehj2GmJUunAajiOBXrLdbGU=;
	b=HANMH1SHHVgqGERZ+CfCuy3N/By1G6fywVTRZ/Vob127VrB1XMt8nhOm2vJB3SMJGOW9ZC
	D/0ueXtMKxN0WcZUxZq4EsB3P9EqGauFfmBgp4cXM34BWAuHeefimXWzyKV0QCVdLYWAnV
	ZdZR7p6CHoh5XWNXcNnZvl9eBNGAAAdX5kuRlQRVlkV0rg3lGBw3JHYS7KBxCtSGIgxdLf
	9ByIWUngtl4Pb6LKNmSld/dX7noHTkowYZMyx819mSoLJqpYtjh0EP/VvG+2d6EVlSFIrQ
	zBSBQxpzIaW/Mkrrapf3X16WZKbK/54ACNqNpW4ynCLO9q+wA94GpTMP6tkb8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825907;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfrjJYABQC1nNFqKy4OHehj2GmJUunAajiOBXrLdbGU=;
	b=uGkRH+nijyGH05MUl4vwDgVqmWEBtNYR8UO6vaPnC9xUd/4c4PkkAx+sbDGPMYdV7xqCDA
	CTS3M8evY41vqhAg==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-11-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-11-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382590648.10875.9276311797493248650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fbc3facb0b5c607eb80974e33cd155556075cca4
Gitweb:        https://git.kernel.org/tip/fbc3facb0b5c607eb80974e33cd155556075cca4
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

arm64: dts: st: Add exti1 and exti2 nodes on stm32mp251

Update the device-tree stm32mp251.dtsi by adding the nodes for exti1 and
exti2 interrupt controllers.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-11-antonio.borneo@foss.st.com

---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 172 ++++++++++++++++++++++++-
 1 file changed, 172 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 5dd4f35..1426446 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -168,6 +168,99 @@
 			};
 		};
 
+		exti1: interrupt-controller@44220000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x44220000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<&intc GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<&intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_80 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
@@ -322,5 +415,84 @@
 			};
 
 		};
+
+		exti2: interrupt-controller@46230000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x46230000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 17  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 18  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 19  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 20  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 21  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 22  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 25  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 26  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 27  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 28  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 29  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 30  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 12  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 13  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 14  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 15  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_40 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 11  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 5   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 4   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 2   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
+		};
 	};
 };

