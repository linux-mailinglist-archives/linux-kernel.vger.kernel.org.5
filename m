Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1D7785B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHKDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHKDBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:01:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF62D60;
        Thu, 10 Aug 2023 20:01:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-68783004143so1232063b3a.2;
        Thu, 10 Aug 2023 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722903; x=1692327703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3VeUl42GIsBJoy2db7FH5pZ3W66hnMuj1immbzSRdg=;
        b=BXWcJn5q0lkz/7skqUZ3b6l6Q2Lv798L+/u0WP0i0ytMYpUvMGFpZsviVVOBXXgRD4
         3gmH23BPSCjzLDlkcBOSWkBmUIY+g3pLsl7X8KQUAvH1TLMCR4/4CxSR6dzvdPRFNaRg
         qqfK1eKicq8nJLLButyWq3Y9fyHWPj5ldXg8syCRJT4WrhGyic+x8kjtaNdICsrEFY4d
         zEgNLm7ERUGu6TrNMH9k4PwG3TGh1J68rVQ66E8yyVGa4YugRpEdGNAE4Qc9zgYwnJ7K
         njygRTNczL55Wp1IBSTKL7HnMnacCH0XlkPB7CWKKQML/LoSR0+EIc2dmHxm1VH7YAJF
         4PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722903; x=1692327703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3VeUl42GIsBJoy2db7FH5pZ3W66hnMuj1immbzSRdg=;
        b=VsNmrMT4b64nIvqpu4x3+tYNipWWcUuIU06pQyeKBWECR2Ggo6RF1+AtN4RMdQXu++
         ee4BC4jCV8zT78LAF2Q0IhhsUO/pxjiumAHrA6b2Jn2YhGtcnlvrafUkSvN93xCojQiH
         o9qPgsdqADKGoKCKAXjOKxixxS7ZM9pFKQVivRNghFkq1sKU29AE4WUFN8g7DvrMH/my
         UEjCDQqrbkqEoxQkrL3GszJKxvF5KSbzmPiuILPEUDejaKjdmrri59NRbgOK0yVevnI5
         1I963OGwhGjUhnM1vL83ddMXnpjWkSII/v9U3O2EP25IEuwkQfi65r2qozigKE9olObK
         nN4g==
X-Gm-Message-State: AOJu0Yy+7yc/CmXil7J62CJJwxlFiwj2ovr+pLxm5zfAhbtwORKD+egr
        jjwdFORWyPSRvx+iH38iaGo=
X-Google-Smtp-Source: AGHT+IHLpMnBAPjatoHM3usBXK2gLWCHJk9kgiqZQIH1oLxXGCgKsaIkRhQja3bfGRHLWjVidYblPw==
X-Received: by 2002:a05:6a20:4327:b0:12f:c0c1:d70 with SMTP id h39-20020a056a20432700b0012fc0c10d70mr919689pzk.40.1691722903447;
        Thu, 10 Aug 2023 20:01:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b005646868da17sm2281197pgo.72.2023.08.10.20.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:01:42 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v4 1/4] net: tcp: send zero-window ACK when no memory
Date:   Fri, 11 Aug 2023 10:55:27 +0800
Message-Id: <20230811025530.3510703-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
References: <20230811025530.3510703-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

For now, skb will be dropped when no memory, which makes client keep
retrans util timeout and it's not friendly to the users.

In this patch, we reply an ACK with zero-window in this case to update
the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
connection and will probe the zero-window with the retransmits.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v3:
- refactor the code to avoid code duplication
v2:
- send 0 rwin ACK for the receive queue empty case when necessary
- send the ACK immediately by using the ICSK_ACK_NOW flag
---
 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               | 18 ++++++++++++------
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c2b15f7e5516..be3c858a2ebb 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -164,7 +164,8 @@ enum inet_csk_ack_state_t {
 	ICSK_ACK_TIMER  = 2,
 	ICSK_ACK_PUSHED = 4,
 	ICSK_ACK_PUSHED2 = 8,
-	ICSK_ACK_NOW = 16	/* Send the next ACK immediately (once) */
+	ICSK_ACK_NOW = 16,	/* Send the next ACK immediately (once) */
+	ICSK_ACK_NOMEM = 32,
 };
 
 void inet_csk_init_xmit_timers(struct sock *sk,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e96ebe373d7..2ac059483410 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5059,13 +5059,19 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 
 		/* Ok. In sequence. In window. */
 queue_and_out:
-		if (skb_queue_len(&sk->sk_receive_queue) == 0)
-			sk_forced_mem_schedule(sk, skb->truesize);
-		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-			reason = SKB_DROP_REASON_PROTO_MEM;
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+		if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+			/* TODO: maybe ratelimit these WIN 0 ACK ? */
+			inet_csk(sk)->icsk_ack.pending |=
+					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
+			inet_csk_schedule_ack(sk);
 			sk->sk_data_ready(sk);
-			goto drop;
+
+			if (skb_queue_len(&sk->sk_receive_queue)) {
+				reason = SKB_DROP_REASON_PROTO_MEM;
+				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+				goto drop;
+			}
+			sk_forced_mem_schedule(sk, skb->truesize);
 		}
 
 		eaten = tcp_queue_rcv(sk, skb, &fragstolen);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c5412ee77fc8..769a558159ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -257,11 +257,19 @@ EXPORT_SYMBOL(tcp_select_initial_window);
 static u16 tcp_select_window(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 old_win = tp->rcv_wnd;
-	u32 cur_win = tcp_receive_window(tp);
-	u32 new_win = __tcp_select_window(sk);
 	struct net *net = sock_net(sk);
+	u32 old_win = tp->rcv_wnd;
+	u32 cur_win, new_win;
+
+	/* Make the window 0 if we failed to queue the data because we
+	 * are out of memory. The window is temporary, so we don't store
+	 * it on the socket.
+	 */
+	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+		return 0;
 
+	cur_win = tcp_receive_window(tp);
+	new_win = __tcp_select_window(sk);
 	if (new_win < cur_win) {
 		/* Danger Will Robinson!
 		 * Don't update rcv_wup/rcv_wnd here or else
-- 
2.40.1

