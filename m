Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374B7BEE92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378953AbjJIWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378937AbjJIWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:54:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC6A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:54:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a581346c4so122778276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696892079; x=1697496879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gqq3YrEYGFNss40u9rh8HNKvaODfOxHAaOpSCan2mbI=;
        b=PKj54VcPH+Y3gu4/HHgNOJ9DfmDHm6YbJEZXlYMV3+hgRoJKbx0VkdX4ScjK8rytGf
         18g5ZhBi3KwCC/QXw5THS1mlkXnODg9v6BHb8R/UvqvSgUhHh9lFu4a/y3OIvNt9S2Tj
         p5YrR4ZgaEODegXEILQNCVGYi/SdUGXifWhTUblPsXBZo31hOOz53YzfiXzya+f3r5rv
         LR0BcgQ5CPZuzHkINS0xAP4P+eun8qIpOj68kgtv4PtuRQVxAFMy1XvZ1K+YF4M25QsU
         5dh4VBA3FFfJ+9y+uWgs+hiPjci+M6RcSmy0gtHWPx3BzJd5NdGBGu+TaQ8y09nY3tj6
         IwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892079; x=1697496879;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqq3YrEYGFNss40u9rh8HNKvaODfOxHAaOpSCan2mbI=;
        b=hX6CuiWzfied7N0v54Uu2k9H9Ru/x6RcX+AKMUSbuF0zLFRmUNHfRuoidQJwF1FSXP
         UQjpbkVA2F9NjlFaSLGssdxDTCL0ghc3Gk4u1FuwvwgKf+gT6etJr0A/iX/Mb0vDms1X
         euEK50FUv1/kg7j+Fb8irjUjMBVGr8RmVw8mMJANKDr+yIaQJEz1s80KvJpzxBag6D2h
         yVYPoML1Z7FpI/FoXox/U9OauOJnp0abTWX9cP3KL1V8HKuDKeeWZ8HDb/KZFioZI3sd
         xX003EoOpYgnfgXtJonICUt4AgtwdFy5JF3Fw0OhjIzrt5fFjH7gr4griNwHf1ujHS93
         U3lw==
X-Gm-Message-State: AOJu0YwH/zpMU2eNH6tgghI9j0mD4EGrnIfE1Ah1GtkWKwYtXQahjfRO
        pyq6Zxd2ddY7sGVXwdF9vG3Rf6b5ohsv+mJmKA==
X-Google-Smtp-Source: AGHT+IGqRyKQO1JGYXaSwkdjuidc1nCgtQhkDyo6o65+vuBrsf67eezBuY0/4UIhwIEhv+s020m9P9wsa/SEuNBOow==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP
 id h5-20020a056902008500b00d8656445d12mr302836ybs.4.1696892079757; Mon, 09
 Oct 2023 15:54:39 -0700 (PDT)
Date:   Mon, 09 Oct 2023 22:54:37 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK2EJGUC/x3NPQrDMAxA4asEzRXYztCfq5QOrqS0WpwgGeMQc
 veajt/y3gEupuLwmA4waeq6loF4mYC+uXwElYchhTTHEO7o1QptO7JpE3MsUpE9Y9Mq7oLN6Tr 3jrSaIGGkhUOmxLf4hhHdTBbt/+HzdZ4/cFU+pYAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696892078; l=2762;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dnJs1bo1eq2tjq6VR/G42QgTFZ/5UULFEzYTX6dAjz4=; b=Gq6P/7az6Lfl/v56lJyGITjEvb9rCpFg5YZenKeB6EJWQNAyLr6rUZWZOEeJ810Sy56KUkrud
 LUyx/1GXlWXAjWqd+7FHFUHndSQrvYl4rzI6v7iqGR6dDD3FqnY6y7Z
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
Subject: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
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
 drivers/net/dsa/vitesse-vsc73xx-core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4f09e7438f3b..09955fdea2ff 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -928,7 +928,8 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	const struct vsc73xx_counter *cnt;
 	struct vsc73xx *vsc = ds->priv;
 	u8 indices[6];
-	int i, j;
+	u8 *buf = data;
+	int i;
 	u32 val;
 	int ret;
 
@@ -948,10 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	indices[5] = ((val >> 26) & 0x1f); /* TX counter 2 */
 
 	/* The first counters is the RX octets */
-	j = 0;
-	strncpy(data + j * ETH_GSTRING_LEN,
-		"RxEtherStatsOctets", ETH_GSTRING_LEN);
-	j++;
+	ethtool_sprintf(&buf, "RxEtherStatsOctets");
 
 	/* Each port supports recording 3 RX counters and 3 TX counters,
 	 * figure out what counters we use in this set-up and return the
@@ -962,22 +960,16 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 	for (i = 0; i < 3; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], false);
 		if (cnt)
-			strncpy(data + j * ETH_GSTRING_LEN,
-				cnt->name, ETH_GSTRING_LEN);
-		j++;
+			ethtool_sprintf(&buf, "%s", cnt->name);
 	}
 
 	/* TX stats begins with the number of TX octets */
-	strncpy(data + j * ETH_GSTRING_LEN,
-		"TxEtherStatsOctets", ETH_GSTRING_LEN);
-	j++;
+	ethtool_sprintf(&buf, "TxEtherStatsOctets");
 
 	for (i = 3; i < 6; i++) {
 		cnt = vsc73xx_find_counter(vsc, indices[i], true);
 		if (cnt)
-			strncpy(data + j * ETH_GSTRING_LEN,
-				cnt->name, ETH_GSTRING_LEN);
-		j++;
+			ethtool_sprintf(&buf, "%s", cnt->name);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-1cfd0ac2d81b

Best regards,
--
Justin Stitt <justinstitt@google.com>

