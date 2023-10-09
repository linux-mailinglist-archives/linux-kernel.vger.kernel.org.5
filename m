Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CC7BEE71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378933AbjJIWrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378893AbjJIWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:47:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71939A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:47:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f61a639b9so77443127b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696891657; x=1697496457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JxJfBT4mqTTWnkuNgqYZhhygki461FFicbWyOS8kMU=;
        b=DmPAehzvoTwkKdspLj51IBwSEzAFLp6fjnm20o3YJ/KuILkutjMKDgPEHiJ2qpCrAh
         wO7ncqUy8274bSTlhusCsAnGQ70FtjMznmruxDj7lWKaQBbMnSOkaKXO/pl44IiqAhsP
         XsvIcI+2d1uLlLLrUqdoQ4Gqdx5bTe3xL4ZcLCLaVVWTITDVqXgUouLG0vopNvSBhc8a
         kDWUynDXQamaethdZsg5I592cMmLhEu6FHLe9QFCuljCYHlp7jB0aJ31DP4OqTfbhgxa
         tgMLcDS4V/luRjx7R8pfkZ5/gw1TfmkqVO+e/5hSKGDeZxeTQ9f1x0y/PjDIwH9C6xOh
         Mtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891657; x=1697496457;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JxJfBT4mqTTWnkuNgqYZhhygki461FFicbWyOS8kMU=;
        b=JLlU5NNKkGEHWX+8HTOEYukrXofsbHGBHN7Im/wsbhMyeU6TkgTunHzvM/ZLE29SOl
         OIbsEqeO6lG7X/BQH3NBdySMcZdMNOKYk7wakmpsivwO0Kx+2n2FBpPw5JXc2bELkXlX
         nh331m21w/oMm/HeA+NrNVHb8dhE+7NyrgC7V797l0bdbE2R7UCNlkXFI9X7UkJsbX5u
         zpyUhck+nN9krVsQMNHZXlAHEU05dNQqNfnMpXQ3E6yNo4g9K5kl1UNXG70BYZTQF+Xj
         pA/aIs9PHsiQqeRpig/GYO44UzY47nnsnMxsjSgDO0PWKX1ZgPfZ2GTMJj+BNYotSmUe
         pLxA==
X-Gm-Message-State: AOJu0Yy269wq0f4zyK8h6jIMc4JP3znqAgXQKpeI+vTdud430FYzzUGK
        sdwFfVx+ktK416N82fxigueWGhWg+ZP4AlpSxQ==
X-Google-Smtp-Source: AGHT+IElN9GkpT3U2xvrH7+kjhlHlG+bmfY+dBqb/0nsReSoHqtmIJ/Qqs5nM/0N4BjpBVaPpbPj2pXTmOviCVtSrQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2a0f:b0:5a7:aa51:c08e with
 SMTP id ei15-20020a05690c2a0f00b005a7aa51c08emr38184ywb.1.1696891657694; Mon,
 09 Oct 2023 15:47:37 -0700 (PDT)
Date:   Mon, 09 Oct 2023 22:47:37 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAiDJGUC/x3NQQrCQAxA0auUrA2kLQ7qVcTFkKQaLNOSDEUpv
 buDy7f5f4dQNw24dTu4bha2lIb+1AG/cnkqmjTDQMPYE10xqhdevyhum3pg0YoSGV3zXPWNXuf LmBLy4oqMiTJNJMJnZmjR1XWyz394fxzHDzHi6qqAAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696891656; l=1743;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wtw1m2N4k6i9bXVmmrVL0qb6WJmJ01VqahgGi3xl8qU=; b=KSLRqEm2ZqeXXCS1E3PZL8ukrOE9+X+1GQ0FA+gBqwC/r+hSaMsJlHCmEWNAH5+mcSDLOMho1
 qP2UVgg2jHxC9Qn+PsWDNqkGJi73jv5FRKqRIWkKFdYvO/bGMOrfOqe
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
Subject: [PATCH] net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
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
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/dsa/realtek/rtl8366-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realtek/rtl8366-core.c
index dc5f75be3017..b13766a3acbb 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -395,16 +395,13 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 			 uint8_t *data)
 {
 	struct realtek_priv *priv = ds->priv;
-	struct rtl8366_mib_counter *mib;
 	int i;
 
 	if (port >= priv->num_ports)
 		return;
 
 	for (i = 0; i < priv->num_mib_counters; i++) {
-		mib = &priv->mib_counters[i];
-		strncpy(data + i * ETH_GSTRING_LEN,
-			mib->name, ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);
 	}
 }
 EXPORT_SYMBOL_GPL(rtl8366_get_strings);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-60a0f0ddc5cc

Best regards,
--
Justin Stitt <justinstitt@google.com>

