Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48E802A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjLDCXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:23:49 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5834BC1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:23:54 -0800 (PST)
X-QQ-mid: bizesmtp82t1701656608ty8azrma
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Dec 2023 10:23:21 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: uGhnJwy6xZKw3HYMUMtltLGm75iKrd0p9Mg4/P8rycRmhTyVbD11w/SP4bnWS
        xkFnJqlin6yip5DFMzorO23bnDYDqkAa53H9SKei1jG30ThzFmOQ18rKB6knc7iBaOurEBi
        UtMz5/WbYXY3fsMQDLbBnzr/Gk8cj/hbb6LaM+djjX4aqDdSRKUrFqm6F3xqzMT4iswY4Ll
        uN2cZS6upIg85/ItXCf7i8HmVr/8RUqeKPWo01J4b8yvLwUbKgqvbcfv3SGNK+QWkn7J+1q
        eg4TcD2f2WYioztZpfXgvgXyesSPrhHxjzm3hAJQevs/h/aRXPliziDbZFRF5yvoenE2F3M
        zEHEllLyrEKYGf1QczFwrAqeWeDfFXfUlvUpk0sGCNZ0GIQx8E01V+qwqZ09TNwUPbF9VeF
        JweGbcYAIaU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17993081573831466038
From:   Luming Yu <luming.yu@shingroup.cn>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH 2/2] powerpc/locking: enable HAVE_CMPXCHG_LOCAL in kconfig
Date:   Mon,  4 Dec 2023 10:23:02 +0800
Message-ID: <4250629DA95C6D4F+20231204022303.528-2-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231204022303.528-1-luming.yu@shingroup.cn>
References: <20231204022303.528-1-luming.yu@shingroup.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable arch feature HAVE_CMPXCHG_LOCAL for ppc by default

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..c10229c0243c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -226,6 +226,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
-- 
2.42.0.windows.2

