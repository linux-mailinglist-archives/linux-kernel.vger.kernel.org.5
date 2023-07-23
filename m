Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96075E26A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGWOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGWOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491C1709;
        Sun, 23 Jul 2023 07:07:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so5160318e87.0;
        Sun, 23 Jul 2023 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121262; x=1690726062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnquK1Bf+NrtIkuj5n5WuqzSN63Lf7C6vpkZFjzFEOU=;
        b=qjJQFC/pyIzq5bIHb2/d1EwWRDADxVHwsIYltrDhEDjdIyYiSo6jp8z0KqroqYON3F
         +iJq+JNhOv4SsBqXGKmIDOuFqmR/jHOY896lHtjmewuG2iScImOi+Qudmz/aPmtiIvKY
         Q1mAtUVquvtaY2jW4t9x2jKlwn63GW8mKSX+Y/2K7gqQDl32czJ4If0HQttiGh+vptod
         kDz+O0HEDckL4Dt31oMpO3mpD9j2LwCvcSNxIpBYgl40IR3glQoysydHVP93uuPLmoUO
         wxxeAnk+/5n344l2/I0R7CrRMY+kV/jhziVc2O0RT7kEq6sHokBmVKqJtd+j3XwNTojO
         8vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121262; x=1690726062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnquK1Bf+NrtIkuj5n5WuqzSN63Lf7C6vpkZFjzFEOU=;
        b=L59nxJJcaI3w7IRb+ey1eXa5hNAXoIqUjAOvjXLw+VfGF3XXWUgUGKmHrKqz2im+Qj
         h/0I14HUmujJ2VSFM5OoVD6/XrtOkChCXUFq+0ufCBQlzS0Pt8qXVGiCVsjqIdjwsdGB
         YmYKef9T/L3BlYEQnQTNSjUEd2TfEEutZ/lYAAJ5TiK0izlZKSF1vraz8LTdj04bYf+I
         V7+48JQtsbFt98ndjR35equgDs1tf3djgtdROJ8MOiecVqfdTYMbCu0A9iXh9F3hkQ1z
         t/r3R4P3FpW26tm05su7i7CpJPOYhy5FcijuXdjYWvE9Ldh4Q65/J8Dzno5dgGTByicx
         8edw==
X-Gm-Message-State: ABy/qLZLbFXow9+HM5+JFaNWbvQTQE34efoXW761pmetoQWkz0OCT0/y
        qqgrurKQrwg4ek0GiCDmlGSGaBpUnEYrvA==
X-Google-Smtp-Source: APBJJlGdrL+NcR7PEBtWtKnxNv23eTE7INMr6IX5Sn2CahykbJMH6xT9aE11pXbRN/YLaBOfBDM4Lw==
X-Received: by 2002:a19:7508:0:b0:4ed:cc6d:61fe with SMTP id y8-20020a197508000000b004edcc6d61femr3856837lfe.24.1690121261699;
        Sun, 23 Jul 2023 07:07:41 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:41 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: msm8976: Split lpass region
Date:   Sun, 23 Jul 2023 16:06:53 +0200
Message-Id: <20230723140712.9438-7-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723140712.9438-1-a39.skl@gmail.com>
References: <20230723140712.9438-1-a39.skl@gmail.com>
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
2.41.0

