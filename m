Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDF7BE92A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbjJISYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377527AbjJISYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:24:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D1EB0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:24:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso6700406276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696875861; x=1697480661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOe87dtF8f2vVZaLo1VI1Io3ZSRwFhO2mL6l5vDJPeU=;
        b=AqBNLc/ODmGvM7i/zIVnKQqJjEdspQKkLMYCrOP0O4dsv0EK4w/qzW1N8wbI2v0dOK
         7bl4niVWr9fPwgEOpgzL+52Qo4a4FzYX2FO/AokgNoB8lCDfoLJHnbZ9KeU8xz8SsVKf
         2hoEUOtMb4n/CSzQ2VgJV8lQoqh4xe9He9gG8G1Xo9eNWyjBTNC3rgaY8yTepspHc2Xo
         QeV3VyXixgyW5mvgjJKF7ICiDHVhursTYSyTjl8QjgK0ddgDmY+xM2ikl0ZOScDMyT3C
         +v1FXT99cIkN0Qof/tgnwmY7Q5W8e2vxzrMf4Gihj875RnivpSWYQec12bQgmUtSi0RU
         36vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875861; x=1697480661;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOe87dtF8f2vVZaLo1VI1Io3ZSRwFhO2mL6l5vDJPeU=;
        b=VpC2mLGFNtaHnmHk+sCxNgqu1kt64eFynup+b1BEuTrC+0G2EbgacIaMtmOS73oPMf
         kW3otY8jEjpsKZAarPwbi5PDwO42mPWI3TXOl8ZBIRuonlbVGgWF/HBMCEqmUdfHvdrn
         llGRF076vQMyf/RkfovdFYWbGZhqpmF4Lp/hJWZwrWpCyTeRqT2pZxYY5a4h9Nt8F4If
         KYljmG+QkpsWIZKq0gPNne2Y9eNgIj/uYc7fsdPUscpxygJCpF9GIBeBAXKElmiDnni4
         /GY9QVU2ntGjEsPAMLClXoG1URA5QsdihPl1hCLZtzA0JDqdQvRjOgpanYt1QJ8EYizA
         Z5DQ==
X-Gm-Message-State: AOJu0YwdQvPmKk+jxAPR3Lb+etoRFE0q2GYpq6Jplm8sMbXfNgTcn1GI
        tH3IXgUgpS5+0DfZn3f4sneVBMVj0VnDJEAQ/Q==
X-Google-Smtp-Source: AGHT+IFC3hmo2rb6A5NbfvWHcFjCc5J7pyx/Rhtkmp7wRH/7V9F5MIpIoRZWCZ2zcQy/pl6DX5rSzrkN8x4djDXjig==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9349:0:b0:d80:12c:d49b with SMTP
 id g9-20020a259349000000b00d80012cd49bmr282372ybo.8.1696875861177; Mon, 09
 Oct 2023 11:24:21 -0700 (PDT)
Date:   Mon, 09 Oct 2023 18:24:20 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFNFJGUC/x3N3QrCMAxA4VcZuTbQ/TNfRURKm20BiTUp0zH27
 hYvv5tzDjBSJoNrdYDSxsYvKagvFYTVy0LIsRga17S1cz1aVglpx6i8kRoKZYzm8ekl8/ux2Ic TBqRAk5t8O3TzCCWWlGb+/ke3+3n+AK2SqrB4AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696875860; l=1558;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yDFBSw0V7Cy1imQVxlIU4QmZCv9EuU9vec23gtxIRXc=; b=S39+gdooJRUg9dxjjjTV4pncP9RRL3ek8BSE4LJUNtiVQoov+qSTSt31Ueu4JkQi5Jm3KLRY+
 TTGzmzYRNojAbqsXC8gje4J8QrdHXbrGwPbScinRm52YP0QGIhMbjhg
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
Subject: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
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
 drivers/net/dsa/lantiq_gswip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 3c76a1a14aee..d60bc2e37701 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1759,8 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
-		strncpy(data + i * ETH_GSTRING_LEN, gswip_rmon_cnt[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);
 }
 
 static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-dsa-lantiq_gswip-c-ece909a364f7

Best regards,
--
Justin Stitt <justinstitt@google.com>

