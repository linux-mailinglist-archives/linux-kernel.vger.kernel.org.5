Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF157590AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGSIx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGSIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:53:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA60136
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:53:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5V3c6sH6zBJBHm
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:53:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689756828; x=1692348829; bh=5jTBrlBpaXbneCRhhoxAJ0k+U/g
        EFkX4S81v1MjnjK4=; b=ex2FhJbf5Hw3Oj9o6uRCUkaSy75G9r1LB/pvVQ5sOzY
        TA0+boIJVrg34Folj3+IKVtdzjjpy56FRUsHlxfuG9JtDan+WA5XAbWOd0OqM26o
        nZiafsz7rDAJOMzRUsbN26A4puWVbYXSixXSFTsLOaBogIOuxeORjoqICmwBrqxW
        Fd5SZ6foYtrctMCMrWJYtVzAoiJHFMKLzSa4M6dyhNDKp6wfYmZ6t4Bg7Jlb9q95
        FAW0IlITX9NuF95T9J/feTNkgvYGDE8J79izhENVyMmW504M4x6qm32i8GKSQlMf
        J5EAIw13DlQKOOXuEwTd9Cc5NcIwm/A+kNNkyj3f44g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DNtAO0taQEGr for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 16:53:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5V3c4S7WzBHYMG;
        Wed, 19 Jul 2023 16:53:48 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:53:48 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, robh@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: powermac: "foo* bar" replace with "foo *bar"
In-Reply-To: <tencent_F5ACD262BC92A89156BA56E9FC5300BE1A05@qq.com>
References: <tencent_F5ACD262BC92A89156BA56E9FC5300BE1A05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ead1920f07ad9b7e0a0c7667ba3ee93a@208suo.com>
X-Sender: hanyu001@208suo.com
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

Fix below checkpatch error:

/platforms/powermac/pfunc_core.c: ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/pfunc_core.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c 
b/arch/powerpc/platforms/powermac/pfunc_core.c
index 07555c1bb484..7d01352a69f5 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -105,7 +105,7 @@ static u32 pmf_next32(struct pmf_cmd *cmd)
      return value;
  }

-static const void* pmf_next_blob(struct pmf_cmd *cmd, int count)
+static const void *pmf_next_blob(struct pmf_cmd *cmd, int count)
  {
      const void *value;
      if ((cmd->cmdend - cmd->cmdptr) < count) {
