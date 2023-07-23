Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB475E380
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGWQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGWQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:11:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBE1722;
        Sun, 23 Jul 2023 09:10:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso576594266b.0;
        Sun, 23 Jul 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128573; x=1690733373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAGDbj4w5cqYpPhjbv0lV9BCY/wz/Fddf4zaiPiVK1k=;
        b=B23twYJYp6zKU1881M5PgC/7EWYMBfYki3iHA9pDNh3HOsf9qlPI1gel24VxrlFUHr
         zcqzl5li0RMxmoKtFoRQYXqBgCiEpSIdDrzCxBRv6nbw6VoqJ6N5cSKR+a1hiy+PCnkG
         uG1HiS7pBlAZg6wwK4MnhSWmcVCBy6TI0oMyIRLxjkpHsNoImh+KjRvKEygBE1h6Wsv0
         z3bO+NN26kGR3L/RymPJaCY7/eILDRYBlrW64XaZP5RmnPVcxIZK4HwhevXQbcFzqS5T
         jx5jPel15Bd1GukFjH2zAWytdhcZW07093WW/ve+14KfwNL62JhjLxnFqTewJ9aFQb3D
         QtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128573; x=1690733373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAGDbj4w5cqYpPhjbv0lV9BCY/wz/Fddf4zaiPiVK1k=;
        b=lM+U3A6NHHXfbz01I65/HEc3SEHdgkfqRwxwSMxBPte6JsEI5o5NODcvQ0LkHoSs2l
         NCfDph3uXRy7I7HMJ0A2kZ3vLvgZ7oX3iftl+XEA4VnhSiguh9aP+Mz/9mPFlyYb7yLV
         p8msCXLgGm/LtPwRpbgMpfKFDZrdb/B+N5LwQp2et1MhvNxFsfNJg6gBddoHgqXMTW++
         rWRaw6aMCqxlRX7wRro6yczSJdofz5prrVJVfJj8jV2zagFpYkfR8NHknVYMeAUfXDiU
         BtLjXPkXLhm4gyXGaZu9SALKmME3pexKgDy44nPNhMYVJkd5s0bsUmfpmVDYW2bfSebY
         IHHA==
X-Gm-Message-State: ABy/qLa8n/qO9IQw3b3OBNZ9CqPO5NkMb9hzFHv0lE7V8a1Ux+wUS2XQ
        kPBYKyUHagzzztjuzwnpODiXqDoDLzE=
X-Google-Smtp-Source: APBJJlHvwxCH+Dj328ydbFV7zl7xzoo9fFh5RQZofh/S+UtyTWl5AS7LLHhXKqaVspOAiqz+RLmE6A==
X-Received: by 2002:a17:906:535b:b0:99b:658e:3941 with SMTP id j27-20020a170906535b00b0099b658e3941mr7191830ejo.70.1690128573018;
        Sun, 23 Jul 2023 09:09:33 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:32 -0700 (PDT)
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
Subject: [PATCH v2 6/7] arm64: dts: qcom: msm8976: Split lpass region
Date:   Sun, 23 Jul 2023 18:08:25 +0200
Message-Id: <20230723160827.22660-7-a39.skl@gmail.com>
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

Some devices like Sony Loire uses Broadcom module over sdc3 however others
utilize qcom WCNSS, split shared region based on downstream pil-tz loader.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index ab76806317a7..7385d5edec04 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -338,7 +338,12 @@ mpss_mem: mpss@86c00000 {
 		};
 
 		lpass_mem: lpass@8c200000 {
-			reg = <0x0 0x8c200000 0x0 0x1800000>;
+			reg = <0x0 0x8c200000 0x0 0x1000000>;
+			no-map;
+		};
+
+		wcnss_fw_mem: wcnss@8d200000 {
+			reg = <0x0 0x8d200000 0x0 0x800000>;
 			no-map;
 		};
 
-- 
2.25.1

