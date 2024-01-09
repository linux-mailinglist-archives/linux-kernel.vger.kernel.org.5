Return-Path: <linux-kernel+bounces-20318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07CB827D43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3511C23441
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565633EA;
	Tue,  9 Jan 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEm+FxQ7"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA86D6CA;
	Tue,  9 Jan 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d45f182fa2so22008705ad.3;
        Mon, 08 Jan 2024 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704769980; x=1705374780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66aC1vXoQT3OSiY5ewrbnScT/Lwyxm5wMDu4a47YpCU=;
        b=mEm+FxQ77mKR3Dgbz0O3xraIpyQ0eqrx+74+TNlTBkGgUV1dpADk/OIOkcoVCQXcaF
         twkl5G4svPgl3kEXa0Xerkik3GwApGr0RDtMeIqGYJ5mwC3j+FyD7SoYzjKOit2wa3Ov
         f671OD1CSi5mcXB6HeMKijLARLpf6sRTFvf6XozX7H9LPD8GtrDjF81Xgl9vhl51jzg0
         vBMFyyZvwqJHlvLcwYN8F6eB+J65fK5pdffdhfvuMNL1suTgNJZEDtv7n8tRDPcZNI6a
         ZYksJuaRprutul3S0jvgWdoDJ5Pp4MSqSVvzea2umCGO/MYgObnSshgGGKYZtFMx9au+
         w3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704769980; x=1705374780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66aC1vXoQT3OSiY5ewrbnScT/Lwyxm5wMDu4a47YpCU=;
        b=ox1nyZygosqa/AzqyEzsOvKMeT727v6Hag8M3D9BZoNQFikgkhv25zliv0QxhIdpgM
         9gewqYyksMyePH3jP0V/Sz72JCWIVZvsRqFYfmDDQfjmSRsCzUvqlyNgxHjmP5Go+3gk
         epQMbj0MSudfnNHjA4hVZ02tvPrLleHDihbTUr3Y5O1LuYa1/Xu0TF5OlKpCA+IGSqPJ
         YIZlWIStX84TIfZMiBJli+MQGe0p62DqVae3HejXiyc/cCRv7z5gmWU0ZtjLP7rfKa4E
         SkEXVRP/uEdUxphBPvjACLShtgyqW+GqATXcwD8dK69YaAE/Hf6VaNeInXiO/9UZrLa0
         BsEA==
X-Gm-Message-State: AOJu0YwFiK4eE0M0FSBojS9RcwjVkGLbkA67foJYNZ1TkSfoD63158EF
	PCwzGb0cwXr3NxL0IKRL/Qg=
X-Google-Smtp-Source: AGHT+IHi8GPyXxwUaOoRvCZlyEw7z8egspDHefL7Xoc9JoKikxUFHAkFye2GOt+4+Tqq/2/+BGs2aw==
X-Received: by 2002:a17:903:32ca:b0:1d4:5276:765b with SMTP id i10-20020a17090332ca00b001d45276765bmr6245366plr.124.1704769980081;
        Mon, 08 Jan 2024 19:13:00 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001d491db286fsm589174pls.282.2024.01.08.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:12:59 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH] net: tcp: accept old ack during closing
Date: Tue,  9 Jan 2024 11:12:04 +0800
Message-Id: <20240109031204.15552-1-menglong8.dong@gmail.com>
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
 net/ipv4/tcp_input.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index df7b13f0e5e0..b2b19421de8b 100644
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
+	SKB_DR_SET(NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
-- 
2.39.2


