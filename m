Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA075E45F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGWTIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGWTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3631E64;
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so34110915e9.2;
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139285; x=1690744085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTMQVQh48oncaObvCwMPfvKa0bWzXZnBK799pHg2Dv0=;
        b=bCiMZktGad9BSboHOC65EBv2cGtO7o93KwBe3/7kTNjYRnrcrQH+c9Z2PKKuxBeN3M
         nmKZHzmHVqbv5CUrXiN61FYYGeRxZGHXFvjWVtInpJvCbqEOoh7sgaHM+VnjZM23sfGj
         uSye6FBC0Ur4gbBSWfwaMShh1ipioZPf2Vy/q76t8OSdWz4tyumkdZoYPZJfUQqUivDi
         a6r65ZwKuWYuPPaTc9Bp/NLSSz81RcusgpuGF9EzfaFZdPoOPGHX42QQK19uyJtcBNd3
         IttBU2yceUrvzY6pge0FolGG4WXJr7P7jvcX7tg8tdSVhPDnl1emmd71NAXYcYhmc2tQ
         dNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139285; x=1690744085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTMQVQh48oncaObvCwMPfvKa0bWzXZnBK799pHg2Dv0=;
        b=Xor49jaSUZK4lMuD6qsc16I4InlEwWqtoZraU++5MgeP0C+d5RC2yZOAQW5i22lBCi
         jHStiQc1dd69IWcEijIp1BtGq0PjQLXKhg9M6xGc9zlzmllyEmIuys/VAb6n16/LaTA3
         eBon7Pb/9pN4k5RJUcLqLuweKhp6iGQI01JPGazSLqDCnGlabXcHUuoDRf74W/Sm4boQ
         tjlLm2baTRI00peCbBs+KFZ+J7LWXmE3LIn/ufv/DaObN6OuT0/UyKMsGTmAtnccxlJW
         HGLHTTBjeaCaKksaUicf2yJQxi8RoGZ3et4cSRI3nW7EV40mcLIOTkdNCdYjVmjX0N8u
         OU5w==
X-Gm-Message-State: ABy/qLYmnWciDhxbAbw7c6o7q+pFZKKvc9h1PBjOxaAzja8YaiG59J4J
        gTnFhLmj/VTgpRu8mCHDBFd138CpqYM=
X-Google-Smtp-Source: APBJJlGXt9j47otiy1K2DcM5J5hDiWrm7wM7aVR+zKsxvs+1wLmy0GncLeRkQojl75zJTqyTAI+UAg==
X-Received: by 2002:a05:600c:2990:b0:3f5:146a:c79d with SMTP id r16-20020a05600c299000b003f5146ac79dmr6548215wmd.15.1690139285300;
        Sun, 23 Jul 2023 12:08:05 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:05 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/7] soc: qcom: socinfo: Add SoC ID for SM7125
Date:   Sun, 23 Jul 2023 21:05:05 +0200
Message-ID: <20230723190725.1619193-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID entry for Qualcomm SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..785b88e2da54 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -371,6 +371,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA429W) },
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(QCM2290) },
+	{ qcom_board_id(SM7125) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(IPQ5010) },
 	{ qcom_board_id(IPQ5018) },
-- 
2.41.0

