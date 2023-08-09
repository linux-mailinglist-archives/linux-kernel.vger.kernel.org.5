Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB377501D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHIBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjHIBHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC81BFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4df4a2c5dcso4221510276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543266; x=1692148066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9K9YUhTMTzK19uCHNnSBLcKhcXx1YxnQhkeYxtQnQ=;
        b=FLufdnQLID7CLFxDuinWTCHCNOM0tHWDzh/Q+ezwYBHvUhcKrvNRwf2X/858fNR7wb
         d8vbxPP43ceY/pyaj0Uw5PQ59JrcnSpcF/a3LfcIMqUOkY5p5Iam1144VCB1Ons2vj81
         BmLiwO5IZchhdKNB3Hp+SHWii5wcBQkoVNE1bp5inoSeur+njvbFP1qGHTgPtXq1kfjg
         BEkjKbj13r7baEfK+6B3OTRz0y7Eybl5D1FWifL02RvN4LssSj5E1eUpHkMefprJM5KT
         H0ueJcMX3S8gV9suDKG8GXE43UgliTiV3eYQCRxb8WAldQnhoOh0RconuamFRyja+cUu
         eP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543266; x=1692148066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9K9YUhTMTzK19uCHNnSBLcKhcXx1YxnQhkeYxtQnQ=;
        b=Mq7C7LGr+0pxaex/zppFXM1i2sKyyJ7LUYryy8rahwjw133IQLxujow8aHBodfJHub
         1Uprvll09X1ihRJrpGEG3Zjkq5pfxvf+sYeWEIAqI8Np/K26BEhifKP/8Ap+bs1Q9f76
         ccKq9kGk3D4EVD53OzqSIq4wX+0kyIpPLTEgUvvht0k7MXgui7tJos587LyX9/Wp0J0x
         asrgXIC+j61lVwLqWgq55PVVPD6e2XvAL/FKvvJ2T8wDxV1eqWZiAQFKH5sWUQZF4H5C
         cusXaUwziALdROt4EKIUZ34F3vx/F/2QiGyIf3IV9DfQBGTVyOw52qp18+KeA+UMF3zS
         qv3w==
X-Gm-Message-State: AOJu0YwDM9vnY9ijH8qj44nAHNVQysrquqRfNot4TgJfni1+1dkDfSZY
        42+ep2cr08AwOgNg97btJq4xsTJ8HXEyfyIMOg==
X-Google-Smtp-Source: AGHT+IHZpwGDo8C14lufhH346u2Bau1BUWvvndGq88fm59ryfmewZSsy7jAPCKUfUcYrjFtU1dpqY0m+aY5jSzBV5Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad26:0:b0:d58:6cea:84de with SMTP
 id y38-20020a25ad26000000b00d586cea84demr24517ybi.11.1691543266633; Tue, 08
 Aug 2023 18:07:46 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:10 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1182;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PvqWKqnPHt6FvPDmHzVp42icOwjac4OjqNFq/tqlT4Q=; b=sh9zj/YLC302K92KXYEsgv5KQ7slHtAn4AjmXQutkadONIDR1z3dS2tfhEUE1/fEjCLLxhXmz
 uQNQ/ErDWgqDBqL2ooZ4J+hnTeNjcylCNu2Z3wgVuRaaaBWLe9vWLDa
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-7-5847d707ec0a@google.com>
Subject: [PATCH v2 7/7] netfilter: xtables: refactor deprecated strncpy
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
        SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer `strscpy_pad` as it's a more robust interface whilst maintaing
zero-padding behavior.

There may have existed a bug here due to both `tbl->repl.name` and
`info->name` having a size of 32 as defined below:
|  #define XT_TABLE_MAXNAMELEN 32

This may lead to buffer overreads in some situations -- `strscpy` solves
this by guaranteeing NUL-termination of the dest buffer.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build tested only
---
 net/netfilter/xt_repldata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_repldata.h b/net/netfilter/xt_repldata.h
index 68ccbe50bb1e..5d1fb7018dba 100644
--- a/net/netfilter/xt_repldata.h
+++ b/net/netfilter/xt_repldata.h
@@ -29,7 +29,7 @@
 	if (tbl == NULL) \
 		return NULL; \
 	term = (struct type##_error *)&(((char *)tbl)[term_offset]); \
-	strncpy(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
+	strscpy_pad(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
 	*term = (struct type##_error)typ2##_ERROR_INIT;  \
 	tbl->repl.valid_hooks = hook_mask; \
 	tbl->repl.num_entries = nhooks + 1; \

-- 
2.41.0.640.ga95def55d0-goog

