Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE77A2F63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbjIPKya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbjIPKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:54:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F5E3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:54:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso28058585e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861639; x=1695466439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWMKdu6oGlBA228l/1n9KS3VAt8D5mHcxorttTQ05GA=;
        b=DOGue2to/U5vvQ/qb1lcdFpMc76Z+6buxj4Vxm8B/lHEMP/09zdm58AKOQ4xMwR3eN
         0dlWu4iTmYfcRSRV2QBMCJ5FQe+9V0WA70FLsDgzAcL460oDFGGMz9sgwnEEMPDnRjce
         M4sRQZMx23ZKOIGhB2s9TJzVRkV/RGApsDCZ4UFodnM0xZXX2R9amEAXHZbSPz7jnmYq
         SIZ9FjHxNA8AE6N3tlRd6DoYptZVtsuLGYnQV++nRca4qVQ76KJrcgJ2WetUbKE7A00b
         gkL1+JQ8SCStcYuOEbpqqEYs1oJiB+tqnCLCt9V/Z+wyyV/jScpbVtS8CHy+mpbL0ZLZ
         ZIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861639; x=1695466439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWMKdu6oGlBA228l/1n9KS3VAt8D5mHcxorttTQ05GA=;
        b=qfy0jlMevXllT0VEbXUzb/RgShNvvZJEtRPE8bjpEzG/jGNMWZgYVJGUns+N78VCZV
         P7Rj7mAu1gBUgEW2b7scr2LsDqLJlxBuNOB1QI6CbvMGwFIPHGRwvDFLxmlxl3leEKJ7
         USOheiePPBzOYB94sjcRMK2g5OAaYInF7m6LTLSUhcEETysfkACL8aobFYkfBuy4BPxO
         pT2zvnNTdMdltItNHix/z91AVb//88IjfXokXjRErVEvVHUODhUkjiUCtJlgx/yMpLBw
         8SO7etkVSNNrRW5n0EXoZnZhdRc+ZbfuoUufuSVwvdkTNa5dFRc7z72R+Le+rWUFZi81
         vOPw==
X-Gm-Message-State: AOJu0YxUzpYb/S+9EvDvb3B3ZrBq4OoNRvleoES1Skkd3GrJ24g0u8x0
        kO6i4LmIjFLjAdAopS+d3sXPYg==
X-Google-Smtp-Source: AGHT+IGqK774glaK2AjLdLVkE+1PqZuz5eH9Wgcszf2PJ29KM2yg/dFPiRnvwjBZsb8Xt3j9zLrviA==
X-Received: by 2002:a05:600c:249:b0:402:ff8d:609b with SMTP id 9-20020a05600c024900b00402ff8d609bmr3695473wmj.33.1694861638768;
        Sat, 16 Sep 2023 03:53:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:58 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 16 Sep 2023 12:52:48 +0200
Subject: [PATCH net 4/5] mptcp: rename timer related helper to less
 confusing names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-4-05d1a8b851a8@tessares.net>
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6828;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=MdXDRzXjWlApK+QTPTufQ6ZpvGH2K3dtcUOmL+Qgea0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAVm9GHZKzxl+8WRaPD6naZe1x6tFWU9ecf
 2RtSC4yDcWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 c07FEACzGddVDOpe9M1NaGWxorOCEWGV1h/SCICL8YlqpC0oRWPv6WP5hODlA3FFvXKjqubtECk
 mCHhaRreaRYX72Fg9hFwgmlekbUPFVlGQTo1gsqh6BrK1WDtWdkxa7YOR4VBHZrsDx2xlvZ1ue6
 BdTLZxbwOXnEO4bbrTxfa9HqqAhqPnKtyAzMXJtCs2pFGTVmC2ib2SwfFC6AHUlK4/20+pLjmMB
 Xpr6JkmT2slZK5TnO2DdT5EKIdGHv+lmbKsGaosRmaYDqhtab+CRUHC4G3N5TyJBm2xPO5nOxMP
 CByNTKeegnjUh7FSx073RGYE9nIrMa0Nkum2DTWUk8DKYcY1SBubi5ipthbcMSAc8EWMga75FZK
 CuxDEW17lD1Hdf2DzDBlcDX/HHcwTaj5V6TfkozdfTzjRvmlfUBKRrBLcJOpKuGvY8LMlXB216F
 uHtGPznaNNjq2ZJlMvEgNWEwgmiqZzyg5cCQYi6J1fH7T1UCuWx8vvmTZyDD2dap9lhiXS1fn1u
 mrvk4MUOr4qS2GsNhiqQZkuTqwLWY6Nj8OyvdsBlUMKnntP5NzQ9N2Pb6ZWcHTa8j/roHU873YC
 bDDt+cReEPEmndHTWtSMbWuS8lNvUJTMBRwB8YSfmVCXYvX8xGzlC5iaLI/3f6fxv786gZnnNU+
 PxAgIUvE7xpT/2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The msk socket uses to different timeout to track close related
events and retransmissions. The existing helpers do not indicate
clearly which timer they actually touch, making the related code
quite confusing.

Change the existing helpers name to avoid such confusion. No
functional change intended.

This patch is linked to the next one ("mptcp: fix dangling connection
hang-up"). The two patches are supposed to be backported together.

Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c96b8da71df..c8f38f303a90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -405,7 +405,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -911,12 +911,12 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 	}
 }
 
-static bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 
-static void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
@@ -1050,10 +1050,10 @@ static void __mptcp_clean_una(struct sock *sk)
 out:
 	if (snd_una == READ_ONCE(msk->snd_nxt) &&
 	    snd_una == READ_ONCE(msk->write_seq)) {
-		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
-			mptcp_stop_timer(sk);
+		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
+			mptcp_stop_rtx_timer(sk);
 	} else {
-		mptcp_reset_timer(sk);
+		mptcp_reset_rtx_timer(sk);
 	}
 }
 
@@ -1626,8 +1626,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_push_release(ssk, &info);
 
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (do_check_data_fin)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1690,8 +1690,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2260,7 +2260,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2629,14 +2629,14 @@ static void __mptcp_retrans(struct sock *sk)
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 /* schedule the timeout timer for the relevant event: either close timeout
  * or mp_fail timeout. The close timeout takes precedence on the mp_fail one
  */
-void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
+void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
@@ -2669,7 +2669,7 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
 
-	mptcp_reset_timeout(msk, 0);
+	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2758,7 +2758,7 @@ static void __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2849,8 +2849,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
+			if (!mptcp_rtx_timer_pending(sk))
+				mptcp_reset_rtx_timer(sk);
 		}
 		break;
 	}
@@ -2933,7 +2933,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
@@ -3053,7 +3053,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_timeout(msk, 0);
+		mptcp_reset_tout_timer(msk, 0);
 	}
 
 	return do_cancel_work;
@@ -3116,7 +3116,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_stop_timer(sk);
+	mptcp_stop_rtx_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (msk->token)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7254b3562575..5e2026815c8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,7 +718,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
-void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout);
+void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2f40c23fdb0d..433f290984c8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1226,7 +1226,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(subflow->fail_tout, fail_tout);
 	tcp_send_ack(ssk);
 
-	mptcp_reset_timeout(msk, subflow->fail_tout);
+	mptcp_reset_tout_timer(msk, subflow->fail_tout);
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)

-- 
2.40.1

