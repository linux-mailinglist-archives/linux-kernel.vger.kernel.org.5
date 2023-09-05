Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B37925D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjIEP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbjIEEQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:16:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D601CC7;
        Mon,  4 Sep 2023 21:16:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso1107443a91.3;
        Mon, 04 Sep 2023 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693887388; x=1694492188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeLpY9djXSpdgH4Ae7n5MB3zE0D3lzBJjJWuWYn4B9M=;
        b=APQVz9WNVetZ4H8NlK4KETQYPo0dXbIwAQpRsRRgajHctu6HWWPounKT4ChGq+BO4V
         EGy17icSJXfYnUsQV/SepLixMIrnPngxh/K6g43IS2JI+kiWdwxLEHPoPJN3kZhUREkH
         nMJNraoRdFyafHhIRkajXvUxWTyYXpeciGZYfQShwV0hSrd6kWewZV34diJ6eiiXVKll
         H4TjoMEZ5ylcAzqhOm+dwy/m0SY0YnUvDPuHFsqWTseE5RRhzLCpd7h+MeWTLbxMqIN0
         PZKhX6IdBAJ0UdSPIm/q9d7njqygFUthcnHrqw1Z0+YYZMqplzcPxvj4ZUTJGFGX4NOT
         MrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693887388; x=1694492188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeLpY9djXSpdgH4Ae7n5MB3zE0D3lzBJjJWuWYn4B9M=;
        b=RRvHW/WET8FGQpcYLqVN5L0SY74kVFbFGy3Hf8BV3HrfyJxz011QX8k/DEtuO/ya1G
         sevKptL/ObGPjytDfzT7WimxGXuMo7dLCpcjt1r9bAQdi0xb6CDN/gYkNwJo0DD7+r1h
         nVF+3+u7xdbVlN5PWtwS86ggS/vU8BXoOI4W/aZIoZO8WwCpBlO7TGG4x2xs5mXpnj27
         Hc3EyUcoiXaugksEJ/kHYjXLiMIsYWg3n3jfndnBAaiSfzV8ZcZusPudBkNsx8NJh3f3
         VXmbpwHGuvLlA5HCJRYiN+S1JSTnS3MNyHFIspJ57WjMmFm5H/UOqWoCg26E5ki84cBo
         aHCQ==
X-Gm-Message-State: AOJu0Yyrxt2e38kewx8wUxytUSuKKaNf/9aJ2RlePctYoxzbpGL8d79K
        pBCzRU66IjMVuTbmI/8YNh8=
X-Google-Smtp-Source: AGHT+IGHKwLSesdv+VTDY2ZVcovQ2Vrs0ifGMuVs4J32gJ4Kms/n3HDyIZqhULXtcu+bbYFqI4HShQ==
X-Received: by 2002:a17:90a:788e:b0:26d:20ef:1d32 with SMTP id x14-20020a17090a788e00b0026d20ef1d32mr8899654pjk.38.1693887387618;
        Mon, 04 Sep 2023 21:16:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a40d:5ac2:3458:cc95:7315:1247])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b002639c4f81cesm9719984pjb.3.2023.09.04.21.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:16:27 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Shubh <shubhisroking@gmail.com>
Subject: [PATCH] net: dsa: mt7530: refactor deprecated strncpy
Date:   Tue,  5 Sep 2023 09:46:14 +0530
Message-ID: <20230905041614.14272-1-shubhisroking@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Shubh <shubhisroking@gmail.com>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 035a34b50..ee19475ec 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -836,7 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
-		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
+		strscpy_pad(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
 			ETH_GSTRING_LEN);
 }
 
-- 
2.42.0

