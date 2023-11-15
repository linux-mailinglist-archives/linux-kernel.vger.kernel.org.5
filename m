Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A17ED546
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbjKOVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjKOVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:02:50 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2A2116
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:32 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6710040E01AA;
        Wed, 15 Nov 2023 21:02:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pXT0SVRYf-iy; Wed, 15 Nov 2023 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700082146; bh=VIEDzqjqAqM/JDStRAxBLsjP5JDujGUG3aqGUxkA66E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4YjHIOMomKnINhvHfbPygfWutYBxRpF/M75uJRcOu71aMuDW86Zl7BAgPq3m/Eeb
         MLi6R1tDoyaZTmboUOFPAfHKGzh2X9n43qw67toJ24iC1wmcZMMIlxALI8UDaTTHWj
         AegVAui2lX0ZrNuaRRxt2ckdLrbuC0ncU0H0jU+ftNcqzrGGXT1tJPxYl88peuu7lw
         DXDqLSD+k/HVp2IlxN485XwDv10RS8/viAUZfhkqPVo9berIwVEPLFlO0cwx6hYFpi
         XCPBW5hR+UGxLmHfeHToFeuGhlKN56BHhi7MUkw2vuI5i2y6yvTzWdLW+vcxWRGzR6
         wW0pyfPBqCGYBC4gWxKioafjE6UrDEdMQfz98VqkdZDXy367i+xA8/RRieh/O/Qof/
         zjStstics2xUKMwMiKy6rO4V3+pK+pqNQE55UewC4scSfUjJ+D15o1l4ziH+BCgQIV
         jVrJ0h3BsS/YONlUz7VZPtRrXWSHuWDIexxV0sMa5giEOFs1GZ1W5B0GRUOtRnbM5K
         5KrOCbMij00gUvT3MFgR3YH9EyfOuE5cxaF9P7LiM2VgJMmQKOjJ/r5+HTk31I5N52
         MYKLwbcqnTO5oxJnvo3N7KSreDDHPTSVNrPk4/ucnn1sEp5lYdCI+vnNtnAh7DJ8FH
         z5DQg3B/O9JEc68PvbUFGbV8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFE4940E01A3;
        Wed, 15 Nov 2023 21:02:24 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/microcode: Remove the driver announcement and version
Date:   Wed, 15 Nov 2023 22:02:11 +0100
Message-ID: <20231115210212.9981-2-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
In-Reply-To: <20231115210212.9981-1-bp@alien8.de>
References: <20231115210212.9981-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

First of all, the print is useless. The driver will either load and say
which microcode revision the machine has or issue an error.

Then, the version number is meaningless and actively confusing, as Yazen
mentioned recently: when a subset of patches are backported to a distro
kernel, one can't assume the driver version is the same as the upstream
one. And besides, the version number of the loader hasn't been used and
incremented for a long time. So drop it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/m=
icrocode/core.c
index 666d25bbc5ad..b4be3a2c79df 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -41,8 +41,6 @@
=20
 #include "internal.h"
=20
-#define DRIVER_VERSION	"2.2"
-
 static struct microcode_ops	*microcode_ops;
 bool dis_ucode_ldr =3D true;
=20
@@ -846,8 +844,6 @@ static int __init microcode_init(void)
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 			  mc_cpu_online, mc_cpu_down_prep);
=20
-	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
-
 	return 0;
=20
  out_pdev:
--=20
2.42.0.rc0.25.ga82fb66fed25

