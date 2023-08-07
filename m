Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6D772662
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjHGNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjHGNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:47:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4A3E53;
        Mon,  7 Aug 2023 06:47:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1bb84194bf3so29411185ad.3;
        Mon, 07 Aug 2023 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416035; x=1692020835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRHs0oQl+CF4CqoniuHI9S6BlLWdP4X6ChmtvgMCww=;
        b=svAlTn21dkZIGdxfF3T2QxXCXmc4WyXl8RIkqygcuSnC+LWDaDtj5+lXcwzYrEMEVA
         TjcfsQtcUoyoH0Yx83G1N1pPqw3sEW6J0gqgra+qTz+9Fs/eDNxJziSJrpU8ilu4Qt6c
         zQqL0qsxmQrSViZcqrm2cioAYMopw9fJV5SFavpRrPgDVrhhYKDP1HlN2+o1Q0yUChzQ
         QE9DZwTzbX6rbKwhyGePQc2vFOBlXmSaTg03zZbHGpeKbU4Qr2ThpQWXvS19hgXIhKDR
         mAEg+7cGyHMO+Wtq5OcgWM5x2prFAUEy4jasQvNr22gUZZ67B9ksOHbusDEfwWzKW2aW
         cRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416035; x=1692020835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvRHs0oQl+CF4CqoniuHI9S6BlLWdP4X6ChmtvgMCww=;
        b=VyDwwfJsd2S5eYApTF3h5ZhOFZX8rVHWsKJvv2NdJJliy0B7CAjX3gz7WzEdegAL2u
         rfxM7U111RNZmW3au5jhRSBk18Wwzjz0nSrogE+61lc2FCiFYKdLVj4Xi0qmZWMzUE0l
         vRZzQq60v82hartPyZMxv4MWoDRn4xEoNfQc8VjRGNFypZN1bYJzLisSgyMGOrTqs84j
         37WwfwrQr9b9nTHWk8UFNN4eDXC49EUix1r2ZcXZb3DV/uabnM3q/kTL16Nb3N2AppSO
         w0JTlxmO5wWpeWSb10gfQeXegYRs7rjJhdTOt9GEGoclZmPosvmDDHR5QW1X8yARD8Er
         RMUw==
X-Gm-Message-State: AOJu0YxwKh5vEx4IU3r3S4QRFfaFgREYLfeto2UHaeh8RMGJUcjumR3t
        /B3p7YL1OI2dRx8cjZn1lKg=
X-Google-Smtp-Source: AGHT+IGo9ZA9f/X75Ozpaoe1bJghhVKHuLA3Fjfd7lrguHqy0CTs1/AtSC27A6MrgzKlinLfp0Iu2w==
X-Received: by 2002:a17:902:b20e:b0:1bb:6eeb:7a08 with SMTP id t14-20020a170902b20e00b001bb6eeb7a08mr8812654plr.10.1691416034543;
        Mon, 07 Aug 2023 06:47:14 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001b54a88e4a6sm6912097plt.51.2023.08.07.06.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:47:14 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v2 1/3] net: tcp: send zero-window ACK when no memory
Date:   Mon,  7 Aug 2023 21:45:45 +0800
Message-Id: <20230807134547.2782227-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807134547.2782227-1-imagedong@tencent.com>
References: <20230807134547.2782227-1-imagedong@tencent.com>
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
v2:
- send 0 rwin ACK for the receive queue empty case when necessary
- send the ACK immediately by using the ICSK_ACK_NOW flag
---
 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               | 14 +++++++++++---
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

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
index 8e96ebe373d7..aae485d0a3b6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5059,12 +5059,20 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 
 		/* Ok. In sequence. In window. */
 queue_and_out:
-		if (skb_queue_len(&sk->sk_receive_queue) == 0)
-			sk_forced_mem_schedule(sk, skb->truesize);
-		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+		if (skb_queue_len(&sk->sk_receive_queue) == 0) {
+			if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+				sk_forced_mem_schedule(sk, skb->truesize);
+				inet_csk(sk)->icsk_ack.pending |=
+					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
+				inet_csk_schedule_ack(sk);
+			}
+		} else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
 			reason = SKB_DROP_REASON_PROTO_MEM;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
 			sk->sk_data_ready(sk);
+			inet_csk(sk)->icsk_ack.pending |=
+				(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
+			inet_csk_schedule_ack(sk);
 			goto drop;
 		}
 
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

