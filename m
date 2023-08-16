Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5277D723
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjHPAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbjHPAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:38:48 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1D1BFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:38:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VptSxww_1692146323;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VptSxww_1692146323)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 08:38:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, steve.wahl@hpe.com, justin.ernst@hpe.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] x86/apic: clean up one inconsistent indenting
Date:   Wed, 16 Aug 2023 08:38:42 +0800
Message-Id: <20230816003842.116574-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kernel/apic/x2apic_uv_x.c:113 early_get_pnodeid() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1cedb2519938..cfd4a1c1aec9 100644
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
-- 
2.20.1.7.g153144c

