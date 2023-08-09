Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE44A77501B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjHIBHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHIBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6101BC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58440eb872aso82395537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543264; x=1692148064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ONd/JWe6ZkZveFErN2MpT8R9y0a9lN9YX7PcEW+G4U=;
        b=uQLE6smTxRX1leyrpUsBgAjJ8PIzUdv4bviLmq+pneR9cFdSU81LNgBj+5zuPWMTxv
         ZM+VYE9mpr2gXAT1BU9K9ORDZWFt70DUua28vGnkl8D3+KaywwJSdYhS8lqshy7QqWwK
         G+2L0rkCIlBTkycm7qrfg7AfR+xtQjGOD7PUyy8qLs3XjElgbidIsCcvAH7scOt0SmIX
         1oF6rcbfsf4gyeuw/xehVb+CLcLzD+5+XKYgaYVIf56BFnyjz9pG6/dECj4OImbuGJ2U
         4Lto6ebxG3IOzK1sq10U3j3lMzewZz23wET6IRt9JzgFF5dwLLCVRgt4xKV9ypEvUIZm
         kPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543264; x=1692148064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ONd/JWe6ZkZveFErN2MpT8R9y0a9lN9YX7PcEW+G4U=;
        b=ALtcpY7JuhqRjMOWDOHEmoXdWgdaF2UfxLL7ju67W+CwEG3iFOMhk8/lAdDenaBMRI
         jNnj+sdf3FXYIXl8g7t7fvXmm5OZE9jCivly7vkokXJYRlC+/u2JwOBHk187xeaklpgf
         tYrdB80ENQLgGqHR7ixMu6dWP6ztBgnndzW8drFhOzB7srMHAwW6PbT+gkeRbLCcRPNj
         p6sJepcMbzy2nxmqYj9oXNKTAWuYHwSxorVZ2lwHuJHpgERHNgdM5bLlNsMS3zcug84w
         HrN62g9Sr8Car2ycG5wI8ERGOXZ8r8/2InMlW4iYnGWuYEuwmTPirCXkrN1Quaz6dyEf
         E0xQ==
X-Gm-Message-State: AOJu0YzIfmYW90cB+3kMHrfJ3cx+5emz1JWNRmKo8VCzDfdc9aCN0siJ
        l2HLWaepI/PVjiPU7XYMXxrsrQzKUXh+ImMBgA==
X-Google-Smtp-Source: AGHT+IFSvuXNP2dx+Ff+aSebW/a9wiOdcrWvL+hMHmBzATR59BrjhU/mVsaG27/i1cWSY+NuqBRcVyRoRP6u8e0Ksg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d383:0:b0:c72:2386:7d26 with SMTP
 id e125-20020a25d383000000b00c7223867d26mr29048ybf.0.1691543264480; Tue, 08
 Aug 2023 18:07:44 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:08 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1715;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KAM/QyHZk/9K6ANTYuqL7ePIPoJfU95ZXORzcYBHKm0=; b=gTI5CntTcfznrG6dmuSsXnxc4n1o4o6Fr5coSwA9r4jnyrg5eABEjDeuoGl/WnYNTeR1qMjOq
 yEuh3uRaIV7AGuLgca9Dj1nGSHWHNDrgcOqsP8fNvz3sX6wu8Eifm2E
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-5-5847d707ec0a@google.com>
Subject: [PATCH v2 5/7] netfilter: nft_osf: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `strscpy_pad` over `strncpy` for NUL-terminated strings.

We can also drop the + 1 from `NFT_OSF_MAXGENRELEN + 1` since `strscpy`
will guarantee NUL-termination.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: Should this usage @8556bceb9c409 also be changed to `strscpy_pad`
or is zero-padding not required here?
---
 net/netfilter/nft_osf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 70820c66b591..7f61506e5b44 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -23,7 +23,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct nft_osf *priv = nft_expr_priv(expr);
 	u32 *dest = &regs->data[priv->dreg];
 	struct sk_buff *skb = pkt->skb;
-	char os_match[NFT_OSF_MAXGENRELEN + 1];
+	char os_match[NFT_OSF_MAXGENRELEN];
 	const struct tcphdr *tcp;
 	struct nf_osf_data data;
 	struct tcphdr _tcph;
@@ -45,7 +45,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	}
 
 	if (!nf_osf_find(skb, nf_osf_fingers, priv->ttl, &data)) {
-		strncpy((char *)dest, "unknown", NFT_OSF_MAXGENRELEN);
+		strscpy_pad((char *)dest, "unknown", NFT_OSF_MAXGENRELEN);
 	} else {
 		if (priv->flags & NFT_OSF_F_VERSION)
 			snprintf(os_match, NFT_OSF_MAXGENRELEN, "%s:%s",
@@ -53,7 +53,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		else
 			strscpy(os_match, data.genre, NFT_OSF_MAXGENRELEN);
 
-		strncpy((char *)dest, os_match, NFT_OSF_MAXGENRELEN);
+		strscpy_pad((char *)dest, os_match, NFT_OSF_MAXGENRELEN);
 	}
 }
 

-- 
2.41.0.640.ga95def55d0-goog

