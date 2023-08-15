Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792477C9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjHOI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjHOIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:55:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33E2114
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:53:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so78578391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1692089630; x=1692694430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vs87HKrsdbyJ5hB+fbzGtDIkM6Q580dZbGEbWsN7GQ=;
        b=h1Kj4Vv++QxwzfQK5nZb17y0iz9qPAaV65Ed2PSCtT/l46FlujKD3MAackCJX/IduH
         I0iFLgP+yvYuANd/zJ9NPbEMstwg5JgqtYDJRDtM4V6oxVnW0SB9+C2+Q+GDxFp9AKvC
         k508f1FN6NdkkGhB9ccmioBG4T4viMbFfLaX4rELUZZVYaA1IAJ3DMn0jMczk3796kyB
         k0TSpc3qaI5+PaMMd4UNn3EId3MJzc+zZJc01BCvgTzybJvxWOEhR5YO2CrH6Qxvzs7i
         WX2fLXXqu/VBW6FIZhG1Kv2NqaCnWhMHTLMVP7dGhOUc0EEBfO/Zi79QbqLkXjJj9MLG
         36PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692089630; x=1692694430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Vs87HKrsdbyJ5hB+fbzGtDIkM6Q580dZbGEbWsN7GQ=;
        b=PvKnDnbSxv1fi5TKwZCfRgoandZbJgJHZKbhqRfCIttPP1/ARTdk5iG0g461IzDDIL
         yVeesBnzrDAAeGnyHJOQYm/ZMcOBOcVuFG5Wmpr48TUldA31nFH9cfMx6JcFksCIeOP8
         PnUl8/UAXehhj7Ki6PhXXjLu5gxwgdSEzxWbEom5cWa5FBo8fukbL0ZysvzQ4DMlDk66
         f30iILGIo3nAQi+bEQTFB5FuO6khzTTFbL0deWT5QfZZXHLik1r5ynxo3pCeDr4nV/Gs
         tJ3rfRsJz9DiXrouUrI3cX5Xou3Ny2EgZd3RaL2byWjPfPxlyzRN+fDO03QM8OKxuSPt
         xJrA==
X-Gm-Message-State: AOJu0YwqM9AJeMyndmpiFe4Ue48IP6x9nh+J6r1RodkpUY3r+FpJKJNf
        Te7cUvYgFrXCTlgNOBhFYWnKyJ+PeWCvNEms4iyfng==
X-Google-Smtp-Source: AGHT+IE3r0FZO/UlxTbbEefaRKebasBru9eYcTIFRU80+0WF9KbVrbhV5Nk0igRdaIa3zAcVh8NTeg==
X-Received: by 2002:a2e:9dcf:0:b0:2b6:e958:5700 with SMTP id x15-20020a2e9dcf000000b002b6e9585700mr8690050ljj.4.1692089630288;
        Tue, 15 Aug 2023 01:53:50 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc01495383sm20172457wmo.6.2023.08.15.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 01:53:49 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 15 Aug 2023 09:53:41 +0100
Subject: [PATCH bpf-next v2] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com>
X-B4-Tracking: v=1; b=H4sIABQ922QC/0WNwQ7CIBAFf6XZsxigrVJP/ofpAerWbqLQACE1D
 f8uIRqPkzeZt0NATxjg0uzgMVEgZwvIQwPTou0DGd0Lg+Sy5YorZtaZWdwi010nNR/6/iQNFH3
 1ONNWUzf4WTCWZaEQnX/XjyTq/s0N/1wSTLBJGMXPQqJqzZWCS/qJNh4n94Ix5/wBND/S2q4AA
 AA=
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar reported a KASAN splat in tcp_v6_rcv:

  bash-5.2# ./test_progs -t btf_skc_cls_ingress
  ...
  [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
  [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226

The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
accounting for request or timewait sockets. To fix this we can't just
check sock_common->skc_reuseport since that flag is present on timewait
sockets.

Instead, add a fullsock check to avoid the out of bands access of sk_protocol.

Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v2:
- Do a sk_fullsock check instead (Martin Lau)
- Link to v1: https://lore.kernel.org/r/20230809-bpf-next-v1-1-c1b80712e83b@isovalent.com
---
 include/net/inet6_hashtables.h | 2 +-
 include/net/inet_hashtables.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 284b5ce7205d..533a7337865a 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -116,7 +116,7 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched)
+	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP) {
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 1177effabed3..b277f7ef423a 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -462,7 +462,7 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched)
+	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP) {

---
base-commit: eb62e6aef940fcb1879100130068369d4638088f
change-id: 20230808-bpf-next-a442a095562b

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

