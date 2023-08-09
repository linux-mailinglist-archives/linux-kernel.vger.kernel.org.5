Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207AA775014
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHIBHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjHIBHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880571BC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-585fb08172bso75084927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543261; x=1692148061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kynZ2eY0/O6E/bQJdWZNL+mmpUwUSkdwurja4abucs=;
        b=Ol0O7ydBLmDGDB+SZ9v11BQgV4K8njIy76TSgXpaauJtbgStqpW/RYu/DWTxMxv5ZB
         +9MacsQSpkAhtOY9LVIFSQQtbwXVuIBhhpzOiV/EdBvEkZB/SRk8+/hM3Av3riZbSVSG
         QtCWUqHY7ASjZgsslXjvn1A8l6P037btB4PjAGygJPGdrTpttKYWlOta5a139Ww0nVw2
         4wZvofllE9KdG42dhpE4GXt+mC+sxQs7bOpHb0LRCj1twgqrLPVTJYEBe17+KyMG8QjB
         UtPRDLE2isjgjcvvsvJSfiJwpN73phog9iVfBbXoVUO8z8mhgWMyyQoeNpXAgTDKPl0/
         qpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543261; x=1692148061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kynZ2eY0/O6E/bQJdWZNL+mmpUwUSkdwurja4abucs=;
        b=cXB7rZCPOnfSaVhdl9yfSJtnqPn0EqExdgPUB+21lyF08ehRczNq+qcusgkK7Aiefj
         Wr0F0ATH048VwvJbb4Ffq9UeQfaMt4dhEw7xERDQOh+ZJ2ycKDVw7NqGC2K7s40fDXa5
         MRXIabZWRCJB6Wb9aji86EHIhOdzigXX3yOr/3OcE0+6OV+kp6+VBAts64bk6uQVeOyN
         4W5nTFOfSRXB5WUVv3EMg/z6ejYq4e9u8VgWbIlyx7QYqUm1XfvhbrW6g9iURYHz5f6P
         NnV7SP0G0TANsSxtA2u1ueGrIyAOU5AMasw2QRPMfOjZbRakF72Q4jNUAOga0ujCv+XT
         p2Nw==
X-Gm-Message-State: AOJu0YwZOrukuORZ/e/aOzo+iZjjgPGJkWvaKmDCjSg5CaYn0xeAwbGm
        XKrbVXIP8PSPUTb9FC4xOaJLqhgVOFJq/O4mjQ==
X-Google-Smtp-Source: AGHT+IGWrBqKRyMPFFB9tEV4Q4dgsTSTg2iWnoP8DD7tIMTceBZqZZlfU6ptL0dqjEgU1ZHHFa6n34AN1ZEUPEROSA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:181:0:b0:d4f:d7a5:ba3b with SMTP
 id r1-20020a5b0181000000b00d4fd7a5ba3bmr30722ybl.8.1691543260881; Tue, 08 Aug
 2023 18:07:40 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:05 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=903;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GfuXN5T5xhe6k6w3cRknlOVNIOtegqmz8uQBUV4/tcw=; b=GYSS0ZoTuERfJ/SVnofWzjum44puD5h0s+zSjx2gITL2EhREYqCQpVB9N07nRO0v9d+gxkHdQ
 SOb7icKznTnC9EnhPquUOW6p8PVJ2Ep9ughhPfdNGQsR/NcIvz+Wupm
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-2-5847d707ec0a@google.com>
Subject: [PATCH v2 2/7] netfilter: nf_tables: refactor deprecated strncpy
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

Prefer `strscpy_pad` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: Opt for `strscpy_pad` over `strscpy` since padding is wanted [1]

Link: https://lore.kernel.org/all/20230808234001.GJ9741@breakpoint.cc/ [1]
---
 net/netfilter/nft_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 38958e067aa8..bbf11c4871b2 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -108,7 +108,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		helper = rcu_dereference(help->helper);
 		if (helper == NULL)
 			goto err;
-		strncpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
+		strscpy_pad((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
 		return;
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	case NFT_CT_LABELS: {

-- 
2.41.0.640.ga95def55d0-goog

