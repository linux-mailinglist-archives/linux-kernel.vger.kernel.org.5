Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF85767EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjG2LzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjG2LzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:55:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EC3A99;
        Sat, 29 Jul 2023 04:55:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3174aac120aso2908158f8f.2;
        Sat, 29 Jul 2023 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631715; x=1691236515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3q+L7EE1TkpxxmtRm93suLpVPlWGwO+iRnmPNbcpp6s=;
        b=mBzFMgkv1OVQE4vElaM8tRO+UIjOimxmAb5DV5QeM94ZFzpWQFOdFk2M2fD41NhPc4
         tflz9ASQxYW29cxIZ6grhdZ9ItdUiW8LSJyrZ0LrBSGUXIlBehKvmyuoJfZYBieA3p/E
         r65MSx8lgQerIVQT/U6kTi1LTzc69NGnJV9gyAGOPEeCmjZtMLWTlQ/yNuYvQTYrE9Nv
         HplMhnrYmsng8g3v0koRlPXdcB4dRu+Ai1Jl/Qkp40vn8oQuMzl19Lnw+VoIfgudva3m
         6w0QCX0y4eV1e9wDe4zXbuT9GWznY4MaT0So4WLHFKfnC/5yX/itBOz8+F+69VVoS7c0
         JQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631715; x=1691236515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q+L7EE1TkpxxmtRm93suLpVPlWGwO+iRnmPNbcpp6s=;
        b=cVO41m/ZdiNPhSQX1ZUtrXuasSc7fUbb2OlMPqPrhk7uof24111Wtplkw86voWV4st
         xsg1LM3qSDLSDV9P3GPyHFC7tnWb+7AQ+ZTU1SKAJIeNuUEcjRrTYqHmMkVieYMHxlqp
         1p0KtK8jj4wKC64QlkxrnhfKuO2nrmsB5jD59i6nXL0feHviL0Vofr9MTvIEx9jUDUb/
         TbsjR50MMnMVBP8u71/0y9b+twWrZ4B+dfoceS1bTQcxvhrHt8bsQMRskzKOJnS0o8MS
         44lufaYsFgdEMIuRQyUuUBIXgT5lXpvcHXkVY7rbAt5/g1BHhANwgSYDrcP7ZHdhvWDB
         uw2Q==
X-Gm-Message-State: ABy/qLaodeEgqp+Vr6gB074Ds8/3yvohwiLWWwSWaz0+8VRGHVHEyhYI
        hYXTdMhwtug/gw8b8qx4If4=
X-Google-Smtp-Source: APBJJlGWklIuKSEcZzYMZGwwHbKmjzcXuNtxmeFxU35UBDxbkXqYo2C/agu+03DtgvVbFkRKTnTrRQ==
X-Received: by 2002:a5d:690e:0:b0:317:5cc7:794b with SMTP id t14-20020a5d690e000000b003175cc7794bmr3638169wru.13.1690631714702;
        Sat, 29 Jul 2023 04:55:14 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm7295289wrv.71.2023.07.29.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:55:14 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v2 1/5] net: dsa: tag_qca: return early if dev is not found
Date:   Sat, 29 Jul 2023 13:55:05 +0200
Message-Id: <20230729115509.32601-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checksum is recalculated and dsa tag stripped even if we later
don't find the dev.

To improve code, exit early if we don't find the dev and skip additional
operation on the skb since it will be freed anyway.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/dsa/tag_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index e757c8de06f1..e5ff7c34e577 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -75,10 +75,6 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 		return NULL;
 	}
 
-	/* Remove QCA tag and recalculate checksum */
-	skb_pull_rcsum(skb, QCA_HDR_LEN);
-	dsa_strip_etype_header(skb, QCA_HDR_LEN);
-
 	/* Get source port information */
 	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, hdr);
 
@@ -86,6 +82,10 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (!skb->dev)
 		return NULL;
 
+	/* Remove QCA tag and recalculate checksum */
+	skb_pull_rcsum(skb, QCA_HDR_LEN);
+	dsa_strip_etype_header(skb, QCA_HDR_LEN);
+
 	return skb;
 }
 
-- 
2.40.1

