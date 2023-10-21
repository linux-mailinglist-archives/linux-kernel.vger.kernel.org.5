Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5167D1F8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjJUUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:34:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EEBD6;
        Sat, 21 Oct 2023 13:34:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c603e235d1so296040266b.3;
        Sat, 21 Oct 2023 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697920448; x=1698525248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tmj+Q+dO8iYyZQ2rWjEl3KiKAAEvOCc0F8gmRd/LTk=;
        b=hKCqf8LUh5htUnKwKlm4+2yDG4YDsJbW75onGu6uj0BiDgmquVf7PvH8rORLl8ENWO
         72h7CWXW0g8DWdfTcRNk7yCeBw+ph8UyxGy38qGLD0xGPzsxT8lGNqOJBbHFzoqsTQ1v
         hbL3n2JE9aWh1JNglS4Byb9dGiH/Xbvb+veXUeM00ODmLQkB69uCb0kox3LKMrlyv9v2
         VSL0xKf8+rl7pQldciH1m1woDdil8po9PUuzaYg7r0H0HAEdzj4elxFmmv744tT9ePM6
         KOdLpVaYxJnQhaNueNTqiaxqwvoJ3tHiKA27oqelVpogMWEoOp1oTYBFnXETlnGkMENw
         AlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697920448; x=1698525248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Tmj+Q+dO8iYyZQ2rWjEl3KiKAAEvOCc0F8gmRd/LTk=;
        b=YZRk9unvys0b4EEVmp1q70CKE0525oX0IEqB8rcFiVf8eOfx2bYPZnorfS1czi/4TE
         NsjJ2HqwxgJdIlm8HJushivoDE5zVlOZAAt9eR2WeAZgsXk0IL1zgpUShF9QrEpH2QIp
         akucAH+2380t29nVlPHd01Voy1KERcfN+O8NUjRlIyWpgW4PFbW+WOcZ00jjKdsax7ba
         hw1AUkyl4XAqs1LVfM1N8HDbURaRfWm6WZjqS7wPqOTiU2QionUQOCQElCI1IB5puNT4
         qNkbn2Fm1TkNyl2SL85LTvfiPnompNJzoEdtqfcGEnN8qyKVsLsraZw6FeUt35TtGHXc
         pKEA==
X-Gm-Message-State: AOJu0YylXKQy5DWjU/eNsnjm17Azf91zYkPpf1UpAnRzIdfKwO5bSs5p
        ioSvXMPnuC1axF9BK7oYYyI=
X-Google-Smtp-Source: AGHT+IEjNJkoNjeazjRD49G3ATl6rQ4VPkS5PLB9hkxJo288Gkap4PRpVs505D4/aB/cYAyKiyIdLw==
X-Received: by 2002:a17:907:d8b:b0:9bf:7ae7:fd6c with SMTP id go11-20020a1709070d8b00b009bf7ae7fd6cmr3681709ejc.10.1697920447766;
        Sat, 21 Oct 2023 13:34:07 -0700 (PDT)
Received: from localhost.localdomain ([145.224.104.33])
        by smtp.gmail.com with ESMTPSA id w21-20020a170907271500b009ad81554c1bsm4040198ejk.55.2023.10.21.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 13:34:07 -0700 (PDT)
From:   Luka Panio <lukapanio@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Luka Panio <lukapanio@gmail.com>
Subject: [PATCH v5 1/2] From: Luka Panio <lukapanio@gmail.com>
Date:   Sat, 21 Oct 2023 22:34:02 +0200
Message-ID: <20231021203403.215023-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.42.0
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

dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)

Add a compatible for Xiaomi Pad 6.

Signed-off-by: Luka Panio <lukapanio@gmail.com>

---
Update commit message
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..1bfae1b237d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -965,6 +965,7 @@ properties:
               - sony,pdx203-generic
               - sony,pdx206-generic
               - xiaomi,elish
+              - xiaomi,pipa
           - const: qcom,sm8250
 
       - items:
-- 
2.42.0

