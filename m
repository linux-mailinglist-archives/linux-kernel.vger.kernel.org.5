Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A53781303
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379472AbjHRSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379523AbjHRSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:42:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021335A5;
        Fri, 18 Aug 2023 11:42:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso841072a91.0;
        Fri, 18 Aug 2023 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692384155; x=1692988955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tC87ytfbpYDqxm55kNo/dnnHD896FFpzuLkzfJ0vw34=;
        b=HHHeW0kMnjD2rzZTTJouYt54sd4ScQ5bQ3ZReaKfwC9Nqqpjvo9vuNoKMdhRslVIfK
         eapb93kt5LRZzlpT552Wbt5w2FfYcPSxvrMeNGzMB3swYPkOq54Wp02AcoPDC8cQfimH
         fstd9Yh/Qpo9y8FF24cP90fAy3/tdrQEkTsRmcJmR3zQDio4CZQVoSQ7NeHkzLneZygU
         Ogez300R3FCO3/5I8vm9iL9EPzQk0VUaW+SHBahA65WasB2SPowHq3MgbYgWm4/PRcJr
         ZoKe1NJAfmy6yqpwZ3idH7FHG98mDVzAYkxvB7aXbWhxqGQh1dFg6E2jUGFL+9KIHhTD
         /qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384155; x=1692988955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC87ytfbpYDqxm55kNo/dnnHD896FFpzuLkzfJ0vw34=;
        b=jRVM0w2lwDIAmvZKt6hp6PTIjUmpvNmCOFDu8RZa7Zsi/cUnpalAvCUpKsdsK/tZKD
         OTEBL/3FdB2hpeSjJLX5HbnQsMugdbydSK/bww6fuOdFtCsgzSuQ8XpXHBTvHQdRTaR5
         7FmGHY1Kyumi8DM+h8rebM4+4CFs8n4rn4i2oXwCvyyxklOrufao8qBGDnx/oT2txfIP
         y3t8mHqC0W7YLLAX/Xxm1M8i/hZcjGKtY7LRUuMmeLQ1q/wTNceC2nwAtqzZR3mxKO6c
         19ZWKyqJqU5brpS5ZCQSQeC26oaPcGguxkPQhY27doHOYx+Vo8fC2PMOgnLU/gJL/2aj
         Vawg==
X-Gm-Message-State: AOJu0YxcKCtvIZMD2CpdY8seZzJjIyPCrnw11ohkXXO6SMfATBf1WMcu
        6RHGMpC/G2Xxmul/draY0gqExf4cxOzStQ==
X-Google-Smtp-Source: AGHT+IEqoWGs4DFszNmL/EEjujikAHCo4BP0FuNfQx6BUjSeFkvIEu1uDom2G7LkB+iEZRGhfdCM5A==
X-Received: by 2002:a17:90a:8681:b0:267:fba3:ed96 with SMTP id p1-20020a17090a868100b00267fba3ed96mr52088pjn.3.1692384155093;
        Fri, 18 Aug 2023 11:42:35 -0700 (PDT)
Received: from VAN-928222-PC0.fortinet-us.com ([173.214.130.2])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090a5b0400b00263b4b1255esm3546721pji.51.2023.08.18.11.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:42:34 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, keescook@chromium.org,
        johannes@sipsolutions.net, pctammela@mojatatu.com,
        dhowells@redhat.com, fw@strlen.de, kuniyu@amazon.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xqjcool@gmail.com
Subject: [PATCH] netlink: Fix the netlink socket malfunction due to concurrency
Date:   Fri, 18 Aug 2023 11:37:11 -0700
Message-ID: <20230818183712.123455-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concurrent Invocation of netlink_attachskb() and netlink_recvmsg()
on different CPUs causes malfunction of netlink socket.

The concurrent scenario of netlink_recvmsg() and netlink_attachskb()
as following:

CPU A                           CPU B
========                        ========
netlink_recvmsg()               netlink_attachskb()
                                [1]bit NETLINK_S_CONGESTED is set
                                netlink_overrun()
netlink_rcv_wake()
[2]sk_receive_queue is empty
clear bit NETLINK_S_CONGESTED
                                [3]NETLINK_F_RECV_NO_ENOBUFS not set
                                set bit NETLINK_S_CONGESTED

In this scenario, the socket's receive queue is empty. Additionally,
due to the NETLINK_S_CONGESTED flag being set, all packets sent to
this socket are discarded.

To prevent this situation, we need to introduce a check for whether
the socket receive buffer is full before setting the NETLINK_S_CONGESTED
flag.

Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
---
 net/netlink/af_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 383631873748..80bcce9acbfc 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -352,7 +352,8 @@ static void netlink_overrun(struct sock *sk)
 	struct netlink_sock *nlk = nlk_sk(sk);
 
 	if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
-		if (!test_and_set_bit(NETLINK_S_CONGESTED,
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf
+			&& !test_and_set_bit(NETLINK_S_CONGESTED,
 				      &nlk_sk(sk)->state)) {
 			sk->sk_err = ENOBUFS;
 			sk_error_report(sk);
-- 
2.41.0

