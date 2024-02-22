Return-Path: <linux-kernel+bounces-76928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86185FECD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261CD1F29197
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0F154C14;
	Thu, 22 Feb 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwShxTs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mo6zLQVV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A018657;
	Thu, 22 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621872; cv=none; b=a9/OUIuUCw3rn6OqG9+Nvlgl6s9jpT0iVb0FPnRkKROmlaMTpUwgVPzm32SJMAAUxfIzeK54hYWcv/CDX5UxgENhTMClLy47I3kLnyNnteaYusAHAQS6E3KVDQpCccOpsMMJ4AwesBF3ysajBT3l9YbfX20i2cQUmhUYCp9nH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621872; c=relaxed/simple;
	bh=MM1JJIPhpSFC52meHfm3jKUwwDEzuYxplUwdvanFmRE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tBLhGpptlCBxkLF6pvYeAkjI24qkPctcU9Q32zqcLtjPMiVUzTvhJdQ+C60WkKS72u+Ut3hADvNI4I5tnYA2NttelHv1wFidICG69/88YTTIzu3GaX/5ynjtussXofgrDSgrokZBizZVe5DLbGD3nMkAUUNQG5hkrBTYOWciywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwShxTs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mo6zLQVV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:11:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3ebpby9F9c9txMOY2uW4k2z/FPljp4f41sJjxGz3Ww=;
	b=MwShxTs1EjJtIx0OkmLYwhazAQyfiq3M1mWUcnUCYQXRlAnMVGSY3et2Z+XVFBnuF+OCIe
	1Zp0vHvZEkUKd8KcFB/gvKS8CNzj3wh66tgVMuNGXg33P2MAPrQrPZHilwsvbwGkv78/Yr
	hJnIjDZzvu7Bg3pdSt3zKm9yMiMd4EhojvmIg2o2MZLLtw5q/AHJLv2uenue9BOuhAFNbP
	vFRYOIq1LY0SC9QoJA/Qh7jaBuwXaak4omi56mMLM0cZR5mczqq38i+VjpgH7iPL/2yg1D
	GqVjSee8qQzrYK+8hqezteIEtQmqLTBhXkBZRJz9IXMao932QzGb4XwawjuYSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3ebpby9F9c9txMOY2uW4k2z/FPljp4f41sJjxGz3Ww=;
	b=Mo6zLQVVN+nX247/QVEzg3ye1PsoHpU+O4rVgX3cBHdEpIhj4MOW5UH0cLWI7+RI/FZcAq
	9MG8WymLjZmpPJBg==
From: "tip-bot2 for Huqiang Qin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs
Cc: Huqiang Qin <huqiang.qin@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240222074640.1866284-4-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-4-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862186740.398.15170945026800873163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3f734564a03df595c671316314b65a465d333f4a
Gitweb:        https://git.kernel.org/tip/3f734564a03df595c671316314b65a465d333f4a
Author:        Huqiang Qin <huqiang.qin@amlogic.com>
AuthorDate:    Thu, 22 Feb 2024 15:46:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 18:04:43 +01:00

arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs

Add GPIO interrupt controller device.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240222074640.1866284-4-huqiang.qin@amlogic.com

---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index a03c766..2bfe2c4 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -171,6 +171,16 @@
 				};
 			};
 
+			gpio_intc: interrupt-controller@4080 {
+				compatible = "amlogic,t7-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg = <0x0 0x4080 0x0 0x20>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts =
+					<10 11 12 13 14 15 16 17 18 19 20 21>;
+			};
+
 			uart_a: serial@78000 {
 				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg = <0x0 0x78000 0x0 0x18>;

