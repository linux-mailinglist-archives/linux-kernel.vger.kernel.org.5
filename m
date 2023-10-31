Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95EC7DCADC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjJaKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjJaKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:30:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0FF1;
        Tue, 31 Oct 2023 03:30:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6bd20c30831so1307547b3a.1;
        Tue, 31 Oct 2023 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698748230; x=1699353030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qj37DKOBvq5iOgjYOiYoCEkc6gwIDyLnQahEd9fN5Z4=;
        b=nVsBGaFaWmff5DB9pQQqPsr0PrnjNcZv1Rscixe6fnQ7uzfNJPhWSQY2RHUFwOLGnU
         aBMI02zCuT/cRAbaoW0sDELai/9udefXLGwxGET7baH8xX8H3SQXU9uco171l90+HJdX
         JePKkbsYiTAw4eoE+ZBs+LtOgL0/uSP1W9L4ABlgMrnLnkPSA3hVL289rzftd3Wz5t/D
         3sNiTUnI7y8H5D/UfFbQcZsgTJrQWseQch/D3eROJX2uSAORdMNhV1INpLIp8KJEIPn5
         suIdLke+Q5azmi3AyrhqXjriJ/quKLFqRT3cUEoOrvtM8ix/fnk/lQ7gDKWo94fHC1z3
         Vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748230; x=1699353030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qj37DKOBvq5iOgjYOiYoCEkc6gwIDyLnQahEd9fN5Z4=;
        b=UHg9OplCYAz7IKR3esi4eMRF3SOx1lTIfRN6d13ata/jD19oHcFzRcrvOlud/3Ciuw
         g1rAPknZ1+BrdaByCm7CVz6m32nNExKuOK/n2w3dGeGVwzhMCZuiEdSRBfBw4JCuAv+2
         Iz7AhoRngRDkSIhJdNtJVFb11ZbLAl27nm2fP5jb5zEAI1xrKJzPRFaNLz0vX7e0R1lU
         oqggwdlDhF8St+XZoNJgq0G0w2W5OmBx6tELfWs4O3LraZ7BAVANjwXDjw0Eqh9mrTIO
         MyrlU1bA2pjDgwdxoKNbv33+Y+RMKkZK1AJi6K4frN0YQAsx1Ue1ecs/B3FO3h75gdBR
         +1rQ==
X-Gm-Message-State: AOJu0Yyv5K8xbPd+/86pEAlWwh/mWweUN4PdizELT/Uj+E/mBWDibiwo
        RSj4Ti05frQuc3QWebdfG/U=
X-Google-Smtp-Source: AGHT+IF+v0D8hOV3q7PGSZAlaU8mLwN5Iy+fxqSjmYlV72q6DrmM8ADNRUW0qbH2RRoO0jBO877UeA==
X-Received: by 2002:a05:6a00:309b:b0:6b9:7d5c:bb58 with SMTP id bh27-20020a056a00309b00b006b97d5cbb58mr11846810pfb.0.1698748229950;
        Tue, 31 Oct 2023 03:30:29 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id l1-20020a056a00140100b0069029a3196dsm956395pfu.184.2023.10.31.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 03:30:29 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, andriy.shevchenko@linux.intel.com,
        claudiu.beznea@microchip.com, robh@kernel.org,
        dario.binacchi@amarulasolutions.com
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3] ti: fix possible memory leak in _ti_omap4_clkctrl_setup()
Date:   Tue, 31 Oct 2023 18:30:10 +0800
Message-Id: <20231031103010.23792-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrndup() and kstrdup_and_replace() in clkctrl_get_name() can perform
dynamic memory allocation. So clkctrl_name needs to be freed when
provider->clkdm_name is NULL.

Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---

	 v2 and v3: fix commit info.

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

