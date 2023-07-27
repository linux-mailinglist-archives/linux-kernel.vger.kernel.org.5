Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12FB765797
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjG0P1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjG0P0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD61FEC;
        Thu, 27 Jul 2023 08:26:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso16516681fa.1;
        Thu, 27 Jul 2023 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471609; x=1691076409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdSNTdHfu3gmfnNmRZ2hSNcbvNs2kLgKcLc95quFvnE=;
        b=Ot63R368iSKukEqX+qAC4oDZKw7GhuAcTMUwho6PAJxiZPK18ngo6jwMnRNjiuzviz
         gkNNylRKqi6X9L757EsPpYKtFQbb+RisWEfUA7RsDkNumkHgzLUMmqFLAHr3lKvhDSwK
         8PV4j7sGqydTylHtyOuW4gSPtQA2vrTCKNIKIYvCxERNkgGIj0YZBYvAtZgmqR49kRpu
         zFs6RIg1CIIzvsIpWz9XGwByufeeGFj0TxgY/irWUd3jqAt2Oq3Y1V58/Oe2h2e/Jhgw
         v2Lr2YfuiySrvgVuQlpMUK9oe7nguXRcd27XtW6kfzZBJwE5OgkWmCXgcpt+DJrRVsha
         AlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471609; x=1691076409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdSNTdHfu3gmfnNmRZ2hSNcbvNs2kLgKcLc95quFvnE=;
        b=eZafKpHztt883cNJSapLYwJPKb4jb6YuijerDHWUQKEep+zHi1LF60auiLjiDF6x6i
         OPG5Gz6seYUVKeR/3VE0dXH1VNY2whJlOiCmEqM20BK7KS4hBYZysmNAtfK7tj4fAM7e
         GOfDKZ54AJqN48YY32jSZt+RJvdSu5BIScB1PxURneNvcrpiPh/lRtAECwy3eND1i+Jo
         L741sUPUFesQm2RKbv1DBMY0Lqhnl1nDAhVbuKax6YZbTLzsx2lRcGVW0OYbK2C0oWt3
         huHyGB4cg54COmZEUYoX/W9rKzpi33x6VFrc+dwsydJrlrqNnqZRqv92xC2y8sv15AyK
         +lKw==
X-Gm-Message-State: ABy/qLb0QAiQeJTCOiiglxXyBKsVuIbn/AISvwa5yXICWy5qCD7BzrAh
        JQPI7OqYKJsl5d+bjgDrGJjZATqU1bi9xaKX
X-Google-Smtp-Source: APBJJlECjtY232aDHswklrgmAPFnRUY97te2qhkbwXkITkFGmWaf+ews7rGxaiPlP3xdW7gRsnxVOg==
X-Received: by 2002:a05:6512:3c86:b0:4f8:7568:e94b with SMTP id h6-20020a0565123c8600b004f87568e94bmr2351473lfv.56.1690471609243;
        Thu, 27 Jul 2023 08:26:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:49 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:39 +0200
Subject: [PATCH 4/6] mfd: tps65219: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-4-c8edb27bf404@skidata.com>
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

As the tps65219 supports both, a cold and a warm reset, register a cold
and a warm restart handler.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/mfd/tps65219.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e0c42e4fdfc..85752b93256e 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -278,12 +278,21 @@ static int tps65219_probe(struct i2c_client *client)
 		}
 	}
 
-	ret = devm_register_restart_handler(tps->dev,
-					    tps65219_restart_handler,
-					    tps);
+	ret = devm_register_cold_restart_handler(tps->dev,
+						 tps65219_restart_handler,
+						 tps);
 
 	if (ret) {
-		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
+		dev_err(tps->dev, "cannot register cold restart handler, %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_register_warm_restart_handler(tps->dev,
+						 tps65219_restart_handler,
+						 tps);
+
+	if (ret) {
+		dev_err(tps->dev, "cannot register warm restart handler, %d\n", ret);
 		return ret;
 	}
 

-- 
2.34.1

