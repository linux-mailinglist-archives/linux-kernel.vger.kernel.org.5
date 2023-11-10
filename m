Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAF7E804A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbjKJSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjKJSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:00:09 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381182AD2A;
        Fri, 10 Nov 2023 02:58:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1727581b3a.3;
        Fri, 10 Nov 2023 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699613914; x=1700218714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgCullXs69eYhISfXuDpHxjryEOlOpmI+uw8NW6NNb4=;
        b=ifCvakJ0vl9wmUWX2XTa/QoQkBQUWKcs8tm6sTxQfqDiLRdsjUGtndEGAmEna25PcT
         qs/JYNJO2FfOnyMapQsEed1iclBoJ7AQXz8mHzBZOqonlC5oJDUU61fMXPGBIMDkWt8O
         snjJ8GDydOqFWK4llU5ZFfPTc9JJPpCWGUsPiQsNotzvYf+jAl/evu2hUVAr0SU17xJ0
         nyPMlVbpOp06S8V/kwYe3T6vIe97lrijq/wceoako9JFtOdOZpsmbzAFB4BCO+joMYVv
         H4lkThX2WR8AIORrixqRWh0oAWUbwnsM3qD6pfCUKsKp9JyLbVfMV9+z10wLQDzcPbsQ
         syoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699613914; x=1700218714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgCullXs69eYhISfXuDpHxjryEOlOpmI+uw8NW6NNb4=;
        b=Bw4UL6DUfqUzqDukUJxmrxHhr/8tmtV9HeawBs2nvdwzmEkmKtJp7W/z/rjDM7B2HP
         B4irlDs3rrsWZNDsO4jQOT/MuMm3Wq/ZkeS1Zr711cytpwetMM9hV8jvCXelNhajcfaI
         lsphGbDHlEzatXXCMdQy3PmCgNBfktYYjO53ptTVveTtcFmnX/3u38GNlNt1X81BvHvf
         JsA690hlUoUxJfZqfWRzRbBsg1mWA1/tw7yQRODOM7uHNQEtHLTfYTfaBwGj9xkwhPt7
         uk4yowkA1JlFqbwfIpHYjMR+Ai6CMdSm58OHgpc7bMygwek/85pOwNww1IRxaMNOcqse
         bekw==
X-Gm-Message-State: AOJu0YxcM6JGwdWqbPRakjRwLVT/1dMfu9neoOrKf8oJT8ed0djdjBtl
        X3/3CL43zMPRpe+1hqWNGLBPV6rAG+GGnw==
X-Google-Smtp-Source: AGHT+IEQZj+JOsqGYgZ8zjnhecxauxVdWisXmGc0MRIjquJPWv/siqqO9vhcdG7oRGhlxy9dE/sW8g==
X-Received: by 2002:a05:6a20:5504:b0:181:261f:f368 with SMTP id ko4-20020a056a20550400b00181261ff368mr6412147pzb.53.1699613914507;
        Fri, 10 Nov 2023 02:58:34 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b001bb97e51ab4sm5103694plt.98.2023.11.10.02.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:58:34 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:57:23 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ywchoi@casys.kaist.ac.kr
Subject: [PATCH] tls: fix missing memory barrier in tls_init
Message-ID: <ZU4Mk_RfzvRpwkmX@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tls_init(), a write memory barrier is missing, and store-store
reordering may cause NULL dereference in tls_{setsockopt,getsockopt}.

CPU0                               CPU1
-----                              -----
// In tls_init()
// In tls_ctx_create()
ctx = kzalloc()
ctx->sk_proto = READ_ONCE(sk->sk_prot) -(1)

// In update_sk_prot()
WRITE_ONCE(sk->sk_prot, tls_prots)     -(2)

                                   // In sock_common_setsockopt()
                                   READ_ONCE(sk->sk_prot)->setsockopt()

                                   // In tls_{setsockopt,getsockopt}()
                                   ctx->sk_proto->setsockopt()    -(3)

In the above scenario, when (1) and (2) are reordered, (3) can observe
the NULL value of ctx->sk_proto, causing NULL dereference.

To fix it, we rely on rcu_assign_pointer() which implies the release
barrier semantic. By moving rcu_assign_pointer() after ctx is fully
initialized, we can ensure that all fields of ctx are visible when
changing sk->sk_prot.

Also, as Sabrina suggested, this patch gets rid of tls_ctx_create(),
and move all that into tls_init().

Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
---
 net/tls/tls_main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c2c6800949d..235fa93dc7ef 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -806,22 +806,6 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
-{
-	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct tls_context *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
-	if (!ctx)
-		return NULL;
-
-	mutex_init(&ctx->tx_lock);
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
-	ctx->sk_proto = READ_ONCE(sk->sk_prot);
-	ctx->sk = sk;
-	return ctx;
-}
-
 static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			    const struct proto_ops *base)
 {
@@ -933,6 +917,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
 static int tls_init(struct sock *sk)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
 	int rc = 0;
 
@@ -954,14 +939,27 @@ static int tls_init(struct sock *sk)
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
+	mutex_init(&ctx->tx_lock);
+	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->sk = sk;
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	/* rcu_assign_pointer() should be called after initialization of
+	 * all fields of ctx. It ensures that all fields of ctx are
+	 * visible before changing sk->sk_prot, and prevents reading of
+	 * uninitialized fields in tls_{getsockopt,setsockopt}. Note that
+	 * we do not need a read barrier in tls_{getsockopt,setsockopt} as
+	 * there is an address dependency between
+	 * sk->sk_proto->{getsockopt,setsockopt} and ctx->sk_proto.
+	 */
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
-- 
2.42.1

