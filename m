Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C67751FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjGMLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjGMLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:24:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D610E2;
        Thu, 13 Jul 2023 04:24:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-66f5faba829so384046b3a.3;
        Thu, 13 Jul 2023 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689247468; x=1691839468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diCaU9T9K+7GZFl+nMf3Y8Nxqf/vtw/IWeBhwen/Vlo=;
        b=odnOR2uY1RopKeXAJpLEGKBaClPQYiJSC4r7/9td95LLHhm/Zzp2ObvEJyV2zQm3gT
         iDtl05cdoTfKb6MOfjUzEhv/oLbm24y2DXud3CFIMB31lRckYjLIHksk5oZOYMHzvj/n
         4Hc//aOM5kNk35RI9WgA4XDR3FuVH1J9Z7QxfahoLfI/gfNdxVQbQIYgmNoJqNnmXuqi
         sehbB7y8Aqe6UmChPf70W0cetQt/8l6S71DR9zgxvFO0OQYjHQ/R4RWEVpBB85AoP0/H
         uDFcbV+mes/8wSGDPRQ2fd6noOvkCJ4emJslvPCbnYji1XKAJ6xWjKKWCwrnQOwh6SXE
         sTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247468; x=1691839468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diCaU9T9K+7GZFl+nMf3Y8Nxqf/vtw/IWeBhwen/Vlo=;
        b=k4mfMXbcBTKwS+LBG3snx25MC1DYONySbvCwhLYwcGlSjniEDytwIXRC2ASzyv6//t
         VykRjdi1zOFDTcTSuaJXV6TfmhzjPU0YkLUDGPcyarzA+AOcLXhFjDPad5m7/2pBkm98
         JAEIfHXDuqhHNFZBaQ+D2arv23iBmkZjbAgygJm+Swqfo0R0czBisL7qt05g8UrfyIxM
         0K9XTtvSA3prCNX/+LZ68RdcMql0emRWwxucIBEwzFBm+82I1UYSKw+AmaoMpwqm9Fr0
         oXFJYcHSDA5V3qYlpcNl8HG7szKuk0wKRMA9BHnjjn8hSQANVbJ5qXAqpgzTn6QIxk+F
         Sfcg==
X-Gm-Message-State: ABy/qLYMKAQ1eKFR+cTnkizAUtKdbjf6Wn4Ufasir+I+lFzJ8qeN36F0
        O2BXBJ6EfeCjJYT1MWrd15s=
X-Google-Smtp-Source: APBJJlGZvaloFXknVRTvqkS8CO2229Ce8SaVTTc8OYaqYbk+O9Fae3U1O78NMpT1HHYwb5Da+Y9qWQ==
X-Received: by 2002:a05:6a21:7881:b0:130:2e61:3061 with SMTP id bf1-20020a056a21788100b001302e613061mr676155pzc.60.1689247468114;
        Thu, 13 Jul 2023 04:24:28 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.86])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709028f9000b001b86dd825e7sm5686717plo.108.2023.07.13.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:24:27 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com,
        morleyd@google.com, imagedong@tencent.com, mfreemon@cloudflare.com,
        mubashirq@google.com, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
Date:   Thu, 13 Jul 2023 19:24:04 +0800
Message-Id: <20230713112404.2022373-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

For now, skb will be dropped directly if rmem schedule fails, which means
tcp_try_rmem_schedule() returns an error. This can happen on following
cases:

1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
   the receive queue of the tcp socket is not empty.
2. The receive buffer of the tcp socket is full, which can happen on small
   packet cases.

If the user hangs and doesn't take away the packet in the receive queue
with recv() or read() for a long time, the sender will keep
retransmitting until timeout, and the tcp connection will break.

In order to handle such case, we introduce the tcp protocol OOM detection
in following steps, as Neal Cardwell suggested:

1. reply a pure ack, which doesn't contain SACK blocks, if we fail to
   alloc memory to queue the skb on the receiving path. We only do this
   for the next wanted sequence
2. we assume that the receiver is OOM if we have retransmitted the first
   skb in the retransmission queue for N times and every retransmission
   has a corresponding pure ack, which doesn't contain SACK blocks.
   Meanwhile, SACK should be enabled on the connection, too.
3. the sender enter OOM state, and use the probe timer instead of the
   retrans timer. In tcp_send_probe0(), we retransmit the first skb in
   rtx queue instead of zero-window probe packet if the socket is in OOM
   state.
4. we exit the OOM state if snd_una was changed, which means
   FLAG_SND_UNA_ADVANCED is set.

