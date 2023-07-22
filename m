Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74475DB33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGVIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGVIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:53:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A126B0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso4165366e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015977; x=1690620777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIc8M4Qy3pFtVj2yi3L/SVZu8FUlQ6AWEoOSAi/6fH8=;
        b=w4DBPj+CXb3LrpeNPsUTPCjt58AFkJroHXqKy03TGeJmIlozv0/+1zaT8iyCRksAxS
         WQp/vlzwYm0R8yxuxRFsDbE9R/Zl8N9YTc1jXDQyreHKD084CdyYw2hptAbwqTUewGdq
         7sv+NJr+YJXGCzTtmlQ+uDU4XUiSsaXs6ssjGzPhoRZNG8YTClNhRaB1Zqq5LKaB2+Ev
         lANYKqREpAv4/6WiewyVlatAkUNj/K/2YQ87wMqN66StPF4ev2d2UB9xN6LQ3Y498uxY
         j/VqnJGc+yGqj1BoIvYtdqAmblhqofdBcZFbO5oSvXgB9JYshegKdj5CJEvm+VY4cMsb
         cmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015977; x=1690620777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIc8M4Qy3pFtVj2yi3L/SVZu8FUlQ6AWEoOSAi/6fH8=;
        b=R/5QdgPNvc4OWpK4bsL3XRLPviPMJE4t/4vKimY9ujAQhC2+oax3CcBW95sH4vQk++
         TlbYwUuI4iT9dvxsqGlKCRiree4GUjtWfMYZEIZ/aS8LCyKJBA7/LBwrKatTZiajNrcg
         /p9qe7FCMaodAj2yeRMCzLbgjlOlg+oEpQovRHh5/KZDHNfpDBsdSWX1FOMItSpYPaxx
         Ah0ZaoeRJJC+kb5VcW3V40DevPc+DB+wMq9zw+cqmqkLHB97Fi3Xq93ZHHPcSzhS1lpv
         IKGgaDAtOuAfF87vlQPQGVXEdW25Y5FfxuVvyjxw3fqzyU7ML4jyMdG+dItYcRe/Y9vT
         qGCw==
X-Gm-Message-State: ABy/qLZsSRO0Dmn9oow08NGrkv2qyzySponwaxG3aDqEAEqHIPeqfwvm
        g7PHqzm6tH2p/+DGkGjRqSLS1A==
X-Google-Smtp-Source: APBJJlGKaR4gCCj53dKyGL/HJZH1SQtSpJI1WmJ0zg1lrDyiUoaYykapWQ9JpphfzyWhzBk8QTTgKA==
X-Received: by 2002:ac2:47f1:0:b0:4fb:763c:af54 with SMTP id b17-20020ac247f1000000b004fb763caf54mr2451752lfp.62.1690015977235;
        Sat, 22 Jul 2023 01:52:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b004fbf5242e8bsm1107034lfn.231.2023.07.22.01.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:52:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 22 Jul 2023 10:52:47 +0200
Subject: [PATCH 3/3] arm64: defconfig: enable Qualcomm SM6115 LPASS pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-topic-6115_lpasstlmm-v1-3-32d1643d8774@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690015971; l=718;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3c7z5lg3GdcTEBcbEgugsr8/arhScheGCYc9FCflb+g=;
 b=iaV0Oo8qCRBQGYyEEEkhvqpIZMrYxKbgTwYDTKy7dp0vjQox3xllLm87sbnc5qQUJaSeIEeLa
 Yk6uRWOKKDJAFcRmgo6eMSuEL3MR5RHiz9PS08SFeSkezXHmNgeNWNF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm SM6115 LPASS TLMM pin controller driver for
providing GPIOs/pins for audio block on SM6115 based boards (e.g.
QTI RB2).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6cbf6eb59378..6911101db09e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -587,6 +587,7 @@ CONFIG_PINCTRL_SDM660=y
 CONFIG_PINCTRL_SDM670=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM6115=y
+CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM6125=y
 CONFIG_PINCTRL_SM6350=y
 CONFIG_PINCTRL_SM6375=y

-- 
2.41.0

