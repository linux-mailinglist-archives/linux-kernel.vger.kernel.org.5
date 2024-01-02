Return-Path: <linux-kernel+bounces-14020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B98216F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8AD1C21108
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CA1879;
	Tue,  2 Jan 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8dNTxRQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700F10FC;
	Tue,  2 Jan 2024 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66b093b86so6400305a12.0;
        Mon, 01 Jan 2024 20:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170775; x=1704775575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAxabFINcvVYO/q2LghOlxe+58oZ0L+QsCNCz6T1Lcg=;
        b=f8dNTxRQOcFoqZidRLzPR3t7/n7cUzI73X01y8Kqn19/lnbwET8PKcbAkXR6qezH2J
         rXAqFjxjmty/b0/MbPLO+EdS1PpnJt+4HvheVMiBRixJzctjG+bDU0S6s/MN0fXHgsa5
         6dOAZ9zftWu6FLk4noCzeR2DR8eUqHJze+nu2J3jKTlUBbF+cWdZ8/B+FiBDYOwlq0Ri
         scJ5vzbZ6tDMq364QFuX5cUIJLyRbRW3IEWbHdiPyfJmOxcYOi2ZOC+p17wHRtyaUwWp
         QqdB3y4DO4KZlFOqtFCZzQYTI3iE2a3iB8AcgSsBpGLsviURUyIPawq0MP0RQHGw/Alc
         YnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170775; x=1704775575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAxabFINcvVYO/q2LghOlxe+58oZ0L+QsCNCz6T1Lcg=;
        b=uoq2JC+gAuq8Iu/bQJjrtWINasMtdbrJM3gAykIEWrGvhqRH9aibNuKZAeUfRRhmrG
         VUtDvDsY4Mj1LNMq36iuOmRdwwOF3p4goKgFPPre9laeJK+QhBzZV9ZehKogGvKTy1YD
         wPiAa5rAf7SEn8z8PmVvizsaFiGx1QU6AktvPUjCY1JJSdd1/n7IDFqtg7b+NlCcI2c1
         tu1kuqYab8Jx/nQHxtAv+Z5424Ftkve0mc1cN1qywb+xzVLpqn+TkaaMHOxtRBwsOSh+
         BtbPAAejSa/4rVDtFQTWSx9rDctBup/NhlL2aegXrWZTa8J/Ui3QprLB9Rls+7tDpWc5
         lc0g==
X-Gm-Message-State: AOJu0YyQN4mVehaRzAfEn/4fzI1LnoQojjKrcoM4YYajwQ2Bf93VXmWR
	Lji9cPdr/wDH8szJ1opKIYk=
X-Google-Smtp-Source: AGHT+IH9IqOgrvDHv0JBk46CuYwK0n0E7o0qckt63SLybfH3Rj3RdJ4BvjYWOLWs2BqYO1BI/Oun0g==
X-Received: by 2002:a17:90a:8685:b0:28c:95fc:c322 with SMTP id p5-20020a17090a868500b0028c95fcc322mr10494576pjn.5.1704170775269;
        Mon, 01 Jan 2024 20:46:15 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:15 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: dts: aspeed: Harma: Revise SGPIO line name.
Date: Tue,  2 Jan 2024 12:44:05 +0800
Message-Id: <20240102044409.3810873-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
References: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same name as reset-control-smb-e1s
change to reset-control-smb-e1s-0 and reset-control-smb-e1s-0.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---

Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7db3f9eb0016..8a173863ef24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -505,9 +505,9 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
-- 
2.25.1


