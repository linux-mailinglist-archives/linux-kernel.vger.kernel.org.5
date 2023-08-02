Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC076CCE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjHBMid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHBMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F42706
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so30005821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979899; x=1691584699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/arHXwGDpg0PaLjq3SVx/1vOD3CQunADkBlXywyjWc=;
        b=pzjM00rclJ3O6oMZD6Vt6W+n1moVRi5fOb2JrgpCj8wKpTq4/z6+RtGZEJvxRXBtZV
         WndP5sU5ASyp3G7zpmVg160TH7sMgywghbM7AA0LejUZIJxH0ddd2J6md27Jjr+Z2whu
         rK2ZKj46vxytOk853vjyuAEJRubLDfTTimGagp6St25tx9awbuMupq6n//43oG4a7Vaf
         z75+e1M/CHOF3jNdO4bQ6PnrGeIE2OZBu9MGnLUHr58UGXwtPTLNQUYlRP99ps8KSEfg
         C4Ao2mTaasEFK5MMVn//gdktkxTHXEXNzocbeJe4jJRNO9ep1WdFKjaduBY1Mwy3NqQM
         GMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979899; x=1691584699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/arHXwGDpg0PaLjq3SVx/1vOD3CQunADkBlXywyjWc=;
        b=VK4CyFkgaDV7O4vMRVbXe9klAL0UunBOB2QqF8WSofd1fCWVSeix/o+9MJ/O7z1ihj
         JB5qnt558Ur5QgXE/ooEusIkAXckkNixTB87IGMfcRhwJm57lKQWKy7Gvwy83sMJN2R3
         cLCMw7VDWdj0+hxZUWPU34cWDcTFWhBcrT9tAkFHtUYvXlEKRtwTQUJ/XyCVbQ6WXA4J
         Q2O/Jy/K/cW9lkbZGVWIHZ1bFH/WRwruxjmOM0Jx2Ewg1NQU0ldleVudqEhU6iLwkfIi
         xNwbGpVX9AAoR+CYB0N7lL5lhu28maTiPGv9BEGJLfKO6yf51FdLnGfZp3RmsOSD6LNx
         d2LA==
X-Gm-Message-State: ABy/qLb1BZYM36Z9dABeQvNRg03xL6rWsbe5wCazOe0uVlgFzBpnF3K7
        qb/5ewS3uBJ2IdIVAvEEPn36RA==
X-Google-Smtp-Source: APBJJlEIw9eIfqcPtLZzNmEUFCp9vj9/HnXINY+FrqvSgVQvrQnVQDh/HFfTYafJpEBnYcmADWIIvg==
X-Received: by 2002:a2e:980c:0:b0:2b9:b41a:aa66 with SMTP id a12-20020a2e980c000000b002b9b41aaa66mr5429905ljj.20.1690979898810;
        Wed, 02 Aug 2023 05:38:18 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e9ec8000000b002b9e5fe86dasm1897050ljk.81.2023.08.02.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:38:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 02 Aug 2023 14:37:42 +0200
Subject: [PATCH v13 02/10] MAINTAINERS: Add entry for Qualcomm
 CPRv3/v4/Hardened driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v13-2-d01cff1c54cf@linaro.org>
References: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690979891; l=984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2YiA3nGNcsVPCq1IwlTdMAqStD1lE3rx04PXJ5i83As=;
 b=/aE9/NxMNY3o+ds1NwBS03mBqZjAuS1DKfNpv8RGPTcD4ywBrlNoAWFXhqTRhVaZtzCiJY7vE
 My7YAfaWacCDkCONSmD6pJ4K1kNF+ar5KWeXMz0/H/aKp3zvAJxU7E8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, update AGdR's email]
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1089ef3319f2..a7514261b157 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17621,6 +17621,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:	drivers/genpd/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.41.0

