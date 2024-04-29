Return-Path: <linux-kernel+bounces-161977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38948B5412
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6838C1F2209F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAA225D9;
	Mon, 29 Apr 2024 09:16:35 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8A17C79;
	Mon, 29 Apr 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382194; cv=none; b=uI08aOqkLqLadBowdms7XiFgPh0ufp+7dg1FuovP8Kyg3UEEe9yu9ahEIZD8D4dswH1K7OVTbuJAjQmj1XRcdKXrRRg9rXg6HtcHa/FkPdwsJVog2xyORHq8aqKMS4p48/SG0s2VzJsxae1hNGMm9FrEd3ISNfDVeHUdXFX4ygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382194; c=relaxed/simple;
	bh=TZaXfDgPaZgcxEi+ra9/iPiMANbZYn4vjy5qATk3lbw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=T9CIM7coBGpJkR7OauBS6TpKZcfsd6et+ZSTTFFak9jlAeHNVWEifk3cRS22ZJHmWl5dWvQdvNULJ3ztje2+0cSxHSo1eCmFOxQ+VEDp5p2OcXuARNrPksfBgOnjb7zsO83Yl8VnXXsxOwII+CJJpYIKuR/5zST5e7dqPzzU9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VSd482mZtz4xPGH;
	Mon, 29 Apr 2024 17:16:24 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 43T9Fti6063422;
	Mon, 29 Apr 2024 17:15:55 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 29 Apr 2024 17:15:57 +0800 (CST)
Date: Mon, 29 Apr 2024 17:15:57 +0800 (CST)
X-Zmail-TransId: 2afb662f654d799-db7cc
X-Mailer: Zmail v1.0
Message-ID: <20240429171557482x0zswaWhCLkpHecR3bZqb@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <edumazet@google.com>, <kuba@kernel.org>
Cc: <horms@kernel.org>, <davem@davemloft.net>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <dsahern@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <he.peilin@zte.com.cn>, <liu.chun2@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <kerneljasonxing@gmail.com>, <fan.yu9@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
        <zhang.run@zte.com.cn>, <wang.haoyi@zte.com.cn>, <si.hao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY4XSBuZXQvaXB2NDogYWRkIHRyYWNlcG9pbnQgZm9yIGljbXBfc2VuZMKgwqA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 43T9Fti6063422
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 662F6568.003/4VSd482mZtz4xPGH

From: Peilin He <he.peilin@zte.com.cn>

Introduce a tracepoint for icmp_send, which can help users to get more
detail information conveniently when icmp abnormal events happen.

1. Giving an usecase example:
=============================
When an application experiences packet loss due to an unreachable UDP
destination port, the kernel will send an exception message through the
icmp_send function. By adding a trace point for icmp_send, developers or
system administrators can obtain detailed information about the UDP
packet loss, including the type, code, source address, destination address,
source port, and destination port. This facilitates the trouble-shooting
of UDP packet loss issues especially for those network-service
applications.

2. Operation Instructions:
==========================
Switch to the tracing directory.
        cd /sys/kernel/tracing
Filter for destination port unreachable.
        echo "type==3 && code==3" > events/icmp/icmp_send/filter
Enable trace event.
        echo 1 > events/icmp/icmp_send/enable

3. Result View:
================
 udp_client_erro-11370   [002] ...s.12   124.728002:
 icmp_send: icmp_send: type=3, code=3.
 From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
 skbaddr=00000000589b167a

Change log
=========
v7->v8:
Some fixes according to
https://lore.kernel.org/all/CANn89iKNtKmN5im8K4dSZGqAV8=e3bZb
Z5AhxbcNbjFxk5V1Jw@mail.gmail.com/
1.Combine all variable definitions together without mixing 
code and variables.

v6->v7:
Some fixes according to
https://lore.kernel.org/all/20240425081210.720a4cd9@kernel.org/
1. Fix patch format issues.

v5->v6:
Some fixes according to
https://lore.kernel.org/all/20240413161319.GA853376@kernel.org/
1.Resubmit patches based on the latest net-next code.

v4->v5:
Some fixes according to
https://lore.kernel.org/all/CAL+tcoDeXXh+zcRk4PHnUk8ELnx=CE2pc
Cqs7sFm0y9aK-Eehg@mail.gmail.com/
1.Adjust the position of trace_icmp_send() to before icmp_push_reply().

v3->v4:
Some fixes according to
https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJz
BzkJFVgCTdXBx=YBg@mail.gmail.com/
1.Add legality check for UDP header in SKB.
2.Target this patch for net-next.

v2->v3:
Some fixes according to
https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
1. Change the tracking directory to/sys/kernel/tracking.
2. Adjust the layout of the TP-STRUCT_entry parameter structure.

v1->v2:
Some fixes according to
https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHu
FQTJvJsv-nz1xPDw@mail.gmail.com/
1. adjust the trace_icmp_send() to more protocols than UDP.
2. move the calling of trace_icmp_send after sanity checks
in __icmp_send().

Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
---
 include/trace/events/icmp.h | 67 +++++++++++++++++++++++++++++++++++++
 net/ipv4/icmp.c             |  4 +++
 2 files changed, 71 insertions(+)
 create mode 100644 include/trace/events/icmp.h

diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
new file mode 100644
index 000000000000..31559796949a
--- /dev/null
+++ b/include/trace/events/icmp.h
@@ -0,0 +1,67 @@
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
+			__field(const void *, skbaddr)
+			__field(int, type)
+			__field(int, code)
+			__array(__u8, saddr, 4)
+			__array(__u8, daddr, 4)
+			__field(__u16, sport)
+			__field(__u16, dport)
+			__field(unsigned short, ulen)
+		),
+
+		TP_fast_assign(
+			struct iphdr *iph = ip_hdr(skb);
+			struct udphdr *uh = udp_hdr(skb);
+			int proto_4 = iph->protocol;
+			__be32 *p32;
+
+			__entry->skbaddr = skb;
+			__entry->type = type;
+			__entry->code = code;
+
+			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
+				(u8 *)uh + sizeof(struct udphdr)
+				> skb_tail_pointer(skb)) {
+				__entry->sport = 0;
+				__entry->dport = 0;
+				__entry->ulen = 0;
+			} else {
+				__entry->sport = ntohs(uh->source);
+				__entry->dport = ntohs(uh->dest);
+				__entry->ulen = ntohs(uh->len);
+			}
+
+			p32 = (__be32 *) __entry->saddr;
+			*p32 = iph->saddr;
+
+			p32 = (__be32 *) __entry->daddr;
+			*p32 = iph->daddr;
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
+
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 8cebb476b3ab..30b302492613 100644
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
@@ -762,6 +764,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (!fl4.saddr)
 		fl4.saddr = htonl(INADDR_DUMMY);

+	trace_icmp_send(skb_in, type, code);
+
 	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
 ende:
 	ip_rt_put(rt);
-- 
2.17.1

