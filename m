Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFF75E384
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGWQL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGWQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:11:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C119AC;
        Sun, 23 Jul 2023 09:10:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991ef0b464cso987253566b.0;
        Sun, 23 Jul 2023 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128575; x=1690733375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJXUCfPfxMZDrw8reVp/mOwjqAotIrdk28gOPKfujpk=;
        b=CiD0CijqD2LZn4fISlmA/WzpS0y7CDEsbIh1bTpP/35MGba94PiLhenPUkvaIBCVDu
         j9Kq7hLo8z36/0ceBT4KyoxzUkbTxjI+9xSkjxFtGXkTo5I545PhwQZW799+xaM4+gt1
         ph1/P22d4mxXnURSmuQubquB4YLYiWb6cDoPzGhxKKlNEctEZFxtd4j+nrJ1UQm4m7Sc
         k+N6UoaTyi3bcf5Qezgj9KxbTdhQxxnICjctuFBC8rXiO0VgjSPOs1VFi9gLtR4RsEHw
         13Rqm6OiG6PGYum+h6hq9HtBqnZsiw5uQh98cZmueJEewiFJrb2PncfgmtUgyQ0tifr/
         6QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128575; x=1690733375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJXUCfPfxMZDrw8reVp/mOwjqAotIrdk28gOPKfujpk=;
        b=TttoT6eQqk4jo3FtLsme9Mco/Spi1DEW8QsoooBzy1kEw1/8qfl50JEYdH2QQa8nAp
         4elhPOlRwP3O3FJUDZUOvOMh72npTqhAM2M2fFM2o9tn5EgLOMkpHjuxrH54gI5rOGc2
         Cqwm3Vlpfbk2BpfMhbuq0ciiutByOu6iUH/HvFucts8gZ29UrZxCqvH04tGKEgaYVNaY
         0gFJtP6MFMwdHiDsR3rAnkN+cr9i74xH/F0FtXuPKM3VPjJj/37KJQ4K/NomsXmuGorJ
         4g3JgAVmMRrGa7tWChopNG6tT9qtYw8+W/+BbKv7bzMXpmL8GTArIilVgwRaoPkgfO5+
         v+tA==
X-Gm-Message-State: ABy/qLb6uVbjmNiGwwqi0ZqtffdjTppOqlYfWBT07eLKjANSzuHTGGkk
        FfpQ6S7cpVOR5KWxsRLUmiyJhwAm8bg=
X-Google-Smtp-Source: APBJJlG3ZC0ztrZPhpT4podw6SZVxxGG31tprJEN0TaQkh2VnoG4Ub1tVZe25vh8DB+dkWy4OBcY6w==
X-Received: by 2002:a17:906:30c5:b0:993:fb68:ed6c with SMTP id b5-20020a17090630c500b00993fb68ed6cmr7568461ejb.15.1690128575066;
        Sun, 23 Jul 2023 09:09:35 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:34 -0700 (PDT)
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
Subject: [PATCH v2 7/7] arm64: dts: qcom: msm8976: Fix smsm ipc bit shifts
Date:   Sun, 23 Jul 2023 18:08:26 +0200
Message-Id: <20230723160827.22660-8-a39.skl@gmail.com>
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

Update bits to match downstream irq-bitmask values.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 7385d5edec04..5537ec049451 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -433,9 +433,9 @@ smsm {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 8 12>;
+		qcom,ipc-1 = <&apcs 8 13>;
 		qcom,ipc-2 = <&apcs 8 9>;
-		qcom,ipc-3 = <&apcs 8 18>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps@0 {
 			reg = <0>;
-- 
2.25.1

