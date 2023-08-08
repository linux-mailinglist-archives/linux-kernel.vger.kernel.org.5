Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D27774E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHHWsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHHWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:48:41 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F1129
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:48:40 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1bf00c27c39so10387690fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534920; x=1692139720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvwje1x+fgK9E9IR7qsfn31Dc5XiXldAZ1Fo1xHQpAo=;
        b=ZowPnFVAEOQu1o/+XzT8fcaX6DHlVccwrE7gGNHkAx3YDdV+D3o7fUpYyj/vi1Ct5Q
         +QYJDWnAhftWiK8EgTciXmjxfJNfL1DHfcE3o+XOVVHbUUBr2oc33L84fXDKdg0spibe
         GZ5bqdG9qrHx/UtSzbaBTMqp6lQxfoXnPa2UM0vLrI7Zb2YiefFjL0pSu/+rNaKy1wlN
         XhfOQJjCKLo/y7i/PPyKhKK6HKjXtVSpBWc22UEpkQAx89z/FVCmSvgnGCxbk5FjWRbD
         QKj317GKJBKiDYTXPzGM5v1TxwYmVWI7QXAAaldoX9Tx9r5cTrpz+UfvZC+saxnSr//L
         67Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534920; x=1692139720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvwje1x+fgK9E9IR7qsfn31Dc5XiXldAZ1Fo1xHQpAo=;
        b=d0MEXhZKswMYt5S7gGd9B5+otvxvpdcwmUUVPWDgBbByboLkj5ViNiS0VVuwvLMG3P
         LRsgXgkOU7qtbss8CgCVhJKMkaAwqnwZA3JVoc2y2EBDSs81mAoF3GB6E028NPIpNlYu
         9MKRnwVWpOVNqeXtPyKlLDgVWebxgFm6U/AlR1ZHHKQT2XdsPYNmdFp6tar3Q8V5mP1T
         yzUkboTYLFdY3g+haDAsYog4MOyO7dNojKzYJsVR4InSmOhqk0NVWYbsVmxCKHRh4Duz
         khTTT+VODN4/qQEHPwSY3vUx+GHT8iaO4Bb97//XHlY7pyLVr7wNLYFqZEhpyNXT6H8J
         qnTA==
X-Gm-Message-State: AOJu0Yz0zu7NuhF6KhYok2iqW7gqhEjaeAM/fb6y/JKPIrcWAjMgIaqo
        zuPDA2PdbYviInMAjgzLY60ZLQCLwRnyi5BS5w==
X-Google-Smtp-Source: AGHT+IFfTapulzyD7mF8uId+U6qhT9W1jzh/xLHutjoQ+baESmwt1nASohgDjGgqfc8DbSFYevzOUew1G7Fcn9bwfg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5b03:b0:1bf:a06f:ce6f with
 SMTP id ds3-20020a0568705b0300b001bfa06fce6fmr315997oab.9.1691534919982; Tue,
 08 Aug 2023 15:48:39 -0700 (PDT)
Date:   Tue, 08 Aug 2023 22:48:11 +0000
In-Reply-To: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
Mime-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691534912; l=1616;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=epcsNlzjLL3K9DAOvrsRp37/1eZVu8TeiuJpMs34l/Q=; b=L1P2cQc3z99LSWR/qio44oxncmlWLIBSvxY6HOu5W2BRo4B41BhDGwuAbcow63n2hPhRjceUI
 9E5bGIoGP2nDYAORkqUToKLoCEdCN/nRopReeZhHhL/7pSX4tiOQrrn
X-Mailer: b4 0.12.3
Message-ID: <20230808-net-netfilter-v1-6-efbbe4ec60af@google.com>
Subject: [PATCH 6/7] netfilter: x_tables: refactor deprecated strncpy
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer `strscpy` to `strncpy` for use on NUL-terminated destination
buffers.

This fixes a potential bug due to the fact that both `t->u.user.name`
and `name` share the same size.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Here's an example of what happens when dest and src share same size:
|  #define MAXLEN 5
|  char dest[MAXLEN];
|  const char *src = "hello";
|  strncpy(dest, src, MAXLEN); // -> should use strscpy()
|  // dest is now not NUL-terminated
---
 net/netfilter/x_tables.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 470282cf3fae..714a38ec9055 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -768,7 +768,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 	m->u.user.match_size = msize;
 	strscpy(name, match->name, sizeof(name));
 	module_put(match->me);
-	strncpy(m->u.user.name, name, sizeof(m->u.user.name));
+	strscpy(m->u.user.name, name, sizeof(m->u.user.name));
 
 	*size += off;
 	*dstptr += msize;
@@ -1148,7 +1148,7 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 	t->u.user.target_size = tsize;
 	strscpy(name, target->name, sizeof(name));
 	module_put(target->me);
-	strncpy(t->u.user.name, name, sizeof(t->u.user.name));
+	strscpy(t->u.user.name, name, sizeof(t->u.user.name));
 
 	*size += off;
 	*dstptr += tsize;
@@ -2014,4 +2014,3 @@ static void __exit xt_fini(void)
 
 module_init(xt_init);
 module_exit(xt_fini);
-

-- 
2.41.0.640.ga95def55d0-goog

