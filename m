Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C499774E97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHHWsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHHWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:37 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5D2114
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:48:36 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-565893ef956so8901215eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534915; x=1692139715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+nft1J+ou/Hn4BoHtSydnM2Q6o7LrROT4GXzieyqk=;
        b=Z4tv8uuXCuHU3DyrL7CiwM7GRo//gKoN1gu49jVnkLDa77GxmOTvrZb6iVPtpovqAa
         y/YZP94ASRtbfUFGv2+k/+4bVka6Zb8iEhQgqrCavmKZqb5Vf3DMxM1GXr8d184OeWox
         Jkmar07CKdQd0GpGqnTygT2rhd0kL32dr73jAc1qnhLAgdE130ZeCZfffAKAkJ6p4g+3
         Dhu8FFeDILrfEK66hbM9G62Cn84pEjVIyl6RtRVPcwxUI4pmvlJGyT/b7ZFu6jTEPe4q
         d4n4ZEeUzxKpvL+rOyjg+0S0zqmMfzBzAsT4DyiSxbJFnPTWrd8jZrG0UVA3jQ81IpYK
         PMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534915; x=1692139715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n+nft1J+ou/Hn4BoHtSydnM2Q6o7LrROT4GXzieyqk=;
        b=eiM7Z6MzQu41d4S7pI6q6C53Vy6aWA4GlAx5aiKrIieXEYlemd0r83gBQTE8p+sDXA
         csE0z8ymXLu7+BG+VbaNfrEn+YaX3FQ52aoDQ0a6SGuh3Eg5q1Fnl6J80euYuH9Y8xgn
         +g4CsZ8GLXU11a5CMSxf8MEIjLxlLjlsCHFI79pv24yrupqhWUIq+MHrJlrYgYmUmve/
         W0q0HmFDr54VIIGNejj1wQLx+Fnd3L32eY0Bg2rSYVQI3fsjFxwT6HdLDMeZK1TONR1E
         L5mekHWCMJgEmlr/s8wcmVOCKfjqRVYsD/YLWSE1j2ytuQtRWSYXf1SkDvwlZ5MXKVzc
         cmrg==
X-Gm-Message-State: AOJu0Yzm5qwU/DTTeShlKZdw0jqzBkV02XPYEV0Sjvbo7c9AiZUqsm2d
        23SlZsau3mE4BWic79RUKC1m/C3yLbl4I6HQpA==
X-Google-Smtp-Source: AGHT+IG33SMyJD9jmKUFIKwhFa1OIm3UDBC6wsCIb+3jj0vK9d47zhFOBFyzd3Ind1lxI6YX0YxchI++1WpiDqFOxQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:180f:b0:3a6:feb1:bb83 with
 SMTP id bh15-20020a056808180f00b003a6feb1bb83mr630290oib.3.1691534915476;
 Tue, 08 Aug 2023 15:48:35 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:07 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1355;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=h9/FJ0Derc+kHy1+HyfJeM72Jn/xHxsLrarMyJSTkdI=; b=nCzazijk+LV8MhghKkMBl3+PR9A0KP6j7aeC8rKtHaGSgAXmI98rCZPOtIh3eqAsdnnK140X5
 2tW2f/G0EY9C+Xes0E05fHk1dEoFtF75/yOMaNAtBErqXMEO7z5CTOV
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-2-efbbe4ec60af@google.com>
Subject: [PATCH 2/7] netfilter: nf_tables: refactor deprecated strncpy
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
It is hard to tell if there was a bug here in the first place but it's better
to use a more robust and less ambiguous interface anyways.

`helper->name` has a size of 16 and the 3rd argument to `strncpy`
(NF_CT_HELPER_LEN) is also 16. This means that depending on where
`dest`'s offset is relative to `regs->data` which has a length of 20,
there may be a chance the dest buffer ends up non NUL-terminated. This
is probably fine though as the destination buffer in this case may be
fine being non NUL-terminated. If this is the case, we should probably
opt for `strtomem` instead of `strscpy`.
---
 net/netfilter/nft_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 38958e067aa8..10126559038b 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -108,7 +108,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		helper = rcu_dereference(help->helper);
 		if (helper == NULL)
 			goto err;
-		strncpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
+		strscpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
 		return;
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	case NFT_CT_LABELS: {

-- 
2.41.0.640.ga95def55d0-goog

