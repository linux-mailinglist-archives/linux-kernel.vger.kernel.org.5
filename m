Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875075E378
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGWQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGWQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CB2691;
        Sun, 23 Jul 2023 09:10:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so623353566b.2;
        Sun, 23 Jul 2023 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128569; x=1690733369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUcwhA8G7S1cIbVU/vc9FW2erMBFb+FEatJ9nSLfdYU=;
        b=PkvzZSyZVg6CQ+77fjkN2hXwOvJsXtdCIUgIHt7L3wAqueyqX942toBG0VhpswJJ+k
         4hvaoOXNaIZIkFJ0S5WTQAzxJU3ALlVHXYUaSg6QwdPGDstmifXxL25c62TToOo57lJL
         +mPIapiUQaMAVxOeymWUtg2NZTyjBxwhAcPG0pUGbaDaCoSSCMDUWqo1XTvBemxmwSlr
         QC/Gc+MgdUdmJYq1ss2jPPEYcD7TFRxoOZeKHPZHME7IeHb/nUGm11gdN1F8RUwD0Yib
         jciUjQJCeLHpeW2D7kxw7XNhuxjZw+PIeIr0nLyPn6gK3h2YQPvwBTYNXwgFq4NKlXqY
         op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128569; x=1690733369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUcwhA8G7S1cIbVU/vc9FW2erMBFb+FEatJ9nSLfdYU=;
        b=XSXbB4xPXIZdv4MOzOapOscn9UXV6nfI+oaHhL8TU4NFKkf/FwAIVJ/rPEjOal5q7q
         eQ4thua3ezEl8l0a5kXhEhAViyDpInN/itYDxwz+WxiWD1VTdXIZriRmYVewFx4yN8vn
         Py7OKxM+EgDnKVsGhyrMXLzVzAMkU1Vi2q005AMF0X4V8Zr+vk1u7+l2J1ZPtbwi8tDE
         MjfTn16KnmHwA00LFOpiyz4Arxk29A3ZCtPAp8lm5/fw9GWnwamy+hUtTDcgjqFKP+CI
         8qT8Z9tVq76QfQK1OZZfIJT9v0du6hkA05CvKWY/IVe5curlWXrlPCbUWFQLb5cSb+XW
         pa2w==
X-Gm-Message-State: ABy/qLarzyZAiCvw9Qy++RgB6W/1mseWq6wgn22BjOOio/9HhAWNBvIJ
        Eb/2ExEGWicgbF/3MqRIZK2/Nx9pIIE=
X-Google-Smtp-Source: APBJJlHweXuChCIL+PlGEKZWCfU1vLl00hMo2Xl0zRldJtqeXjAaRL8qtsqZrUif2jCqBrlUXccGFg==
X-Received: by 2002:a17:906:8a68:b0:993:f996:52d2 with SMTP id hy8-20020a1709068a6800b00993f99652d2mr8122020ejc.20.1690128568780;
        Sun, 23 Jul 2023 09:09:28 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:28 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
Date:   Sun, 23 Jul 2023 18:08:23 +0200
Message-Id: <20230723160827.22660-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723160827.22660-1-a39.skl@gmail.com>
References: <20230723160827.22660-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MSM8976 HFPLL compatibles.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
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
2.25.1

