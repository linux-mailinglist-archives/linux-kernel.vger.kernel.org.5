Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F180ED17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376614AbjLLNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376610AbjLLNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:07 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 05:17:12 PST
Received: from fzi-msx-e-01.fzi.de (fzi-msx-e-01.fzi.de [141.21.8.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B864109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:17:12 -0800 (PST)
From:   Frederik Haxel <haxel@fzi.de>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Frederik Haxel <haxel@fzi.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nam Cao <namcaov@gmail.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Anup Patel" <anup@brainfault.org>, Baoquan He <bhe@redhat.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Fix XIP boot and make XIP testable in QEMU
Date:   Tue, 12 Dec 2023 14:01:11 +0100
Message-ID: <20231212130116.848530-1-haxel@fzi.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [141.21.46.139]
X-ClientProxiedBy: fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45) To
 fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XIP boot seems to be broken for some time now. A likely reason why no one
seems to have noticed this is that XIP is more difficult to test, as it is
currently not easily testable with QEMU.

These patches fix the XIP boot and allow an XIP build without BUILTIN_DTB,
which in turn makes it easier to test an image with the QEMU virt machine.

Frederik Haxel (3):
  riscv: Make XIP bootable again
  riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro
  riscv: Allow disabling of BUILTIN_DTB for XIP

 arch/riscv/Kconfig                 | 6 +++---
 arch/riscv/include/asm/xip_fixup.h | 2 +-
 arch/riscv/kernel/head.S           | 5 ++++-
 arch/riscv/mm/init.c               | 8 ++++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.34.1

