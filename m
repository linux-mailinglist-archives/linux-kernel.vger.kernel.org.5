Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A97559E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGQDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGQDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:11:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C000E4C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:11:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R46YC5G5fzBHYMQ
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:11:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689563471; x=1692155472; bh=5pfHnurrO8HEEiqTxHThC6NSN3N
        hBzCzjOJYI5fhtmA=; b=h2GkpB1WMZWKdK8hojZqWD+pucPXuDJtGi5WTY0lVBb
        i5coZ+lEWTihCBNcWXnwQj9Iex9eIt7uZVEZ1LMysRotAn6Bx1dAZweomJzKo3mp
        dq2Y/D3/LyyshaSsseLaVU5gfChwdZ8g8Ubpa2Ao2KfbFtCYswBen1goekhJLoln
        ant02pKO5vtMEonV/HYnKGCOh4wOKiEvQNEXIRtyUVMcnjpUTYC9dD+M+NQiiIAY
        BOQvd8RGOKfIYTiGH34RV9qhDSEKtH0h4Ve0pUWqnntwzCUCWsO3LHLepZgabhoS
        gUKDuFxDtY3b3nMudyY+QSb/SitrhbvrNQByy06K/iA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YuAaJkvRPn1H for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:11:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R46YC2GHgzBHYMC;
        Mon, 17 Jul 2023 11:11:11 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:11:11 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 3c574_cs: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_C283203D2CCA281A87720665D83277B4CE0A@qq.com>
References: <tencent_C283203D2CCA281A87720665D83277B4CE0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7f6fba66a5cad4486c04efe56ded5ae9@208suo.com>
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

This patch fixes the checkpatch.pl error

./drivers/net/ethernet/3com/3c574_cs.c:770: WARNING: Prefer 'unsigned 
int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/3com/3c574_cs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c574_cs.c 
b/drivers/net/ethernet/3com/3c574_cs.c
index 287af1d..6f5c9db 100644
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ b/drivers/net/ethernet/3com/3c574_cs.c
@@ -767,7 +767,7 @@ static irqreturn_t el3_interrupt(int irq, void 
*dev_id)
      struct net_device *dev = (struct net_device *) dev_id;
      struct el3_private *lp = netdev_priv(dev);
      unsigned int ioaddr;
-    unsigned status;
+    unsigned int status;
      int work_budget = max_interrupt_work;
      int handled = 0;
