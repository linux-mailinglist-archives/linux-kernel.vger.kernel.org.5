Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2209B7F938B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKZPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjKZPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:47:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F111BCC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a03a900956dso654602666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013615; x=1701618415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ZptptuvFLM3UckOpdhtM6b2Gb9AhuhmBdl+FUGxy4=;
        b=qCjEHyBNCRjaooKgEnWoctUnHXgMYZn79Rnauk2Yqesv3GG2CE9CzlZhZKIhjc/2kN
         +0CV9OYADwLTSAteBoVq3qTh5l0mbSYZuUdTWoJyIrK8mHHbYfkBzoniTFaW3vLFH9Tv
         O+DwrmtANk8jW8n5tsp5ArcsK2W/oGXk1k9t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013615; x=1701618415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ZptptuvFLM3UckOpdhtM6b2Gb9AhuhmBdl+FUGxy4=;
        b=gyHifA0MulUqOw9w0u3PGHENcCwntpsPhIuGzjJXm7rz5+t6otOHsM2qICqKEK7MfK
         BpylRD/gK/m8UIYNaUxQVC5O9fk/inNRzd5TxSQ7yUWsrHmzPbNBa23AL1YmNxwP1XqD
         CO2GzmwVWmmy0gmh3H6d0s7upsLHTh+b1EQs9ObmqX9fJRrsbtdr3Cx8B/5Rz4p6VbDY
         /AWS01+rGmm3kwctbRcQMgL2s8eF+WRuf52Hs9B/J9I6ARacCLVe8gLVFyxC6PqESReU
         0pC2izNBprRyMv/hty4HGbHh3+pNqHNF8usxRrymd2bAtLD5CEBvkCa9o76r7BUzcb2j
         h+7A==
X-Gm-Message-State: AOJu0YxQsnLzfANfbuEGaU1Q+Zt/iNFI+wWMhsncuVlhEV5oR4LJfc7E
        ay/ZpyScdl5IiaG5UOv6x6N6wIXfnFoonZir3wNzHA==
X-Google-Smtp-Source: AGHT+IEfT4doHnOsbz6gudgEBQhP/ws0s3F9AB/JOga8mqtwKh+rmACr2W6jdNBb1rt3mTUHfeVG4Q==
X-Received: by 2002:a17:907:7b94:b0:9b2:be2f:e31a with SMTP id ne20-20020a1709077b9400b009b2be2fe31amr9616483ejc.31.1701013615439;
        Sun, 26 Nov 2023 07:46:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:54 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
Date:   Sun, 26 Nov 2023 16:45:01 +0100
Message-ID: <20231126154605.15767-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add Tianma TM041XDHG01 that utilizes an Ilitek ILI9805 controller chip,
so its compatible string should be added to ilitek,ili9805 file.

Add the compatible string for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 .../devicetree/bindings/display/panel/ilitek,ili9805.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
index e08af5f0b2e9..1b5bf42df7d6 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - giantplus,gpm1790a0
+          - tianma,tm041xdhg01
       - const: ilitek,ili9805
 
   avdd-supply: true
-- 
2.42.0

