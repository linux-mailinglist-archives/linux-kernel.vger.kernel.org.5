Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5F7785B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHKDCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHKDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:01:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824E2D79;
        Thu, 10 Aug 2023 20:01:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-687ca37628eso1418609b3a.1;
        Thu, 10 Aug 2023 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722912; x=1692327712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OgisSTpDCALq2GggzFZJcvXoiKxj7XqfD1T8ufu6ys=;
        b=Wt0qbxMgSrP5Ha7icZ+FaqBUtW5bx8CzES3A1OByr1DLFZNqE2rfOgQdBOSAoYXI6Z
         YEW41Io2Kxu6KVkXpgxblVOcLWOIei2TAD/mvEIDAFGQbvU8NbNGcBIcwZ09bDGiZsTk
         xvsWQbkWxHVwTVQWVbk+uwPQlg3vJPTu8VqMLJRTv9QM19hy5G28SqAv/jImHYGdwGOg
         r9/SNX7MjzS9dfcgPA7gXdVI0PXg25HvgB1D7moy3eg3u+EjJwl5EJh7DAydyAsnPlEU
         fjV5OU6encgDxAZ8yKO9+H1NtbrPhr8NSV3kXtYGjuSee0lGPqAzLEZyd7gIcly35lh/
         3Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722912; x=1692327712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OgisSTpDCALq2GggzFZJcvXoiKxj7XqfD1T8ufu6ys=;
        b=S/8543aVXjgHYBkg6ZiQhlLyrpDGrFuSaSpxieExYs5s4/WNIVoTCTqCmJrMnVB3jY
         6octBF409xea5OuihnBfaUaVwtZOqgl+uYFd3gJ2KMTfM7Brwry9XdksPxa4wTprUv5S
         so/ceRcckkoBlxmL/GhTlexe8e45AdM69XVee4WNVlAgddeOkFJHrqItD5OheOwlZ7Te
         fcmruHE1t00hcgriUSeQl8VLGFHqB/xbnNRusmPsGqkE7wMBQhHZhtTOlrSedO2YI6r2
         mGeI0PyWEAtPRbsCJ2CBqXfIBM3qSw34yWnGcR5NKohgOiIMcwdbM2ElkZyimt3EJ/dI
         McpQ==
X-Gm-Message-State: AOJu0Yw/67dgCuJsKJXgjr7sSsWiWnroh/93z+OyFyGmUtHAA4q+Bz2x
        a8Xnk+xRo5B97b43bE7QR2o=
X-Google-Smtp-Source: AGHT+IH+jcd+1sV0hamvuNqqBPBWTM367Ti9YvRSnNeVeS2kh+8kjv9rPue2JPLAdXeix1VM0m16Xw==
X-Received: by 2002:a05:6a20:3d8c:b0:140:a6ec:b55d with SMTP id s12-20020a056a203d8c00b00140a6ecb55dmr1141710pzi.15.1691722912510;
        Thu, 10 Aug 2023 20:01:52 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b005646868da17sm2281197pgo.72.2023.08.10.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:01:52 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v4 4/4] net: tcp: refactor the dbg message in tcp_retransmit_timer()
Date:   Fri, 11 Aug 2023 10:55:30 +0800
Message-Id: <20230811025530.3510703-5-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
References: <20230811025530.3510703-1-imagedong@tencent.com>
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

The debug message in tcp_retransmit_timer() is slightly wrong, because
they could be printed even if we did not receive a new ACK packet from
the remote peer.

Change it to probing zero-window, as it is a expected case now. The
description may be not correct.

Adding the duration since the last ACK we received, and the duration of
the retransmission, which are useful for debugging.

And the message now like this:

Probing zero-window on 127.0.0.1:9999/46946, seq=3737778959:3737791503, recv 209ms ago, lasting 209ms
Probing zero-window on 127.0.0.1:9999/46946, seq=3737778959:3737791503, recv 404ms ago, lasting 408ms
Probing zero-window on 127.0.0.1:9999/46946, seq=3737778959:3737791503, recv 812ms ago, lasting 1224ms

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_timer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index f2a52c11e044..74c70fc1003c 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -519,20 +519,23 @@ void tcp_retransmit_timer(struct sock *sk)
 		 * we cannot allow such beasts to hang infinitely.
 		 */
 		struct inet_sock *inet = inet_sk(sk);
+		u32 rtx_delta;
+
+		rtx_delta = tcp_time_stamp(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp(skb));
 		if (sk->sk_family == AF_INET) {
-			net_dbg_ratelimited("Peer %pI4:%u/%u unexpectedly shrunk window %u:%u (repaired)\n",
-					    &inet->inet_daddr,
-					    ntohs(inet->inet_dport),
-					    inet->inet_num,
-					    tp->snd_una, tp->snd_nxt);
+			net_dbg_ratelimited("Probing zero-window on %pI4:%u/%u, seq=%u:%u, recv %ums ago, lasting %ums\n",
+				&inet->inet_daddr, ntohs(inet->inet_dport),
+				inet->inet_num, tp->snd_una, tp->snd_nxt,
+				jiffies_to_msecs(jiffies - tp->rcv_tstamp),
+				rtx_delta);
 		}
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (sk->sk_family == AF_INET6) {
-			net_dbg_ratelimited("Peer %pI6:%u/%u unexpectedly shrunk window %u:%u (repaired)\n",
-					    &sk->sk_v6_daddr,
-					    ntohs(inet->inet_dport),
-					    inet->inet_num,
-					    tp->snd_una, tp->snd_nxt);
+			net_dbg_ratelimited("Probing zero-window on %pI6:%u/%u, seq=%u:%u, recv %ums ago, lasting %ums\n",
+				&sk->sk_v6_daddr, ntohs(inet->inet_dport),
+				inet->inet_num, tp->snd_una, tp->snd_nxt,
+				jiffies_to_msecs(jiffies - tp->rcv_tstamp),
+				rtx_delta);
 		}
 #endif
 		if (tcp_rtx_probe0_timed_out(sk, skb)) {
-- 
2.40.1

