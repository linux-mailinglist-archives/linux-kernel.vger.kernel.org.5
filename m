Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E367AB92B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjIVS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:28:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2BCA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:28:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so2104095b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1695407303; x=1696012103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw3faLr6JrKkgEvs+aliRfwvgQoP/liBpAuWtI3CE6o=;
        b=Wk8rVXvq99Tm2dqw8XG0mfraKIIlXSx1pHu7Cdu0/SGQSgs0ArDahroxgqKm+KoImz
         p4kw+bWzEiomnxXmQgqyjFetcUQj7SnCKwQuwWZR9TBy60zK2oT7lvlp9p0D4z26G3KN
         7W/+dQ55ePJaMUZS2po4I2H4dZft/BT7HMqPgiSALiMPrFRTeTPXOGeZ/Dw2U0vUj+DC
         yqDygww/jGTr9aHWVXCBvRRZJOnbBaeABvKQo9KMZN+1kJI1ZI5bcd/FYiLsPlvc39aq
         vn3yy+YaTuUhwkcE8Lpzg0TBvJJFkzpZBYUGzDjVawxzR3hR7lAQaMSdUld1lIumiu/w
         DZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407303; x=1696012103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw3faLr6JrKkgEvs+aliRfwvgQoP/liBpAuWtI3CE6o=;
        b=pd5BIWQO5ktPxrDGd40yo86JIiGI8h+3Zv9bM2bFpa4HW9WfRi+OzPcDMAwy2A9DCp
         5eHwrgZgkfzNxP+k70oQs60G4OOufWMlN7+aATNQv/lZKDA7//rtNFXLuO8AnuahhVga
         RbTEPu82L+PiF+sA7Ucc2Ka+5a7ntFDVFY0iGqT/Ms8YXQplgWvAL7vA7+5h36r2mzcU
         XGDANjU/U3VUiqKICGJzLn6tbNu2vCCj5DL6hHSooPVzgvp/F0r25iHU4Y6Mn/0xQMJ1
         C/tcIqijltlc15o+fojxnFgPH2AIflirj7FJtsbgCD6rF6vJ4wk16hl3zAf0ujuF6/dI
         p59g==
X-Gm-Message-State: AOJu0YyXlmnw1+A3zR6QnQP5/rj0fLkRiDeJglOaQnH9myZMrbHnEYyy
        A+wUUjpE+L0eqbivzALIRuFJYA==
X-Google-Smtp-Source: AGHT+IFn0nXh5YkZnmOJjPC7EVOVti34ysa7XbjXODjpleMIHxTaQee6eaOKsLnJ4Y0yUAVnYpXjIQ==
X-Received: by 2002:a05:6a20:d406:b0:14c:c393:402d with SMTP id il6-20020a056a20d40600b0014cc393402dmr367890pzb.34.1695407303487;
        Fri, 22 Sep 2023 11:28:23 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:8efe:adee:187a:8f0e])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm3525816pfb.43.2023.09.22.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:28:22 -0700 (PDT)
From:   "William A. Kennington III" <william@wkennington.com>
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        broonie@kernel.org, joel@jms.id.au
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
Date:   Fri, 22 Sep 2023 11:28:12 -0700
Message-ID: <20230922182812.2728066-1-william@wkennington.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to use the value of ilog2(0) as dummy.buswidth is 0 when
dummy.nbytes is 0. Since we have no dummy bytes, we don't need to
configure the dummy byte bits per clock register value anyway.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/spi/spi-npcm-fiu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 0ca21ff0e9cc..e42248519688 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -353,8 +353,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 		uma_cfg |= ilog2(op->cmd.buswidth);
 		uma_cfg |= ilog2(op->addr.buswidth)
 			<< NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
-		uma_cfg |= ilog2(op->dummy.buswidth)
-			<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
+		if (op->dummy.nbytes)
+			uma_cfg |= ilog2(op->dummy.buswidth)
+				<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
 		uma_cfg |= ilog2(op->data.buswidth)
 			<< NPCM_FIU_UMA_CFG_RDBPCK_SHIFT;
 		uma_cfg |= op->dummy.nbytes << NPCM_FIU_UMA_CFG_DBSIZ_SHIFT;
-- 
2.42.0.515.g380fc7ccd1-goog

