Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86303774E98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjHHWso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjHHWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57419129
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:48:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so73698087b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=l0+YZUWT9MVORUoAKyZtIiSvH9yjrNYKYquI4h6G3Bw2EZqzd31uHqgRU63WUeJiTY
         CpJguIuWZtSwCxzXZL7m605eZS8Es5f38S3flkVmk3kM8LB0HvSqtkdI1c7Z2AyBkGtq
         5NfO/1zVNGQ5YGvx0dhjCckfQkOwM8SuFYDezhYuUQtB+xJ3JKUpKSCYccD2Z2qKxi22
         OO6RsTdtADjOReVX0UY1bUfshvROIJWuQWuJYZtqakkYY3FJ3grYtZbKyVjGMV37v+ur
         OCp34anb+2N2Kvfjr0/rniDTTRMNJAKTjeHOC8KCmX2XwY+Iinw733StNw48QbzrItoa
         QVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534916; x=1692139716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWB/bxoqLSL/ZtMTZ8dV/jChYqo6p+fCOGWCHHtspAU=;
        b=em/zvKz9GkJL/QyW47ByBpiAx2cMB2fSpvpNxEPSLy1yJkObECY5I4/2VJpfEukkH7
         kntZe4p6N3c+wEr2kGaz5h5iOlwPxJ4N9Bp0vWSjby9Ldhlk44GvMqwqMsTtmBuL2ZCE
         jvN78yuM7Oh9ndb4peABjLMKvO6PhyuNZXWK4OHj7FwTZhzY7lA/3O9sRqt7x7bcVoI2
         kReH9BXrSzmEyX2L8IKvQBF0NUWaon9MBDiINRJxUyiRYNhsEJehiifNTyAvR33OAJUq
         Z7W6shj+EzjQVG0HRdUANlcsinZK/rY3pKGLEjFOpjY4U/Ta4vXofqYQrmpBgAcDfJx1
         ZmUw==
X-Gm-Message-State: AOJu0YyuwfhohN7Q+zn6FYSx51Dgq0bWRbbBwgauDLbhK63upDbGhhU2
        KiEdKloQKEXl8pxhcDW99fHVlxG/d2wl4meFqA==
X-Google-Smtp-Source: AGHT+IEZqIi+KfXakktMR77yvcqvv7E79OwhtWF6B0zRs21LhdiLRA3ymZOhLEcubECjKuLZCFe6Vy5Az1cpq5gVng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae05:0:b0:579:f832:74b with SMTP
 id m5-20020a81ae05000000b00579f832074bmr22779ywh.10.1691534916696; Tue, 08
 Aug 2023 15:48:36 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:08 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=968;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ql8BKCTJsc3POKLEq/ADab6DF9AYOTL/azd4EamUBcI=; b=P3R80qBBGIzHAbifBNpGmUCEncCAPqmEwus6LSS+QDg9lMvg2IHe2edYrrt/QOZp2p4frMdd+
 ACoDi+vL9tDBW4ezE6keUa+9XyhIWr0M32IT7a0qKJXdIEfk7Y9a0tM
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-3-efbbe4ec60af@google.com>
Subject: [PATCH 3/7] netfilter: nf_tables: refactor deprecated strncpy
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer `strscpy` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note:
`strscpy` is generally preferred to `strncpy` for use on NUL-terminated
destination strings. In this case, however, it is hard for me to tell if
the dest buffer wants to be NUL-terminated or not. If NUL-termination is
not needed behavior here, let's use `strtomem`.
---
 net/netfilter/nft_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..f1a3692f2dbd 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -150,7 +150,7 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 		if (priv->flags & NFTA_FIB_F_PRESENT)
 			*dreg = !!dev;
 		else
-			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
+			strscpy(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.41.0.640.ga95def55d0-goog

