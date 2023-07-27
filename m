Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E276578E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjG0P06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjG0P0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97231FF2;
        Thu, 27 Jul 2023 08:26:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso12229525e9.1;
        Thu, 27 Jul 2023 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471608; x=1691076408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5lUd6tLllXoqVN95rU12GI/kHjXVOUk+BNB7Y22cto=;
        b=FjsdD+F62OVFGK0evuFmUjv+fYHflFxnl7eTSOLR+NXfZROQ34Eou4GPvtFmLGiJwb
         Ks70ALf537BmtGdLK4EB7Ufr6+Zu+b7jPbyo7IxuK8/NfIgkhA0/5j32Px3PuRN2Wh6q
         Hmb8OtMzEH6euQFvszszXZ4erEJb5h/YmVrCJz1Z6DFjIxsFOHZOIWEmHAuybBNDPEPX
         hX4cF2DoQ8xxqWjap1trw7ZrA5q0tocGUEiXVaT1VPUh1dZa2FQscPW0BTp3oPSbD9Dz
         cvcBp+Qy0PZuq61ANQpoT6/cMDmAzmzNLo/SZp73vZqmOgM00VaYyqjdUIdN6c7IqeML
         R10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471608; x=1691076408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5lUd6tLllXoqVN95rU12GI/kHjXVOUk+BNB7Y22cto=;
        b=KjqA72P0/eF2AFM0NWZ+0x4rxBsLi14R3qrEqlh56mZhvVhx/qf5RYfHl+cs+wFclu
         4d9ILcW6UAZJNWUssCn5vltQjuifni5LP2gegeQskW1sQry54WabNMFprfit315i99Cz
         nmilhEKICo+I+oFHu2oG9bRTeO9ImBHULrsGpkQOQ6SQ/60Xwo+gYAc+nK2GEBJOIYbM
         zTLpbWbomb3W407Cpy54awtjfmJSUBx5NbdB5sTEYupjuD6j2tHyMO9bAEBS5HZChOzQ
         yi0DCzUxndCupjCRPrqI/DyfPHqylB1PWVLr+0QXbbgFxPO5qHahf/NNyzLS+MoeITon
         7Byw==
X-Gm-Message-State: ABy/qLbyOgrJNo8Rc0UYK/keKcb0J85IBe+MvmJ04pLO8iMA+TIL8CRA
        wTb6bld8hUOnViABjH+7D2I=
X-Google-Smtp-Source: APBJJlFjGqSrbh0oMoihKOPYd1QdUFuycfFOnzva1CI7AXyNbgeXj1ldzIMEDsOHkjausLac9x92sQ==
X-Received: by 2002:a05:600c:ac1:b0:3fb:a100:2581 with SMTP id c1-20020a05600c0ac100b003fba1002581mr2186582wmr.14.1690471607767;
        Thu, 27 Jul 2023 08:26:47 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:47 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:37 +0200
Subject: [PATCH 2/6] mfd: rk8xx: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-2-c8edb27bf404@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
In-Reply-To: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Specify the implemented restart handler as a cold one.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/mfd/rk8xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index e8fc9e2ab1d0..15e8e6a9943a 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -697,7 +697,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		case RK809_ID:
 		case RK817_ID:
 			ret = devm_register_sys_off_handler(dev,
-							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
+							    SYS_OFF_MODE_RESTART_COLD,
+							    SYS_OFF_PRIO_HIGH,
 							    &rk808_restart, rk808);
 			if (ret)
 				dev_warn(dev, "failed to register rst handler, %d\n", ret);

-- 
2.34.1

