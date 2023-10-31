Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C277DCF15
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjJaOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJaOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:15:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD7FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:15:00 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B46D40821
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698761693;
        bh=K+d8FOi611qgqDiSGAqowSPHYlSjp+mGUPNXtAF6OWs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Vjy1LLO9xUSCgh0u2jA4PTzzPU+X87yOCqzdD8lE6uurXofu7IU84F0FmNwdYM+Ve
         LJK+ocPW8VkV+pxqt+jo9LKOEkHf4d9ltAuEo96iJV0plhN9BOjfnF/Ni6aV5Roexj
         iot3JjB7v0p8g9j7oeJ1ltdvjNv0rUTQPGwCpgTxnjWwbzLjnayMkY7n02fKQ2bt87
         SvbwR9Esklg3hMlhPVyjPu1ols5hSDDGO/sL/19Xmk3lUolYQRgZr6WJ/hCQQkMDN4
         QAvsKh6GNbnFS8sHc7tlQcXX2WWSHgeMiZCTtNYrg6Z/kWHoFRLyriIh79JX8j6yvC
         NQ7/N2srjplAA==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53e26bbbc63so4140789a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761689; x=1699366489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+d8FOi611qgqDiSGAqowSPHYlSjp+mGUPNXtAF6OWs=;
        b=n6jjngFeB9ETymmGpStYkBzjqEDU5s8IuUJorGk3nzeYbD935u0TjXCTwYV3g1SM/L
         0repY10zmwftbH4s4bPtnTDKRvKfvjHGO6gzhIivKuopcYKpJtTlJsa+oBDS3yWEeMcH
         ZiJPOUjXuml2XfPmG4vVwzc9bWSd829p4EdXX4Eq3gxNIndSBhptl/uolqHxN8NIKz2D
         IEL7C6ua+COcyP18mCVAsjAaLy9iEFCcZXByn2Pn0Ddj+C5OMAYDJfp06Rf4uVS41eOV
         By/rQERQvrq2fJpKU0+/y4kivHIIvEOwjzHSQBs7ZG7syt3iCG4LZhan/r8ImBPg1JR2
         VH8w==
X-Gm-Message-State: AOJu0YyVJFLaqf6wXoXuC5yorDggPrALKDgfJemlI8DY5cJ7A/JkyFSF
        AYI7AUW4FvC60Be7jSKjlk/PiDh5A5fBSJ+04R+SfODtktrBd2ErusqL3IO2CtDP/jBKiE/6/+V
        Ps/t6tHAoE+EcHA3/G/oCSagpFtEb57mRwszon2OE4g==
X-Received: by 2002:a17:906:ee8c:b0:9bd:dfaa:3f3 with SMTP id wt12-20020a170906ee8c00b009bddfaa03f3mr11080310ejb.7.1698761688997;
        Tue, 31 Oct 2023 07:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkm4eTftMYL/pLkJ6rc17J8JPzS7UGZtP1W0Jm3fINC348oTDOAtfZqM1Xw64GNQBGyCSGeA==
X-Received: by 2002:a17:906:ee8c:b0:9bd:dfaa:3f3 with SMTP id wt12-20020a170906ee8c00b009bddfaa03f3mr11080294ejb.7.1698761688788;
        Tue, 31 Oct 2023 07:14:48 -0700 (PDT)
Received: from stitch.. ([2a02:aa7:4003:190e:bd47:7b6e:876:4bdc])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709061b4500b009d23e00a90esm1037395ejg.24.2023.10.31.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:14:48 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
Date:   Tue, 31 Oct 2023 15:14:43 +0100
Message-Id: <20231031141444.53426-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
References: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cache controller is also used on the StarFive JH7100 SoC.
Unfortunately it needs a quirk to work properly, so add dedicated
compatible string to be able to match it.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 8a6a78e1a7ab..7e8cebe21584 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -38,7 +38,9 @@ properties:
               - sifive,fu740-c000-ccache
           - const: cache
       - items:
-          - const: starfive,jh7110-ccache
+          - enum:
+              - starfive,jh7100-ccache
+              - starfive,jh7110-ccache
           - const: sifive,ccache0
           - const: cache
       - items:
@@ -88,6 +90,7 @@ allOf:
           contains:
             enum:
               - sifive,fu740-c000-ccache
+              - starfive,jh7100-ccache
               - starfive,jh7110-ccache
               - microchip,mpfs-ccache
 
@@ -111,6 +114,7 @@ allOf:
           contains:
             enum:
               - sifive,fu740-c000-ccache
+              - starfive,jh7100-ccache
               - starfive,jh7110-ccache
 
     then:
-- 
2.40.1

