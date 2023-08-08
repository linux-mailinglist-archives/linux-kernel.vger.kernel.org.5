Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A543E773C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjHHQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHHQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:02:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F365B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bfcf4c814so852054566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509487; x=1692114287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/3xpf+nkmYM0/cP3Mm0ug8E6Tr0ifjOM0Sgp4Fheis=;
        b=DdQS2GKjAMFl7QoJ4ty5jNL5YOdf58nAJ/DUUG7PYrmUasPOT7dIf92KHnguBJ6Dnu
         rxWKwc6E6GndCRSvsi/Rqbzj3wFm+vMYFfktLhQG9XmNzKg6+OaZWKDdMdCekqVVd1Yq
         k9b/3xlQgOBUsIVIO5m8jRskM4zCh98aolCKMixaUVbt6dczITWBeZQyHm6oMtfe05xs
         QO9KxiZsjVVOlHJJ7CqgPRYv3WmuIRTzXgA6wpzYVlXlWz8en9c2PL8IJcYcl13+QOoZ
         73ZA/AhAN/FnRt+0iKSOECRUqRPgMKwBUBkSK0KNp9Mbjv/8vQ2ZHpSBqNhIkTvm1Dyd
         5G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509487; x=1692114287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/3xpf+nkmYM0/cP3Mm0ug8E6Tr0ifjOM0Sgp4Fheis=;
        b=W0pwEV2coCT9rHqjFKid4fkgAz5//atjHaqE5GSDwUBK+VRB2HbcrgKeIwP4k/rvjt
         SDwl4qivaSoCOeMvoeXPpi/eNEV3guYhhuG/diGld4xU9hMl+mOhkOx5L91h5baFMezN
         c9mGQU6Ht3MoHvbtJA/KGcCAduO/MTNA2mNpF7svpnbaUnvc17a0ES5jYLaAPPjRxull
         W1lcLDJpBVzk62kjcYRwNcwYxFoJNqwu6/AwtZJ8+eP++H7asexCwoCjAn64TNkLT0pN
         +kMrX321ZWhQlvKs3NQZ3PA7oYNIqrI6eIi33vZJNrL8zMMiDke32fJHVrnn9p8EAVAb
         tpqg==
X-Gm-Message-State: AOJu0YxA5aPkLE8Nv0wH2iawlB2vcwOzVgjHKRFArx+p4vMj7omdPFla
        wazQkRK2BLbCRRdIwWYkT+KVUgzD4NSQ8z4cVrU=
X-Google-Smtp-Source: AGHT+IFRoA13RhrMxnqW7ljjsyav/4dAxADif8m2tF9UwYMnrRa7VWJJXVr+r6ZRwLdvaG4hOCJatg==
X-Received: by 2002:a19:6547:0:b0:4fe:af6:5e5 with SMTP id c7-20020a196547000000b004fe0af605e5mr7041396lfj.23.1691483262566;
        Tue, 08 Aug 2023 01:27:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 00/11] clk: samsung: remove number of clocks from bindings
Date:   Tue,  8 Aug 2023 10:27:27 +0200
Message-Id: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No dependencies, patches can be taken in one set via my clk tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  clk: samsung: exynos3250: do not define number of clocks in bindings
  clk: samsung: exynos4: do not define number of clocks in bindings
  clk: samsung: exynos5250: do not define number of clocks in bindings
  clk: samsung: exynos5260: do not define number of clocks in bindings
  clk: samsung: exynos5410: do not define number of clocks in bindings
  clk: samsung: exynos5420: do not define number of clocks in bindings
  clk: samsung: exynos5433: do not define number of clocks in bindings
  clk: samsung: exynos7885: do not define number of clocks in bindings
  clk: samsung: exynos850: do not define number of clocks in bindings
  clk: samsung: exynoautov9: do not define number of clocks in bindings
  dt-bindings: clock: samsung: remove define with number of clocks

 drivers/clk/samsung/clk-exynos3250.c          | 11 +++-
 drivers/clk/samsung/clk-exynos4.c             |  5 +-
 drivers/clk/samsung/clk-exynos4412-isp.c      |  5 +-
 drivers/clk/samsung/clk-exynos5250.c          |  5 +-
 drivers/clk/samsung/clk-exynos5260.c          | 41 ++++++++----
 drivers/clk/samsung/clk-exynos5410.c          |  5 +-
 drivers/clk/samsung/clk-exynos5420.c          |  5 +-
 drivers/clk/samsung/clk-exynos5433.c          | 65 +++++++++++++------
 drivers/clk/samsung/clk-exynos7885.c          | 14 ++--
 drivers/clk/samsung/clk-exynos850.c           | 35 ++++++----
 drivers/clk/samsung/clk-exynosautov9.c        | 29 ++++++---
 include/dt-bindings/clock/exynos3250.h        | 18 -----
 include/dt-bindings/clock/exynos4.h           |  5 --
 include/dt-bindings/clock/exynos5250.h        |  3 -
 include/dt-bindings/clock/exynos5260-clk.h    | 25 -------
 include/dt-bindings/clock/exynos5410.h        |  2 -
 include/dt-bindings/clock/exynos5420.h        |  3 -
 include/dt-bindings/clock/exynos5433.h        | 42 ------------
 include/dt-bindings/clock/exynos7885.h        |  4 --
 include/dt-bindings/clock/exynos850.h         | 10 ---
 .../dt-bindings/clock/samsung,exynosautov9.h  | 18 -----
 21 files changed, 154 insertions(+), 196 deletions(-)

-- 
2.34.1

