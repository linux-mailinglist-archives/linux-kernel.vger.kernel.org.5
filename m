Return-Path: <linux-kernel+bounces-82631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F030868773
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9A31F237A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65C1B949;
	Tue, 27 Feb 2024 02:58:14 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82373610D;
	Tue, 27 Feb 2024 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002694; cv=none; b=XNIJE4rGMdAzCe4cbsGIot1HsuDNZvtaNaKa1VQMgapl+Yc6yxP7duSz9nPfeqXzePRMr9yCzOSJTw6zCG+pT16M3BYcPSH7B83CTdlytbvxKfseMXVu26AEtstCqwopjDh2cAGn7UEgqFrWXQLU/LoXE/aVO5jMLHv8j9+3/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002694; c=relaxed/simple;
	bh=AaZ7qsvOSZA9cbUPNq84VziHt8N0O2Mp93ysaLF45VM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=D2Tq0I5JA7WDgiJmLj3Km47ywXHcyCTNHRoaIlsC4iQVWzRFQ4xPZAbjkelhRwiUrfUMhgDnw6Bo7Gex8NzeCERhTf0WGeh4Oo6bSUORRQyet9wTTECGXUsMuHbeYM0CUU67jv87snIjqaZKhXOJXDr2ZGC7ZZBpX31AH1d95QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4TkMSC0LSwzCh15;
	Tue, 27 Feb 2024 10:51:07 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4TkMS20jVpzCHrX8;
	Tue, 27 Feb 2024 10:50:58 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4TkMRp0Q4Sz8XrRN;
	Tue, 27 Feb 2024 10:50:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 41R2oZRh081486;
	Tue, 27 Feb 2024 10:50:35 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 27 Feb 2024 10:50:36 +0800 (CST)
Date: Tue, 27 Feb 2024 10:50:36 +0800 (CST)
X-Zmail-TransId: 2afb65dd4dfc2c8-53c3e
X-Mailer: Zmail v1.0
Message-ID: <202402271050366715988@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <davem@davemloft.net>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <dsahern@kernel.org>,
        <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <he.peilin@zte.com.cn>, <liu.chun2@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQvaXB2NDogYWRkIHRyYWNlcG9pbnQgZm9yIGljbXBfc2VuZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 41R2oZRh081486
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65DD4E19.000/4TkMSC0LSwzCh15

From: xu xin <xu.xin16@zte.com.cn>

Introduce a tracepoint for icmp_send, which can help users to get more
detail information conveniently when icmp abnormal events happen.

1. Giving an usecase example:
=============================
When an application experiences packet loss due to an unreachable UDP
destination port, the kernel will send an exception message through the
icmp_send function. By adding a trace point for icmp_send, developers or
system administrators can obtain the detailed information easily about the
UDP packet loss, including the type, code, source address, destination
address, source port, and destination port. This facilitates the
trouble-shooting of packet loss issues especially for those complicated
network-service applications.

2. Operation Instructions:
==========================
Switch to the tracing directory.
	cd /sys/kernel/debug/tracing
Filter for destination port unreachable.
	echo "type==3 && code==3" > events/icmp/icmp_send/filter
Enable trace event.
	echo 1 > events/icmp/icmp_send/enable

3. Result View:
================
 udp_client_erro-11370   [002] ...s.12   124.728002:  icmp_send:
icmp_send: type=3, code=3.From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
skbaddr=00000000589b167a

Signed-off-by: He Peilin <he.peilin@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/icmp.c             |  4 ++++
 2 files changed, 61 insertions(+)
 create mode 100644 include/trace/events/icmp.h

diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
new file mode 100644
index 000000000000..3d9af5769bc3
--- /dev/null
+++ b/include/trace/events/icmp.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM icmp
+
+#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ICMP_H
+
+#include <linux/icmp.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(icmp_send,
+
+		TP_PROTO(const struct sk_buff *skb, int type, int code),
+
+		TP_ARGS(skb, type, code),
+
+		TP_STRUCT__entry(
+				__field(__u16, sport)
+				__field(__u16, dport)
+				__field(unsigned short, ulen)
+				__field(const void *, skbaddr)
+				__field(int, type)
+				__field(int, code)
+				__array(__u8, saddr, 4)
+				__array(__u8, daddr, 4)
+		),
+
+		TP_fast_assign(
+				// Get UDP header
+				struct udphdr *uh = udp_hdr(skb);
+				struct iphdr *iph = ip_hdr(skb);
+				__be32 *p32;
+
+				__entry->sport = ntohs(uh->source);
+				__entry->dport = ntohs(uh->dest);
+				__entry->ulen = ntohs(uh->len);
+				__entry->skbaddr = skb;
+				__entry->type = type;
+				__entry->code = code;
+
+				p32 = (__be32 *) __entry->saddr;
+				*p32 = iph->saddr;
+
+				p32 = (__be32 *) __entry->daddr;
+				*p32 =  iph->daddr;
+		),
+
+		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
+			__entry->type, __entry->code,
+			__entry->saddr, __entry->sport, __entry->daddr,
+			__entry->dport, __entry->ulen, __entry->skbaddr)
+);
+
+#endif /* _TRACE_ICMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617..437bdb7e2650 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -92,6 +92,8 @@
 #include <net/inet_common.h>
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/icmp.h>

 /*
  *	Build xmit assembly blocks
@@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct net *net;
 	struct sock *sk;

+	trace_icmp_send(skb_in, type, code);
+
 	if (!rt)
 		goto out;

-- 
2.15.2

