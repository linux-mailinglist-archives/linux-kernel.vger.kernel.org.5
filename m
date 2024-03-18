Return-Path: <linux-kernel+bounces-106441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B693987EEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57587B21E34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10256755;
	Mon, 18 Mar 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqI1GgKz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C955E7A;
	Mon, 18 Mar 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782560; cv=none; b=bWlaKGVfd5Oc0JYF3RsZQJNmHidSA2gWJ3r+q+VY8wLXyB0pURShZNIwDifQwzfOj7FKBCR+ypRT2TnV90B63t7WYmevuu8crZgjzPy/tLFxX4FmAu0U2LbFPwYdxU73B3dEfALwvAN2RGXqNVj3LnEsdENEjLd1Jrszn110x10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782560; c=relaxed/simple;
	bh=d9QlQ3LmOITKy+7UaQgBMxtlKEfegHfOQNyg6pP5+qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AD1pHe9ruTKTULWgs/dDrDRkjhpPwiTg5BEK7ArLscsHuwOSOEApUPuR+XX/YyJ5piU7yhqUyifKB2e+Qpr2FW6DWlyYwkl1j6gWELKvBW0BQ5guB5EE/KjrYhmf2+tzeMHfsZKybw8T7KS0Jz9sNigIRWzVyA/QXat2Vmf7Wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqI1GgKz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d3746950so5590217e87.1;
        Mon, 18 Mar 2024 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782557; x=1711387357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVCv5MO0HlKhbS+d3hf8UIAQYrD8eX3xs/eYmEYQzI0=;
        b=TqI1GgKzTpOgGP5igxK9kP13B8ZsUrT2DMl5FD68kW6+p94TkTv3jKRi4boKU4DFh3
         s289NQG7pm6VJDcTlO/3ugCmN+F8LP/9UwmRTh7w+BcY/VQ7cNXdTUtyEOXZoqT/5qmj
         Rk94swGzuPPsix0rYhVCV80iGJ4Kxny0ReFFl9agG7yZn7qjH1VtG+Bv8and2V0XOd0E
         RF6OjI6sXY2kTx/plI1uad2eVT+HE3Br4pEoRXYr8NFw1tY+4hWlIEOVbFpT2dT92isi
         Nsyop41T6ftI80FLN9Uc6fLodIlZMGSMnUW7Vp/DlUQuBJxN3OlWeac9O57A9LELtYuq
         m3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782557; x=1711387357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVCv5MO0HlKhbS+d3hf8UIAQYrD8eX3xs/eYmEYQzI0=;
        b=JDKB7n6jolUgZkb/YruzQ31kJVo0kL5+/WuoDkUxT/cQyZ6jpn9OWf/jguJMckFe3P
         biHbfRlxKVgcV+4bxzz17kQM9/BrxbbZJy19G/c90pdCEg41MqTY2RpaoaXHmYaFCfed
         jhBwAROhaxjET4ux7S+qL+n5CILFp8jh1e+nc0Au3KrEIo2k6yMXNDkXzbp5wIq3xbZI
         aJZDJoKGVfe3JMe1YQ+6XGFJSC/yPitqXK367hhfwJ962toCBbbWY1jfDLB/EUFcMbKH
         kMWTUcBVb0zTHwyDAxOSDdyvNLWifbjEzy/B30wDyk70SZIqWfc9mYUOl+M5+utSWVXQ
         HDVg==
X-Forwarded-Encrypted: i=1; AJvYcCXW4jxtiurjd5fonss9rFB27aANlbizuEDsxCAfb8qcQHgwpe59dFdn3CwkVy1dpfzZZdQouNcR2GxpfomJ2Z6X7rluHCrmoM0mTDA1hSQd9pnw9csJcSEYdxrc+OuiLPgSqdLOPJFjsOQbDLw4oOZdJ/QMjodMq+55c2DpXtMxuMSroNPMsZvJJWy/
X-Gm-Message-State: AOJu0Yxk0AxMjJLN6owUYMogWHvg5cWZjxzHMobuvziM1HyHj/VH7aG6
	G4Gpca/30I9xK0jLnhP5JBNNuwfLByo/uwn9iQmvzf+S3R2bnr+e
X-Google-Smtp-Source: AGHT+IFLZD9aDd6er/E29kcIwyxVtdJbv+F4efOZQg0CdYfzysDvkBTztnDCZ5XsxpnjJfQxIrwuZQ==
X-Received: by 2002:ac2:498e:0:b0:513:ca99:5908 with SMTP id f14-20020ac2498e000000b00513ca995908mr8625770lfl.26.1710782556915;
        Mon, 18 Mar 2024 10:22:36 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0034180898569sm1140769wrb.72.2024.03.18.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:22:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/4] serial: sh-sci: Add support for RZ/V2H(P) SoC
Date: Mon, 18 Mar 2024 17:21:02 +0000
Message-Id: <20240318172102.45549-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add serial support for RZ/V2H(P) SoC with earlycon.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2 - > v3
- new patch
---
 drivers/tty/serial/sh-sci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a85e7b9a2e49..4a60d77257d6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -290,7 +290,7 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	},
 
 	/*
-	 * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T.
+	 * The "SCIFA" that is in RZ/A2, RZ/G2L, RZ/T and RZ/V2H.
 	 * It looks like a normal SCIF with FIFO data, but with a
 	 * compressed address space. Also, the break out of interrupts
 	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
@@ -3224,6 +3224,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 		.compatible = "renesas,scif-r9a07g044",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
 	},
+	{
+		.compatible = "renesas,scif-r9a09g057",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
+	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
@@ -3554,6 +3558,7 @@ OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a09g057", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
-- 
2.34.1


