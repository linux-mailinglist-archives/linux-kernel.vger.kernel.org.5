Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7DF7B74BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjJCXVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJCXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:21:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD0B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:21:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae2f8bf865so856031b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375266; x=1696980066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBFKpyW9pXC/chljQ3RVPO1a7/I5zD11PHOJtNgxGKI=;
        b=MiCdz5COYwWf9hL/xnHXtxqCz4yQ/SKt5Qf/jcyVDi0wwrLMkHafzR3e8ycB0eH3Lk
         XNmdCYFjbSYG56n9KoLGqMHDBsR+fip+Ra70CPWpozjJWZf6/kuYJOf0gj7A1LodLT6y
         IcCxZ4v0Qgp2aV2tJVS539EvZJqChNWtlpzj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375266; x=1696980066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBFKpyW9pXC/chljQ3RVPO1a7/I5zD11PHOJtNgxGKI=;
        b=TVHV8vUao2lXq/7eephZrRmwvJBIqGGlalSsqLamsWJ6n2gL1rSKwVAINOpLcGn4T7
         u9WcbaGUPychqOkOJsFweE+kGvyamjXoUANcYJUqQF9BXfBSBQRsOhZPPLO2WY5UggoQ
         EQiTqMb+P7/HGGjBFjshrXN8XktuYupfevvKUTGtiDvNytUe/4lB0uZMV1qEWeI/FAcm
         SvOrJDBPInxhTXTIZquiZD3SEfqgZgF+/ouQI4k0EoHrxZk/BZCN7fYwya+L2IheTVl9
         Mf9fDmh5wdMgDyOBBYN/GGa4aruUzWnioDr4eyVCRRo/oD13pa+R4fQSjM28cZbZ01Ds
         bc7Q==
X-Gm-Message-State: AOJu0Yzfzz7JVLtZz3po0NUtd5a38u5g72IsXDoNxX6oT3cML2pCWg2+
        Kg4ke3+/m1W3kxu4KdDTQNoFsQ==
X-Google-Smtp-Source: AGHT+IGCof0Hqb3mPKc+AYcTgobw28lFfFAO65kr8ZCTc70Pbr/5ajX6F+9Wku/B1p579KNguN0XjA==
X-Received: by 2002:a05:6358:279c:b0:143:2f7e:aa with SMTP id l28-20020a056358279c00b001432f7e00aamr833720rwb.28.1696375266337;
        Tue, 03 Oct 2023 16:21:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b00268b9862343sm129724pjs.24.2023.10.03.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:21:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] netlink: Annotate struct netlink_policy_dump_state with __counted_by
Date:   Tue,  3 Oct 2023 16:21:02 -0700
Message-Id: <20231003232102.work.430-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AOFOpjhFJ4cNtC6OCXwo5LXfLCQZ4I9UO9j+h4yyfUs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKHeX2lvqJ/DWVLVsK0XgYQdAiBj6vxjhY/Yt
 h5lBPgBr8iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyh3gAKCRCJcvTf3G3A
 JpbFD/90/nKxGOgPkTr6m5FPWz2QDZiqlWSseFGtlBSmRfwd74/AKir/9n+h2SPdpiYHhSm/ODj
 51C82bHdtlFqYyi2OBiblShtD+quu3qiiSrWWZIT+5K96uTq3AcXZZbi/ovSimsx8/2Obpax6fz
 80F/rONc9qVKXV9W/EEnYuNJF3sr79igF094ZYZYM7O69/7xHKfzFnK4pkbwOtVkSPvL2uHfELN
 3bcaSwyUuRownQ2+/2nhM5BRhxDIWkQkqyWDmxCCx7mijOa8r6Wd3QjtjoJY/MuQaPrAPz1AHJy
 3twQgCD5PnlE5UC4SQs78etQpqHTWwAUp1y4BhbVSA8jIkEBzJZF6DXcnqI52Fk2AYi1thlj1qt
 tPKeT4/aWr88J8MRfMSCZActXpIt8Yz4Cy8My6kyFZxlRrupFk42VxFZ01yS6td9FrQWj53VKdv
 qd5MkDrRBBpvDugLxBPLBWoIchJzKvGu0/zMvRBvD3HhqLUL0C6wC4/Iw5z7r6CW5ueDQeOB7/w
 W4ymWTWy124oUuEo4VWi9MJeZhyNkKN2BW3ryIoxvfaD4XOgt7yNfxbloUafYLZYY+GOLAppurQ
 UHjRxahSEzRMOZUYDp19l9tcD+ZRz8Gar+GHZUqnjHYm+yQLqroHP49nsGckTdqEpSEOp84biMe
 B/3psD5 QDKIWtDw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct netlink_policy_dump_state.

Additionally update the size of the usage array length before accessing
it. This requires remembering the old size for the memset() and later
assignments.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/netlink/policy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/netlink/policy.c b/net/netlink/policy.c
index 87e3de0fde89..e2f111edf66c 100644
--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -21,7 +21,7 @@ struct netlink_policy_dump_state {
 	struct {
 		const struct nla_policy *policy;
 		unsigned int maxtype;
-	} policies[];
+	} policies[] __counted_by(n_alloc);
 };
 
 static int add_policy(struct netlink_policy_dump_state **statep,
@@ -29,7 +29,7 @@ static int add_policy(struct netlink_policy_dump_state **statep,
 		      unsigned int maxtype)
 {
 	struct netlink_policy_dump_state *state = *statep;
-	unsigned int n_alloc, i;
+	unsigned int old_n_alloc, n_alloc, i;
 
 	if (!policy || !maxtype)
 		return 0;
@@ -52,12 +52,13 @@ static int add_policy(struct netlink_policy_dump_state **statep,
 	if (!state)
 		return -ENOMEM;
 
-	memset(&state->policies[state->n_alloc], 0,
-	       flex_array_size(state, policies, n_alloc - state->n_alloc));
-
-	state->policies[state->n_alloc].policy = policy;
-	state->policies[state->n_alloc].maxtype = maxtype;
+	old_n_alloc = state->n_alloc;
 	state->n_alloc = n_alloc;
+	memset(&state->policies[old_n_alloc], 0,
+	       flex_array_size(state, policies, n_alloc - old_n_alloc));
+
+	state->policies[old_n_alloc].policy = policy;
+	state->policies[old_n_alloc].maxtype = maxtype;
 	*statep = state;
 
 	return 0;
-- 
2.34.1

