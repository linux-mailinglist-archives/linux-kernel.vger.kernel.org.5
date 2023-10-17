Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146097CBC03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjJQHIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjJQHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:08:34 -0400
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53793
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:08:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---.V10zIDI_1697526506;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V10zIDI_1697526506)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 15:08:27 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Steve Rutherford" <srutherford@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Wang Jinchao" <wangjinchao@xfusion.com>, <x86@kernel.org>,
        "Yuntao Wang" <ytcoode@gmail.com>
Subject: [PATCH 0/2] x86/head/64: Mark the code as __head in mem_encrypt_identity.c
Date:   Tue, 17 Oct 2023 15:08:05 +0800
Message-Id: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to head64.c, mark all the code in mem_encrypt_identity.c as
__head since it runs in the identity address. This is part of the
patchset that builds the head code as PIE[1].

[1]: https://lore.kernel.org/all/cover.1689130310.git.houwenlong.hwl@antgroup.com

Hou Wenlong (2):
  x86/head/64: Move the __head definition to <asm/init.h>
  x86/sme: Mark the code as __head in mem_encrypt_identity.c

 arch/x86/include/asm/init.h        |  2 ++
 arch/x86/include/asm/mem_encrypt.h |  8 ++++----
 arch/x86/kernel/head64.c           |  3 +--
 arch/x86/mm/mem_encrypt_identity.c | 27 ++++++++++++++-------------
 4 files changed, 21 insertions(+), 19 deletions(-)


base-commit: 0c09c1d70838475762255844b72fa0e7fd6ace7c
--
2.31.1