And we introduce the sysctl "tcp_oom_retries" for the "N". By default,
its value is 0, which means the OOM detection is disabled, to reduce the
impact to the users who don't need such function.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- disable the OOM detection by default to reduce the impact
- don't impact the fast path
---
 Documentation/networking/ip-sysctl.rst | 14 +++++
 include/linux/tcp.h                    |  1 +
 include/net/inet_connection_sock.h     |  3 +-
 include/net/netns/ipv4.h               |  1 +
 include/net/sock.h                     |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  7 +++
 net/ipv4/tcp_input.c                   | 71 +++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  | 13 ++++-
 net/ipv4/tcp_timer.c                   |  7 ++-
 10 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4a010a7cde7f..3de2dce74037 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -694,6 +694,20 @@ tcp_retries2 - INTEGER
 	RFC 1122 recommends at least 100 seconds for the timeout,
 	which corresponds to a value of at least 8.
 
+tcp_oom_retries - INTEGER
+	RTO retransmissions count of the receiver is recognised as OOM.
+	Given a value N, a hypothetical TCP connection will enter probe
+	state if N times RTO retransmissions performed and every
+	retransmission gets a pure ack, who doesn't contain SACK block.
+
+	The default value is 0, which means disable the OOM detection.
+	If disabled, skb will be dropped directly, without sending an
+	ACK, when rmem schedule fails. The function is valid only if sack
+	is enabled.
+
+	3 is the suggested value to enable this function. Do't make it
+	greater than tcp_retries2.
+
 tcp_rfc1337 - BOOLEAN
 	If set, the TCP stack behaves conforming to RFC1337. If unset,
 	we are not conforming to RFC, but prevent TCP TIME_WAIT
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b4c08ac86983..0801119a94ea 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -337,6 +337,7 @@ struct tcp_sock {
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
 	u32	lost_out;	/* Lost packets			*/
 	u32	sacked_out;	/* SACK'd packets			*/
+	u32	oom_ack_rcv;	/* Number of received pure ACK for OOM */
 
 	struct hrtimer	pacing_timer;
 	struct hrtimer	compressed_ack_timer;
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c2b15f7e5516..2c0d51a241b3 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -164,7 +164,8 @@ enum inet_csk_ack_state_t {
 	ICSK_ACK_TIMER  = 2,
 	ICSK_ACK_PUSHED = 4,
 	ICSK_ACK_PUSHED2 = 8,
-	ICSK_ACK_NOW = 16	/* Send the next ACK immediately (once) */
+	ICSK_ACK_NOW    = 16,	/* Send the next ACK immediately (once) */
+	ICSK_ACK_PURE   = 32,	/* Send ACK without sack */
 };
 
 void inet_csk_init_xmit_timers(struct sock *sk,
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index f00374718159..378656328b68 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -196,6 +196,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_fib_notify_on_flag_change;
 	u8 sysctl_tcp_syn_linear_timeouts;
+	u8 sysctl_tcp_oom_retries;
 
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	u8 sysctl_udp_l3mdev_accept;
diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64..ecc5ba2f8ddf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -959,6 +959,7 @@ enum sock_flags {
 	SOCK_XDP, /* XDP is attached */
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
+	SOCK_RCV_OOM, /* the receiver is in OOM state */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2afb0870648b..61143d0864d7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1489,6 +1489,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "tcp_oom_retries",
+		.data		= &init_net.ipv4.sysctl_tcp_oom_retries,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
 	{ }
 };
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 57c8af1859c1..f5179bcdf3bf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3762,6 +3762,65 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 	return delivered;
 }
 
+static bool tcp_need_ack_oom(struct sock *sk)
+{
+	return (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_oom_retries) &&
+		inet_csk(sk)->icsk_retransmits &&
+		tcp_is_sack(tcp_sk(sk))) ||
+	       sock_flag(sk, SOCK_RCV_OOM);
+}
+
+static void tcp_ack_oom(struct sock *sk, const struct sk_buff *skb,
+			const u32 prior_snd_una, int *flag)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 ack = TCP_SKB_CB(skb)->ack_seq;
+	struct tcp_sock *tp = tcp_sk(sk);
+	int tcp_oom_retries;
+	unsigned long when;
+
+	if (sock_flag(sk, SOCK_RCV_OOM)) {
+		/* new data is acked, which means the retransmission
+		 * success, and we can leave the OOM state now.
+		 */
+		if (*flag & FLAG_SND_UNA_ADVANCED) {
+			tp->oom_ack_rcv = 0;
+			icsk->icsk_backoff = 0;
+			icsk->icsk_probes_tstamp = 0;
+			inet_csk_clear_xmit_timer(sk, ICSK_TIME_PROBE0);
+			sock_reset_flag(sk, SOCK_RCV_OOM);
+		}
+		return;
+	}
+
+	/* Only pure ACK without SACK blocks is considered here */
+	if (TCP_SKB_CB(skb)->seq != TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->sacked || prior_snd_una != ack)
+		return;
+
+	/* this means real packet drop may happen, don't enter the OOM
+	 * state
+	 */
+	if (icsk->icsk_retransmits != tp->oom_ack_rcv + 1)
+		return;
+
+	tp->oom_ack_rcv++;
+	tcp_oom_retries = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_oom_retries);
+	if (tp->oom_ack_rcv < tcp_oom_retries)
+		return;
+
+	/* enter OOM state when we receive enough pure ACKs */
+	sock_set_flag(sk, SOCK_RCV_OOM);
+	tp->oom_ack_rcv = 0;
+	icsk->icsk_retransmits = 0;
+
+	/* use oom-probe instead of retrans timer */
+	when = tcp_probe0_when(sk, TCP_RTO_MAX);
+	when = tcp_clamp_probe0_to_user_timeout(sk, when);
+	tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, TCP_RTO_MAX);
+	*flag &= ~FLAG_SET_XMIT_TIMER;
+}
+
 /* This routine deals with incoming acks, but not outgoing ones. */
 static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 {
@@ -3907,6 +3966,10 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 				      &rexmit);
 	}
 
