Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9679D272
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjILNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbjILNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676682695
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso7375082a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525539; x=1695130339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbXnoaG8UM/xnuGoKiBDSZrOmSb2jf1llCbQVLffVMo=;
        b=hCQcTHvAJViXwhhNQyHwZ6I4nV/hzy0Cm0pLsGSixn4we5e/BJB8sP5pSd1dO+Pl9B
         9VZ2vxGEE9YwutNZPp/ktkOR8800LC0R8V6FtBDSRziHxAjGV5bpgdNXN3ZLDm4i9CDw
         JqIfowanFIvid3UHF8BBxeVIZs1vpPWtmEitEYVrFhe9t8qUSMOLxG7JsISB0+5qF7m9
         WVndscGNLi1q0FS8Gm0EdMJsOR20HDpcxihBAuZpXXmfzepytqZiRnm9V8o41Aj2D9eL
         moHjuGuTCsS8KOhhEQ/EYMNx22qk5yNk3BWg5JkpuMUKnvRMlfiB5bV0tEvifX/cHssh
         DCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525539; x=1695130339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbXnoaG8UM/xnuGoKiBDSZrOmSb2jf1llCbQVLffVMo=;
        b=psAnCflT+xE3d836Ogj7H3x8zL/TzBqagUT2eTRnCO3EYTE1ZiM96kAFEuTXrjJ29q
         cMRGLpFX9Z2VyWFUCyfvAcA5xHmsjysd4j62039ZxFrkL+FWlfbQpP5BX4UnmkzWdbmk
         bB5ZUTdh7eu5+3Oi7xnMez3JidnRVqQr+WvTrcfs3mvpXVDvt7SSmGMhgd7CpCkDVW64
         EQjMEJ+bvgaqWmF4znHJ5/EQkLNdJ7scZtJ1XrYz0sYMS6mom4zMxaxOM0yz1FPsI5U7
         Yx4xnuXgdjmYQ8QTuDI1xBDgyramRGxYFX5Eu1CS2Ie54ozoRHZiC8dceyOWCV54VvLS
         1f2g==
X-Gm-Message-State: AOJu0Yw5caMxzfbPRElQ5pgpxfi4m6mqTI2nUakPv5iuaDg9283KERJ2
        gAiEd1tWEJo/TCd5AGOOSbOJFw==
X-Google-Smtp-Source: AGHT+IHjyWCzW0ayXb0LJwcsgfnod96ca3muMqyfMqr31yt9brYBDxzKS84KHnsnwu97DkDO8oho6A==
X-Received: by 2002:a05:6402:c07:b0:52f:bb0b:57bd with SMTP id co7-20020a0564020c0700b0052fbb0b57bdmr281117edb.17.1694525538846;
        Tue, 12 Sep 2023 06:32:18 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:52 +0200
Subject: [PATCH v2 14/14] arm64: dts: qcom: sdm630: Fix USB2 clock-names
 order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1150;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xV/ZqPgMqaXSG0vXi80ddqfx5e4u+5Uywuqjc5SC6yQ=;
 b=JcTmOePKvRMjpiooocOU71gidr0+FDs8aF2A2fYneNgn3SUS4LV/RsG3oSoeLzyRJR5ZUAxgN
 oS5s69VDs47Dt+cXpXsmvMD6uFQgNYxxFQObqf8CfQ8l2zMKddqof+k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last 2 clock-names entries for the USB2 controller were swapped,
resulting in schema warnings:

['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
        'iface' was expected
        'sleep' was expected
        'mock_utmi' was expected

Fix it and take the liberty to make the clock-names entries more
readable.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f11d2a07508c..316c8fd224e0 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1394,8 +1394,10 @@ usb2: usb@c2f8800 {
 				 <&gcc GCC_USB20_MASTER_CLK>,
 				 <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB20_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core",
-				      "mock_utmi", "sleep";
+			clock-names = "cfg_noc",
+				      "core",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB20_MASTER_CLK>;

-- 
2.42.0

