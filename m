Return-Path: <linux-kernel+bounces-116840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF888A468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2A51F611C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FB15ECE1;
	Mon, 25 Mar 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOtrIZRQ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8713173E;
	Mon, 25 Mar 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362569; cv=none; b=SYTMfAXRujtQyGuiLqBL3tG6kfPveJ1wgcjtNvsn2zjXhSWIm8/DPMsTFZNpZKSPEU8HgfJJhWXNZqlLl6nkN8IebDV9SurkxZoyeWTTyTlZUPFjf8/G+zxpFpNGHXfrGcFwdS9vnZS9qxA9/tiOxtuCb2/hBUgS4RTaH4ai1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362569; c=relaxed/simple;
	bh=9GVBUu/FfME7hJnTGLJoojIPT623ugOT1Rgx4WBw8tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIyzz6RpIPbUkANTIr+4hsT6iFJ8eBhxMmkXnOqNJHNF2Kp0Alp8SQ1My3We3Kj0NNbzSk3+XsDCRzOKQMZMvk3N5Xx1VkDcScL9c4qzylPUFu2RqzO+nrinKYhkURNkhCBmbob5njB9Hzhs/xXvTrvVx+kx7Oa4U1lVCu484VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOtrIZRQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33fd8a2a3e6so2820130f8f.0;
        Mon, 25 Mar 2024 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362566; x=1711967366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmp26Wyrh5R6YY4RQvUCX7nV7M7UVvO0NSBIsiSwspA=;
        b=NOtrIZRQbolTWYBWUwpidr4vrC3LjkcAjyZfR/Qj8PWM8LUOHz7PLEEXbSyBS4QmoL
         4g4p5+OW8OJ75JHfQhOFO5iRAeQzS7bWIOw67XbiVbWyrwTSjqkyuVb505m/QZgcbxpN
         svO/rWNpbuaYzshcjTVKyeO6VmvrfIzgKYqMbCLdyFHZ7zPEAWdXmfa0a3llvSkqtqjX
         n7QgbT9P7FWLgrYi9I496+Lia0XboZV58QYjvlfdxfo2wP2WrhxtKwcpMwsS6ubfOD57
         1/yOIBmGyU5zK6PgA1ozCEVdTUyXsLh0RR0LzopIXq5+RfheN7W9zp9NAEIR/9c29ngE
         YMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362566; x=1711967366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmp26Wyrh5R6YY4RQvUCX7nV7M7UVvO0NSBIsiSwspA=;
        b=JZqRJ50EJ4B6OOnECHq3Wreacs6rC2fUOzxMAMynb84h6DDRJQLHZbgT43KEyMvMPm
         JQJ3T5bLMmcMLPDt4NzZqtHfgypwwtsiG/4o3nsfXA385WY3uSkZqw/7eOjDD6BEVGNr
         Bi9YGXrMygXEZxeLD2sZcGKbb7O+PgiueupEt/a5xQ76HBIlqkTNgrqfONKQJKWhn2YW
         zHmrDEXyjxNT9EOlyKNnrWuY3HCl4i5Wr0OxTWtRs79YYX5wuFHJnMQFteTlmgrLglX+
         awln48ztoFZ0czUMYnQgTyfwsfx1A6ScLkwitKzV/LP+5AkXrGSIm5ooZ3YViPfm2iv+
         IHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ztUn/kyxr1VqGwU6CxkoXZ9OjWtaI1vs/tXQF53tlbCQwxIPQFTIFcfV3NtoXJLkXq8jM+x3QrZ0wdJo+0vGtkqP1lTw2DPoB8HUfYzk9YvFsl5GGotYMKq6oFbM4Cwvp3uXwETpKveuSkau8Pr2TcYPQizy6F1UOjpAEIPd/XKYa+SQNUDx
X-Gm-Message-State: AOJu0YwuNiTe9e/kuMzdS+KCqakJBGq9bcieEVIgeUPTWAF/KyvaR/ga
	T7VPdlmceGeYOh3GOWOWfWz6loBxaYT12NacZx5Z0UvH2uGuEHbO
X-Google-Smtp-Source: AGHT+IEVlCOJjAaIAB+mb/cq3ZaQVF2CjGfbd2m+A6Gjn+L/66qfIIAX3D+oMoiIrwo0dRcDtHOY8A==
X-Received: by 2002:adf:f60f:0:b0:33e:6db4:e89f with SMTP id t15-20020adff60f000000b0033e6db4e89fmr4364206wrp.22.1711362565745;
        Mon, 25 Mar 2024 03:29:25 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id bq22-20020a5d5a16000000b00341d0458950sm1394958wrb.15.2024.03.25.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:29:25 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: kerneljasonxing@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Mon, 25 Mar 2024 11:29:18 +0100
Message-Id: <34a9c221a6d644f18c826a1beddba58af6b7a64c.1711361723.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711361723.git.balazs.scheidler@axoflow.com>
References: <cover.1711361723.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
and destination IP/port whereas this information can be critical in case
of UDP/syslog.

Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
---
 include/trace/events/udp.h | 29 ++++++++++++++++++++++++-----
 net/ipv4/udp.c             |  2 +-
 net/ipv6/udp.c             |  3 ++-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
index 336fe272889f..9c5abe23d0f5 100644
--- a/include/trace/events/udp.h
+++ b/include/trace/events/udp.h
@@ -7,24 +7,43 @@
 
 #include <linux/udp.h>
 #include <linux/tracepoint.h>
+#include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(udp_fail_queue_rcv_skb,
 
-	TP_PROTO(int rc, struct sock *sk),
+	TP_PROTO(int rc, struct sock *sk, struct sk_buff *skb),
 
-	TP_ARGS(rc, sk),
+	TP_ARGS(rc, sk, skb),
 
 	TP_STRUCT__entry(
 		__field(int, rc)
-		__field(__u16, lport)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
 
 	TP_fast_assign(
+		const struct udphdr *uh = (const struct udphdr *)udp_hdr(skb);
+
 		__entry->rc = rc;
-		__entry->lport = inet_sk(sk)->inet_num;
+		
+		/* for filtering use */
+		__entry->sport = ntohs(uh->source);
+		__entry->dport = ntohs(uh->dest);
+		__entry->family = sk->sk_family;
+
+                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);
 	),
 
-	TP_printk("rc=%d port=%hu", __entry->rc, __entry->lport)
+	TP_printk("rc=%d family=%s src=%pISpc dest=%pISpc", __entry->rc,
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr)
 );
 
 #endif /* _TRACE_UDP_H */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f..531882f321f2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2049,8 +2049,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		kfree_skb_reason(skb, drop_reason);
-		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7c1e6469d091..2e4dc5e6137b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/indirect_call_wrapper.h>
+#include <trace/events/udp.h>
 
 #include <net/addrconf.h>
 #include <net/ndisc.h>
@@ -658,8 +659,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		kfree_skb_reason(skb, drop_reason);
-		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
-- 
2.40.1


