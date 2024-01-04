Return-Path: <linux-kernel+bounces-16725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC709824300
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E404286A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5D225DB;
	Thu,  4 Jan 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSfQPNdn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83B224E6;
	Thu,  4 Jan 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d409bcb0e7so2857795ad.1;
        Thu, 04 Jan 2024 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376059; x=1704980859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxGy7pLjWz6nitoY50e2aJeZJJqgkNuCQ+WC6P62+FQ=;
        b=RSfQPNdnp/T8vi7COWyJVWI5B+ya1D1j5YxH34VCU/IkhvAKaLcXdj/hJmub26i85K
         BFFo4nPL5NpUad8ONVjoFokNeieXc/mxW65h9Pecgk7wJARkOsnqLk3z/Ud/2jwr4h57
         aYkIQJHPV0F+Kdp6WpbH6Rye5Qk1HWLJ/Zcco3w8WIcAmFtwbSRYe77N9Q7z369gMCin
         yX7Y3Q34BIaaYPJQalNr0du2x9khRw8GucvezyDNmg0XYgXWO/tA/ZxIQkx7PpoEP9mA
         eouGoYwgyW3BwkMRTKp3rgJnozigC87xptCSskVJWTE1+b1y7WwhPb7LgjBsR3K5n9yW
         Ezbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376059; x=1704980859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxGy7pLjWz6nitoY50e2aJeZJJqgkNuCQ+WC6P62+FQ=;
        b=lS7VFsEds08bXVa9SPxd5nsjptL7VbcdVyvQG+jSc1mzGPrc0k7i8dPnktrXZk1xKE
         0xnOKxc2lDwdNbCPo0nrPo/JbLmnyqv0aSSPuMnOnPusTrSCs8HQ3y2Jqbg/mvhSfCWU
         4hzaFeZ6oNFeEcLuFOd6rMJdHoc3oDXACFph7PB4IJAflLSwj11UVlt6HenMH3iEcyYF
         S2s6Tg6AlDrhAa8yuaKvPFDcLnEUyyxP/fxhiwSNjvjYWwiihq/AUu666DyMsC4DTsKY
         UHD5Z9NvrlEQaHd7QYzDrSjjA5EA62BZTeIhA5BBwnHwLXXUOhv0Bjwcq+f1lfDp1ijb
         NBGQ==
X-Gm-Message-State: AOJu0YxL5D77D3kr9SKke3tqzVFvO1rVazAUNUv9D+0h2T2t2i56YsfA
	szOAk3tlQSQVqGte1byxI3zPRS62p5E=
X-Google-Smtp-Source: AGHT+IHjZB4c8LT5IHLe50DMbalsQ9CbaL2Y4/m+a8a1k9zs5tQH0Y5UKPao5FbMsaY+QyINqSis1A==
X-Received: by 2002:a17:902:6548:b0:1d4:1dac:9fa9 with SMTP id d8-20020a170902654800b001d41dac9fa9mr471413pln.72.1704376059493;
        Thu, 04 Jan 2024 05:47:39 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:38 -0800 (PST)
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
Subject: [PATCH v2 1/6] ARM: dts: aspeed: Harma: Revise SGPIO line name.
Date: Thu,  4 Jan 2024 21:45:27 +0800
Message-Id: <20240104134532.536793-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
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

v1 -> v2
  - Add infineon,slb9670 information for tpm.
  - Patch 0006 - Add PDB temperature.

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


