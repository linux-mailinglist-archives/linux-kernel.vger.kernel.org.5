Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD675F404
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjGXK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjGXK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:59:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1C90;
        Mon, 24 Jul 2023 03:59:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so58898051fa.0;
        Mon, 24 Jul 2023 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196370; x=1690801170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNuEXVvvuCAkiuz8BidvSXWcAbM3rfmu/apd1ht/nuU=;
        b=fklvpOQFCL3HOgzNrOXZIkBrZQFgAKCKMBY2bbX0mpsbkqXGAVOISGudghz4K8hUey
         gVm/cb149EszqLSoP0AtoV9TI1ubXO5ZHvCnsQHWj442xcVEyhWJ4KeQdp3nwD7aSuMJ
         S1PZXsJOINa0G1OxZhZfDwsJqPwpNaQyajKanlpOiuOPHTMi6UVfrDrgR4vPVA0nUXvM
         2xsmjktq6G/HENAk80/w8BAprtNDVx/ad6mHgU1udKfbFrJk8uVZ5TaoBdbMNzy1vpBZ
         Rhv1dd2D7SNjMBz8/RHzCZjqJLXTaLc8dGsCD8M4mg9PV8GeJqv6hB6ikpQct3QeFnTj
         78mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196370; x=1690801170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNuEXVvvuCAkiuz8BidvSXWcAbM3rfmu/apd1ht/nuU=;
        b=AcVfF42QpHV9YSmS2PHyXx6VkT+IZErqdH/GEOtG5/7Z31AwmtVpG5PwifCqrRqKsE
         IyfXSKzLw91Gd+J9QABv4bgeBi+W+jWbU202izF/Ly4AcUtEKxcBrZTFWmOjfYW2cWl6
         Z0lfxsaVXyXrQM7yBXaTRnvZt8UiB3ZoG0eBJ9ylRc7PacorqoV2D9+PkF/SbEvFoCXg
         uyHDoeDuzgI5vHBTwwJoTNMDjLhvsdGwNVoI0wWTvh15Cns5KGsHcmIIVwVBLe35ysTp
         JMrDvynOYCAfRyzN88vb/eRUHjcz18C1g3+QNvNQmOymn7H42waDs48BORFrwgo1Ey+t
         NmLg==
X-Gm-Message-State: ABy/qLZxyJdiNJi/wNEhEQ5jP4mviDrkNs4Nf2OBNGX4YM8CukmnCWFl
        dzw+RklhO8aUeEeg3l4EM80=
X-Google-Smtp-Source: APBJJlG+lgAyR4y1jRq2lOBks2Ab/QDYRzJKDDyvzF1Bnqhzrcd0Q+xTVDlr/H0W86aZRHhFTkMIDA==
X-Received: by 2002:a2e:7d14:0:b0:2b7:2ea:33c9 with SMTP id y20-20020a2e7d14000000b002b702ea33c9mr6296249ljc.20.1690196369662;
        Mon, 24 Jul 2023 03:59:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm10055353wmi.13.2023.07.24.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:59:29 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/3] net: dsa: tag_qca: return early if dev is not found
Date:   Mon, 24 Jul 2023 05:30:56 +0200
Message-Id: <20230724033058.16795-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

