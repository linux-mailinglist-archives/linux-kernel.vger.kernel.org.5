Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3508C79D263
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjILNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjILNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD872116
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso7115534a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525533; x=1695130333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45YFU5JcmronSMHtWIJchtM2DzmSuCT4y1WBsd7RbnI=;
        b=g26vSFBEi982CZiaJtFxJug3FsOi1RP+p3SsgR3dX7flpKK3UEB+o8Fa3Ky8xym3rl
         +XP3tasvcMfoYtL8FakGHwXnttTtVMiK7ChCWmBX3WSTqpV9qqBEaDalAFoKL7bzy/tA
         Fv6j6TxG51u26x+uWMeAw3aKJk4ImEbCMwvH5pF/Y5V+RJHFUhrPRDctCLQbmY6Cetzp
         VB57eY6Nx8CSBVcIMavThavCWPyRsoE4UkB4fVVhz307Awto8UQ6k3b/mdL61zAlill7
         z7H34vbZd6JNMDljiFZFmwcNHcW2Y+wFu+/f7787BfuS6qTGO90GtYUhfWzpa7U7sNkj
         LCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525533; x=1695130333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45YFU5JcmronSMHtWIJchtM2DzmSuCT4y1WBsd7RbnI=;
        b=pCI0eQO2H7Ubj8qvYxpvwXGyN2dF3yLkU6xAev9eh8SIPzePcF7wajTOb+6X3XMghw
         zJd1ES1fQVFJOf760OaF97hKBf2UdXehAcbr/lj8a1FYqi5Vj5NsLmrOfemjxrAdtQPy
         jCIqjjRMyf/HsCNDilakqn5AnwUdTXfnuGeQ95vfc4KCsHeuWLboYMsbN2QMwphcZe0u
         ucDUBi+B3hgT4U2NWESURT/qQk1YmwMAIN7yIlaw/uE957emjnSJtVjiSvWteD3QGhtp
         MGeZlr3l/ymM1cHmB+hbsJR0TWrdDAjTpD4t8tq5jIVg3QoR3h4z1Q1apX7Fu99VFQzW
         nkDQ==
X-Gm-Message-State: AOJu0Yy/pp7XjHygeaU8B1VrP0cOM09MEj/bhlwqvg3ZaE3/E+P8GV+z
        PZoYPU2XhVZxNYYl4pJoxkBK3Q==
X-Google-Smtp-Source: AGHT+IFqpnswu8OnBmINYA+lldI8HWxw2rBKgaEqSn1Lel8BXqQ52DxoMkZOSrQPuXC7VTtdKwRz5Q==
X-Received: by 2002:a50:fe8e:0:b0:52c:84c4:a0bf with SMTP id d14-20020a50fe8e000000b0052c84c4a0bfmr10274612edt.30.1694525533476;
        Tue, 12 Sep 2023 06:32:13 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:50 +0200
Subject: [PATCH v2 12/14] arm64: dts: qcom: msm8996: Remove AGGRE2 clock
 from SLPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-12-1e506593b1bd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=853;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lSiwdkbvQabczgwyXIMk1Ll81JJNyjV8OASMQGT5ls0=;
 b=FbB1+RF12wYQcbxElETqL0vcuCj9+AfFrDtI5q+xrU73UuBoobmmh6+VIjF0kpYJwu7InjkhH
 Q6L3caabD81Be/2QZCyXYTsVkF1cq09ZG/XMoNlJ1Bxc+C2QeyTW8C4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index acef67ab0581..7061a8e12c81 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2433,9 +2433,8 @@ slpi_pil: remoteproc@1c00000 {
 					  "handover",
 					  "stop-ack";
 
-			clocks = <&xo_board>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "xo", "aggre2";
+			clocks = <&xo_board>;
+			clock-names = "xo";
 
 			memory-region = <&slpi_mem>;
 

-- 
2.42.0

