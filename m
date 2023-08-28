Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D378AA0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjH1KSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjH1KSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:18:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D85C6;
        Mon, 28 Aug 2023 03:18:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-400e8ca7e38so25875875e9.3;
        Mon, 28 Aug 2023 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217886; x=1693822686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CeZBtWQaJUN6ZOGBoOnH558TFF2EUag60T17Wp9Kg4M=;
        b=Vs8QHefx/RWpAkKrxleoTCuMbFc/uAGM+iQu5RyJo7hteyEQolfGpUZsZJQ+fQD/sk
         IVi5kqxICnYYpKflJyeC6VwO6Pdp1+seovJbejJ6ME6vv48YEDnxgfruXCr4S9Gv3E9j
         0wwu0BX60HriSq/ShMnqgWG27zes2bNgtURPYo0nfXnDuKugv/9GOO71BpIcl/L0/NSV
         K50TH0gJhoqfZLnOBzmVlCwN6p/1yyH+ZB/t812TJhals2Dcq38DqIhj4OaCcm/Vwtd1
         4TbJyp9cuqC+WT7tgpMkJpSuzpr+EDZqcxuYCg32BwBUFM1BJqh2cWXg0haWlVAbw1bh
         QrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217886; x=1693822686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeZBtWQaJUN6ZOGBoOnH558TFF2EUag60T17Wp9Kg4M=;
        b=Un6zB3uYXN+ci1JObCjzw4nUll58bBctcjO1aDcQNuA8EbZVIszsiwK2p66bOiLIkd
         qWLSZsOQUilYHVSLkR/91U/8VM3itY0NwIewyvyfdzqvsdgolMz+JaQ6lmbFsRhqYYqk
         d6CtRJUtUWWjzJXMeVs7hXt5EhE4RJj/JGoUm9TlLiKIWXjQdewEe+QyTRZj0svjnM0x
         sMwvI59X2nvp8MV5YGzZwtvnY9knd/fOT6cD0/5VuadiUEjYlgWdWW4Wy3i6mgGTce66
         ko7ErIQ7CpG3PPvCdbPLc4sIb7x3KcJwl9D4AbYoxSEudCPy6ABNsOTz3bVYq6E6Df7t
         GIzA==
X-Gm-Message-State: AOJu0Ywogepn3tEUsMB5y3LeHlz5bTP+LLQ+hTWRyV03/UIK9JDrPWMa
        r6T1s95ScziqdSpiLBffGxaOaFETSfM=
X-Google-Smtp-Source: AGHT+IHlR7naiZ50D4GZfiqE7+hS4xiSzN++QiIM+EM1E63Np0zIERMFSvy1wgM39uNwGoEott1LWw==
X-Received: by 2002:a1c:771a:0:b0:401:bdf9:c336 with SMTP id t26-20020a1c771a000000b00401bdf9c336mr4871176wmi.27.1693217885966;
        Mon, 28 Aug 2023 03:18:05 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003fefca26c72sm10374554wmm.23.2023.08.28.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:18:05 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     alex@shruggie.ro, herbert@gondor.apana.org.au, olivia@selenic.com,
        daire.mcnamara@microchip.com, conor.dooley@microchip.com,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] char: hw_random: mpfs-rng: removed unneeded call to platform_set_drvdata()
Date:   Mon, 28 Aug 2023 13:17:57 +0300
Message-Id: <20230828101757.9724-1-aboutphysycs@gmail.com>
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/char/hw_random/mpfs-rng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_random/mpfs-rng.c
index c6972734ae62..0994024daa70 100644
--- a/drivers/char/hw_random/mpfs-rng.c
+++ b/drivers/char/hw_random/mpfs-rng.c
@@ -79,8 +79,6 @@ static int mpfs_rng_probe(struct platform_device *pdev)
 	rng_priv->rng.read = mpfs_rng_read;
 	rng_priv->rng.name = pdev->name;
 
-	platform_set_drvdata(pdev, rng_priv);
-
 	ret = devm_hwrng_register(&pdev->dev, &rng_priv->rng);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register MPFS hwrng\n");
-- 
2.34.1

