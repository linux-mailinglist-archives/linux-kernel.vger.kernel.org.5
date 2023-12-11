Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0680CE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbjLKOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjLKOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:19:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC683247;
        Mon, 11 Dec 2023 06:16:09 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702304168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppjU+31LnK9VxtavD2GvL4JVjKrjbiZoU7R+ROKBQw0=;
        b=hDjdil+9JU5/ytG0e6pkeyZEi9edP1ZWxu1wXzWH9ftXHULdjTHR1m6Pidh/DpgHOJYozI
        XhD5eCdVGfxOBwp5i25Vvxwn+ipA0o2iZpmzoKMuDTtBdWZr/bdKalDhIRgo39NV6DCNWk
        oCdvQR4T06kV0c8sEJnSmaRiiN8Pq4Rdro2hV3WDV4IP1SXNIXAp+RLXJZ7dl+hMU1T3LS
        +yVnBMcUdWUrFNwsneDvxu9wkG9fdvJYPkmcl13RMSIqKFIDtAuXU84mTO5hfCpzUCkcId
        eJLJRXkgv94QnTJJQdLce7L+H+N0r6hlJHcC6IhDwDfVyMdp+8x+cBUlXJPx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702304168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppjU+31LnK9VxtavD2GvL4JVjKrjbiZoU7R+ROKBQw0=;
        b=ibuq7a5Az7Pjp0C516ChSpwDNo8VYpdGUiMuwu2e4BF0j1aNiiNTNq3aHUS31bE6P+aI6D
        IgAuM+cNwzYVydDA==
To:     stable@vger.kernel.org
Cc:     jiajie.ho@starfivetech.com, palmer@rivosinc.com,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: [PATCH v6.1] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Date:   Mon, 11 Dec 2023 15:15:55 +0100
Message-Id: <20231211141555.89648-1-namcao@linutronix.de>
In-Reply-To: <20231211145750.7bc2d378@namcao>
References: <20231211145750.7bc2d378@namcao>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia Jie Ho <jiajie.ho@starfivetech.com>

[ Upstream commit 78a03b9f8e6b317f7c65738a3fc60e1e85106a64 ]

Selects ARM_AMBA platform support for StarFive SoCs required by spi and
crypto dma engine.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
[ resolve conflict due to removal of "select SIFIVE_PLIC" ]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..29d78eefc889 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -23,6 +23,7 @@ config SOC_STARFIVE
 	select PINCTRL
 	select RESET_CONTROLLER
 	select SIFIVE_PLIC
+	select ARM_AMBA
 	help
 	  This enables support for StarFive SoC platform hardware.
=20
--=20
2.39.2

