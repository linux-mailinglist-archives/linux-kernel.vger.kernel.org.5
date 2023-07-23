Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347E075E26E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGWOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGWOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4731722;
        Sun, 23 Jul 2023 07:07:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso5055185e87.0;
        Sun, 23 Jul 2023 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121263; x=1690726063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqnwiCRTKEz/1wjL6Wfye4Vi7LFOrL2Vihn903cSKUk=;
        b=SDQYyCa7KhSZaaTV7TzxLxQbwewMBXtrp2T/NDl003tAJLpEvL6ptw64nqxQia5a4B
         S0LxSHk5CsrcVmYVk/lV2g98y65azmojDLdSrJR4xqUrTFnwkAzi3dcJh6QDfyFfj+cD
         8V3ji+aHnnUs4CVkUr+STqVE4sJdz4NbEV+mOsH8kE9fFxZATb30kkmKm6U7dCgSZ4yB
         u5v9HspvsfRIjvM3MFrBZA498Z7PeYTo3uKIGTctcvfPs9ox2GSF9Luk0EW9KijhoDA5
         uqC5ZM6kjrwJwBnIPd2QmHUMcB5M1rNGCq3cc7xihLey96Uw5FdYEb43bMpFfjsQZ4yb
         b+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121263; x=1690726063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqnwiCRTKEz/1wjL6Wfye4Vi7LFOrL2Vihn903cSKUk=;
        b=iJK2z4N58+8ozx4GX6HbUTRBjFqE68r3Z7VEGwADoM9FATMuRhxkyIk1msk+zqlzMi
         2gQgQOeqwP4pbefScg9qdh0T4ejC4ydGAS4OQhpCoBIp6OYurqXYmcUetBH/nz08w7K2
         nf3mqRTShrsUyb93cYdr0MQEzWoHSWxBu76zkZUBP4dICAeoUwCLRjPhG5YKdjvfwcm1
         CrmCrY9JKMlKy7zNk4IJ+BzN5aScbFOWz2dxSZdlSTjJ8p0XWDsgpkpx0SAmZzzpOxZC
         SpXpEidNI9HymHPaDH0cyEbQnL3Vh/mnwTBCpI/viYl6ZYd1aJrECbLZuxDKghk9sZNO
         +Xzw==
X-Gm-Message-State: ABy/qLbZpQes8/+OSRtplA7B0C4d7zffiL84qnhcmuGxBC2B+cRoSgvZ
        n8I5xJjnlF7p9q34ou2k0JouzL/kuBCYNg==
X-Google-Smtp-Source: APBJJlG9AtHOHcoa031sYG18h0ZZBjJPcgSERlzIioJ6AW7uFsSIXHdp7Xyo0XeMpOWecSsa/UZE+w==
X-Received: by 2002:a05:6512:10cc:b0:4f8:6dfd:faa0 with SMTP id k12-20020a05651210cc00b004f86dfdfaa0mr3906952lfg.2.1690121263523;
        Sun, 23 Jul 2023 07:07:43 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:43 -0700 (PDT)
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
Subject: [PATCH 7/7] arm64: dts: qcom: msm8976: Fix smsm ipc bit shifts
Date:   Sun, 23 Jul 2023 16:06:54 +0200
Message-Id: <20230723140712.9438-8-a39.skl@gmail.com>
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
2.41.0

