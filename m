Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374597A664A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjISOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjISOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:15:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4699C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqkGD16ndz4f3kjw
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:15:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdwErQllkNB7Aw--.46916S4;
        Tue, 19 Sep 2023 22:15:32 +0800 (CST)
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
To:     masahiroy@kernel.org, mcgrof@kernel.org, joe@perches.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org
Cc:     xiexiuqi@huawei.com
Subject: [PATCH 0/3] scripts/export_report.pl: some bugfix for exported symbols checking
Date:   Tue, 19 Sep 2023 22:11:18 +0800
Message-Id: <20230919141121.711084-1-xiexiuqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdwErQllkNB7Aw--.46916S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45ZF4kKFyDXryxWrWruFg_yoW8AryDpF
        Z3K3y0y3ykAFyrt3WrJrWkCryYyFW3Zry8Wry5Kw15XwsrArZrJ3Za9r15WFWUZw4ktFZ2
        yFnFk3sFyFs0qwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: x0lh5xhxtlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie XiuQi <xiexiuqi@huawei.com>

'make export_report' with CONFIG_MODVERSIONS enabled, but we get this warning
message and empty export-symbol-usage SECTION.

  $ make export_report
  ...
  WARNING:fs/efivarfs/efivarfs.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:drivers/thermal/intel/x86_pkg_temp_thermal.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/nf_log_syslog.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/xt_mark.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/xt_nat.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/xt_LOG.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/xt_MASQUERADE.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/netfilter/xt_addrtype.o is not built with CONFIG_MODVERSIONS enabled
  WARNING:net/ipv4/netfilter/iptable_nat.o is not built with CONFIG_MODVERSIONS enabled
  ...
  
  SECTION 2:
          This section reports export-symbol-usage of in-kernel
  modules. Each module lists the modules, and the symbols from that module that
  it uses.  Each listed symbol reports the number of modules using it
  
  NOTE: Got 9 CONFIG_MODVERSIONS warnings

The causes of the problem is that the formats of modules.order and .mod.c are
changed, but the modification for export_report.pl is missing. So, fix them.

Xie XiuQi (3):
  scripts/export_report.pl: fix the path suffix of module
  scripts/export_report.pl: use the module name in warning message
  scripts/export_report.pl: fix modversion checking

 scripts/export_report.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

