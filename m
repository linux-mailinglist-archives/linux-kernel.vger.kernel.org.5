Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D07BEE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378918AbjJIWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378893AbjJIWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:44:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC049E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:44:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b3ae01c0so8479597b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696891440; x=1697496240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcEkRtI6p90rXcCOvkouPghb3M9m0aVLP4AHp4xDips=;
        b=Rwa4I42WxiXXdptfUjSOUyqNZhDMOnOI1l+KC1YWHpvGJDOs3o17zdVc5WqhTsapfk
         ao99ZcqBhVR5+QVPTGcaozDvyDqEh6/C6nExnGFY7MsqUwj85VcrnAjJH6bqxqkqChTi
         OGEfpoPmbqez+38JL6xq9RUSrraHwKJ8Tjwjql/ODJt1/4k7SsCp15mL0vTJfjB+GSDZ
         x/1Lkklz3prHhrjlvsOU03vL9XpiMvnUbApv8zCyqIqwrtZWRECR7xQpRMN/FtCJauPL
         iZn3VqmxtIDxDbJ49LmpkiWZ/vpjWsQdbFETqwKWFpKZAKOm72JMTW8FXtg0j79iQUkw
         SD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891440; x=1697496240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcEkRtI6p90rXcCOvkouPghb3M9m0aVLP4AHp4xDips=;
        b=dH8Izq7vDo9SD5TasqEZ2XXxYexnMXaOgBip/x3EyfobGa7IyMTWxCy/T+ZazhHMtK
         j4GLh/dhCJOs+riXANkr8imGXw3aWRsH/p2pd2rc+cwNkps2wRT1rO3tCvBeID3BnODn
         8qE94W7vlHHtosaLon5bYpaUUZRc+JxEoE4CR/iWujPxZtiWUa+OmJ0wemwGNi3B4q6R
         LLCmtEOfb3hoesnpFAC2IMefjf1bPq3xc9MVd1sjqxzgMiXAZy5kspswQl/kEzRvAGO8
         Fh+PTG3aTFxe9oZLasrgejNPQs7KsRWK63CiP7wfhAbIede0G7sZ7i4bSw8Hbuatw3OM
         BLYA==
X-Gm-Message-State: AOJu0Yz6h6Cg8+AOjvzevIM6XJxMrftx67S5mv6eAR4e6MutsPzFBSYi
        gyVJU3FlzzpJEu9jrMfiqpbyUJbCPdhyuZR+8w==
X-Google-Smtp-Source: AGHT+IHkpV1hHXIfuxQJyt7g8E/CbFYu+6ckAULhpEVyGObpkH0MlWXRLpGSIDfzr9abk8U0Q+VRPJuFdqHSOOF6Ug==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c3:0:b0:d9a:45e7:b8bc with SMTP id
 186-20020a2500c3000000b00d9a45e7b8bcmr25189yba.4.1696891440537; Mon, 09 Oct
 2023 15:44:00 -0700 (PDT)
Date:   Mon, 09 Oct 2023 22:43:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC6CJGUC/x3NTQrCQAxA4auUrA0krRb1KuJifqIG61iSoSild
 3dw+W3eW8HFVBzO3Qomi7q+SwPvOkiPUO6Cmpuhp35gohN6tZLmL2bTRcyxSMXsAU3CVOWJVqf jMB5eERPGyDTKPjFTglacTW76+d8u1237AVexKdp9AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696891439; l=1543;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=t6ppbaGIRSBsCeLAwhf3icSi3QggQapCJpuQhPkWhCk=; b=FWHhhun5aGED0QoILNdMciMZW3HTaYxCbuwQE2GB9YVe3/t5D443MOnBAm6QN6t6igpdopFpI
 UblLVj3B+mDBhtxxWYA5eMKhHFTTQGn4GjNgywTjOiej/yfypbDcEFq
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy with ethtool_sprintf
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
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 41ea3b5a42b1..d171c18dd354 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *ds, int port, u32 stringset
 
 	for (i = 0; i < RTL8365MB_MIB_END; i++) {
 		struct rtl8365mb_mib_counter *mib = &rtl8365mb_mib_counters[i];
-
-		strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", mib->name);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-bb106e4c110c

Best regards,
--
Justin Stitt <justinstitt@google.com>

