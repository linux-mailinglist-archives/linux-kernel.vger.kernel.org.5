Return-Path: <linux-kernel+bounces-119648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0E88CB87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71771F82BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25484FC9;
	Tue, 26 Mar 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxCHy5mZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBB41238;
	Tue, 26 Mar 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476359; cv=none; b=qeC5w9vYGa3T/M+y7RI6Nt8Ygff+RUR5MnwoTFMSrCnEvGU4RSfFlVzXtmkg7v/gXu6RJkqXyQMcycC1VXCVsO7cUn2YtGkYNdHk1dWZ2Zd01r280X5QKcb29ZtW5jhmfWs5BnzhK6kXUV55Kfmd8+w05ruy83VD6yiuacjEQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476359; c=relaxed/simple;
	bh=Z8BlIPVLI03rfVazMUWT5hVeAe+y76SizIxskoTqgm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riIFAQ7s53AN0J6LnxjVkrpc7aP7ISCGj4A3Yebz8NA263AlG3bvSk/xxYZvIo9x47qRzBs9ZYn0+nKd2p+VB13X+kdSBlz65pyhma6rUn8dKgarysinEuEHPZviXjz7YSz6z/5v3qSFPrnwGIU11wz0DNTC57R4X17lINMx0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxCHy5mZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34175878e30so4185799f8f.3;
        Tue, 26 Mar 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476356; x=1712081156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c2stnKJuR84Ay01kn2oc6rwDVFwsXL9yn0nGaU5p5Q=;
        b=NxCHy5mZyG2JFab5XGWnt6ycDMedt1JELpJgQScFFE/tRtFyJ/70qPT7+7FnTeMt3V
         AS9oP7sGXEhk4ncnb8HiL8tC2rnC0v0H5LcFhcPuCyl4LAZ9TaQJI1lrC5QsCwWMjSZN
         2UN/iszIGyVZW26NQ37AB/LBgAGPs3lvUBOno/0CtZZBtTjB8+/aifF/dJsiLjKKdwnP
         KN3MRzszhx5aMtiKYF5go7bn+kjyF4Eq392t3RY6EEPR0gRGeGcjiffqDcx21n9604cw
         0dl4FY45K5vxCZaLtXn85VwH9Va8VDo+tk2CShLCtcU06H1L4YDalqLYa/Rq2wRiqlda
         BMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476356; x=1712081156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c2stnKJuR84Ay01kn2oc6rwDVFwsXL9yn0nGaU5p5Q=;
        b=pfd2EvTfJqcnrOU5C4tM4njK8+C8Rsdf41tR/m6/AxxbpH5mWOdcju2cZXnyIotYzU
         PhcgqJk3q3wzZ4LqsuI5VGiDcVmUjaBj6z2ncTvfBXT9LxYKAt2/Bd8hplTDWB0xSVE9
         uu+p0SWDwrxnxFmMdDmzFRqT4Dc9X2nxxu8N9je4tdiFMdwVyCxTAvSiY7NJ282Ppv5Y
         VctyhX9PXKmpIstyMiUVEiajLHnQLhjtngAxix6KkRyu4IOAx/oV21ZooRkVdRNz8FW4
         QfxaRysf4XiDEQh98ZCxB0kdLko5alRl0vdQlRV89m7s0fAuL5nEdKO326hFPtlmFxVZ
         v9aw==
X-Forwarded-Encrypted: i=1; AJvYcCWjYcALl2iRWpSuno3Ko2XCQLfazOxwBCFGlVCzVgvlnt2gHMgDUr3WoTd2obZTg5k6PUk9hrl8yI9JA1SR3pDGFOPN6ccopBk/ArUKfk4xPZDzRo6ukTuEh45XA3KYKTTjvB/9tea/Tktok+WDtVvF2JCdATwGLUENsmBKFMN2OJgBfEibbRBA
X-Gm-Message-State: AOJu0Yy1UoOqsnafpeuEwaWtsntD9hThEWTMkrEMD3xZcISTHFXXtot4
	9zvHyS+xb5iN//89Z9DpFRzCWQEVoTan9ReKuTWn3lQYCGbM6/+k
X-Google-Smtp-Source: AGHT+IFQI9z0WQomLuNHg4+6pEZtOvE3uVTDQSk/n5uIUoFcS1OWyTQCSMdXg6+vHONM0C2CwVNaVA==
X-Received: by 2002:a5d:648e:0:b0:341:cf92:ed33 with SMTP id o14-20020a5d648e000000b00341cf92ed33mr6141919wri.11.1711476355861;
        Tue, 26 Mar 2024 11:05:55 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00341c6b53358sm8275523wrb.66.2024.03.26.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:05:55 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Tue, 26 Mar 2024 19:05:47 +0100
Message-Id: <0c8b3e33dbf679e190be6f4c6736603a76988a20.1711475011.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711475011.git.balazs.scheidler@axoflow.com>
References: <cover.1711475011.git.balazs.scheidler@axoflow.com>
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
index 336fe272889f..62bebe2a6ece 100644
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
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
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


