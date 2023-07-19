Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F57590D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGSJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjGSJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:01:31 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C219B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:01:17 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5VDB2YdbzBR1NZ
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:01:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689757274; x=1692349275; bh=5jTBrlBpaXbneCRhhoxAJ0k+U/g
        EFkX4S81v1MjnjK4=; b=iHzOFG4JZy3llVVW7xe/Zk9WX979XyVIXf0vG12ywLZ
        /NNBtUS3+YbIeyZXpBYPel2zUe3oTlJBpIlaJWqSblvmgb4vhWpcRHnnfi842fZA
        XhPmc7/rwibSN+anCDva7GOleKrRWJpyW0uYtu1Uz5r7eU8OryDOlIZVCThFCAGc
        9WEGSqQxI/YatQ0mD06RsEkKTOcI1QwTZLSfXXNaGvIcFpFN/QNp2uS1uW2d5flR
        Z4Xtwd/XWhyXirfHqYf9L4fRrzh8u5vKBeJjRIGfaq55GuHPCGME6toz1g4XyhjH
        0BScOhyDO+1FqentDjfUwL5Y9gJiZVSGQQouap4441A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KlcnStZzMdHt for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:01:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5VDB12RQzBQskt;
        Wed, 19 Jul 2023 17:01:14 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:01:14 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: powermac: "foo* bar" replace with "foo *bar"
In-Reply-To: <tencent_C5AA0B2A51C60188B468D96BC7CF03051809@qq.com>
References: <tencent_C5AA0B2A51C60188B468D96BC7CF03051809@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <808db4cae30043c168daefebbd16067e@208suo.com>
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
