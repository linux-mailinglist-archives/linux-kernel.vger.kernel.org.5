Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458D7DA622
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjJ1JUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJ1JUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 05:20:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22FDC6;
        Sat, 28 Oct 2023 02:20:14 -0700 (PDT)
Date:   Sat, 28 Oct 2023 09:20:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698484812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzwgE7hJFoAcrISD610JPwsdxWzfKRKqDZ4TenMWbhQ=;
        b=O1+13Bjj8fhl98byGjT/6bqpQLSzSRIPkU2yhO7pIbiCjEar1eqvA7bfpKSK1n4kOZV+J1
        IewZFUWWzafvCqAFXZa+K2eQJkZhco7T2VzGMbjUXgXO0HT3aN0WJMsPuZXXZp0c3Xein/
        SbRR8GO4MpclJSwHfihu8Rizs5oDmYMBPdcFo2JuxF9gmYnMHYP+KoiazNO3ERVU9fUpm8
        BlIUGfYEbzS5YdfWTTJoumDmIzy4P9HXe2HPj451bms/Ev3ZhNkW2j8IKuAO/AdoSS89m7
        U/RESycwFPwWYcsJUT0l/8crrX9AzNjf+enb1Z7s6mXXpWXLPgJ/INNWr8L+GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698484812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzwgE7hJFoAcrISD610JPwsdxWzfKRKqDZ4TenMWbhQ=;
        b=B+7bVKP13HWDfGHrZZxZEPuOBdP5iiEzwhtUNiai8+j5R8B2TAR+YBRMvX2Rea/vhmx42u
        iFcP+9/nnDQhTGAA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/headers] x86/headers: Remove <asm/export.h>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230806145958.380314-3-masahiroy@kernel.org>
References: <20230806145958.380314-3-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <169848481164.3135.9645125925587156994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/headers branch of tip:

Commit-ID:     8b01de80306cbd914be9c45bce30206a49699141
Gitweb:        https://git.kernel.org/tip/8b01de80306cbd914be9c45bce30206a49699141
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 06 Aug 2023 23:59:57 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 10:38:08 +02:00

x86/headers: Remove <asm/export.h>

All *.S files under arch/x86/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230806145958.380314-3-masahiroy@kernel.org
---
 arch/x86/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 4f1ce5f..a192bde 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,5 +10,4 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += early_ioremap.h
-generic-y += export.h
 generic-y += mcs_spinlock.h
