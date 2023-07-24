Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303575F3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGXKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGXKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:54:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442A90;
        Mon, 24 Jul 2023 03:54:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fd190065a7so32623325e9.2;
        Mon, 24 Jul 2023 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690196068; x=1690800868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm2AmYXeSq7Hv1D3EYH8vxoR54aZLC/z7y6TUDXlfXw=;
        b=d9UMgBhPwr9+yS0cB8RgNScyWl6BhHVnRy8vrVAfOBKNk6b2xc+GWR5P56tHAcVBZT
         ckIoK4Eqrokqg700VJ3UnLuEVrOCK8jrRwCBv3BOS8u8NST3tSx+CltWurz5swA81Mfv
         A2Es1/fkBb+zs4Tv2VY8QEmqRZhwg4BZ7Ym4fqUQjP5d9XBO1OHi9GojHgOGw7V46DGX
         de/BS6iskM9gQnfDrdHjzG4mi4aQBOC5HguEkLHuomkhX6N0kordNQlWGky/OwvcKisN
         iP0OG97pozmINDmZ8dHhnrLnq4o534AgT29943ny4cLzpbvknbksrSq+f82ZoOIHFO7I
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196068; x=1690800868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm2AmYXeSq7Hv1D3EYH8vxoR54aZLC/z7y6TUDXlfXw=;
        b=dSvhFHEwvlz2I0V269xO062qdp8QOI2MzyVlgYj3efoQaUvETQ1eusOnVd8RhJyuDK
         4slC2GKD02JoDQ7MCTBWXKlaG2KednNL13hU0EGxV3EUl/L98U4S2iRRVpa4b0NH6O09
         y8EHRROeNuq77Hch3YVyOapK8ptr06cObWiAIx3MVRQ9uAHlam5eQ7NbLiuRuNjKExhq
         ECJ6W9JJPPMiNB6TqrSnAfnk8H0MReI3RbzISD+T15GnuoghloOWnOv21z33sCj7kVhv
         WdMZ1LmZOLbcI84jkiZNoVl4puK9LuRM0e68DQXD49gyIhNP4n8omuPc85QeV962xOe7
         Uw1g==
X-Gm-Message-State: ABy/qLaTscQvWstrY4BOU4IeHt9qbUgAVP2F/z8OZa/hX18dvUgtPNLo
        PzBfanXjIuiZrMKLN0+wSX4=
X-Google-Smtp-Source: APBJJlH/2BbzxEZghaykXJzZO9SLi2QkikMnuGRruKqHnDxO2xRWHD+bs5wItOEpHv6nJW1vwwaEmA==
X-Received: by 2002:a5d:5909:0:b0:317:60ae:2ef5 with SMTP id v9-20020a5d5909000000b0031760ae2ef5mr1036070wrd.31.1690196068041;
        Mon, 24 Jul 2023 03:54:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm12529631wrr.109.2023.07.24.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:54:27 -0700 (PDT)
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
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Subject: [net PATCH 1/4] net: dsa: qca8k: enable use_single_write for qca8xxx
Date:   Mon, 24 Jul 2023 05:25:28 +0200
Message-Id: <20230724032531.15998-1-ansuelsmth@gmail.com>
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

The qca8xxx switch supports 2 way to write reg values, a slow way using
mdio and a fast way by sending specially crafted mgmt packet to
read/write reg.

The fast way can support up to 32 bytes of data as eth packet are used
to send/receive.

This correctly works for almost the entire regmap of the switch but with
the use of some kernel selftests for dsa drivers it was found a funny
and interesting hw defect/limitation.

For some specific reg, bulk write won't work and will result in writing
only part of the requested regs resulting in half data written. This was
especially hard to track and discover due to the total strangeness of
the problem and also by the specific regs where this occurs.

This occurs in the specific regs of the ATU table, where multiple entry
needs to be written to compose the entire entry.
It was discovered that with a bulk write of 12 bytes on
QCA8K_REG_ATU_DATA0 only QCA8K_REG_ATU_DATA0 and QCA8K_REG_ATU_DATA2
were written, but QCA8K_REG_ATU_DATA1 was always zero.
Tcpdump was used to make sure the specially crafted packet was correct
and this was confirmed.

The problem was hard to track as the lack of QCA8K_REG_ATU_DATA1
resulted in an entry somehow possible as the first bytes of the mac
address are set in QCA8K_REG_ATU_DATA0 and the entry type is set in
QCA8K_REG_ATU_DATA2.

Funlly enough writing QCA8K_REG_ATU_DATA1 results in the same problem
with QCA8K_REG_ATU_DATA2 empty and QCA8K_REG_ATU_DATA1 and
QCA8K_REG_ATU_FUNC correctly written.
A speculation on the problem might be that there are some kind of
indirection internally when accessing these regs and they can't be
accessed all together, due to the fact that it's really a table mapped
somewhere in the switch SRAM.

Even more funny is the fact that every other reg was tested with all
kind of combination and they are not affected by this problem. Read
operation was also tested and always worked so it's not affected by this
problem.

The problem is not present if we limit writing a single reg at times.

To handle this hardware defect, enable use_single_write so that bulk
api can correctly split the write in multiple different operation
effectively reverting to a non-bulk write.

Cc: Mark Brown <broonie@kernel.org>
Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index dee7b6579916..ae088a4df794 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -576,8 +576,11 @@ static struct regmap_config qca8k_regmap_config = {
 	.rd_table = &qca8k_readable_table,
 	.disable_locking = true, /* Locking is handled by qca8k read/write */
 	.cache_type = REGCACHE_NONE, /* Explicitly disable CACHE */
-	.max_raw_read = 32, /* mgmt eth can read/write up to 8 registers at time */
-	.max_raw_write = 32,
+	.max_raw_read = 32, /* mgmt eth can read up to 8 registers at time */
+	/* ATU regs suffer from a bug where some data are not correctly
+	 * written. Disable bulk write to correctly write ATU entry.
+	 */
+	.use_single_write = true,
 };
 
 static int
-- 
2.40.1

