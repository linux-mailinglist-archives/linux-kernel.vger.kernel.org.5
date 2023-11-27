Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4293D7FA0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjK0NWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjK0NWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA261A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78255C433CD;
        Mon, 27 Nov 2023 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091356;
        bh=35mSssdQ32iia6B41JAGWk9Z95xz7+xMRF65KM9/eUM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u0kxVcFL1u3Tut+idFGtQrKOgeBXK0Q9kX+gNESLPwytck9pOdMAca5r40EtdASty
         CbcOWKmsPxbKTUbfCulvFSxoUul56xoqpvpopxl0oDfDglqR/v4xSVleH0dWh2NWST
         b0llnAQ7g0CSlov87WUFzoSYZqj39oRfuSZH+PVUjprQeAs2aKMgZR6FbP/nbriYXw
         e56EiPxa6C6qhNr4SeJxixN2MPPxMt3JSdkr1jmGrfxA29VgIkGrucdMDQynZG3LE/
         qhRPct7jH048cWmt4ZsU1fQsJqnhF6tOjK/FF/MPwAWWp5tiUzsA4om8xI+1q2iPCR
         RCoEcx0JZ3u4Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, dmitry.baryshkov@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com
In-Reply-To: <1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/5] Add USB Support on Qualcomm's SDX75
 Platform
Message-Id: <170109135110.42627.7639304783931136606.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:31 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 10:42:00 +0530, Rohit Agarwal wrote:
> Changes in v4:
>  - Replaced the v5 offsets with v6 offsets as per Dmitry's suggestion in patch 5/5.
> 
> Changes in v3:
>  - Removed the unnecessary change introduced in v2 of patch 2/5
>  - Added Fixes tag in patch 3/5
>  - Rebased patch 5/5 on Dmitry's cleanup patches.
>    https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
>    https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: qcom,snps-eusb2-phy: Add compatible for SDX75
      (no commit info)
[2/5] dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
      (no commit info)
[5/5] phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support
      commit: 7f6f9e0def00cfaeb1d034fd13dbd84470aeccbd

Best regards,
-- 
~Vinod


