Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BE7C4D57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJKIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:35:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042D93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:35:38 -0700 (PDT)
X-QQ-mid: bizesmtp71t1697013251tdcqqafe
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 11 Oct 2023 16:34:09 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: FwowAM4HOqAVKxvoHOg+FFtkzyhqthXdQT4dyvq8RM0ldk9sx097/DTTVtTym
        zDrumLi3wKzCr8HeAtYLjJAO0L0+aIbGeOa415C5O9jPe7FMnKkoUVvHuiA9aKuYc+9Q1aM
        9cJ/snUP8/szBAD7Bjs3eaWzuqEX+BnI7N+51e2OV79N001z7CTBNMWbJqV+bykxn7ic2Q7
        RRHq54a8wsMzE6aZmUluVyilqnAsv/dg/rJUBkGm4OBESBJw3+EzrA5i0dRI+0hK+/Dazvv
        F6v2yTOubJMkx7Sf6/j1qLEQN3zoG54wpS3sggddPKE3seMGmKHz2Dx4zAl25vrsVzJFfqU
        bs1DClkTvFRJjSLK+rmaGFnDXt4enoq7xPY3bzlojOIb1ZqDxL5jep7gSIHFg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10839386821577447536
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        lihuafei1@huawei.com, songshuaishuai@tinylab.org,
        petr.tesarik.ext@huawei.com, duwe@suse.de, ribalda@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org, hi@alyssa.is,
        heiko@sntech.de, alexghiti@rivosinc.com, schwab@suse.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 2/2] riscv: kexec: Remove -fPIE for PURGATORY_CFLAGS
Date:   Wed, 11 Oct 2023 16:31:32 +0800
Message-Id: <20231011083132.2428720-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
References: <20231011083132.2428720-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.155.65.254 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.65.254 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.155.65.254 listed in bl.score.senderscore.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.155.65.254 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_RELOCATABLE enabled, KBUILD_CFLAGS had a -fPIE option
and then the purgatory/string.o was built to reference _ctype symbol
via R_RISCV_GOT_HI20 relocations which can't be handled by purgatory.

As a consequence, the kernel failed kexec_load_file() with:

[  880.386562] kexec_image: The entry point of kernel at 0x80200000
[  880.388650] kexec_image: Unknown rela relocation: 20
[  880.389173] kexec_image: Error loading purgatory ret=-8

So remove the -fPIE option for PURGATORY_CFLAGS to generate
R_RISCV_PCREL_HI20 relocations type making puragtory work as it was.

Fixes: 39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 9e6476719abb..982fc8e77108 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -81,6 +81,10 @@ ifdef CONFIG_CFI_CLANG
 PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
 endif
 
+ifdef CONFIG_RELOCATABLE
+PURGATORY_CFLAGS_REMOVE		+= -fPIE
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.20.1

