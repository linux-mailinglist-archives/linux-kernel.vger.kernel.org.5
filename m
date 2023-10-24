Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891E7D599E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjJXRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjJXRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:19:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0E118;
        Tue, 24 Oct 2023 10:19:18 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:19:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698167957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T36xLw+jZlKdVBpAh9HUGlDtM7FrIarSDa4uGv1Q9cY=;
        b=gchgNzLsjlRrmYmzAxHjcr5EObdu2Y0XiPfmqpFPGd6ug4PZx0xro9mAlUSwErrOZ6hzZ9
        6LMSzHQ5lAHSfoGVDuQ/22BMz9F39sP+dnSEItC1YE5JKRL6OSS6iICaEOfyhZjiRsRmUi
        UqWEgIQpSYFBCntJNhA7ZfHOatYyVvc/dXWIVgv+zALBKlKX1OVF5fWK34va5cqKxN253a
        TpnCJXm07DEffv9DYauST0nQmW2BYPs5ucF4nUvbS9fNxNKPK8VCHETVyjD2efiu0qb0eL
        WXs0LLY3ZD+gw/e6LWSV+uJUdjuzJzdyNai9crMFy5peW8WTjdx5wSqAaowieg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698167957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T36xLw+jZlKdVBpAh9HUGlDtM7FrIarSDa4uGv1Q9cY=;
        b=SB/bvDwjZqKQWHmivF02ByakQlmDjDt5ejAH4WrodKbzGFJXxBeWEuW+xLMUsV/oxlWuG7
        Vul69DpTHnBitADg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/defconfig: Enable CONFIG_DEBUG_ENTRY=y
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <169816795612.3135.14520921782886876664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     70c8dc9104275037a39ab0b2a4ed6eaacac39e32
Gitweb:        https://git.kernel.org/tip/70c8dc9104275037a39ab0b2a4ed6eaacac39e32
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 24 Oct 2023 19:09:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 24 Oct 2023 19:12:37 +02:00

x86/defconfig: Enable CONFIG_DEBUG_ENTRY=y

A bug was recently found via CONFIG_DEBUG_ENTRY=y, and the x86
tree kinda is the main source of changes to the x86 entry code,
so enable this debug option by default in our defconfigs.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 1b411bb..73abbbd 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -281,4 +281,5 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_UNWINDER_FRAME_POINTER=y
+CONFIG_DEBUG_ENTRY=y
 # CONFIG_64BIT is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 409e918..61e25f6 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -276,3 +276,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_DEBUG_ENTRY=y
