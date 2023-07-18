Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4C757359
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGRFsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:48:40 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9210C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:48:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4p0K5v0xzBHXhK
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:48:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689659313; x=1692251314; bh=Gu+rNwPS98EfN/nf1FC0RCiifB1
        aY8jnrwiEnASRdE8=; b=EE9jMhICvNSK1FQ2mw27X/8TzYGz/9N+e85ediDPK66
        aUjzgvRW43o8huQxQ++zTDQIbcwO5g18asEWdTu+MEZZdNHkypXLESequoXemNwr
        Ul7/AMfWX2WWeetVgoZMAZYdeAeEVXjB5zrh47dxRtkFW6dt8nOKHstnFMk6EMo6
        JzRwBCccKa5GOHfVH5QF0oZ/RkdiDc+lRiXsiykFsKP8mwPRyPi625k7Jf0fnVkI
        sNEoNAc/p7I8h9McoFYaI/NqjqAMUqxghM4GM2gq/YB9xjeUolqV1/ScWh0Ykcg8
        3LBbKzuZChdJVh0fWBAw1c1zjVO+2/aR/ykU1svPgCA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4w1KxRV-bUUD for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 13:48:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4p0K32QjzBQslS;
        Tue, 18 Jul 2023 13:48:33 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 13:48:33 +0800
From:   shijie001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: Fix errors in af_llc.c
In-Reply-To: <tencent_4CED92D1C8320CEA29489ED8DFEF3614EB05@qq.com>
References: <tencent_4CED92D1C8320CEA29489ED8DFEF3614EB05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7da2f0c57e848c77ab30a948dc73653a@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo* bar" should be "foo *bar"
ERROR: space required before the open parenthesis '('

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  net/llc/af_llc.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 9ffbc667be6c..f0891088e7be 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -124,9 +124,9 @@ static inline u8 llc_ui_header_len(struct sock *sk, 
struct sockaddr_llc *addr)
   *
   *    This function always consumes a reference to the skb.
   */
-static int llc_ui_send_data(struct sock* sk, struct sk_buff *skb, int 
noblock)
+static int llc_ui_send_data(struct sock *sk, struct sk_buff *skb, int 
noblock)
  {
-    struct llc_sock* llc = llc_sk(sk);
+    struct llc_sock *llc = llc_sk(sk);

      if (unlikely(llc_data_accept_state(llc->state) ||
               llc->remote_busy_flag ||
@@ -1030,7 +1030,7 @@ static int llc_ui_getname(struct socket *sock, 
struct sockaddr *uaddr,
          rc = -ENOTCONN;
          if (sk->sk_state != TCP_ESTABLISHED)
              goto out;
-        if(llc->dev)
+        if (llc->dev)
              sllc.sllc_arphrd = llc->dev->type;
          sllc.sllc_sap = llc->daddr.lsap;
          memcpy(&sllc.sllc_mac, &llc->daddr.mac, IFHWADDRLEN);
