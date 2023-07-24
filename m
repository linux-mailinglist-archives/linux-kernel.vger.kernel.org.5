Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4475FD0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjGXRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjGXRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:20:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A810F0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bba48b0bd2so6972725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690219248; x=1690824048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG6Fw3427yb+1A3z1UjhPjDu/XeyqKpB6skEHK30hAE=;
        b=jmO32zV7MyqDXvN5bP/2SuLkTtT38XiVZWCkqII0s9Z5i9H0ZJ6/OFVSuF8bKjVmFV
         lzuYRHvb8wVLEbrAyac1/IgtgXOuEApCTv4f6lGy9x5GF0oqdK9wO5Lz3PLC8jdQl54o
         YWjZ2VlcYpMYGQW+SBKxIinFp5SkICN9Hlo/9GzBwrgIxffsGHxAZx0PYzwp1GsS1fyl
         vXfIXoIYNwqBXmC6iy7H4ihFptx2/aeEIqJFv7hU6yi1QLXEhLpCebbhq90jSomoVmIi
         4EFbqERAo9kOOVtR4xAhnrmh0hfkoeKVdRG7khI9UFPi1SVJEpwf4o9009xg7DHUNPkx
         N4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219248; x=1690824048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG6Fw3427yb+1A3z1UjhPjDu/XeyqKpB6skEHK30hAE=;
        b=iJVq0tACbxkAL9YJTRUtxZjXUhJhR1W+0bWr505IygAKqmR8COECVB/j6MvDA0ZafZ
         dVPSBECFVkPVaFIhrMJ48Nk+Zg4NQ2CNMz2m60GEkrkZkj2jBs4uv94rIBtu76DyzeFw
         shKZCnvsS0eQz94VfUOWjQT2WC0YcEPn0+QmBq6Yz1cQss08cmAV6iyD3bItlkDc05OZ
         bRtT8NB3WnAgfGyM9c+xengzrwYpqQQtK0yi18fzWFOQ0RTCp1hQ6n/49wbHaHoIajHJ
         De5HfkUXCbEkXtjRpMRCD0zL/q5aACBTbgbXOIrDbcwf/eaWZV2VSZEiHboLNlaCPjhu
         rT3Q==
X-Gm-Message-State: ABy/qLZAXHw3fo/bwGfvdNb0n8RlJcq/naBfoN9sfohr6oqcoh7tPtwM
        PbQqfc28j8iiHkqJ3GvtpLbvAA==
X-Google-Smtp-Source: APBJJlHXX6f8aSU2q7XTjWqD6MEPU2ep9lzFpSAwTPqEvRGH8trskBaYphPiUnho53oicuo7BT838A==
X-Received: by 2002:a17:902:7d93:b0:1b8:b26f:a6ac with SMTP id a19-20020a1709027d9300b001b8b26fa6acmr8556357plm.5.1690219248651;
        Mon, 24 Jul 2023 10:20:48 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b55a:eeb0:a3a8:248e])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001b9cf522c0esm146456plb.97.2023.07.24.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 10:20:48 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 10:20:38 -0700
Subject: [PATCH v2 1/3] dt-bindings: riscv: Add BeagleV Ahead board
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-upstream-beaglev-ahead-dts-v2-1-a470ab8fe806@baylibre.com>
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690219247; l=1043;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=WpzSzfYRuktV65/KrbeijV6SvDJPRaBdgv74PJSJApo=;
 b=VlVKSb6j60XCYtqQ4xA6mjMyq3wo5A4KCBV05ljq2zRQIKv58/TcihvJhR3H6bMpxp+zu5+ij
 5OAHc8kNWpyAtaZ8zN5FuYC6a67LkjHgnM9/nigLqONCu2WgqsIsHHV
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the BeagleV Ahead board which uses
the T-Head TH1520 SoC.

Link: https://beagleboard.org/beaglev-ahead
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/riscv/thead.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documentation/devicetree/bindings/riscv/thead.yaml
index e62f6821372e..301912dcd290 100644
--- a/Documentation/devicetree/bindings/riscv/thead.yaml
+++ b/Documentation/devicetree/bindings/riscv/thead.yaml
@@ -17,6 +17,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - description: BeagleV Ahead single board computer
+        items:
+          - const: beagle,beaglev-ahead
+          - const: thead,th1520
       - description: Sipeed Lichee Pi 4A board for the Sipeed Lichee Module 4A
         items:
           - enum:

-- 
2.34.1

