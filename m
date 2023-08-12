Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB0779FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjHLL1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbjHLL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5F10C0;
        Sat, 12 Aug 2023 04:27:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe44955decso3224244e87.1;
        Sat, 12 Aug 2023 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839632; x=1692444432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU55BRi9jqkommNEXyQaNiy0A+qH53L90d7/C677RoI=;
        b=kbidcN+F6qMPvbd7FUAzY6AV74Q3DgkuPDtjtoLgxSJCrxTF5uqDwpowunBv9u1V9b
         teEN8m+GyYqUhIb6NGg34T5IK72TFptKIJhOoFlVNlAOwxbHmZMAeoj6ZS5eDjzRYi6f
         vYuKsoUeNUY56ew14RHH1zPRQeaYKgdm/HQVkHNCvw2ywMjCTkb7/+LX46znXkSm9kiM
         SD6uCoEeF/UcEpKel6cW4UcoNYoco3oTka9wnC8+QGM37uQnA0//Kcl6vF3H/+kRiAAF
         nXZGMvEpRPleZWji1k4ulpBmwJP3ZpEZQIUFFdDjA4s3JQ4nnBcpen6Y6A1VABoIPOqx
         1mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839632; x=1692444432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU55BRi9jqkommNEXyQaNiy0A+qH53L90d7/C677RoI=;
        b=Ifkt0gq1b/2oK6Dc/+kPCGxR53s98L5HaWSbby9yCxDyaaPtfbmUw+rt7IO13X3KeT
         ozt2PvwzWyjAq04zWYobmAvQcbtQFC6pd+ko1OeDcassa2nSGR7iDj82z29B7qCzWL84
         dCXEyrqub7w1tcVmWMFkd8wjTKXQSQHriNR8jVC3kn/dFteUnJM6tyUosxgEEZsNOm3M
         J5afAfHHAGd8UfKhQNAtRwU23tsQSO7UDZ5G17/eb/n/DA+cFzlBDgispPpTnWCzwnUP
         JyHAOUS3Ej3Sf6743AaM2u1B/e0M1TPzWg0pOd6SlwsjlOaxN9kvJM3PqgBKW/FofDp2
         Z0yQ==
X-Gm-Message-State: AOJu0Yz/x2Mg6nIXLowMvNyqTiycJ4GvZWogYQGE5qRvsq8tee+QgEpG
        3DjUdw1HyR8VCNFSTiDg71uwH2f1WvQZ8Q==
X-Google-Smtp-Source: AGHT+IHkUlAyw1EbQzTXAy0OSQppQrYg0ktAyVbdXb7k0R23U77+wAa9Q1IqiIIcHhdSvoHKJxg7OA==
X-Received: by 2002:a05:6512:398d:b0:4f7:6404:4638 with SMTP id j13-20020a056512398d00b004f764044638mr1633448lfu.17.1691839631999;
        Sat, 12 Aug 2023 04:27:11 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:11 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/7] dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
Date:   Sat, 12 Aug 2023 13:24:47 +0200
Message-Id: <20230812112534.8610-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MSM8976 HFPLL compatibles.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,hfpll.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
index ec02a024424c..5769cbbe76be 100644
--- a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
@@ -12,6 +12,9 @@ PROPERTIES
                         "qcom,hfpll-apq8064", "qcom,hfpll"
                         "qcom,hfpll-msm8974", "qcom,hfpll"
                         "qcom,hfpll-msm8960", "qcom,hfpll"
+                        "qcom,msm8976-hfpll-a53", "qcom,hfpll"
+                        "qcom,msm8976-hfpll-a72", "qcom,hfpll"
+                        "qcom,msm8976-hfpll-cci", "qcom,hfpll"
 
 - reg:
 	Usage: required
-- 
2.41.0

