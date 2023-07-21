Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADB75C177
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGUIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGUIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:24:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB3ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:24:12 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6jJT1NGvzBRDsH
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:24:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689927849; x=1692519850; bh=uKz/lYTXVbp7dyPkEj/qVBdvy+E
        9BEwlnFlNbHF1bP4=; b=RLqFg3Nz928eRSJ3mlSN03ZGycHq7/zHz4B3yxYRg3H
        wTCHZS1Hm36hDzKu1kZMmc5GX/8K89Oi9T3BpssIf6Rrqhf5RSQFWiaW3NzjwoqG
        9tzNCWTNvBTnui/Y54Sb5KUDHWzes8ICKbUOk6u6E3iZg3MzIvqc/o9N6rayD92o
        RfuM1GMgqYmO6uaIiDulySRFCcML4OyoEwPIVuj7AjbPNHUUy0Loq3EDAQiLuZb/
        s0YNQUpSO/e/6xWtz2TCA/g5251JZ7CpC0JEplhec5r3mAr60r5607ac0X/5ogxj
        V+4S5c19lOzJdSSDBoY7F5o5P4SSLaEspVZqIgCSv+A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XU6636Klb8sX for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:24:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6jJS6DF9zBJnMj;
        Fri, 21 Jul 2023 16:24:08 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:24:08 +0000
From:   sunran001@208suo.com
To:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/acpi/boot: Remove unnecessary parentheses
In-Reply-To: <20230721082253.5944-1-xujianghui@cdjrlc.com>
References: <20230721082253.5944-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <260758dc7d70a6bb7f5d5c5717696f63@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "return is not a function, parentheses are not required" checkpatch
error.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/acpi/boot.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 457f1f6622d0..31c0cb4b16e2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -860,7 +860,7 @@ int acpi_unmap_cpu(int cpu)
  	set_cpu_present(cpu, false);
  	num_processors--;

-	return (0);
+	return 0;
  }
  EXPORT_SYMBOL(acpi_unmap_cpu);
  #endif				/* CONFIG_ACPI_HOTPLUG_CPU */
