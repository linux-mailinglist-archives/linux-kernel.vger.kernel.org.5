Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7380F45F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjLLRV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjLLRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D5E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121F8C433C9;
        Tue, 12 Dec 2023 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401688;
        bh=iJbsCCsQPExgoBlXs13IszghcdhAlE8CqVmzx5/6CUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjNBK6p0cc6mZk7B3InU4ICb7IP8uBhF+KNLoACi3S+7zVAKgZH0b4X9E9LQy9kMZ
         ITnv4OYQg+erUKTrk1aeZ+z+pit1r0iUPHhFCjKFPbYyC2Obok34R0/U9ZG4NLIv+2
         7DcaScI78W4tvHyFDsQuTQ4V0gkWACMGbK/PuI/iSscysuZjFqbo0R8k0ko/JfW8KM
         tRyB4SCg6BmzBDnDt1tQtJXeNrc2LKWW/mj8JeArHn120+W4epFDm5cAbtHJlqgeJE
         lBqjabQH3m6Wd/qKL4NGv3UnTyP4rZmK45YWaPn2q7xOQBYFLHjUU9gWn7sXx5PyAf
         vCLa5e4BJUQkg==
From:   Will Deacon <will@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Gross <agross@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Sean Paul <sean@poorly.run>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v3 00/12] RB1/QCM2290 features
Date:   Tue, 12 Dec 2023 17:20:55 +0000
Message-Id: <170238433491.3098250.94876533885104502.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
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

On Wed, 29 Nov 2023 15:43:57 +0100, Konrad Dybcio wrote:
> This series brings:
> - interconnect plumbing
> - display setup
> 
> for QCM2290/QRB2210 and
> 
> - CAN bus controller
> - HDMI display
> - wifi fw variant name
> 
> [...]

Applied SMMU update to will (for-joerg/arm-smmu/updates), thanks!

[05/12] iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible
        https://git.kernel.org/will/c/28af105cb650

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