+	if (tcp_need_ack_oom(sk))
+		/* we don't impact the fast path......do we? */
+		tcp_ack_oom(sk, skb, prior_snd_una, &flag);
+
 	/* If needed, reset TLP/RTO timer when RACK doesn't set. */
 	if (flag & FLAG_SET_XMIT_TIMER)
 		tcp_set_xmit_timer(sk);
@@ -5056,7 +5119,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			reason = SKB_DROP_REASON_PROTO_MEM;
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
 			sk->sk_data_ready(sk);
-			goto drop;
+			if (tcp_is_sack(tp) &&
+			    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_oom_retries)) {
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_PURE;
+				goto out_of_window;
+			} else {
+				goto drop;
+			}
 		}
 
 		eaten = tcp_queue_rcv(sk, skb, &fragstolen);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cecd5a135e64..26a2fc6ae574 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3216,6 +3216,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_notsent_lowat = UINT_MAX;
 	net->ipv4.sysctl_tcp_tw_reuse = 2;
 	net->ipv4.sysctl_tcp_no_ssthresh_metrics_save = 1;
+	net->ipv4.sysctl_tcp_oom_retries = 0;
 
 	refcount_set(&net->ipv4.tcp_death_row.tw_refcount, 1);
 	tcp_set_hashinfo(net);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2cb39b6dad02..6a30ce7e649f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -959,7 +959,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
-	if (unlikely(eff_sacks)) {
+	if (!(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_PURE) &&
+	    unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
 		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
 					 TCPOLEN_SACK_PERBLOCK))
@@ -4130,6 +4131,13 @@ int tcp_write_wakeup(struct sock *sk, int mib)
 	if (sk->sk_state == TCP_CLOSE)
 		return -1;
 
+	if (sock_flag(sk, SOCK_RCV_OOM)) {
+		skb = tcp_rtx_queue_head(sk);
+		WARN_ON_ONCE(!skb);
+		if (skb)
+			return __tcp_retransmit_skb(sk, skb, 1);
+	}
+
 	skb = tcp_send_head(sk);
 	if (skb && before(TCP_SKB_CB(skb)->seq, tcp_wnd_end(tp))) {
 		int err;
@@ -4178,7 +4186,8 @@ void tcp_send_probe0(struct sock *sk)
 
 	err = tcp_write_wakeup(sk, LINUX_MIB_TCPWINPROBE);
 
-	if (tp->packets_out || tcp_write_queue_empty(sk)) {
+	if (!sock_flag(sk, SOCK_RCV_OOM) &&
+	    (tp->packets_out || tcp_write_queue_empty(sk))) {
 		/* Cancel probe timer, if it is not required. */
 		icsk->icsk_probes_out = 0;
 		icsk->icsk_backoff = 0;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 470f581eedd4..41dbe52101b8 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -369,7 +369,7 @@ static void tcp_probe_timer(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int max_probes;
 
-	if (tp->packets_out || !skb) {
+	if (!sock_flag(sk, SOCK_RCV_OOM) && (tp->packets_out || !skb)) {
 		icsk->icsk_probes_out = 0;
 		icsk->icsk_probes_tstamp = 0;
 		return;
@@ -544,6 +544,11 @@ void tcp_retransmit_timer(struct sock *sk)
 		}
 		if (mib_idx)
 			__NET_INC_STATS(sock_net(sk), mib_idx);
+
+		/* initialize oom_ack_rcv with 0 when the first
+		 * retransmission happen
+		 */
+		tp->oom_ack_rcv = 0;
 	}
 
 	tcp_enter_loss(sk);
-- 
2.40.1

