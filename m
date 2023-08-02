Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0776C4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHBFUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjHBFTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:19:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCA210D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/0CU48Zw70eP8gCcZfPtoIrEyWctIOGQrz7h9ITawzM=; b=BjWKxpZG+8KfojucOLyUNYAbPV
        r84HoLLtxHBma5a0aWgIcRFjRNK14l2Gc8kotnZxbLuxpfNxOjvtW6xsfqrhzQbRXpRPm4Yd652Ft
        bjnE4WB/9sX2mPzHNTm6+vkqOVZDaC1FoSdNshu/MWLA65YnHBguCmoSGay2n+5cYIoOjPl+Nyyfc
        fETQHCV6cgvsqJFXdsn+zhCUfQLni74w37zWDSnDoUUBhuy/O32OgtXe7KKR+MvGzDRQqtKGUC2Rb
        lYQi1Oock4Fy10eaudKkN5ZH3YNSVLTzFw7yiz/+tLhsxz0+a0fafMYdqRsnyYBy8SovyY4Wq0tPR
        MP9pjzpQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR4Ga-0042og-39;
        Wed, 02 Aug 2023 05:19:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH RESEND^2] nios2: support clone3() syscall
Date:   Tue,  1 Aug 2023 22:19:24 -0700
Message-ID: <20230802051924.7837-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the clone3() syscall to prevent a warning from
checksyscalls.sh:

<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Christian Brauner <christian@brauner.io>
---
Is there some reason that NIOS2 should not (does not) support clone3()?

 arch/nios2/include/uapi/asm/unistd.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -22,6 +22,7 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
