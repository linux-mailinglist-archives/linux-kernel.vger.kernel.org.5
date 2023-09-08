Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14DD798244
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbjIHGVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjIHGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:21:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417419A6;
        Thu,  7 Sep 2023 23:21:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1bf1876ef69so3929625ad.1;
        Thu, 07 Sep 2023 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694154077; x=1694758877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZKTZfBK+A502bdB4x6E91XtGMQJaKt3JAZWmYT/Cyk=;
        b=qMbb5ducl/jZVB9dVlh3TkpulSYiAg5y7hMjXL48JZUDG+XNTPuXUeycQ6m0CKZoh2
         jz8VEg3Kcy5X7kRlrJ3e7tEF/DbpaCW3s6CDbQy1NWSx4a12TGyyORnFoCyxLdZTS2DP
         m8oINvWGRSyZU2oQWvWhPysu+hP+7tLeReVFxWKZwfhcXyE+VMYC23RYUX9RefF1kBN4
         Zj9PSjmF/qLUTS1RCCbA377Mcq3BXo+gFa7YThg6yUm/A04o8VxUu6nBllxnqXADGX3j
         TS4FP32IBYI1pBBdj5w+FI4Wyio8iLmr7ZCAFZTc74qVaRQdVbKss9cQMR2jZFUVwQ6t
         sGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154077; x=1694758877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZKTZfBK+A502bdB4x6E91XtGMQJaKt3JAZWmYT/Cyk=;
        b=HTJuBwF2isO7nsjyktskFM+J13FWsHxeIhaQIWP76+EqjRwShVJZXE4UK5LDNtj3c6
         XnOARaDaDMtvcLpv/a6iI339u0nFv8OLxfpfGKovmjI519SpNE3r9n0JS93AeRPHEYju
         gDQd4yWa3Ye9tUlY/qbOle7D9pM1qIzpZYODJSLUEeh9fTEfuoyo6yt/rt82mHyARZ3U
         twYIXt9okd28v0iCkLRt3hpvQiVefZpfsdWPmtLxYvwtwRGAu7OZRyrbS+eCIyvJBUJ+
         SSGJU+kcKzQ+TH3Pn9YpfmOQQQh5WckK72w5p5vJvjI9QFo2+2GXN0DSXPSGAtfAe6tU
         Q9xw==
X-Gm-Message-State: AOJu0Yy+sYmLI68TZxQzwOZoi1S2N6DFgdqfe+XA/2wolzJkvuzqvC2U
        +8/bJrgiEGoxCslVPr/Yb6Y=
X-Google-Smtp-Source: AGHT+IH5FFj2A0AMT8B2pjOk722yu7NFnd14Qmz4rc/had4vrkOUm7nQ3ZH8agE8XZ2zEOBykPYxRQ==
X-Received: by 2002:a17:902:d508:b0:1c1:fbec:bc32 with SMTP id b8-20020a170902d50800b001c1fbecbc32mr1781145plg.6.1694154077596;
        Thu, 07 Sep 2023 23:21:17 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b8c6890623sm768620plg.7.2023.09.07.23.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:21:16 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 0/3] Fix possible OOB write when using rule_buf
Date:   Fri,  8 Sep 2023 14:19:47 +0800
Message-Id: <20230908061950.20287-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADD bounds checks in bcmasp_netfilt_get_all_active and 
mvpp2_ethtool_get_rxnfc and mtk_hwlro_get_fdir_all when
using rule_buf from ethtool_get_rxnfc.

v2:
[PATCH v2 1/3]: use -EMSGSIZE instead of truncating the list sliently.
[PATCH v2 3/3]: drop the brackets.

Hangyu Hua (3):
  net: ethernet: bcmasp: fix possible OOB write in
    bcmasp_netfilt_get_all_active()
  net: ethernet: mvpp2_main: fix possible OOB write in
    mvpp2_ethtool_get_rxnfc()
  net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in
    mtk_hwlro_get_fdir_all()

 drivers/net/ethernet/broadcom/asp2/bcmasp.c         | 9 +++++++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h         | 4 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c     | 5 +++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c         | 3 +++
 5 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1

