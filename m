Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E165277939A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHKP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbjHKP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5D30D8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so3286148e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769523; x=1692374323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhePiwzsSx/PL85mddTkFwpXPwkG7Z75k06o+iuXV0A=;
        b=v1ebNHHM6M1mmtuZYCv9hRgIOkNvxHx2SBgalyfmwDZhrfEP9IFSEcEkc4TRnRuPDv
         Ao0uoh4HYY2as2H7y1J9ab6sbArcrdWg7SaIIeVQhpHhugrq2WkDi3Emdx/CbDhYrVBM
         D+lPAgyFcDqUpd2x8FeKuRbhvWnEgQaGpZCWhjB7Nwi+rIIhgoiueuPj5VE12UgA0dI0
         h3oYYd9MkdE1qfpUX72Aat2uQTVWut57m3OIDEvheqy/KjoG3gPPP9gnWHvbvLTR5cDr
         N8aKLr3ik3cVQ/ZjSY56pHpzWz4ou7/3bqoVW9jSxs1angf6mLpdQeVnNoc+8EJP1btk
         NF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769523; x=1692374323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhePiwzsSx/PL85mddTkFwpXPwkG7Z75k06o+iuXV0A=;
        b=OiKl+okIEaPOggnOnrWuIxpq9huK6CTCCdndub2YwH1Z5B7CdpIm1FKoObpH8DmRJ1
         RHcDU0y0m2RXnjj0eEnv/XxuAFgp7vNRb4HG9VnZdumYXyrx/AifzfwGzCcNuZeC/n5K
         i10rNdrWDKRWQkUXdeOz3r0jihKeDDiM82se3EIghPXnXhqtGPWDYIN2yLT7ya0A7yqB
         hzpU89aLo2Wroy+x5w/NNz7oVpboAtP4ryRT2+7h6DNvdXHa8EHSJe/VmmX+vSmz9ceu
         9waB4dMg1bB+ji9d7jCu4Yc7I/h3Lw/nwa6gvllCqGiKe9OoZw4CMyRwfR+QzuuzeIFV
         OcAw==
X-Gm-Message-State: AOJu0YxO0gqrbiZQK6AH33OnsOIqki9S+mRD1X5cVGKKY7n3D7/+p9ju
        Bi98ybnfhJ0xnt5Zp4wS++HEbLovWHa4ADZthXNCHA==
X-Google-Smtp-Source: AGHT+IEujOlzrfqvXdCg0+L8AtbpF7nTqrrFN85u705jORmwlIy3xMjlO1zC1yyK/tf3s2Jwb6Ap3Q==
X-Received: by 2002:a05:6512:308c:b0:4fe:8c1d:9e7b with SMTP id z12-20020a056512308c00b004fe8c1d9e7bmr2115985lfd.49.1691769522977;
        Fri, 11 Aug 2023 08:58:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:42 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:15 +0200
Subject: [PATCH net-next 02/14] mptcp: avoid additional
 __inet_stream_connect() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-2-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9Qe781+27wzhv16vF50KO5HsGzkjYeuVU2/sb7jT8+c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv5fFsBgTBTnGPQG9RVKTvL3RVK7VoW1/dY
 tAt+/hU8biJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c4sGEADj8+wJ8gLXhu4xLA3eshwVHpAUMPU6fl5G1adbkUaHa4ymSWx/xIIWUFc+BgqfFa4bUHA
 JZSHhjd5Ui/PTvxdKjznOkZlfpJJrXAke5riO8m2bkSLlAHIyh6YfaeXIZ4BqylD8FjjQi8fu/J
 Mi7HshwB5pwlR6mPcviJi8hiUV6ha9Txs/2nJ4l0uVpNw9i37VyzWW7N7S6MipOFkCiwmQrpnLo
 0Hf69GX16W8QNlyvUxNcBcZr2KilIWTIYAYN/LvyP0TmzCKSAaQqKPqXBRwcDxus7tn3BxmRHig
 aA4FJPpHoM5XRCz5EtPtH5NNKOWWcUrsTlhiWlfKwcGqdVZwM5yTeD2U/LvEcyC43MMhUsTsBk2
 KmM8E+oeTleZtGwTWAuD/dJjtY+KrW86S1iheFW9obk9GQIJNTK8SUzzRBhmF3hdpAZKQlMcNGc
 KZfbu0kd7uPFy6vaAtDtURGiU1YWRx0GT8SNcl4BxqzalwVQaS3oF0VdQkAE3yE7XC7u3kmDsBG
 XjrvyAU9j8Au9o0OtUEbvr8FST8dYjQdG8z/il7pD4pHB5FALIw5jnDpXLIFWRf91KIIZZQAQh6
 7XwvLCdlTkwdU3yeM4FvlDciFXTqzbUHmjQMzSh+n7cLweyaMLk6p0fdSDg138LeQLLqjXfAewy
 fztkK3c9TEI9XkQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The mptcp protocol maintains an additional socket just to easily
invoke a few stream operations on the first subflow. One of them is
__inet_stream_connect().

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at connect time, calling directly
into the sock-level connect() ops.

The sk-level connect never return -EINPROGRESS, cleanup the error
path accordingly. Additionally, the ssk status on error is always
TCP_CLOSE. Avoid unneeded access to the subflow sk state.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index abb310548c37..b888d6339c80 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3589,22 +3589,24 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 	int err = -EINVAL;
+	struct sock *ssk;
 
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
 	inet_sk_state_store(sk, TCP_SYN_SENT);
-	subflow = mptcp_subflow_ctx(ssock->sk);
+	ssk = msk->first;
+	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
-		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
 	if (likely(!__mptcp_check_fallback(msk)))
@@ -3613,27 +3615,42 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* if reaching here via the fastopen/sendmsg path, the caller already
 	 * acquired the subflow socket lock, too.
 	 */
-	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
-	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
-	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
+	if (!msk->fastopening)
+		lock_sock(ssk);
+
+	/* the following mirrors closely a very small chunk of code from
+	 * __inet_stream_connect()
+	 */
+	if (ssk->sk_state != TCP_CLOSE)
+		goto out;
+
+	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
+		err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
+		if (err)
+			goto out;
+	}
+
+	err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
+	if (err < 0)
+		goto out;
+
+	inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;
+
+out:
+	if (!msk->fastopening)
+		release_sock(ssk);
 
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
 	 */
-	if (unlikely(err && err != -EINPROGRESS)) {
+	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+		inet_sk_state_store(sk, TCP_CLOSE);
 		return err;
 	}
 
-	mptcp_copy_inaddrs(sk, ssock->sk);
-
-	/* silence EINPROGRESS and let the caller inet_stream_connect
-	 * handle the connection in progress
-	 */
+	mptcp_copy_inaddrs(sk, ssk);
 	return 0;
 }
 

-- 
2.40.1

