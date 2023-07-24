Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB475F3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGXKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjGXKye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:54:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06FBD;
        Mon, 24 Jul 2023 03:54:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d20548adso2924415f8f.0;
        Mon, 24 Jul 2023 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196072; x=1690800872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf/Qc5DLJ/sURnSwOUoxd8QFaQVoKAa+14ueKRK2tOA=;
        b=nleeeYxFcHqL8srl5QGaYkU6wrOH5DoOGmiLLnSsSrXb06qA85CpS0i0B9l7cYujfF
         +9PbJsVOLM3razuOW/6Lnw8cw1rl7KIh4heSfVFDzWOWuHRkbVyzGKZTK6KgcRty5GYa
         naM0Hp1s6rBw2atG6o2o2LGaQRtztWrk5dkn0KX9w5spvoja10a5Fq8hTomNPrKdAXgn
         UtTyIU5QuF7mfenGFuxUTMYGKTb/g9XvQIsB1LwwgNTpB6UG9jnDOrsttczBAj4fRFUa
         DnBGLnaoYBgdoJw99fK9rBySONYouEMYw8C8kB7EsGS1n/mEugnj2TDHl5f87rSkKOo7
         UeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196072; x=1690800872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf/Qc5DLJ/sURnSwOUoxd8QFaQVoKAa+14ueKRK2tOA=;
        b=L3w+0k7gypZqQsJ3vzYoDqvFUvLs6QQn1Zv1oc5jntRxO4Wn17KY8M08mSOA8b0Jyx
         A9TgsWDkn0esRE+xphBPjYcalaxZ5UC+dCEPnBd0PUvly07/6eBYzebB5rlCAtIPh0Nf
         Clb//ReoA6YFw4C7EvHCwaPJbcQ8NKvsL9BVidMRzt/sFDz3ewGPWk6/xEaNlr+1db6x
         cToEH7sA6MYf6MR0aodc1hi4fFLrgioMPXmxx1gX4Bw8Z0ACa26YYDW6C8+mSRi9kvK6
         UgP7CagnTyd7EDauVtw1ykKn6ubPTz+8UOzamFweLWOhTCkM3azHCGMWbo5/ZJ+O3s5+
         G6bw==
X-Gm-Message-State: ABy/qLZuHBuUmmuy6HQxdcyg/l4EwSok+YTHlcq29iaWTS/ZG3VPt47u
        heb/9S6Wzac7EBNd/6Lcwks=
X-Google-Smtp-Source: APBJJlHK3bok5QHzMzxZRNGwjnTbaJJhwuFS/9L0M8X72BtJuel/e6ii84jcbFxbAh7cYysuN/2iSw==
X-Received: by 2002:a5d:4cc2:0:b0:315:a1bb:4d7b with SMTP id c2-20020a5d4cc2000000b00315a1bb4d7bmr5154424wrt.35.1690196071249;
        Mon, 24 Jul 2023 03:54:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm12529631wrr.109.2023.07.24.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:54:30 -0700 (PDT)
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
Cc:     stable@vger.kernel.org
Subject: [net PATCH 4/4] net: dsa: qca8k: fix mdb add/del case with 0 VID
Date:   Mon, 24 Jul 2023 05:25:31 +0200
Message-Id: <20230724032531.15998-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724032531.15998-1-ansuelsmth@gmail.com>
References: <20230724032531.15998-1-ansuelsmth@gmail.com>
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

The qca8k switch doesn't support using 0 as VID and require a default
VID to be always set. MDB add/del function doesn't currently handle
this and are currently setting the default VID.

Fix this by correctly handling this corner case and internally use the
default VID for VID 0 case.

Fixes: ba8f870dfa63 ("net: dsa: qca8k: add support for mdb_add/del")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/dsa/qca/qca8k-common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index b644c05337c5..13b8452ce5b2 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -816,6 +816,9 @@ int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
 	return qca8k_fdb_search_and_insert(priv, BIT(port), addr, vid,
 					   QCA8K_ATU_STATUS_STATIC);
 }
@@ -828,6 +831,9 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 
+	if (!vid)
+		vid = QCA8K_PORT_VID_DEF;
+
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
 
-- 
2.40.1

