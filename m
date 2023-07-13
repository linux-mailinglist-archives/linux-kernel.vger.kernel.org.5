Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921CA751D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjGMJ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGMJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:26:02 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F316210A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:25:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R1q3Q2yGCz4f3lXD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:25:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+khw69kr7cmNw--.13397S2;
        Thu, 13 Jul 2023 17:25:55 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 0/8] Remove unused parameters in page_table_check
Date:   Fri, 14 Jul 2023 01:26:28 +0800
Message-Id: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+khw69kr7cmNw--.13397S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy8tF4UAF48Cw1rXF45Awb_yoW8XF4kpw
        nxX3sIqr4ru345Zr1UAr4vvr18J3y5JayxXFyxGr4Fqw1qyry8JF9rJFna9a95Ga4rJF4x
        KFWYqryUKF1UAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRE
        SoGDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this series remove unused parameters in functions from
page_table_check. The first 2 patches remove unused mm and addr
parameters in static common functions page_table_check_clear and
page_table_check_set. The last 6 patches remove unused addr parameter
in some externed functions which only need addr for cleaned
page_table_check_clear or page_table_check_set. There is no intended
functional change. Thanks!

Kemeng Shi (8):
  mm/page_table_check: remove unused parameters in
    page_table_check_clear()
  mm/page_table_check: remove unused parameters in
    page_table_check_set()
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pte_clear
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pmd_clear
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pud_clear
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pte_set
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pmd_set
  mm/page_table_check: remove unused parameter in
    [__]page_table_check_pud_set

 arch/arm64/include/asm/pgtable.h | 12 +++---
 arch/riscv/include/asm/pgtable.h | 12 +++---
 arch/x86/include/asm/pgtable.h   | 16 ++++----
 include/linux/page_table_check.h | 66 ++++++++++++--------------------
 include/linux/pgtable.h          |  6 +--
 mm/page_table_check.c            | 50 +++++++++---------------
 6 files changed, 65 insertions(+), 97 deletions(-)

-- 
2.30.0

