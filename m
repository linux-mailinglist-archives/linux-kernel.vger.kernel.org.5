Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD075CC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGUPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjGUPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F18930E8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so3429737e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953786; x=1690558586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytx6skollgD4Zg1m5VdiBVnUPGosx4aLRWdCtyILU8I=;
        b=bJ2VhiB4MPs4/cBw/DhYOWkp86OW+Jklj4kSu6REZPu6cyuBahnV4yU9CzAB8j9Won
         0QJd6/d/wU7/UvV9ezY55CuerAmFwKpFte62LGBUI6xnySv8ixAikibWOrYOxVil2Z+M
         7Qn0Oi6XDJfHip4fDt3qxo2RvLbP1q78pmjjAvKpiwOmrAGWVT77EV3cUgeMaoWd3eah
         kk4QX9L7H3hMySjcnPW7br+sfPXxjq3b1NmTjqs6PsDD5Hguev+Ugf78S74l+wWCz9jX
         3PFRGwrAtNzRMeb17W1ULOECySQbJ4qEq8biDFjQK9Vo8Bzu13U6/aKWmwcVd+SKiS46
         t/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953786; x=1690558586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytx6skollgD4Zg1m5VdiBVnUPGosx4aLRWdCtyILU8I=;
        b=NyBcukxlAvwAAqvMUt53q5oG+2HudMxQSk93AowuG7Z43KZKVciAoI+4NjuoTG5kgU
         cp04YRDLozX934kiEVhdtag2mFYH79hb3F63W13UHbrNqwBThqcME3sHpIRR4nogT7EF
         YCuvcw+A+FtZOPoBICJhBulMu8hbYSqt/dJT++99G93NLDZyLgIhXLFUU6WFK2fCYnni
         Db0QBs6CBZ5Vx2mq4U/v9RuqQerzQutaGD5wgghcpAZMuaccC8J9sfDuf/TIt5g4VrsG
         fQfUOs32uYLFZLRyezgsyCcPG/bVho5rXVtnd+W3f8N8TSMExfFDNkoXhydC9/ZzKIo9
         V8hQ==
X-Gm-Message-State: ABy/qLankokI9f/Mp6nouFl66QdvWeuc0/2R+NArJqNLyfh6+YgP2ttz
        v3J4UZMXjRG4QiRlH2aDn0ggrQ==
X-Google-Smtp-Source: APBJJlGBsdMAo8vkO9FRjMoins0r2QRHghORQuVx+7R45F8dOTdw1ULKkbpPfR+FlaVpXMMG3um2SQ==
X-Received: by 2002:ac2:44c5:0:b0:4fb:85ad:b6e2 with SMTP id d5-20020ac244c5000000b004fb85adb6e2mr1570162lfm.50.1689953785787;
        Fri, 21 Jul 2023 08:36:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:12 +0200
Subject: [PATCH 09/11] arm64: dts: qcom: msm8998: Remove AGGRE2 clock from
 SLPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-9-cf6cd5c621d5@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=889;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yoWJ6GJyGYGui/AX8S84WLQnnG8TcTYdKofjI0ZYPxM=;
 b=sOTxyrH/SrdxXhWJ/GGTUPkJKWi2aeEF4LleEEjzYHyZQp8h2j+VrdYpbCzqLlQIzfaFHn7YB
 q0/mOioPakXDdWdhGitCOCXbjVgOF4uz32zBf81FjD/dNXKo5Gzn9ci
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 360fe3edcc08..547c3f9654a6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1599,9 +1599,8 @@ remoteproc_slpi: remoteproc@5800000 {
 
 			px-supply = <&vreg_lvs2a_1p8>;
 
-			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "xo", "aggre2";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
 
 			memory-region = <&slpi_mem>;
 

-- 
2.41.0

