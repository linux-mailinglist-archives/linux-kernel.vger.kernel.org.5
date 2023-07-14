Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003E75310D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjGNFTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjGNFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:19:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1359270D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:19:45 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2KXv4sHvzBR9sc
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:19:43 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689311983; x=1691903984; bh=At8lmoauX9v2oTiORwjDI33z2M6
        o4w+WjSNw9jM0y3Y=; b=HS/I5ZIGsp0xFLQLI8qCAVp+0v3Vs8eXWG/e+VzAAQJ
        eNqnoaYK9j11XVkELYTLLbAIuUMqemvpMsNQJSCupTvyPWi9J87I07GdipqxfBPX
        /vTBXObTbBQoEqOiQT0LSzX5p0MCiTYanERPIumWh2hdbjE/c1zmmDOLTUTw3zkk
        s84IlU+slrEljub0kMbpSVXcRAZoFWEJSuFjA68yrcwws+Hi2SQTA4rsDeiCzdbS
        8qxytjvpkChjSpnU8BF7jpipHzXIxRGdQ31WFrnuWArqnu4hkGCfjPYYUI4tUDBb
        x+lS3BxZy4V08wHOKhybahGc71PGn9KRcm352fvCNoQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id todjhcOXzN24 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:19:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2KXv2bkgzBHXhS;
        Fri, 14 Jul 2023 13:19:43 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:19:43 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: insn:#include <linux/kprobes.h> instead of
 <asm/kprobes.h>
In-Reply-To: <tencent_3C94F9BD7A26C7C7057F8C6CAB681E8ECD05@qq.com>
References: <tencent_3C94F9BD7A26C7C7057F8C6CAB681E8ECD05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <5dc4597a17908d03fd9c7c9007138a85@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/kprobes.h> is a generic header file, while
<asm/kprobes.h> is an x86 architecture-specific
header file.

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/lib/insn.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 924934cb85ee..080dd263fd6e 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -14,7 +14,7 @@
  #include <asm/debug-monitors.h>
  #include <asm/errno.h>
  #include <asm/insn.h>
-#include <asm/kprobes.h>
+#include <linux/kprobes.h>

  #define AARCH64_INSN_SF_BIT    BIT(31)
  #define AARCH64_INSN_N_BIT    BIT(22)
