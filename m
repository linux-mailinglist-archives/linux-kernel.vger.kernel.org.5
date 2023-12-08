Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298580A637
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574122AbjLHOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574187AbjLHOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:52:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E991FFD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7898EC433C9;
        Fri,  8 Dec 2023 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047090;
        bh=duzDMwVPfMWdsskBcHQN/k5Q3K29fjCRZdJxqrVUZv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axmYB1Gzcf5/eLaool7yq0QSwnx+xWptAaMj7cUPkT28dOjRqPvnj3yAAoH0uxzxH
         hCduRvGHWYWzjNq1+kN5Z7JdYJ6FHjOVUUfymVU90Ddj78K3ReEa2n2d2/veLY38DM
         LoI64dMJNO8W2AxNPbkXqCbeM9CMiLek0bgjrnJK2t8uYR6F2JmvkYqggSi7g8oC3V
         u1/iQiFoU8azUh4QonCN3zQgMKs5mfZGRY7L99W88OEI/hFk1WLUDY9cPqKTjoT/NE
         JXL/SuLK1MxCl/GQpngq/U1vgnXOOef4bFrLyoAtdBS4A9ptECwzATXoOgcQNkeAjV
         cQtGrN2bBiDBA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        ulf.hansson@linaro.org, Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, conor+dt@kernel.org, ayan.kumar.halder@amd.com,
        j@jannau.net, dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Subject: Re: (subset) [PATCH V5 0/5] dts: qcom: Introduce X1E80100 platforms device tree
Date:   Fri,  8 Dec 2023 06:55:36 -0800
Message-ID: <170204733638.342318.11497127096348386267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205062403.14848-1-quic_sibis@quicinc.com>
References: <20231205062403.14848-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2023 11:53:58 +0530, Sibi Sankar wrote:
> This series adds the initial (clocks, pinctrl, rpmhpd, regulator, interconnect,
> CPU, SoC and board compatibles) device tree support to boot to shell on the
> Qualcomm X1E80100 platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: cpus: Add qcom,oryon compatible
      commit: bfea2924fc28b1b9985a208223f315992a68fc56
[2/5] dt-bindings: arm: qcom: Document X1E80100 SoC and boards
      commit: 7a85cecf98ca175d11b7133f7c4e88bbcc0fe5d3
[3/5] arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts
      commit: af16b00578a7a1d9fb99e81282b1b22cd8d32607
[4/5] arm64: dts: qcom: x1e80100: Add Compute Reference Device
      commit: bd50b1f5b6f38b2970841e78513c33fbd736cf40

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
