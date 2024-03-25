Return-Path: <linux-kernel+bounces-116839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D188A467
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ED72E2BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAA548F4;
	Mon, 25 Mar 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0/ZyBh7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7413CA9B;
	Mon, 25 Mar 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362567; cv=none; b=XsKXv0ESWf0DhUgVxTQQ8RSvoz4TCnKyWPGVAapJc/HVeCwX8Fn81hN6WB2BeveB9pv4OIaWEI0ECwGtzOqFYO7eb+ldLozG8sOlCwFZjQGMA/ZIBHBG5JRtRPApRD3o4+biMnY2OclwpLWo/f2uTHOTphtxjV5KnRIrfW9Rn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362567; c=relaxed/simple;
	bh=AEkgv8xYLM1Y6P5xl+hZbNb+Us9X3rjZQ/skIPmLP8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/S5eO4Br0OVirDY3c3D0pVP5pRCLGOPZSQrqc8yV76r6Vd+iKeg6lZMZZz9NiB0dpVqJwl8+oDUubtLaextxk7aG5uBWFfBnUXGy8Pof5pO7u4jdAUtSl2OSiPBIdXTR/gcdybMGAGhMpfxuxkqEOr7mbkrls6nDm5E220XGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0/ZyBh7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so2859851f8f.2;
        Mon, 25 Mar 2024 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362564; x=1711967364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EabZCAmYyC9fAriiA6X6yV4dOCGsBHE168qYS8MPOw=;
        b=l0/ZyBh7p69zKfiQXj5yQB8I3ks5k37fVDejAv2n3p8U3KCtNlcwZV0vsZZIpU9Qii
         NsCKIqRkhBdoJ8FSdlE57MLvAxj9UAly2XLQ7gAgimjRmoRCfh7g05g1iwlIz1TTkccL
         rwUIhdyQ5uA1pjEiJ9TwGJHK0Druatk6bqkbRx4Axa3HiXY0YXhRMa/XN2PDS7ZyNUBi
         +xLEoN5NSKlzA+LP6T16n2bWNuhH5BfBkHv6FSrJ/y8dCaBLeluWI5bYuaoVpkMV6fYO
         GAac2+po/HF+u56WJlnI5SazQyhoEkeh0d8lRf1726MlY7enZC4kJhaP8Qdu0bokWNCW
         Xz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362564; x=1711967364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EabZCAmYyC9fAriiA6X6yV4dOCGsBHE168qYS8MPOw=;
        b=jbpmtDfUHGNkit735fRqUeVm8ouUUqe4UNppFG/2ppE6Nli5V2DGzdI0R4uq4UKlIg
         DTLvY90QN7oidoP9E2vQ/fBqvzg9qAt6IItfCqlI8Yzrwm0ifVuvwM2vY6KRT78zeyp5
         liMAHqXACWJDGmc3sylm2iKWfbuxIhTHIrq0VTvM5+Ge1zn4HhD7Z8UW3IQVCec6+OSu
         Ega8ZYH4bfDCNSfHIYZzg0aitTpuN7Fm0aQuODVTKvlXygujEGfitLWL0956NBYxD+Ro
         cuUabEQb1XjL6TBqKQdMC6ehQqBoyQew4bCUwCJPRfgCiBm3i4w27pZ7sQKWr+hd0E7x
         uqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeQSyE4BL3dGFIK4MjBTNUOa1VfQaJM6swXXFQbVlOIoH96hgyRWnhWmUz+QFrVsN29uN2E3zlCJuzX2wviM/h18Gky27IACdBw2cOCDuXy1fUis6+/xWlDre6RtQ8pKvB6VrEcXTVW+UZ3UuVkqtfwSmr+3nOHDc8YL2fmiZGBfLUQkcfKNLp
X-Gm-Message-State: AOJu0YxqGR0dXJvCJwOpylGYhyAXB2famobQDn5B5HRW++RMH84qnyDF
	hpIhSjSB+DJID4NGPEYvF7D+Nc4an0mm/w8ckOQ4DGc7qSjHqw35
X-Google-Smtp-Source: AGHT+IHDRQtDBPVN8brfP95hrTujHwNSjvul/4icsvx7yeQ+rsK+oMsiwfTb58zn6GWAZqknh/CD3A==
X-Received: by 2002:adf:e94a:0:b0:33e:d470:da8f with SMTP id m10-20020adfe94a000000b0033ed470da8fmr3937861wrn.17.1711362564039;
        Mon, 25 Mar 2024 03:29:24 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id bq22-20020a5d5a16000000b00341d0458950sm1394958wrb.15.2024.03.25.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:29:23 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: kerneljasonxing@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Mon, 25 Mar 2024 11:29:17 +0100
Message-Id: <394f9d55197681e910d104dbd35e62fb4098712b.1711361723.git.balazs.scheidler@axoflow.com>
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

This patch moves TP_STORE_ADDR_PORTS_SKB() to a common header and removes
the TCP specific implementation details.

Previously the macro assumed the skb passed as an argument is a
TCP packet, the implementation now uses an argument to the L4 header and
uses that to extract the source/destination ports, which happen
to be named the same in "struct tcphdr" and "struct udphdr"

Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
---
 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
index 3930119cab08..50c083b5687d 100644
--- a/include/trace/events/net_probe_common.h
+++ b/include/trace/events/net_probe_common.h
@@ -41,4 +41,45 @@
 
 #endif
 
+#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)		\
+	do {								\
+		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
+									\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->source;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
+		v4 = (void *)__entry->daddr;				\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->dest;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
+	} while (0)
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)			\
+	do {								\
+		const struct iphdr *iph = ip_hdr(skb);			\
+									\
+		if (iph->version == 6) {				\
+			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
+									\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->source;			\
+			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
+			v6 = (void *)__entry->daddr;			\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->dest;			\
+			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
+		} else							\
+			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh); \
+	} while (0)
+
+#else
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)		\
+	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)
+
+#endif
+
+
 #endif
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 699dafd204ea..5f19c5c6cda8 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -302,48 +302,6 @@ TRACE_EVENT(tcp_probe,
 		  __entry->skbaddr, __entry->skaddr)
 );
 
-#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
-	do {								\
-		const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
-									\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->source;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
-		v4 = (void *)__entry->daddr;				\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->dest;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
-	} while (0)
-
-#if IS_ENABLED(CONFIG_IPV6)
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)				\
-	do {								\
-		const struct iphdr *iph = ip_hdr(skb);			\
-									\
-		if (iph->version == 6) {				\
-			const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
-									\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->source;			\
-			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
-			v6 = (void *)__entry->daddr;			\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->dest;			\
-			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
-		} else							\
-			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb);	\
-	} while (0)
-
-#else
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)		\
-	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)
-
-#endif
-
 /*
  * tcp event with only skb
  */
@@ -360,12 +318,13 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 	),
 
 	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		__entry->skbaddr = skb;
 
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb, th);
 	),
 
 	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
-- 
2.40.1


