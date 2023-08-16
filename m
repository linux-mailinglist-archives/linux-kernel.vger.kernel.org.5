Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1577E84E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjHPSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345402AbjHPSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:07:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC312698;
        Wed, 16 Aug 2023 11:07:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9a828c920so104423481fa.1;
        Wed, 16 Aug 2023 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692209219; x=1692814019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvUnK1KReC+gtt2VFef+GjeqrRcy7VGJ9VpdQ/fn9pM=;
        b=AgFshPjeEB7XehZx6Fhofe1yYrn3X9UfUoWo8uuZfohdzOoDTIZID5kc7KzO5qGG5q
         AKXPY+Jgwqe8T+pfVbKp1mntpPUmJXNVO7BM3wQqTrZVEwvqR4zkVlHqCCQyJvLNDSpk
         50ZPzj5PYCtfGyhhLaSgmGNzgo+vxM9oUY7gva/vhnuXiWuUwKSAKSrYVjc+50HzEoxl
         wuR7vBt8zVsBQfvJB4C7/aLdG64hCUsVjoPeZWIn0Xmedj7aHCyqHBdEllx34BX9/IcW
         Y963VgfK3e/dB08DtfG1fEvKhCttQ5dtBLZBEobi3Zl2mI0cGffhBmOsXGZm2i5i956m
         Ib3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209219; x=1692814019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvUnK1KReC+gtt2VFef+GjeqrRcy7VGJ9VpdQ/fn9pM=;
        b=kcLC8RemwmpUrUvBEgo95LmBEn8CZUdpmj0KtvXZcY1VKXT+1PUtyA57v215VrU6fU
         vuwpAu2Ll1VLbU5OYJ+e30j3yFGITL+Kq/j4ene2arnrPvTxM+EFNZhS0aX6GTmDZ75H
         rFLpE6dww4Imm2Ra70UqA8XTakb7lRZxwTs+ceUX8Z53uqSUIDBOe/B/Upvvhi0OBlPW
         PqWD2SJ8xBCA36feNWEnCvdYFKQr9uYRXvvyESJpQ7IxuiFCk12sxQZ0/Ys5vunuDw2c
         qAeQzEd5UAlOmv4VSCcfJhETtV+8u9WWjXIVFj+OWldz3vYTtbgXrJVsfOqdX6kIYw7C
         xABg==
X-Gm-Message-State: AOJu0YxAr+Nj/3KqJsnMJUh/SIHt+7SNp48tH4NfqvqoY4Gjq7+dTH2L
        mPLJ1gqhCnU3njU1WkKnRvw=
X-Google-Smtp-Source: AGHT+IESC01SBSEsqvj42Wy+bJMrzx6ExlMdXBKsWkcpAHN0n/366kzX2kBG90asbxBLwAsGTp/Pfw==
X-Received: by 2002:a2e:9a8a:0:b0:2b9:ea6b:64b with SMTP id p10-20020a2e9a8a000000b002b9ea6b064bmr2152740lji.37.1692209219107;
        Wed, 16 Aug 2023 11:06:59 -0700 (PDT)
Received: from localhost ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9c92000000b002b9fe77d00dsm3619531lji.93.2023.08.16.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:06:58 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>
Cc:     Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
Date:   Wed, 16 Aug 2023 21:06:52 +0300
Message-ID: <20230816180656.18780-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Based on the original code semantic in case of Clause 45 MDIO, the address
command is supposed to be followed by the command sending the MMD address,
not the CSR address. The commit 002dd3de097c ("net: mdio: mdio-bitbang:
Separate C22 and C45 transactions") has erroneously broken that. So most
likely due to an unfortunate variable name it switched the code to sending
the CSR address. In our case it caused the protocol malfunction so the
read operation always failed with the turnaround bit always been driven to
one by PHY instead of zero. Fix that by getting back the correct
behaviour: sending MMD address command right after the regular address
command.

Fixes: 002dd3de097c ("net: mdio: mdio-bitbang: Separate C22 and C45 transactions")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/mdio/mdio-bitbang.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-bitbang.c b/drivers/net/mdio/mdio-bitbang.c
index b83932562be2..81b7748c10ce 100644
--- a/drivers/net/mdio/mdio-bitbang.c
+++ b/drivers/net/mdio/mdio-bitbang.c
@@ -186,7 +186,7 @@ int mdiobb_read_c45(struct mii_bus *bus, int phy, int devad, int reg)
 	struct mdiobb_ctrl *ctrl = bus->priv;
 
 	mdiobb_cmd_addr(ctrl, phy, devad, reg);
-	mdiobb_cmd(ctrl, MDIO_C45_READ, phy, reg);
+	mdiobb_cmd(ctrl, MDIO_C45_READ, phy, devad);
 
 	return mdiobb_read_common(bus, phy);
 }
@@ -222,7 +222,7 @@ int mdiobb_write_c45(struct mii_bus *bus, int phy, int devad, int reg, u16 val)
 	struct mdiobb_ctrl *ctrl = bus->priv;
 
 	mdiobb_cmd_addr(ctrl, phy, devad, reg);
-	mdiobb_cmd(ctrl, MDIO_C45_WRITE, phy, reg);
+	mdiobb_cmd(ctrl, MDIO_C45_WRITE, phy, devad);
 
 	return mdiobb_write_common(bus, val);
 }
-- 
2.41.0

