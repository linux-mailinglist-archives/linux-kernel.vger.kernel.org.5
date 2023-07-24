Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7F75FD12
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGXRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGXRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:20:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260B10D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb8a89b975so8906725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690219250; x=1690824050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buBAvhZqaa8ellf0YVL2gYUlbECC3xBJTY5raF47z40=;
        b=gTIM2kB4vQQaNdDtcqBYuGiP1YsKpqqwI4J1t0SFk8H5M0rJjqx5ap/Yb1U+i2RgzB
         N1LINAqF/Bkn3VYnI7CWayUCXVONVj9/eVYJlAr887/L4rqs9GVRvss/TL84viLPOqiA
         oF0R58MUV2WTaO1AGaYrQoA8+Y47tBvqJ7DHPcDubUyICr8cB1GxYnA0ONhjCfg0KPcI
         6hh2aaB9pM9rwGfzUk86rd6Kr9NN6ybIiJzpg1YdAS/Ahg5EBlwXQRblbUkI+56bG/8V
         Jj8LPtIMdnR3w4NJBYBVF5+4Ad2Q/uOVXlx+eUBY31pC+zC9ZM5FsRua2b/m5q2ZnATO
         YrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219250; x=1690824050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buBAvhZqaa8ellf0YVL2gYUlbECC3xBJTY5raF47z40=;
        b=KpXYCXqnRStOVLOJE1BQLROK1QHuTq+iiX6mqrk/h0vy+zwSDYPy4YkHJmBYvtB7QQ
         m9SH7REYIDPh3FGEHEUAh2PD4hZPzp8pFxfQKj1NgL2DAlU0HJodemiKzYT31oXWw2lN
         TvFljWKcAjnXh+CgXBOjzvpiJjmopMp/MVi7Set33eqzwxSx+rcr3OCY0P9efSdwYaMs
         WOpUmOZEtMIBA1hf29SS9b7Ks0AC2TunkrXmPyvw1mL5Dh2j2ZIlRCG4Y8DdoxqBGBQo
         fcP0J/fuVaiGdpwbic6Yq71dEjuK9AUzQbb4VrUckXoJKVfviDIjXItdz11FrmeswmwY
         LH1Q==
X-Gm-Message-State: ABy/qLbkg+AHOtAKviIa0mYZuMACeEFw6KP2ULaKB0bSo8PBMdRnIi3o
        9+85ME9Mm0RXont2sHlhY2J3nw==
X-Google-Smtp-Source: APBJJlG/IxYNfpybnNeZlu9o3AYDP7AHguXUXVbPH7ZH/lPZnrbogHAsCUknUq4NkQUKFozLSPOojw==
X-Received: by 2002:a17:903:2445:b0:1b8:a7ec:38c5 with SMTP id l5-20020a170903244500b001b8a7ec38c5mr9892478pls.57.1690219250281;
        Mon, 24 Jul 2023 10:20:50 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b55a:eeb0:a3a8:248e])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001b9cf522c0esm146456plb.97.2023.07.24.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 10:20:50 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 10:20:40 -0700
Subject: [PATCH v2 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-upstream-beaglev-ahead-dts-v2-3-a470ab8fe806@baylibre.com>
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
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690219247; l=690;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=N7smB4Nhq9ThR0Q1dQ2d331OISGVCJweZ/uFlnD6UHg=;
 b=FNz0zJqz+euHHhcYuXyOiAUhJaKir8B6iGinHSPE63Lf2DS6cE1glAO/LHqp5Sqrmx/BMVZa1
 hsScI33sFqlCEFYGOp8AW3wDdEVehx92uUHN3nisXao4EpbUTZsfmro
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain support for the TH1520-based BeagleV Ahead board so
adding myself as a reviewer for T-Head SoC patches.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..eaec3333f2ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18326,6 +18326,7 @@ RISC-V THEAD SoC SUPPORT
 M:	Jisheng Zhang <jszhang@kernel.org>
 M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
+R:	Drew Fustini <dfustini@baylibre.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/

-- 
2.34.1

