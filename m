Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF57937F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbjIFJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjIFJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:22:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB03E53;
        Wed,  6 Sep 2023 02:21:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-2684e225a6cso553927a91.1;
        Wed, 06 Sep 2023 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992118; x=1694596918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mkTCP1wwaR9YuY5H6Ulmq36vtFFoJH9HnExkyxKpno=;
        b=lRHlt686bQaQVoVWyCv7F2ELUs/ftHzTVdHgKunyeza+8Pr80dNlrTXM2TRin3pOim
         kli+mwqmuASMTgJto9DsdLG8F6gcuQbLOTGrlmoh06zoch2TIKxHXjwTP6LvWnT0vDFw
         lNOBI7n0g9gpks4KpEpsQDVKkrOO++v2/rjXyGKAJdDStJJtwfHBuXYNIsqqvhG/O+5H
         ju3n+OX4Ej0bCZgCvt9IBJozqT7As8j1FjbmOGXrAQvqKZSHdLdLLE9DZkBK33h505+W
         8QnKj8fO249NDpDxkHdhlEZMZrZoc51lTGnO0XW+j78QmtCR3IOZyt/oj8xjmrldnhbk
         c87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992118; x=1694596918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mkTCP1wwaR9YuY5H6Ulmq36vtFFoJH9HnExkyxKpno=;
        b=BWcq9LF/hSKmRcJMCWDXkCJBW09iPXlugY16XjSQES/ob8KhAk8ESpNM6lBdQbMo/S
         Ha1q5o4ZYFDBqhMhwhCD1ijmOTz4eEfE3+EseqC8Q5JYu/HUD9d85H+l9GERwhxFaEmE
         nH7Zk/YzPzuXhQhmc91HdW8H2ZROhdWwUQoKKRoyb5u+z+4rMVUKg+qPnBJU9DccDq3b
         O8RDAtWURJx+yAi/1zvmJ8ntFnzzKcnsOFsSoleDThv0QErn3w/6V4G+/6VxxZRON3Cz
         h8NrWD9BFhPj1/G7epwhZ3dpwx4xNDQ1yt+jctVlLRO3weB8hdDHegWctkH2j9okU1u+
         7ZJg==
X-Gm-Message-State: AOJu0YwACf0WMqOm0bADAjo9ryM4lzWbXiAdRxXQ6bj47eh8IjapopfA
        kFx3CBmVNEuwfKZL5yTFyik=
X-Google-Smtp-Source: AGHT+IGumS01xDzHXnzIBN0/ozMrBV2bEocZTQWgT9l9f/ywNuBPFlMEot9zOWbNCsaAOm4ZDvXC+A==
X-Received: by 2002:a17:90a:1050:b0:26b:5fad:e71c with SMTP id y16-20020a17090a105000b0026b5fade71cmr13211092pjd.2.1693992118570;
        Wed, 06 Sep 2023 02:21:58 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm10679242pjb.14.2023.09.06.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:21:57 -0700 (PDT)
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
Subject: [PATCH 0/3] Fix possible OOB write when using rule_buf 
Date:   Wed,  6 Sep 2023 17:21:04 +0800
Message-Id: <20230906092107.19063-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADD bounds checks in bcmasp_netfilt_get_all_active and 
mvpp2_ethtool_get_rxnfc and mtk_hwlro_get_fdir_all when
using rule_buf from ethtool_get_rxnfc.

Hangyu Hua (3):
  net: ethernet: bcmasp: fix possible OOB write in
    bcmasp_netfilt_get_all_active()
  net: ethernet: mvpp2_main: fix possible OOB write in
    mvpp2_ethtool_get_rxnfc()
  net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in
    mtk_hwlro_get_fdir_all()

 drivers/net/ethernet/broadcom/asp2/bcmasp.c     | 3 +++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 +++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c     | 4 ++++
 3 files changed, 12 insertions(+)

-- 
2.34.1

