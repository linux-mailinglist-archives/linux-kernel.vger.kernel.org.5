Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A77DA1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346399AbjJ0UVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0UVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:21:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D61AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:21:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5079f6efd64so3416264e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698438101; x=1699042901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2aSxynAJWD4w6QHvLKwVWJJOGC7WprRqk+AbZ7X+LM=;
        b=H9+pruVOxJQDYQWtfYdTgN9im65ZC/k2Aej8bvWnA8mneXDCan37cuh/6U7HJUwX/U
         KJq9+NygGgSqeVtkDo/mweJ2/0lWzlM5wfaj7Cmv0GbmNi7D/P21RPTywUAPjAF7zva/
         qvSM+tWLU9KFaPX2/SgPk949/hr7dagG7Lc9imwkcDbS4HubCS+STWqI/lHYc9KPBCqW
         GUNJBFFJnFSNfzyBk/TGFLpar3eT/nZgFPiWbl4e8B5OFEAJ8zippCG4h5HcvUFvh0iK
         melPNEZmNNxgKEcGeoUhMRCeCnLm3CcbOZgLPoaWz09XyTj7bt3WihWCZJ9luNtHMwoy
         sFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438101; x=1699042901;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2aSxynAJWD4w6QHvLKwVWJJOGC7WprRqk+AbZ7X+LM=;
        b=bEEqRX7UvKLSeOHNVejvKCEUYJcs8zN7v8qxrMxJnlDEnlJ5DDdOlZ2KzvheijCAVv
         jcwLvazEFyAhXPzx3aPFrg7UprrPWMlb2V9CZ2HXx5/qzR2f+i+2qrV00XHx73vLQXde
         IhaGDHYPZq12mR3mhx7K6Ai12EgepFJrlOTgzo4M/6H/TftQ0bz0tPzr6vT/QR6gg7mp
         lA0Voa0dsDngiQrZ7OXV0LVB2kfiR9IlTb0IGQ8/IqnRvlHI+w7ofqyhL3vxcD7xP0Tu
         kljvgx/vNsoic0f5TxGxHua90yueF+PpfHSS3Qxc2tkGgjCpUMEMaj3x67SFCULxMmu4
         wXUg==
X-Gm-Message-State: AOJu0YziE77Kxg06XE5bZM673zhAdWJSILEyoFW/w1f3EO/t9Ki8aKm+
        /cQ8cPSLexi5xT/yq0AZYsaMuFD01brEhIs4S5I=
X-Google-Smtp-Source: AGHT+IEa/QcaZvljgbdGu/K4ciK9D0FHLRgitkOzAfJ7CDtPubJGROFgHjxG4bfoHfSJ70jYLFcylg==
X-Received: by 2002:ac2:4850:0:b0:507:a1e0:22f4 with SMTP id 16-20020ac24850000000b00507a1e022f4mr2496829lfy.29.1698438100941;
        Fri, 27 Oct 2023 13:21:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r3-20020ac25a43000000b00507a3b0eb34sm388178lfn.264.2023.10.27.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:21:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Oct 2023 22:21:39 +0200
Subject: [PATCH] dsa: tag_rtl4_a: Bump min packet size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
X-B4-Tracking: v=1; b=H4sIANIbPGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNz3bTMCt2ikhwLYzOzoiTdVHNTo6QUU0sDw+REJaCegqJUoAKwedG
 xtbUATWVsMF8AAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that the "LuCI" web UI was not working properly
with a device using the RTL8366RB switch. Disabling the egress
port tagging code made the switch work again, but this is not
a good solution as we want to be able to direct traffic to a
certain port.

It turns out that sometimes, but not always, small packets are
dropped by the switch for no reason.

If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
(1518 bytes) everything starts working fine.

As we completely lack datasheet or any insight into how this
switch works, this trial-and-error solution is the best we
can do.

I have tested smaller sizes, ETH_FRAME_LEN doesn't work for
example.

Fixes: 0e90dfa7a8d8 ("net: dsa: tag_rtl4_a: Fix egress tags")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 net/dsa/tag_rtl4_a.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..8b1e81a6377b 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,8 +41,11 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u8 *tag;
 	u16 out;
 
-	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+	/* We need to pad out to at least ETH_FRAME_LEN + FCS bytes. This was
+	 * found by trial-and-error. Sometimes smaller frames work, but sadly
+	 * not always.
+	 */
+	if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
 		return NULL;
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231027-fix-rtl8366rb-e752bd5901ca

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

