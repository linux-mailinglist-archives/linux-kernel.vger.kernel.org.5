Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEE8099AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573088AbjLHCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLHCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D6199C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE1DC433CB;
        Fri,  8 Dec 2023 02:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004006;
        bh=ySYaqR1gCbXQ0lYTZYxnK4X5Qq4e8T45+LzfCUwAkb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYXb0/w8cSPIWtlvc2E+KYDUjlvzlUSXIT7oNdaYNdWeYmEr/B+LcxKRXDqcZFNbj
         JONnPz+wgnz6t80BRCYDirxPMpwAqj1N7Kp9OdSySUQ0RVS7flrZG7Ps96uAuiGL7w
         iL45D10LSebLvOfYRE0nRtxP9oeMkQP4x3C85e7lRmvDtB/SFZecyt5lHmrXttxUQp
         16UEjWOsdNCbkkmb+nPmhAYpUmJIcCep6lGcbXO8GuhOyuXkihNeicFCaE45vi2EoI
         Uqd9SVuRbdzCwHBwfVX3JK4RpCJm+YVcdkxRr7no2vgjwca9zYzW+i9Vv2pg3e4Ze4
         hNA1NEZAJT/eA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Adreno 643 + fixes
Date:   Thu,  7 Dec 2023 18:57:30 -0800
Message-ID: <170200426929.2871025.2570466324360786509.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
References: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
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


On Mon, 20 Nov 2023 13:12:51 +0100, Konrad Dybcio wrote:
> as it says on the can
> 
> drm/msm patches for Rob
> arm64 patches for linux-arm-msm
> 
> for use with https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25408
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7280: Add ZAP shader support
      commit: 0ab1bef0b7c359e672cc2b8d51f0179cefa369fc
[2/4] arm64: dts: qcom: sc7280: Fix up GPU SIDs
      commit: 94085049fdad7a36fe14dd55e72e712fe55d6bca
[3/4] arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA coherent
      commit: 31edad478534186a2718be9206ce7b19f2735f6e
[4/4] arm64: dts: qcom: sc7280: Add 0xac Adreno speed bin
      commit: 6a7f8c635dab30233df93b5566d4169ed956b71b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
