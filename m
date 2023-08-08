Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD94774190
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjHHRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHHRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:23:21 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CB1E5B3;
        Tue,  8 Aug 2023 09:09:45 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1bb89ac2013so4346882fac.1;
        Tue, 08 Aug 2023 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510958; x=1692115758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3VeUl42GIsBJoy2db7FH5pZ3W66hnMuj1immbzSRdg=;
        b=ALM6FMLRl3lAWGDKvzWKfwt8peQVQnGhNNub989Bf17M8NiO6I1AzvPjVfvvDd/A9R
         Cf44N/sNQq6L6iupbwagbLv6jwsROj7mocc/f5rSzUQdoFA2PaF6YKItZKTcMdmF8yrN
         6HQoiDS2TbmfI23/uSMkeA4zSe8LiJpyJ06dk63zsu+boRQAttdUzm2gFfvJFooe6SII
         W70d+8WSUyKmQHvM+QqvL/OrslwiQavSa3fIYpEEdAqH+622792cwFTESOfT+u74GCM9
         kemvSs3iHR/mw0m0xLUSRa5xqGhOqIbwZjeTnHfLfXmToaIaDgzA6EkDAzP/4331wyye
         gM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510958; x=1692115758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3VeUl42GIsBJoy2db7FH5pZ3W66hnMuj1immbzSRdg=;
        b=Mlx1/4AijOUbwOdNzSfR7oh5cIcMwRP6BTxEemvmwNGK7VDc/11zIc9N22NZ0ZApWO
         04MjxC5LcByh0ZAa321QKRy2pjrmzYOzhGL0TE/Oj2KBj9BLDnfCfx9ZHPs6JhxyTo2d
         eSLGPdGUZQ3ySEWxFPREzvYiW/WFPhsCzwknwvPEdkPLOLnLHrzZtZBoML+QUML8OgAE
         PuYAN61c/n2HXrS6Qt84w8xhaEc+/FN6Id4ic8L32GLgQGxKB0MRjeMvBNaDKdp/21T8
         5Exltq6vlQZUFgnuir9mPwXjmdzfQqlu2PS3/LiGgvci8kvhlMDLVzU/my7/ZtzhQTJ3
         sivg==
X-Gm-Message-State: AOJu0YzQ9xdxT/Kaz9+AO5Of/YYUtC9vfz/hIDG0ZCezV6yAakSHpJyP
        Mz8XIV5q21UT8wzRhQ6pK2r/ALDNIR7SHzcOZQc=
X-Google-Smtp-Source: AGHT+IHuonVLAW9IJHEHvANu9pDz/t/I0xK1OV57MEExw5JgK2y2La9FkqeNB7I92r0IcYXlbhYiRg==
X-Received: by 2002:a05:6a20:3205:b0:12f:382d:2a37 with SMTP id hl5-20020a056a20320500b0012f382d2a37mr12123960pzc.15.1691495951097;
        Tue, 08 Aug 2023 04:59:11 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id j22-20020a63e756000000b00563b36264besm6484136pgk.85.2023.08.08.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:59:10 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v3 1/3] net: tcp: send zero-window ACK when no memory
Date:   Tue,  8 Aug 2023 19:58:33 +0800
Message-Id: <20230808115835.2862058-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808115835.2862058-1-imagedong@tencent.com>
References: <20230808115835.2862058-1-imagedong@tencent.com>
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

