Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F807FC222
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjK1ORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbjK1ORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:17:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F4E4;
        Tue, 28 Nov 2023 06:17:15 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:17:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701181033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVlzGFNe8fmFPiCW3BR1UDMX0zpe0U0e00QVaeXOICE=;
        b=Y/p3UBuXbSG+18p/sRNNTSbJ0afHymtCKeNdyWa3WRgHjtMq6pFEhQrSzR6PEsgE5Cs+ui
        N3f5HeKZj/m/KEQkKgMaNlcxmyweesbCDrfrMN5umwUOalcrboC0Wksv7UYN5wvAGH/vUQ
        PLjvlZaNR6uQejIVw2436E3og6y3CCfYfSCkNYnVHi5mS5YNNpaQCNf5mkJBxvowaEjeTV
        6BlVWV3hWfcOXHSD+Lojdh3ggv8tYgG+A71h8cwAShsIG1Ea46d0fwAzmbpivU437gn9HK
        ip0PMAXBsKsjk62VS6dA+dHyn+P0uiIo4hVcPEM/l31EUobFRF4xokmN+7dhkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701181033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVlzGFNe8fmFPiCW3BR1UDMX0zpe0U0e00QVaeXOICE=;
        b=dB78d+qWMF+1G5gBW6wpPMaEiWa8M5fmNPeqN0RdkeXyh7AAC9BVuSKCS7S43DR4nqY6QT
        B+N+DOcpVm9FXvDw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Remove obsolete config X86_32_SMP
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231128090016.29676-1-lukas.bulwahn@gmail.com>
References: <20231128090016.29676-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <170118103247.398.14904326110266831066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c64545594daf748422fa083389b062d0a16fb477
Gitweb:        https://git.kernel.org/tip/c64545594daf748422fa083389b062d0a16fb477
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Tue, 28 Nov 2023 10:00:16 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Nov 2023 13:31:34 +01:00

x86/Kconfig: Remove obsolete config X86_32_SMP

Commit

  0f08c3b22996 ("x86/smp: Reduce code duplication")

removed the only use of CONFIG_X86_32_SMP.

Remove the now obsolete config X86_32_SMP too.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231128090016.29676-1-lukas.bulwahn@gmail.com
---
 arch/x86/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41..5a6728d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -384,10 +384,6 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
 
-config X86_32_SMP
-	def_bool y
-	depends on X86_32 && SMP
-
 config X86_64_SMP
 	def_bool y
 	depends on X86_64 && SMP
