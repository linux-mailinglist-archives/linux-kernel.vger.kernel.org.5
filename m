Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E088777AF45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHNB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHNB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:57:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2502E54
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:57:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdc8081147so9497685ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google; t=1691978268; x=1692583068;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fm0TMFuin2nVJfOQii6CnvygCyjrjgFJg/XJLKguZo=;
        b=ZUNThFEc4hgiZaUjyd8Ng0rAQRmVrOU1J3UM0O/irEV1cAfKgZ9L2xQrkCNbkPqco/
         GD7DN6xw3u9NEiUald7qGlFEN01Ui6hMev8K6YiHbPU3v85rBYk+X838IwXmA/+0n4ZD
         sXbblx5T/kC8qYb27xgZ/U3v44EKRdOSz1+ZNaGbWa1gNud+f379ZyvlBbzsL38xCPxB
         +AWmHYQEUPqfwTOdLIcx3JkreVae7OqvVTSm3leB+ZQazPPxQQnPcPc99Cbs9nHXwkWU
         2nuJ5qgjFQJWHOj2FaRSf6oed4HJs3vEprYA8EQFHL/aL42MNUkJpeWTv+ucE2Aqm9yo
         2m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691978268; x=1692583068;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fm0TMFuin2nVJfOQii6CnvygCyjrjgFJg/XJLKguZo=;
        b=dugo4Q1ylcaiZYJyQWhR28U6wL3yY4VIWcUpLKsKus9QGpdu58Ajv1eujYjH1RwXdY
         TJbQWJzWUJWsaB29jx2OnByZFQ/mlZDePK5n4stu8p/XDHxRF/srYZTg0SF+iU51uml9
         XYnr2OhGSKYQuNmFCpF2YAF992mNr6v2wB2xGE0XKIPTZVFAcdvGH9CxlPzcxQlV0yid
         3ZqyUj+QKNKSvv2K+xiVUL7a5o+cfG6X6DPl0a3VlCiHU7ReAjYlpNCMOOdXWXgO0uyt
         zd0wObNpPcmKvgZtl6CRRrUJrQi8wiy/GwWDIjyoiredvf+neXaUNFRk9DuJdXD/kLxU
         Sp8Q==
X-Gm-Message-State: AOJu0YwwmwkOshZfrD9qOUfbaCQ/3zBfz9ovpBJdRAfZgDd311e1zRSa
        rKeUt7HqV7tjVBlYWsANUrz1mdldcHB8CYWo+H3w1Q==
X-Google-Smtp-Source: AGHT+IEJinrn2EOXiV+zlg4ANTeH8wmIIGKRxUmU/utFcxV4Fazdo6/ncbR/oBUBoXy8N3TArk86AA==
X-Received: by 2002:a17:902:e846:b0:1bd:ea18:925d with SMTP id t6-20020a170902e84600b001bdea18925dmr462959plg.6.1691978268264;
        Sun, 13 Aug 2023 18:57:48 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-32.751444.bne.nbn.aussiebb.net. [117.20.68.32])
        by smtp.gmail.com with UTF8SMTPSA id jc3-20020a17090325c300b001b86492d724sm8075352plb.223.2023.08.13.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 18:57:47 -0700 (PDT)
Date:   Mon, 14 Aug 2023 01:57:00 +0000
Message-Id: <20230814015700.70156-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] soc: imx8m: Enable OCOTP clock for imx8mm before reading registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

Commit 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
register") added configuration to enable the OCOTP clock before
attempting to read from the associated registers.

This same kexec issue is present with the imx8m SoCs that use the
imx8mm_soc_uid function (e.g. imx8mp). This requires the imx8mm_soc_uid
function to configure the OCOTP clock before accessing the associated
registers. This change implements the same clock enable functionality
that is present in the imx8mq_soc_revision function for the
imx8mm_soc_uid function.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/soc/imx/soc-imx8m.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 1dcd243df5..ec87d9d878 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -100,6 +100,7 @@ static void __init imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
 	struct device_node *np;
+	struct clk *clk;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
@@ -109,11 +110,20 @@ static void __init imx8mm_soc_uid(void)
 
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
+	clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(clk)) {
+		WARN_ON(IS_ERR(clk));
+		return;
+	}
+
+	clk_prepare_enable(clk);
 
 	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 	iounmap(ocotp_base);
 	of_node_put(np);
 }
---
2.40.1
