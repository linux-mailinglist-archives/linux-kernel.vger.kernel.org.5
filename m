Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7137A71DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjITFWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjITFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E61F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OxzrvE1JC0Hk/FxRt+ZKzqjg6DJt/qiLZ+huaIf11C8=; b=Z73rZCZb2BfvYo6j5H1Sdnan/W
        68wUnbgRHHAerl/zgUOlP1Rg+c4W/rA8Qh2IN+3UVeEPc5g09LegkogfUhbONCiZyGYGE69GMUfZo
        c7q8xrxzucgScNj60o0lLwqQ+LOEGTCYn5UoukAhw5t4vIFO7DnsZ1gcuBkRxlYmIdzOQktRR1SHN
        sd4E0+YbOZz49Af6MM3+DyaH9Vidl5HOeU6mL2TG0z3JdJEB/mhcEdy4EyoDtL0JH/UUoWyAS6j4O
        UAbiQ1FhHMPzsVSscEXJqj7/RXiQzvXAkN2uTJJ+2wFbsbnQWlf9UI6uR+eNtlfLOAfQI0fYWjiCA
        YwE+mS7A==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeg-001tym-1A;
        Wed, 20 Sep 2023 05:21:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 01/16] xtensa: FSF: define XCHAL_HAVE_DIV32
Date:   Tue, 19 Sep 2023 22:21:24 -0700
Message-ID: <20230920052139.10570-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When variant FSF is set, XCHAL_HAVE_DIV32 is not defined,
so add the define for FSF to prevent build warnings:

arch/xtensa/lib/divsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32
arch/xtensa/lib/modsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32

Fixes: 173d6681380a ("xtensa: remove extra header files")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309150556.t0yCdv3g-lkp@intel.com
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/variants/fsf/include/variant/core.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/xtensa/variants/fsf/include/variant/core.h b/arch/xtensa/variants/fsf/include/variant/core.h
--- a/arch/xtensa/variants/fsf/include/variant/core.h
+++ b/arch/xtensa/variants/fsf/include/variant/core.h
@@ -41,6 +41,7 @@
 #define XCHAL_HAVE_MUL16		0	/* MUL16S/MUL16U instructions */
 #define XCHAL_HAVE_MUL32		0	/* MULL instruction */
 #define XCHAL_HAVE_MUL32_HIGH		0	/* MULUH/MULSH instructions */
+#define XCHAL_HAVE_DIV32		0	/* QUOS/QUOU/REMS/REMU instructions */
 #define XCHAL_HAVE_L32R			1	/* L32R instruction */
 #define XCHAL_HAVE_ABSOLUTE_LITERALS	1	/* non-PC-rel (extended) L32R */
 #define XCHAL_HAVE_CONST16		0	/* CONST16 instruction */
