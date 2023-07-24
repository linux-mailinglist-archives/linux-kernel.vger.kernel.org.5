Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317D75F3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjGXKyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjGXKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:54:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1990;
        Mon, 24 Jul 2023 03:54:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31765aee31bso128007f8f.1;
        Mon, 24 Jul 2023 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196070; x=1690800870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEyWGecSm4CuQ74zs3MLXEg5kzDp90u6LK+sKJXsB/Y=;
        b=B07Xq67Ah++90WKhMX1GMpNC+E4X9DXk7Lz+6CBjPwH+uZ9JOMyCvW4oVr3tCfboZy
         H4soUZeTOOhYteIOmvZI3DV9oo3uMAvHkF5sf8LVeTQKpVu9+D4yXMiyEPnkJrBQZs5G
         lw7QHISG6LTo8Mav2202xrUQS5UigmCMtHIrAwkLmaKui1qvc3dVGNHZB+twCfMb8i7p
         So2k3vhM4sjwB1RG4gMN4cZoGofNIEV/MIRAU17hir4DWFqFhhlRm+qpy28tC49r6/IY
         Wpiw+LEUCifV5skNSHXp6s0RiKJ28Kcahw2oClXRuVEDKoMKDlU8SZHiKJsn+muSpjUj
         7cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196070; x=1690800870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEyWGecSm4CuQ74zs3MLXEg5kzDp90u6LK+sKJXsB/Y=;
        b=OgWbdeeh5aF/wj7YsiL3WCZNInLK8HKbgbAz9nEE9jV0waWd/kPSR7aW1flXGGhSN3
         8mVeDYw/PAQ0xlVQTx+sTfqrrrhVSvKpDwj1ZwmrItqELfmwJPfyKB28ru3aY31U+75J
         roQZSRHF12BL+0dTrPOmZxo77AMyscnldhODwBsAGbLKzM8YeezpGtSGIjcyafW/aKN/
         sSVN3r6UyakPQ93OFmi5TQezzGulKaG+B0ppfoLVFxcUHLZREiAsez4pvHSh2xUmdLtp
         ySwW3D6+tv3PFbivEUw392ZwcUXbUnkqcjJVc9FFBwhUrH029jhEqZ01Q23MYq6ejN3O
         r52Q==
X-Gm-Message-State: ABy/qLbp7uIZmoYO7cAVaTnL1j1tv0/8nQSMB1qqCV0fZN/hTFHHmXYu
        IZIMhT+lZGrqhtKFLpUrgE8=
X-Google-Smtp-Source: APBJJlGy2kE8D1SFU2thsf2H+b7Wre6gbhmnESK+alrHjr1iFzxm+EDmn8w9Z4MaKp0jwVQ6Qc3vag==
X-Received: by 2002:adf:e94b:0:b0:315:a6a5:fe95 with SMTP id m11-20020adfe94b000000b00315a6a5fe95mr6070624wrn.52.1690196070065;
        Mon, 24 Jul 2023 03:54:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm12529631wrr.109.2023.07.24.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:54:29 -0700 (PDT)
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
Subject: [net PATCH 3/4] net: dsa: qca8k: fix broken search_and_del
Date:   Mon, 24 Jul 2023 05:25:30 +0200
Message-Id: <20230724032531.15998-3-ansuelsmth@gmail.com>
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

On deleting an MDB entry for a port, fdb_search_and_del is used.
An FDB entry can't be modified so it needs to be deleted and readded
again with the new portmap (and the port deleted as requested)

We use the SEARCH operator to search the entry to edit by vid and mac
address and then we check the aging if we actually found an entry.

Currently the code suffer from a bug where the searched fdb entry is
never read again with the found values (if found) resulting in the code
always returning -EINVAL as aging was always 0.

Fix this by correctly read the fdb entry after it was searched.

Fixes: ba8f870dfa63 ("net: dsa: qca8k: add support for mdb_add/del")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/dsa/qca/qca8k-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 4909603d07c8..b644c05337c5 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -293,6 +293,10 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
 	if (ret < 0)
 		goto exit;
 
+	ret = qca8k_fdb_read(priv, &fdb);
+	if (ret < 0)
+		goto exit;
+
 	/* Rule doesn't exist. Why delete? */
 	if (!fdb.aging) {
 		ret = -EINVAL;
-- 
2.40.1

