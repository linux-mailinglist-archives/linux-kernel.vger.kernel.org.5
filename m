Return-Path: <linux-kernel+bounces-24536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52C82BE01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE1EB23B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691D57876;
	Fri, 12 Jan 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0LGiOv5"
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556057869;
	Fri, 12 Jan 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3bbd6e37a9bso5248786b6e.0;
        Fri, 12 Jan 2024 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705053628; x=1705658428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSg4xRXWuoNbqdqrgRfE1U45ctI7Mu0MbXHLSoUnsA=;
        b=L0LGiOv5wsGksE0dbpmQUJ3sMhYaABqx8w8PBcV0SpIz2pIDI6LaxED7fs9xZNrrXS
         qPGQTDgRlnHmFCN5UiXhLcEzKDIWIKoRABUjSiLf0atURM9jgTpwfytaAuuWncJYKUet
         eSEqfjdaAMOnQsx2IzmKxPcz3Tx2pYivlmUrhHuA5VwhZDJOH3+7pd7sR0z/vX5JtHuH
         P2is0NG4UT43VuCZQmBAYLv6O/yF3hrSQMzzMYG9pDq62jvWHCuZ9ijLcYWaDuLEqCtZ
         99NgGWaRJsx6weQNkcY0rEqEnYs6DkMHx17RDhiIL3CpeRvaoddGUhpr/5FhR7s3n9/r
         n6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053628; x=1705658428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZSg4xRXWuoNbqdqrgRfE1U45ctI7Mu0MbXHLSoUnsA=;
        b=pu7UCiWHLOMBEcOivFcS8lgn+vcQS1fYVq46HbNJA8hJ6T+gtqLkMwyVu+ATluQBTG
         xzMCzNU7Adm/rsCOg6768p3tfKctXEKzQzhhuaifns8UNtOxCMv+fFu2ZkRl2t9iVKi4
         cDbk5tuzuXdy4KMc9Lm6Da60rFnBCH1IlWtScdfTJtoUtS46Bngdq0rVx3dlK9pLTrrV
         JCHtwfp01h0MbRK/Y8f/qd9RAcqS+OpaB7sveIHkaEHqP1Q5sJ3ilPjsaqmYzNkqBLmv
         v+drdiMIJsKYSgatsFeRseqf77wu5Io+EQsKnQVqjtEJ+lbL9y8dSgYn5h97t0lWWOd9
         vcMw==
X-Gm-Message-State: AOJu0Yzqjiiw+l8Z6+/+PrivOBONVz6LqqRj04XEY20PbDpJPCEPXA1m
	UwVtBss3Hk8uq/tH5gI+n7s=
X-Google-Smtp-Source: AGHT+IGfUvt1DlpPEjdKl8TX7I5/J1+w+tswdIzAK9AIhkH2QlACj1OPQxrLv06jnyb4/pucE9F19A==
X-Received: by 2002:a05:6808:2387:b0:3bd:6342:e2a0 with SMTP id bp7-20020a056808238700b003bd6342e2a0mr421499oib.6.1705053628002;
        Fri, 12 Jan 2024 02:00:28 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b006d96bb5db5esm2910962pfq.96.2024.01.12.02.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:00:27 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [RFC PATCH net-next v2] net: tcp: accept old ack during closing
Date: Fri, 12 Jan 2024 17:46:03 +0800
Message-Id: <20240112094603.23706-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the packet with an old ack is not accepted if we are in
FIN_WAIT1 state, which can cause retransmission. Taking the following
case as an example:

    Client                               Server
      |                                    |
  FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
      |                                    |
      |                                Send ACK(seq=21, ack=11)
   Recv ACK(seq=21, ack=11)
      |
   Recv FIN(seq=20, ack=10)

In the case above, simultaneous close is happening, and the FIN and ACK
packet that send from the server is out of order. Then, the FIN will be
dropped by the client, as it has an old ack. Then, the server has to
retransmit the FIN, which can cause delay if the server has set the
SO_LINGER on the socket.

Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
it should be better to keep the same logic.

In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
states. Maybe we should limit it to FIN_WAIT1 for now?

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v2:
- fix the compiling error
---
 net/ipv4/tcp_input.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index df7b13f0e5e0..70642bb08f3a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6699,17 +6699,21 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		return 0;
 
 	/* step 5: check the ACK field */
-	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT |
-				      FLAG_NO_CHALLENGE_ACK) > 0;
+	reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
+				  FLAG_UPDATE_TS_RECENT |
+				  FLAG_NO_CHALLENGE_ACK);
 
-	if (!acceptable) {
+	if (reason <= 0) {
 		if (sk->sk_state == TCP_SYN_RECV)
 			return 1;	/* send one RST */
-		tcp_send_challenge_ack(sk);
-		SKB_DR_SET(reason, TCP_OLD_ACK);
-		goto discard;
+		/* accept old ack during closing */
+		if (reason < 0) {
+			tcp_send_challenge_ack(sk);
+			reason = -reason;
+			goto discard;
+		}
 	}
+	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
-- 
2.39.2


