Return-Path: <linux-kernel+bounces-74425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0185D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4901F1F25637
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C03D964;
	Wed, 21 Feb 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVhUdj2P"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A443D55B;
	Wed, 21 Feb 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508493; cv=none; b=LDuJUlgHUN0RgDWuJDouhEkquBlly9jc0W6YcKSXDlXSEbFGnN5cFjcyzmK1BVhLRiE6J5gNQK7fYzC/vRXZiczKJOdv0SgMYE60/2NIZeglUT3SrEFfMK7XdyUZIXJVNL4b43oQRSit1qFdebIS9BrwgFTqTthAktLgP5kSIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508493; c=relaxed/simple;
	bh=noJgbfQ4VlELlOxko2By54L9aEijTS7Y4DFtwJxSysE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pc9E5mP21Km67W1hv2uz9/eCHbZyPWcjjMZr3zzN/fktJgJWfItCgSQYNsDHnkk1/cswck7cYD4dYMD65GZ3okzB11vndVFeSlLQGDVuHKSZ1GwpCKtxEBuIGu0y/KwxfvWnwDKt14KfRvaL1nmnaVmop9uW3Bm6D8Yz2sEMOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVhUdj2P; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c0467b94c6so4096202b6e.0;
        Wed, 21 Feb 2024 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508491; x=1709113291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWiN52HZtOJyunoIk+D9B+tPXzXySquVGdLsSRQKF0g=;
        b=mVhUdj2PTVml2APENL2GltqGlUzeULoaIIzhFlV2b+SX6zxd9WiExvAjpiAZ2mQmBh
         S/Tu+sxW3wB2w89p6SF70gIw6y1IBioaqoOsf/s9AUVhwANycufIKRtxfVmJOFEZyGXt
         Vm01jyljlnBwyWmYPLUo0GNHB83fmRN2dAe/zfWzHnmsNnjq80ZOdQ3NST46uiTGsh2a
         ipRalID8uJKWaQRG08TiTcAw4E1a6hIsh2tmFL2ZEZ3KbIuX0gzu970EUyidHaxu5KsL
         AWMjWJQP0TQNe55OcIXN3SbF+vNKwqUIeZz+PK/H3HY196oEL5UX1bnjtIFboWII9cAE
         m5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508491; x=1709113291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWiN52HZtOJyunoIk+D9B+tPXzXySquVGdLsSRQKF0g=;
        b=ZjBqy8hL/YGFDELiZSYY8VjloYXFZ3qaEFtDJsmY7sFzK4i7s09TF39coGCNww0Go8
         CKGYubBYJ1L25dxA2GLn+RODoUU9g010JJkAwYvqJVOtOguLChgDAKy+SynZ4XM5lNt1
         cnaIbUJwbhW7ogzigy1nKCkULYBMz73vf2vkMX+LaJHs/6MHeQngbDQ+fBUHgdRSTsA5
         yC5/6ao88ZRYT0SZj6AdcECHkXHzi/ltccuXa7RT8Z+ZDXxFZclpOzVmZYFOzMJ+wx5D
         pv/FrJTMCsVNlc/7iGaTo09H6uWooiCjTlucuNWjORjIUSNafeDP+QQ/X7trGxasRtHO
         qXhA==
X-Forwarded-Encrypted: i=1; AJvYcCW6cSdJJhm9uIFJ5U6GokUcghgFP0aNb/KkbD/lfBphVGkzhb4rsqV02UgoiXj9pP41uGG0bL/8h/dx715jemYDTuXFnyZgZIU4ASS1ggoVZsBmceJAOrQsRIo3RDQLczciCdb1aHVvig==
X-Gm-Message-State: AOJu0YwG0BBtbAI03v7/KOJw4kAfDp1qKWj3aTWHR5RLZYzH5cg82+iE
	PPNJWCtYEIaO59n8mQAuVPLaVHKWkCbjZyAtf+0T3wGPzGsnhYP79lLj/Dgb
X-Google-Smtp-Source: AGHT+IEJ76fTRizHLqPSQ5rnEgwbGtWfwj6l3vs63i0y1QwzOgt9UIioZw4FdreC3cMjNfkMUQE/fg==
X-Received: by 2002:a05:6808:138f:b0:3c1:5515:2599 with SMTP id c15-20020a056808138f00b003c155152599mr11687245oiw.39.1708508490907;
        Wed, 21 Feb 2024 01:41:30 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:30 -0800 (PST)
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
Subject: [PATCH v3 1/9] ARM: dts: aspeed: Harma: Revise SGPIO line name.
Date: Wed, 21 Feb 2024 17:39:16 +0800
Message-Id: <20240221093925.2393604-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
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
Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v2 -> v3
  - Patch 0007 - Revise max31790 address
  - Patch 0008 - Harma: Add NIC Fru device
  - Patch 0009 - Add ltc4286 device

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


