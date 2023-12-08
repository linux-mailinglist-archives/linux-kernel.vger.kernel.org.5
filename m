Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721080A5F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574058AbjLHOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574044AbjLHOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7477B1999
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC8DC433C9;
        Fri,  8 Dec 2023 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047071;
        bh=ohK5wX1yFJfy8/8zjMggRBNNLI7jTP/Vv+IAlntxkNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddDBkLl6lE5iBcxFWJMiFQt3fVnLr/Cwbzih41o3YRm2zukZm0dTh7ddZcogheTXm
         rHqbZlRyEceL5LTNoabbZC5/xtYECeh4Az5iNOqz6ishtpWn3ChVQBE3E9jC0DFpBy
         KKpBrboJ+F2EBZ5S1TzsfiBYwdgBNHT1M8Tewo44ztTgL8SxUCT8DzKtRNYMdkkPM3
         FT9ObRbUmW4watQwVLjf0c7jWSM08QRSYudUebfFv46GbvHFUZ/J1tQ23hu5VoPp5s
         oEOOZ0UFNIIcn9SGcnp/JXT15aykZP88Jy1dU/9YjVsLktL3yLh4A82XxYs2hNxnCJ
         vH2fG+OYN8J4A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: (subset) [PATCH v3 00/12] RB1/QCM2290 features
Date:   Fri,  8 Dec 2023 06:55:19 -0800
Message-ID: <170204733634.342318.13908717706706425417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
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

Applied, thanks!

[04/12] dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
        commit: 56fdc35ef067c8dffee22038dd3a84bb3fa6d2a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
