Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6997D2487
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJVQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjJVQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181491998;
        Sun, 22 Oct 2023 09:21:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66cfef11a25so14017606d6.3;
        Sun, 22 Oct 2023 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991704; x=1698596504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72AhzVLybZCwgkt6DnIQrNHlCAgAiR46KQFBjLYqMNU=;
        b=SpTELPWdXE+PmHGmgyoQ9p1HZ757f5XxlDEJuNdSEvqiPMWYB+h1PzpyBf+QBoaRbt
         1nuSBXi8Pg3LF2GVBm0LqKpCmxDZWr1e+pKCenlExBV1wJ0cJI1pEZw0nuUsAcZtSBBD
         3m2WyDAavJVdzY7eZZ1BLCNg+tw5AvI/TIbM7dE3pq0+X5DSm0Naehh1mpWvuxNPImMd
         jokF/iPEddAIdskEnIwYmmpVOU/CGlG50uSrtAANMXkyBG3lhbAOacoD5h+KYabxkpE5
         AegA8X5F/U/GATq23RNFOi1i357pXNVUZXPg9Ht0LWGKJa1opklL3j0N4qW8bC3LlkMb
         l5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991704; x=1698596504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72AhzVLybZCwgkt6DnIQrNHlCAgAiR46KQFBjLYqMNU=;
        b=t6aRudTqsgHov30MNnGfMp/kEthhNUswBlGkjvXhRHp3bzm/MWg0Jgm5LVD1tIBSkA
         NeFoDKpbWwInWHo6bHdBMh8bAS+w/6i25dMy4xLoossbcucAODYIz5d6xwEQNiJegJ6Z
         teViDFcXFr7sfxg/vO7eV1oxul9l3XWg+WkUv5fnio8/BapWDCXdOCMjm88Mjp1gBM34
         Dnk76wb+3//bab75BXJ26QKKrHALvlLZNlh7brHo62RblZT/WxUs2wMW38dg9PY3cOSg
         DsgiSID7q/YIJqxa0NFOnUlYOiv5RmfRKh1AMt3yR5ShLt68/Ituu6BRPeGZkWjblmHZ
         g70A==
X-Gm-Message-State: AOJu0Yz/SlOt/m1Js4JqNBCKy95NfgYR/Kv+98zRGrc6AJiavphFHDAd
        RFNRiUmjVgXDvZcMkKhH/tEl6RqO3Pez747U
X-Google-Smtp-Source: AGHT+IGCSeZEuAO+QnvCF4RI7SpK27AkZGzr9is8f1Hn3Cyqn0zCc4UnpuQUiO7PN87j4GexiE2WaQ==
X-Received: by 2002:a05:6214:29e6:b0:66d:4db7:4b6d with SMTP id jv6-20020a05621429e600b0066d4db74b6dmr7244166qvb.24.1697991703757;
        Sun, 22 Oct 2023 09:21:43 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id bj37-20020a05620a192500b0076efaec147csm2106837qkb.45.2023.10.22.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:43 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:42 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 17/17] Change the last instance of cork to pointer
Message-ID: <c2ca768b6d2d0114b641634103c67038d87f9c4a.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the last of the instances of cork to a pointer.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4167e8a48b60..b6729817378f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -229,7 +229,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	orig_sport = inet->inet_sport;
 	orig_dport = usin->sin_port;
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_connect(fl4, nexthop, inet->inet_saddr,
 			      sk->sk_bound_dev_if, IPPROTO_TCP, orig_sport,
 			      orig_dport, sk);
-- 
2.42.0

