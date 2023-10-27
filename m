Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3A7D8D44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbjJ0CvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:51:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84349CA;
        Thu, 26 Oct 2023 19:51:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1ca3c63d7f0so2861165ad.1;
        Thu, 26 Oct 2023 19:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698375074; x=1698979874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwGrPcEsgflO09HAy5rdI9eLTEVTJiCucDlbX44V91o=;
        b=J/LFoEm9IdBFsHESIa86vrjGvP9DzQQIDomJWdOx9GHR+YXkk3DMsN9JuCWJVSa+Tp
         B9S5OGtsKFLqxCnBsL56VL60fGkPQLC740AUhZZw8SIHH1+ED3d5zYDXYpVS3dBhUu1K
         A9Xnuss0pNiOtNcVTeUcmDK80zoGbJtyrZSFPgG7g6c7iXzD9dBtCtMS/PdmD+Hce/ve
         EgxI6SxtixaXXTRWv+WI3UPs8j1YSDOzqFnG8ELVSTiKyOSC3QqinWl87WsJoZJE3svZ
         S6EsKoJx9DN3UydekiCH15tD2h6f6XZ5wziZ2hx5Ziln3X8YO+jzHOrcM6K2aebSdzAv
         pLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375074; x=1698979874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwGrPcEsgflO09HAy5rdI9eLTEVTJiCucDlbX44V91o=;
        b=qrewUS9Mcp7D0eNrMWwha46/lMZdU/+uhsyq6LidUbmI2WVO0REVuB1SkFIPOxbTxL
         r7bneqX/XGMiuAxNnYbZkXGUHyhQJ6fenzfs8HdV6iBUbFUDxAmzUWrzUv8SwFG0q8vH
         3MXKsm5K8rgRCwbaOCFyH921HnBSU4Z1FSgcjSe69euHZeQc7Vp7al3F/EbW1lUYZOHT
         9KW6S+dBkZd844k/jGR/1foRZsDaWQ3GctXqocBJ+i5mW3NSPDhvfPB8VijslbeOzika
         lr6PPMDFzGd6oAyFozaTzYH9QQR9U5+6V0ZBNXJTW69E3dYzkbe4LVEs/6gO+aoSqqgv
         mVnA==
X-Gm-Message-State: AOJu0YwnImr2MP5pIqcRdlHq0e4p5I4/k3oHabboI+6oTGvgWfQ+6Pt6
        iHlsjVTgAJAZP35hbkRduZU=
X-Google-Smtp-Source: AGHT+IG9Dmz0BzSlr6ni6jNSm45meUAq0sYl4SNSSDX74yGa+mJ5eeHfKMxB6gMgNJkdcEuxgVfkDA==
X-Received: by 2002:a17:902:d485:b0:1ca:858d:5bef with SMTP id c5-20020a170902d48500b001ca858d5befmr1401151plg.4.1698375073920;
        Thu, 26 Oct 2023 19:51:13 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b001c3be750900sm377882pls.163.2023.10.26.19.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 19:51:13 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, dario.binacchi@amarulasolutions.com,
        claudiu.beznea@microchip.com, robh@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] ti: fix possible memory leak in _ti_omap4_clkctrl_setup()
Date:   Fri, 27 Oct 2023 10:50:57 +0800
Message-Id: <20231027025057.11510-1-hbh25y@gmail.com>
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

kstrndup() and kstrdup_and_replace() in clkctrl_get_name() can perform
dynamic memory allocation. So clkctrl_name() needs to be freed when
provider->clkdm_name is NULL.

Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

	v2: fix commit info.

 drivers/clk/ti/clkctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 607e34d8e289..cb4aa8a45bb2 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -591,6 +591,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		provider->clkdm_name = kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
 		if (!provider->clkdm_name) {
+			kfree(clkctrl_name);
 			kfree(provider);
 			return;
 		}
-- 
2.34.1

