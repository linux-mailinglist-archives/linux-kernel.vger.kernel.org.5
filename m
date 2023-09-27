Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B528F7B0BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjI0SO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:14:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DBEB;
        Wed, 27 Sep 2023 11:14:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so7895250a12.3;
        Wed, 27 Sep 2023 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695838463; x=1696443263; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq+VxeX6yPtc75wO/O6xkDPUJ9EYRWMtvf8PqV0DLZc=;
        b=G8ZKkpP10HzAxCu4ygdkNxVTO1Nd+6CYN6RyY2kQIQ+5o5RmB2mRkwonRKSA/szc6K
         a6cZlM4//UkL+bKdT4cr4kpV7W83irHqL7yvMX2k9eW/JxfKsXkpyt4N6zCyZzsgVBKS
         MI7orFbBIPp1ng1ECX0M49PLx9r8BRDUAT8KVbuHOXtYkSU2cCtq4QACD3MViXgQSAvY
         u5z0MKHne/AJDYCJua2UT3/piSsbnPMZrrTUNLeZKvswcU4YQHFDvhWxHuUYY9PCY/L8
         +AP/Zsd0Y88HIgZJJwbU/0KpYAlXd32LeUUF183/oNnmnqoIfetnn2T92D0OY3vqAaVe
         y05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695838463; x=1696443263;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq+VxeX6yPtc75wO/O6xkDPUJ9EYRWMtvf8PqV0DLZc=;
        b=Auzg/504iE1K47M6eCR5r5SYzDKKouUCUTXURNCoQJYUWGqqf3JgKosDgy2LQ6Z7Zx
         wd/Sju//FxfYGaOgrsvae3A7nFR9Qk08+mPUsnowMkwlwIhgYYBThZJJ+g5Jx4lH8G5o
         IZxGvKXgKXlALwWm8kuDUOV64sDeObqV1ujCCtDVfVUNbxAzX7+buM0fNdYqMDkhUPEF
         WEVTrtyw8i0P2zLBo2xam/XHkh9xOeBMkOSE3ZjNhXR2Aibqd3qLmPsmsmcTHruQUOxW
         +JblZaf5x24OdW9wbQaciibN107Iw5UE6LGGRKAUuLKUA7E9244xjMrOWxRc7ETVNECj
         lTPA==
X-Gm-Message-State: AOJu0Yx5l/ORMpqvrwM9T3DgCcRq4iV3yra8E97nfWUK3EGDdthAC1W7
        Qe1xsFW4K9h4EA0yFUjyBmc=
X-Google-Smtp-Source: AGHT+IGMPOvhhOHHbDoo4pelaJxsrX5/Ixdl0FbELXJqXsLid9awUR156a+UtivLuhoqnFzNxbbBXQ==
X-Received: by 2002:a17:90b:1205:b0:269:3771:7342 with SMTP id gl5-20020a17090b120500b0026937717342mr2247872pjb.18.1695838462709;
        Wed, 27 Sep 2023 11:14:22 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b0026801e06ac1sm13368921pjg.30.2023.09.27.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:14:22 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] tipc: fix a potential deadlock on &tx->lock
Date:   Wed, 27 Sep 2023 18:14:14 +0000
Message-Id: <20230927181414.59928-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that tipc_crypto_key_revoke() could be be invoked by
wokequeue tipc_crypto_work_rx() under process context and
timer/rx callback under softirq context, thus the lock acquisition
on &tx->lock seems better use spin_lock_bh() to prevent possible
deadlock.

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

tipc_crypto_work_rx() <workqueue>
--> tipc_crypto_key_distr()
--> tipc_bcast_xmit()
--> tipc_bcbase_xmit()
--> tipc_bearer_bc_xmit()
--> tipc_crypto_xmit()
--> tipc_ehdr_build()
--> tipc_crypto_key_revoke()
--> spin_lock(&tx->lock)
<timer interrupt>
   --> tipc_disc_timeout()
   --> tipc_bearer_xmit_skb()
   --> tipc_crypto_xmit()
   --> tipc_ehdr_build()
   --> tipc_crypto_key_revoke()
   --> spin_lock(&tx->lock) <deadlock here>

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 302fd749c424..43c3f1c971b8 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1441,14 +1441,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
 	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
 	struct tipc_key key;
 
-	spin_lock(&tx->lock);
+	spin_lock_bh(&tx->lock);
 	key = tx->key;
 	WARN_ON(!key.active || tx_key != key.active);
 
 	/* Free the active key */
 	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
 	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
-	spin_unlock(&tx->lock);
+	spin_unlock_bh(&tx->lock);
 
 	pr_warn("%s: key is revoked\n", tx->name);
 	return -EKEYREVOKED;
-- 
2.17.1

