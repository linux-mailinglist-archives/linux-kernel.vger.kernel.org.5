Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B917711CB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHETiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHETiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:38:16 -0400
X-Greylist: delayed 3512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 12:38:10 PDT
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112DC4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:38:10 -0700 (PDT)
X-QQ-mid: bizesmtp82t1691264283te037nhn
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:38:01 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: +Fw3Sd5mYDVqz4iAmVsa/lmFOKZPfF6chMKgeqPNECbG7H6X5GX9IjhBCT5TW
        FMmSjX/F+mQ4P9NIraT9+IyeVmeqTbHBFi70LeA2rhjEC3NSD8ZkH5KuwG14X1t0z2KhjKk
        CkCoYpnHjhx1P1T2+CVVfgZH9og9o6+WdcRYyvxeWSuR3AXvp4WCkSWJbaCOT5O2bghaC4J
        SKVKn7NDb2JJELT65wI4MiVAbycc0wUs7mkvQf1cyNwjmxXQCcmb56Ie2fFtmGZHGAUrK7p
        vywfLbTylX1T6dyP+kGsKuA24+NXuWpol8WAarUqpjw3s4OEc9g8OSfsWjrbF7rnlEqqIGD
        ZXRuhcGEuPoB7ao2/Bq4seBiVd3XsKYblhrG9FrE8hCwl7pUN57qAyC7fsKIPf3YCTrDXf/
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7154856130623740030
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v1 1/4] selftests/nolibc: allow use x86_64 toolchain for i386
Date:   Sun,  6 Aug 2023 03:38:01 +0800
Message-Id: <4b0af38b9a799835b1bb89445da7a40b0df79b54.1691263493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691263493.git.falcon@tinylab.org>
References: <cover.1691263493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to share the same x86_64 toolchain for i386 architecture.

Pass '-m32' CFLAGS to tell x86_64 toolchains to generate i386 executable.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b4171a754eb2..e2b02761ad44 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -122,6 +122,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = -m32
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
-- 
2.25.1

