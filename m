Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4875A639
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGTGV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGTGV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:21:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692291BC0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:21:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R62dH3yr6zBRDs0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:21:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689834083; x=1692426084; bh=A1UkE9BmwFqy4HZWHUP5PTuquC9
        ad5V23RI/HosL2wg=; b=vVO2D9SQ/mtL3DY7EESWBNG7ill+3LoMPI8LnaajRzf
        w62bvHu5l9KBiNu/QRnKURbmh6i4Wslof3TO0GG+dE/H+OsMItmzMAJMQQBV2owq
        RLh2Rc+cBVfW4RhQH8nGq3FXMApi5oF+//C2V5p58VhKKrKHfzjl1qEtOm1hkSQl
        lQnYRjj+KqvYRDicQyF7uhbA5DflYZLVuErnNRKXkOCnpWRvtHbcWMR6qmaTJSQs
        svMVySAM2GExBH9z1AwfXitNABcHNKOjtYAzCchI5d1V1f2dfe4UpL39u7lIKVe7
        7js+7/Zh729hU98g1/JZuNYC1dosSS4Ihkz+UEN5tYg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e_vgpJm_LZ4h for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:21:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R62dH262YzBR1P6;
        Thu, 20 Jul 2023 14:21:23 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:21:19 +0800
From:   hanyu001@208suo.com
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: kernel: "foo * bar" should be "foo *bar"
In-Reply-To: <tencent_30B748128B938A55A13C4143B6101D6BF308@qq.com>
References: <tencent_30B748128B938A55A13C4143B6101D6BF308@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <e619510596477a54133a005be0a7e665@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

./arch/parisc/kernel/parisc_ksyms.c:107: ERROR: "foo * bar" should be 
"foo *bar"

Signed-off-by: Yu Han<hanyu001@208suo.com>
---
  arch/parisc/kernel/parisc_ksyms.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/parisc_ksyms.c 
b/arch/parisc/kernel/parisc_ksyms.c
index 00297e8..c1a11493 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -104,7 +104,7 @@
  EXPORT_SYMBOL(__muldi3);
  EXPORT_SYMBOL(__ucmpdi2);

-asmlinkage void * __canonicalize_funcptr_for_compare(void *);
+asmlinkage void *__canonicalize_funcptr_for_compare(void *);
  EXPORT_SYMBOL(__canonicalize_funcptr_for_compare);

  #ifdef CONFIG_64BIT
