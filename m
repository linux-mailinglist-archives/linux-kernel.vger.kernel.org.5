Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC27A979F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjIUR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIUR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12D2DEB4;
        Thu, 21 Sep 2023 10:25:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:29:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695284985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAGt/qwNIFdIGEzhI11MBn4XRza5k0JE5+9/NISOHhY=;
        b=ScnTURpN16vW6iwjSl16CC96C1l+22AaY6cRbnp8qyfUH0udrcr3dV7dn0vYoHFUv1YTG3
        BQgYwCpZo6EvQmuJHJJLtDdU/BEt+G1SaZR7/2yjoViIbIgwynfRHevrsKmbvOvReozM3e
        xp3nAFzfdANYMptQjGozgbVrfbnzWzAehRkgRALCGEQ7XXtYz+1PJRUy4h+QEARDwStzdV
        Fp/O0H8ug1y9aIPJJkik7V860wH3IvSKQ/BDZsZSP0fOiOt6yAFmDzwI+LhzvU7Rcqvkp0
        sUrUrGxVp/Y+23lZ7W6Enm0TOp48yv7GOUvES36+J1CcofoJz056xWbpTsLm1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695284985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAGt/qwNIFdIGEzhI11MBn4XRza5k0JE5+9/NISOHhY=;
        b=0qsK5BczhH73fXFQm2OWE/klFiV7+Nje1amRzOnzbSdKBFa476s9txvOBlfLokJOwt6TMF
        QrrgNYYhZrE/3zBQ==
From:   "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/platform/uv/apic: Clean up inconsistent indenting
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816003842.116574-1-yang.lee@linux.alibaba.com>
References: <20230816003842.116574-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <169528498468.27769.16255395394299387993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     57baabe36573c1dc22a53a9ceed748d3e28fe910
Gitweb:        https://git.kernel.org/tip/57baabe36573c1dc22a53a9ceed748d3e28fe910
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Wed, 16 Aug 2023 08:38:42 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 10:22:13 +02:00

x86/platform/uv/apic: Clean up inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230816003842.116574-1-yang.lee@linux.alibaba.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 205cee5..7d304ef 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -110,7 +110,7 @@ static void __init early_get_pnodeid(void)
 	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
 		union uvh_rh_gam_addr_map_config_u  m_n_config;
 
-	m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
+		m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
 		uv_cpuid.n_skt = m_n_config.s.n_skt;
 		if (is_uv(UV3))
 			uv_cpuid.m_skt = m_n_config.s3.m_skt;
