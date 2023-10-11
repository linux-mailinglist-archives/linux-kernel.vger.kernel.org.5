Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B87C5F50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376407AbjJKVso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjJKVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:48:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470F9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:48:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a61f7aaf8so347423276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697060920; x=1697665720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fmgja0bLa+jteMFhSajUsHxegsUDbMvKhEZglRqt45Q=;
        b=wsL7rKbs/MulTCGq7SLJxQqpb+ep5Soiu+13mphubbPnPScNBdl4FUKSdjQNnLGZsd
         JxE+cMV2D/PELRJTwMJna7YWX1QtrIxpUBb/ZZUn60pokcKtxREydkv69xLgZdRtDjRa
         rmy4XCKskBB0ZY80ZA18i9vXWwS51ZAPRQPjJJDiqdtimvb09w+FMsWiVMG1lbwVFlqf
         a3it/hR317J48b2nwFksgweF1h+PqcsjCRATItiS7TAM2gSbTWgVMLzaaAq/ail5JRxg
         fKErnlMz5RTtH7GBfo6Nv5JSH5FnqyQgWLIJZmchCtfTTApDBnCKn9F5BfGZ8+dLjhlo
         C14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060920; x=1697665720;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmgja0bLa+jteMFhSajUsHxegsUDbMvKhEZglRqt45Q=;
        b=srIt+ifQ/hJ/v7f6gZKfuaZoRTCTYKLxbB2xSyvfAarhhKb5jm+L+EY9Yk4RR38sR5
         IkhWMQGgPh/lZ7BxUSkKepXZiSiokXJQbtpWYv0alopVcqZ9pfWvYE3jZcmfCT/OqVgw
         azNo1kv8cOsEhGcTCXyPKNy22tcZSM3nQ4WKQ/NQwE2N8ipcqmJG2PDoWx8kISr22igd
         No0imGdWK8FzHhhnZ1X3Oi4Kio/6aF1P3w4CQu1VN4ALC1fGo4UtNvF0b8RM9zL499Cv
         wZwnWtHLXV0oOWP2hLnTAXK96e2d/C3RBRUC3gWNKDFkVAQVAL7vMrC/4mwxuG3gfERi
         g+pQ==
X-Gm-Message-State: AOJu0Yx7IQvGCcJMevbZSpwaaQLH3Zk+x9uViKxyIoNFDq6PEra0qU3h
        RrZk+nXDI8DSr32mSd52YxWBYmOfyovot247Ew==
X-Google-Smtp-Source: AGHT+IGJoTG4b7zDPCsibXJpxnlw6jNvBvSJLdFkY2BSvTdOPSvUCRCdC6zVI4G66sLlVvOY3vTtDT7UkI8II5FbKQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:870c:0:b0:d9a:3a25:36df with SMTP
 id a12-20020a25870c000000b00d9a3a2536dfmr177263ybl.8.1697060920492; Wed, 11
 Oct 2023 14:48:40 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:48:39 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADcYJ2UC/x2OQQrCMBBFr1Jm7UAnRSxeRUR0MrFZOAmTtCild
 zft4sF7q/9XKGJRCly7FUyWWGLSFnTqgKenvgWjbw2udwP1RFiqKecfeouLWEGVilInsV0aljR 9BDXkHU52+MOkpNlYkJFGcq9xOF8Ce2g72STE7/Hhdt+2P37e/baTAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697060919; l=2791;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=d1CwcSoXBknLIhkv+OR1VBIGF8nQz/k16YwYlTdC9Ds=; b=OX8CmXZpnCy8ywuesrOENMy2j4fqvuDPmBTZziT688Z17/BOW8xmijt701YYwPkN1Ws6XyooM
 RgXZMOR098sC456O0B2+zgQidajVjXgp6fBUqs2vZ/7XEhUvTT2W3s/
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-v1-1-7d1c984f0eba@google.com>
Subject: [PATCH] nfp: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Louis Peens <louis.peens@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect res->name to be NUL-terminated based on its usage with format
strings:
|       dev_err(cpp->dev.parent, "Dangling area: %d:%d:%d:0x%0llx-0x%0llx%s%s\n",
|               NFP_CPP_ID_TARGET_of(res->cpp_id),
|               NFP_CPP_ID_ACTION_of(res->cpp_id),
|               NFP_CPP_ID_TOKEN_of(res->cpp_id),
|               res->start, res->end,
|               res->name ? " " : "",
|               res->name ? res->name : "");
... and with strcmp()
|       if (!strcmp(res->name, NFP_RESOURCE_TBL_NAME)) {

Moreover, NUL-padding is not required as `res` is already
zero-allocated:
|       res = kzalloc(sizeof(*res), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) rather than (dest, src, SOME_LEN).

Typically the pattern of 1) allocate memory for string, 2) copy string
into freshly-allocated memory is a candidate for kmemdup_nul() but in
this case we are allocating the entirety of the `res` struct and that
should stay as is. As mentioned above, simple 1:1 replacement of strncpy
-> strscpy :)

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
index ce7492a6a98f..279ea0b56955 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c
@@ -159,7 +159,7 @@ nfp_resource_acquire(struct nfp_cpp *cpp, const char *name)
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(res->name, name, NFP_RESOURCE_ENTRY_NAME_SZ);
+	strscpy(res->name, name, sizeof(res->name));
 
 	dev_mutex = nfp_cpp_mutex_alloc(cpp, NFP_RESOURCE_TBL_TARGET,
 					NFP_RESOURCE_TBL_BASE,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-netronome-nfp-nfpcore-nfp_resource-c-1812b8357fcd

Best regards,
--
Justin Stitt <justinstitt@google.com>

