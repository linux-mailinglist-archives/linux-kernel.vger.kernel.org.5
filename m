Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356B7567AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGQPUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGQPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:20:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1226BE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso7448291e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607172; x=1692199172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ucP2HxOwgP4Yjc3Q8ZZBgQ8j1uIc3OmiWC7cbRp7SQ=;
        b=aAsyFds6D3PMJEXo1mRw7yaSFEFyCwzpw8bc7QERWt12x+GbYXficzoCDkDyBo7h4Z
         62Z6Rxu+5TMH3EeAAlv60yIOJkKs1lSTWu6iBieEmkUsquuIa11nMNQdHG1kcNXk6Jml
         vJ3dObu5l1Rzkk8/4WSFhvQI/+4XhyexGyeCk2bUjkLEU5rjBwlHMcklMQfaStrCnlHC
         0xORplVjcyGhMZq87BeArmLClMW1oKgWZH6VyMbA1rowzdSZMO1VTIDvtjbCAqA2QdlV
         Wng487nS0xowQ1eGL8UF+0LXKbfRkU6VVCeJzJxiPeyy1m56qprgDRFCfjNPyi5WNzZ/
         iDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607172; x=1692199172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ucP2HxOwgP4Yjc3Q8ZZBgQ8j1uIc3OmiWC7cbRp7SQ=;
        b=KxO1qoWZgpgPHMfyWtEoHoRXZAVMtfk+dYjnxQjupbQLnAv0Hr/oDx4nyf3m3eFM5u
         5h1ifpaGJJM8KC3GrF98ni2u13LzqpB9XFGzvoGtAWxkvLfKVA2zD2mDm2FNLzg0rd4K
         nrCWwtXHNliGavsD8RPyWx81UHOt3EpGG7w96Bwn9mtKJrrS4RgTQmOFmFnCKa4cFQFs
         J+ZihYUuc0bnuhQUhYAEeuXAP+SxfOJv+cdNUJYXXEFanrIPUCRivMnSFucq0ls2OvG3
         rcrRP/qeGKLxBAUZGhRDE7DLgpvhxmCDx6NvW+23wk+5S5VoGx2sRo4WVyFcoG3Lxg52
         KqHQ==
X-Gm-Message-State: ABy/qLZE5c98+HMGuNR7cvodOTIUCPW1bRzqPQlrlyE4QV+YR5NA8MaD
        TQ516Ir8V7yCzjx+GciGkpTXJw==
X-Google-Smtp-Source: APBJJlETFLB1UkIpgDT8VZRfl/t0P/UEyKDkNh0LsL4uDtc+FiFnAOYV9Piu5SCozU2cMNsEkgAryA==
X-Received: by 2002:a05:6512:3121:b0:4f8:6533:3341 with SMTP id p1-20020a056512312100b004f865333341mr8483185lfd.20.1689607172501;
        Mon, 17 Jul 2023 08:19:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:22 +0200
Subject: [PATCH 15/15] arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-15-27784d27a4f4@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=782;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KUdFQ1vDlHA4ohS8EU78+JEQV/TntyZtIcOU/vB61S4=;
 b=PXU+1NIif1o8q606ns3V3Z9OE4O7LZWnqOhTWMcpM/+BblfkOHNE3GpDoGEyTgvH3VTTUBZrq
 TubYMkT6OmRDcWp5p4Sj2bY+QorleRofBFq1lfUNCd7lsYo875iG8b+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU_CC block is powered by VDD_CX. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 29b5b388cd94..bfaaa1801a4d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1430,6 +1430,8 @@ gpucc: clock-controller@5990000 {
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			required-opps = <&rpmpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.41.0

