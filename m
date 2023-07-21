Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16575CC06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjGUPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjGUPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:36:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61283580
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fdd515cebcso3292012e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689953783; x=1690558583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rR9bzwL/2EkjM64V2HNSB/hpDB3lc0to9f2fDn9XL0=;
        b=LzF+FGPmInmULJlW7yDmvDB++/MvRzyeazoEDUmCXBJyaJRnf7rvrXEpLPHM7s5gog
         XWdqhIZwheqmaD14OfyzBqFJoAktX75WHALLYU5SzrqnXS/qYz/xmrZG4DP+Rs9lAAud
         dCh+6eIga/xcW7LVO4Z0suVU1xck/FAbGIyQ+mPE/isw7ME1tWV8b4fCq0+SUuICcK6p
         YbmmmyskhBK11jBZpUqqph7kZ6mB/4sV9+ay4lq64zuGCuNuTiOVE8eKCrT1bOpcAYdF
         TfHrAZh5Au71pBCnnBq1AxCUXpcd+PyNq5tLHOR8T4mhMSym2J0ouzN9XQbToF30CqlQ
         1/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953783; x=1690558583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rR9bzwL/2EkjM64V2HNSB/hpDB3lc0to9f2fDn9XL0=;
        b=Iw3TkkjhaXmXmOFVstYMNMaIWl1ranlXOcZTTveiuVjZQQImMuSa4kE4fqbN9zlsGM
         HRE7rjKQIAbUVfEMvDF9G0Bq56HUckisf0dG9wMztsCXV/UE19x7RWF0jRzUNEDvQWXr
         vKniZDiZOoAYvniPDy0fF4lj4EZkFJ6GQrRD7azCV+GQWfCdR3wa6gVnmWLypThoVpkz
         MBRjybjLzcjKWKAIZIhVzCDfcdutNc9J0ZeWjKvM55YCLaBW2whbJkg5YLZlCdGDeNV3
         8NneSjcepqffjBlm7WwxuCWGtLUeob93g5P+Z0rIDsa2A0A3AOYqdPJixCAWAjJygkxC
         sXoQ==
X-Gm-Message-State: ABy/qLYbwjAhXN3SYeXautXjCVMrY1cJzWf4YKrIfL4rTcQgxewb1JWa
        koyK3+EcLFCgr1sZRQKdP4oziQ==
X-Google-Smtp-Source: APBJJlGGpUFVAT50ZUpSNGeOzHAlhQmE59L1qr/By3RprhWo4YzVMiVtgECA3+HlhiHHnd3Wq5Ixnw==
X-Received: by 2002:a05:6512:702:b0:4f9:556b:93c5 with SMTP id b2-20020a056512070200b004f9556b93c5mr1625685lfs.40.1689953783658;
        Fri, 21 Jul 2023 08:36:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fba1278e6dsm782535lfc.107.2023.07.21.08.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:36:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Jul 2023 17:36:11 +0200
Subject: [PATCH 08/11] remoteproc: qcom: q6v5-mss: Remove PNoC clock from
 8996 MSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v1-8-cf6cd5c621d5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689953767; l=688;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ByX0ALLp37/DmAcaRsF7N8pVxnlU+a9qrdni9EQxdYM=;
 b=7p9bN2xgsTSOoe6mRmgkKaeIuKX3I7onaaEaaEH3tcMwnDer0NB7Tf5/plVjt2RYiyYxCUXjv
 oVegS/72310Cy0Hjat0h50d2oPqaAYLvdpqEB5KIcC2M0QMa5DjzgGI
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

The PNoC clock is a clock for the entire PNoC bus, managed from
within the interconnect driver. Attaching it to MSS was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 22fe7b5f5236..394b2c1cb5e2 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2322,7 +2322,6 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	},
 	.proxy_clk_names = (char*[]){
 			"xo",
-			"pnoc",
 			"qdss",
 			NULL
 	},

-- 
2.41.0

