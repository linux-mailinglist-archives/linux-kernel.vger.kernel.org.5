Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11387A9114
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjIUCuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIUCun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:50:43 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B3CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:50:35 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38L2oThK059250;
        Thu, 21 Sep 2023 10:50:29 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Sep 2023
 10:50:27 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v4 0/3] Improve PTDUMP and introduce new fields
Date:   Thu, 21 Sep 2023 10:50:19 +0800
Message-ID: <20230921025022.3989723-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38L2oThK059250
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enhances PTDUMP by providing additional information
from pagetable entries.

The first patch fixes the RSW field, while the second and third
patches introduce the PBMT and NAPOT fields, respectively, for
RV64 systems.

Yu Chien Peter Lin (3):
  riscv: Improve PTDUMP to show RSW with non-zero value
  riscv: Introduce PBMT field to PTDUMP
  riscv: Introduce NAPOT field to PTDUMP

 arch/riscv/include/asm/pgtable-bits.h |  4 +-
 arch/riscv/mm/ptdump.c                | 53 +++++++++++++++++----------
 2 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.34.1

