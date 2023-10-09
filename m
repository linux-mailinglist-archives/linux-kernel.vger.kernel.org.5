Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78F7BE98F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378234AbjJISfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378082AbjJISfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:35:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FCD61
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:34:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3e0f8872so644302276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876485; x=1697481285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=xZH9r6R6hvMY68Tiu3kpxICYzqQU7DV9Ehb/DiweNr4TSZB0dUV8rz1exoiibYEpal
         Uh7HGc7YYn173RlkOrHG94VBRnrNoNLHpUzDvnlJYKDdThv7A7Qne0fxigSMQ7NsMIsF
         wVir/Ab7d5KHeH4O2x8p07s28fAtSk6xRBzWVJvQZiK+DzOW0583kXdVYu/L3TBeknOJ
         OXYkXK8c9YkXO8SePZflGPT288tE+qM9BiWYl8p8Pcr0E93x5r+WpuuU0ambtsyX1j2z
         RG1Kzuaiv76PghMoa7D/L/5KF+pxj2zKRAiUA3kPXZ5ImczIScSkzIhmUCE7Bt6Ns2IK
         Z7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876485; x=1697481285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=hOnYB13PqL3H3npV7KVAuDcax42N3xGPka/0n9z3mS1rxPT94rQ/pKBPm0X+9rcWev
         2hcsa+24q+U2ZKnUD8cn0SyJF5HWP+YSNkQIVT65moK5z+fWBiADZCivhfhhf3SmGcdc
         kJkaKg8sX9jdWdOcEgU/LntwVkKSjSYYQZyqoyfSQhREhYZHHEyyDLvvvhqEbPWgPry/
         JdiVK7cZHBv66CR0xGXuX+uwOivOFyWtSm5+uFZ+FX/57PjJtvh7ynEryy2ygnLc8P5K
         jb/4I/t/rYMGs4PylF3IQPgkUm46yNwWEJocYtSvtjMw3NeSMFJcNvgLZT+UFIr80M7m
         f4gw==
X-Gm-Message-State: AOJu0YwyPFODPsNIRxKo2WtgTsr8IXuUGw1yt7/1lrHmSQ2949lOTXua
        z4kz0YZxX+5xJ7ZeUexLbgqak3E8Xio84ky4Mw==
X-Google-Smtp-Source: AGHT+IHMz+HoiK4CgCHFqTdRUktcbV79j9WV7kYPpy2lP7Lwe/7Y/FP6kzM8Y3AsOSe6R0NaeE49wvFHxld6DNL7jg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ca11:0:b0:d89:42af:d46f with SMTP
 id a17-20020a25ca11000000b00d8942afd46fmr249115ybg.12.1696876485366; Mon, 09
 Oct 2023 11:34:45 -0700 (PDT)
Date:   Mon, 09 Oct 2023 18:34:45 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMRHJGUC/x2NMQ6DMAwAv4I811IIDLRfqTqAbahVkVAbISrE3
 xsx3HDL3QEupuLwqA4w2dQ1pyL1rQJ692kSVC4OMcSmDuGOvlqi5Ydsuok5JlmRvccvXXQfpDz POSEhc6SuHWIz8AgluJiMul+z5+s8/1JexLp8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696876484; l=1550;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=72/H5p/SqqXCeml5lTqSbORWxP5Dde/Rx27bjYoRkyI=; b=uiIFKsYNOtyGmZZuRJCdtAqcUUTlXBnxMGZ7beN4zUUJbUF5DJ7nGEjqPX9DJ4N7NrHcNyVwn
 5RXoS8GIPeZDyfLDD4QRTM4rqMjNrzqzx7FnEz2V2ZPC7M66FEmogNL
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
Subject: [PATCH] net: dsa: qca8k: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/qca/qca8k-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index fce04ce12cf9..9ff0a3c1cb91 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -487,8 +487,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < priv->info->mib_count; i++)
-		strncpy(data + i * ETH_GSTRING_LEN, ar8327_mib[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-dd2c84b23bdf

Best regards,
--
Justin Stitt <justinstitt@google.com>

