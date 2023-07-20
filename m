Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B275AF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGTNLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGTNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:10:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F44270B;
        Thu, 20 Jul 2023 06:10:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7869bcee569so29337639f.0;
        Thu, 20 Jul 2023 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689858644; x=1690463444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp/kbcPt3lC+SwD9GZ2IUMapJp45CJvsCwWxbmFjMAQ=;
        b=aQ8+U7IN6KXXcBEnnbB24I4haQALk0rl4aneSS+5UnRGa95KKo9F6g/ba95NO3V5+7
         EkOV6lh6yw68cyM77LdIb6DIpgLg4G0eS60W0ciLIQAjfVlUaZhNo+A4QvP1kwUfUocD
         HGZl+97A3PcFs4ogBgxd4UUKaI1kyvhb9ZQQxAQVA72kmb43/1dcpFXpwYjkFEIV3h0L
         eCSYn0meNJC46HdvndIT+lAlH6MhkNTOwKJ3jGTFiNu+/C6NlMm3xCV/cy/KU1r7tKNR
         2dVvYmpeggbtMUFW2aa4NzEsRAU9mLxQ7A8oNEJgS1dp7Y5ecDFjFzwPiLBVFTXWrCN1
         8aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858644; x=1690463444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp/kbcPt3lC+SwD9GZ2IUMapJp45CJvsCwWxbmFjMAQ=;
        b=KelT8cg1Hn16OEnlzyArR4g4sowgS7gO4VDSwpTnUal0qbJ97ppNHhzZCqoJ9hRtCt
         ygK6eIppgdfEOMfKo4riG+dloYLTe6puabEKUSmlMQNy8TGL6y3l3o8X7j2P5kzh97Ww
         ao5ljBut2YSE7Cn3cV25+fgamcwUhnTOvGGEXeT5UHvu1uR0ogURANIf5gadUaKQaBNI
         ifPFD2HpTPYqrwlJ4+nczD2KdXJA1jTJev71HvnTIKYfBjVivvder28iNE62+VbR1/Dg
         yEreRCoZOGxkONss4uAbs1FK+YDgp1uEc2N7kyCCdGU6HEtVTrQ/yvgJFeepoSlAT3oX
         QDqA==
X-Gm-Message-State: ABy/qLaf7mrHPuA/ZsvNCk0pTDRV+HguxhC6t7LxYfLUBsDq5lU1nR4h
        uEViA5isJPq+Am4Lmw2NHBPuRMj0WtptLQ==
X-Google-Smtp-Source: APBJJlElrWF/nCYTy7iqjwNZhQh4nibpNcUhKCFhGUwDSMQvoPbky3gxiXMReoseq7T/qgRUl3o4zw==
X-Received: by 2002:a05:6602:20da:b0:786:26f0:3092 with SMTP id 26-20020a05660220da00b0078626f03092mr2616465ioz.3.1689858643814;
        Thu, 20 Jul 2023 06:10:43 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id k12-20020a02c64c000000b004290fd3a68dsm324873jan.1.2023.07.20.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:10:43 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 Custom Board
Date:   Thu, 20 Jul 2023 07:10:24 -0600
Message-Id: <20230720131028.3730704-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720131028.3730704-1-james.hilliard1@gmail.com>
References: <20230720131028.3730704-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Variscite i.MX6Q VAR-SOM-MX6 Custom Board.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3ab78429799..010601da6c5b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -298,6 +298,7 @@ properties:
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - variscite,mx6customboard
               - variscite,var-som-imx6q   # i.MX6 Quad Variscite VAR-SOM-MX6 module
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
-- 
2.34.1

