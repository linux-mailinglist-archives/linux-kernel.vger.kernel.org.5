Return-Path: <linux-kernel+bounces-1551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F4814FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4051F24DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A693FE4B;
	Fri, 15 Dec 2023 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vXDHXPbf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D23FE30
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02D873F2BA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702667352;
	bh=MRZYQIHPmA7btUFQOfGYSO5VRHm0MVyK696kIcZXcYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=vXDHXPbfzSLvnSVOKE6TP9QsztVOCO+29wlniVxZ5suCImxukbCNBKzlRtHHFovq0
	 Dnbw5xlINqbVff5kgEm1iF7We8h/7XcNal7X0YLJM9RlygqhCuy24Y+E1uPLYtGQGQ
	 quOLMBfyyxI49oqKyouIZWTs9JQOHQX1p9oo/ArWUbZU3PHE5jE0x6LcbeU3bXRrmn
	 P81PCEujycca4ie25Qp6Pe9NDZ/uBqRyE5WjEeHIshl/MGpOntnCk7WDUgh876b4VA
	 B7h2yBhyEJc38xyXwtXHkQpRVo2cqOnnsgk1YHQ67B07EcBrWixIQ7Eg+lE1vhFdtT
	 9vs5zMeRzRdxw==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2cc4b538b37so8199811fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667351; x=1703272151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRZYQIHPmA7btUFQOfGYSO5VRHm0MVyK696kIcZXcYo=;
        b=XFNPb7Hn9E4jC9RicFsMTdZ3VUzctmFRT7MY01eHRhdu92DUk3M6+sa1jDUV0z4siZ
         v4ZdYieNaJaxcajLom03UvL2YmvMSAirCeQZrgnOrCdymQ0UNCebdXWUKDiIIpawEYsN
         j0G6T10pVeyjxOFkertmjCbq8nnNTk4Z8vEAqCVMjolGcRmOsbpwIDbtvnq3Jy93gf/Z
         hgKWmugJCldNW6feVT3DCL3dN5nB1Ec7pGZ7hZHDKuizbaorPn09cvrNv8cYIBGRnjbV
         Q+afXHanY22m3T2ZRr84XESR191+5aYHV9Y6Ak1tSsxzSQBQMo/KuvdqVK+xQF6x2xa5
         HHsA==
X-Gm-Message-State: AOJu0Yzv701W8MmqQ2b7yScW4DM9U/JbUOpDAwFFHzknIBec7nUBSV5+
	G0WH5qf/iH+HSFXz0eqdpwwsE3VQDc5nU0jze9j5lFvZv0lAE10tyYHSWoCvw4HejHH6ONIzsLK
	k/MxbGLHw+ryPrIVcZo7vEWeueJfAZ4pmBUXMpDaBIg==
X-Received: by 2002:a05:6512:4847:b0:50a:a5f7:47fb with SMTP id ep7-20020a056512484700b0050aa5f747fbmr5071612lfb.49.1702667351117;
        Fri, 15 Dec 2023 11:09:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHfU/LDng1X8+W90PqDysrUy0Azr/q6l0EAbqvK90+Z7EyHsMSWUvd4IZQoXgYzTA4LDhgYQ==
X-Received: by 2002:a05:6512:4847:b0:50a:a5f7:47fb with SMTP id ep7-20020a056512484700b0050aa5f747fbmr5071607lfb.49.1702667350770;
        Fri, 15 Dec 2023 11:09:10 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id et14-20020a056402378e00b005527cfaa2dfsm1700456edb.49.2023.12.15.11.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 11:09:10 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] riscv: errata: Make ERRATA_STARFIVE_JH7100 depend on !DMA_DIRECT_REMAP
Date: Fri, 15 Dec 2023 20:09:09 +0100
Message-Id: <20231215190909.3722757-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the Renesas RZ/Five[1] the JH7100 SoC needs the non-portable
CONFIG_DMA_GLOBAL_POOL enabled which is incompatible with DMA_DIRECT_REMAP
selected by RISCV_ISA_ZICBOM.

[1]: commit 31b2daea0764 ("soc: renesas: Make RZ/Five depend on !DMA_DIRECT_REMAP")

Link: https://lore.kernel.org/all/24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org/
Fixes: 64fc984a8a54 ("riscv: errata: Add StarFive JH7100 errata")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/Kconfig.errata | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 692de149141f..f5c432b005e7 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -55,7 +55,9 @@ config ERRATA_SIFIVE_CIP_1200
 
 config ERRATA_STARFIVE_JH7100
 	bool "StarFive JH7100 support"
-	depends on ARCH_STARFIVE && NONPORTABLE
+	depends on ARCH_STARFIVE
+	depends on !DMA_DIRECT_REMAP
+	depends on NONPORTABLE
 	select DMA_GLOBAL_POOL
 	select RISCV_DMA_NONCOHERENT
 	select RISCV_NONSTANDARD_CACHE_OPS
-- 
2.40.1


