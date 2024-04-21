Return-Path: <linux-kernel+bounces-152493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA758ABF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E81F216CB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E6156C2;
	Sun, 21 Apr 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Y2tQHT9z"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD412E6A;
	Sun, 21 Apr 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704334; cv=none; b=VTKQw4Vd/a6JIhKmtzGbyD3JSjh1sFnWARm/eu6W1kdNWWQJ2d8pSTkhAcH9iKrH9f2U0gy0OZMSePLOTQ9kOKaGHekGTa5Bq209UtrKhUiiwl9yALFHsqIrhVWAEtp4ZqPa+RbYlBckGn44xl48xQU/nic6B/VKi4xwKruoVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704334; c=relaxed/simple;
	bh=NVxRoRPRimApQYLL+SiZLTJ3GwIVnEopHPufJImejG8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a++FMHl54nxVRMgZz7gE3K/d8fvMgs5Qg6i/JPZXatyEUCzBAyXSJ0q611iLM4Q2Ru18ut9wvPwlvvqLx/ymJKnP65bUjzBV5FJi2haDPx0Z+bL0kfUZLzlnqbwREc9GyXthxPGgOabgCAAJqkF91X6eKGs76S2//1GVEhLdmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Y2tQHT9z; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713704029; bh=Oid0/2+ncbfbBpARfu+QMrQ+JfMw2YqRGSqME5w6tAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2tQHT9zzQCX7cNwNGXG89m4/wTe/78DKsmLrtWoi7V1NH/fhIfbjTSmc4JPhHxPO
	 KMHgiM6/7J2Cer23fOz9QncBttXV/FRREgb1csHQ7dD5qOKNaHLSoGLfEZ35FB0Rrz
	 WIDscc7qlmLYaNsHyB1Adezihhz1zSGRDBPprxEg=
Received: from cyy-pc.lan ([240e:379:2264:6200:aa04:7d36:395a:da35])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D6B1C271; Sun, 21 Apr 2024 20:53:43 +0800
X-QQ-mid: xmsmtpt1713704026tyjhfqvqz
Message-ID: <tencent_AD84B436C2F31108B66B4739D6E306C5E80A@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTF2H89VCD5B7DlQMjdlBiz4ngf34c+hz0HuyiJ+FkP71jdACfwi
	 Re+X3AAMqp/wxVLWMqLChc4Wifkbxnp3//Tde0b1j4bfQOUOEAXuUe4RjmxsYYtDWsnqYOtsseN4
	 pnr/rX+sPq1AGW16QiQOqUpXqzVmrBfdLsho8crjAK6Xo4Y2wBMxgxU0Sg08Dmppo/9C6JTftFli
	 qEzItM5Z/wFSqohRUzIfgPNB3qlQOWbLjv23iWRY0gsfmr7bJF2pZucQr8V5odlUGwKGfHmWQwt/
	 RNozxGpfoZbT8xxp471ItP77hofEXg/K+aA42FJWAN0L1HbbVTM2YioUaVJcigMlTNqkTWnoYn+K
	 gnskcNCgfiVG8/O6mbP34GT6+Zo5Ftv1lSMCoQJ6U9VPXkrGuZw4KPofx8jMDTC7ylAyz/7T6eKT
	 xu2pY/Ht3nvf4yh2t5vB7R34zVxAUJkuQKLrsJ7aydJr4PWQ7hwzfPVSROuaPR4MQklXrhqoqoDJ
	 TG60ZbfziMtm2ljVUcnJmMyNlxXjVlTVvhtdkVSn2Rl7e0U7KikTJVOtezEbfHMdgH1OQIa12ho0
	 ctEFSOlHluBsuL+nU+9TyAaLjDlO4RWqp7dIGnghdy5BrPsQPnGKbU01rT+6yA2pSB14lLeHw6Po
	 SN9k0UJ/D0qxswyRPPBh85twKsjPWwOfXfuCiuxtfpzUdm1q6DRbxN5eilEOW4OmthwuaWO4F737
	 bJnNF8ULJymrKOQJQyqsI3Om0qKYMarOi8WdUMuFCAoXJcYAuvT5q749lmi6g57bB9Jn2oM15dxG
	 oEK2UsOPB6ZRoTDVwlX/JaGAc5Du+ug7T5mwoHS5Os7ketYJizhE+QIxevA2d1LtignjzTM6cn21
	 6A7/RUcUpanX2ZRUDSf/sNh3sO2RCngysjitPERLJq8ZTkUaBJG8LhBtMBa1E6DVJ0hoApnO3wdd
	 0vmWBoNKD6Xwyod1bI7yTgltkaTmgpWQ1t/CnmniVzFJtAPgT78Ui9AmQJqle97E4xIWtNilMPhq
	 Rs3jP+Pi05dvYxJdmcL1XjdqiIHOqg5v0YzdbfDgh2WWFj21fi
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 2/2] riscv: dts: add usb nodes for Canaan Kendryte K230 SoCs
Date: Sun, 21 Apr 2024 20:53:30 +0800
X-OQ-MSGID: <20240421125330.1039774-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E9B853316D217B8D1E7CDF8288DA5E8ED908@qq.com>
References: <tencent_E9B853316D217B8D1E7CDF8288DA5E8ED908@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds USB nodes for Canaan Kendryte K230 SoCs. The fifo
parameters are taken from factory dts [1]. For the clock parameter, we use
a dummy node here as we don't know the actual clock this IP connected
inside the SoC chip, and it doesn't matter after reviewing the dwc2 driver
code, which will not read the clock frequency but only use the binding to
turn the clock on or off to save power.

[1] https://github.com/kendryte/k230_sdk/blob/v1.5/src/little/linux/arch/riscv/boot/dts/kendryte/k230.dtsi

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/canaan/k230.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb11..2311fb7f7127 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -65,6 +65,13 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -138,5 +145,27 @@ uart4: serial@91404000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
+		usb0: usb@91500000 {
+			compatible = "canaan,k230-otg", "snps,dwc2";
+			reg = <0x0 0x91500000 0x0 0x40000>;
+			interrupts = <173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_dummy>;
+			clock-names = "otg";
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <64>;
+			g-tx-fifo-size = <512 1024 64 64 64 64>;
+		};
+
+		usb1: usb@91540000 {
+			compatible = "canaan,k230-otg", "snps,dwc2";
+			reg = <0x0 0x91540000 0x0 0x40000>;
+			interrupts = <174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_dummy>;
+			clock-names = "otg";
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <64>;
+			g-tx-fifo-size = <512 1024 64 64 64 64>;
+		};
 	};
 };
-- 
2.43.0


