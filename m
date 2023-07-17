Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B1755BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjGQG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGQG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:29:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057EC172A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:29:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4BxJ6SbMzBHXhQ
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:28:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689575332; x=1692167333; bh=gYfLRyY+eBS7ELomGMNo4u0qwZ+
        q7EitNu0BbhLxNN0=; b=kuit9gHhjoxniS43GPa4tZuiKakP7Pbe/PQB4Z4dKie
        TtgWMsRgG5pJlUZ2ISKvXL8yIKDvak3srA0jzE9G2ZF/cd7IiG19IheQTbFmGn9Z
        tuQ49ralXs/NzpjvG6ruopqt0u7Ebc05HwSHvsLE9KkaMkpFqGbZ9nVd8TTDFAMz
        gM1SJCdSFaYifovW7KOJGCeVE5uDOCO0zMc6bndU1BcFa8rzuxSgw1/4y8CFgYzA
        tpqOli+VPgsmNQGPSYALw+tuBcF6/3+EbAE3j5NX3zM9Dn9RZUgKxpMU4uWOaY+v
        SQwK/N+nLmIG5UQgh7zB2rxW5u+ZGCka3zxau2Ede4A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5e3HsuDMwbnr for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 14:28:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4BxJ45dGzBHXgf;
        Mon, 17 Jul 2023 14:28:52 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 14:28:52 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net: space required after that ','
In-Reply-To: <tencent_42BF9168164914C9431B82386C853B9EE609@qq.com>
References: <tencent_42BF9168164914C9431B82386C853B9EE609@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <e0580876db3dbe6f9fedd2eb210bfe07@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

./drivers/net/ethernet/realtek/8139cp.c:1141: ERROR: space required 
after that ',' (ctx:VxV)
./drivers/net/ethernet/realtek/8139cp.c:1152: ERROR: space required 
after that ',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/realtek/8139cp.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c 
b/drivers/net/ethernet/realtek/8139cp.c
index f5786d7..6c828b4 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1138,7 +1138,7 @@ static void cp_clean_rings (struct cp_private *cp)
      for (i = 0; i < CP_RX_RING_SIZE; i++) {
          if (cp->rx_skb[i]) {
              desc = cp->rx_ring + i;
-            dma_unmap_single(&cp->pdev->dev,le64_to_cpu(desc->addr),
+            dma_unmap_single(&cp->pdev->dev, le64_to_cpu(desc->addr),
                       cp->rx_buf_sz, DMA_FROM_DEVICE);
              dev_kfree_skb_any(cp->rx_skb[i]);
          }
@@ -1149,7 +1149,7 @@ static void cp_clean_rings (struct cp_private *cp)
              struct sk_buff *skb = cp->tx_skb[i];

              desc = cp->tx_ring + i;
-            dma_unmap_single(&cp->pdev->dev,le64_to_cpu(desc->addr),
+            dma_unmap_single(&cp->pdev->dev, le64_to_cpu(desc->addr),
                       le32_to_cpu(desc->opts1) & 0xffff,
                       DMA_TO_DEVICE);
              if (le32_to_cpu(desc->opts1) & LastFrag)
