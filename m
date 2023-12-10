Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3696680BE28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjLJXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjLJXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A28F1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58EAC433CD;
        Sun, 10 Dec 2023 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250476;
        bh=VJVGmOcmvxDg+2Q6DzzktB9ab6LfUMqLIbFh2jLy2Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWKXD/+63HmoiF1/vPwh/6eVOq9q1+VfZ9+64SvtCHaYNa7KXDhcHJw2WljqDIr5N
         /1hsozP/JYUXfiXS2Mu1L1JfgeJvHHM6p1zSZGk44IaQhNaTfpQu4/fseAXd3b1GOI
         0hmiADOzdii2/akWE5wt0X2YzdVq3D31zHLvMy7ZsjokEPfV3EuAj42eXWnv+0q36T
         GIR7S0lPNxtO5LY2mcP9e5rG48h3fmZ/XDdnGQuuy+BKvlvio3mxj1pFYSKIpBpx4K
         UMA/6UgLstM/GJRhbVHxJRRDxNtlxjGIL785B0iIpj3U6q72Y1VwWapOmDSJ82d6yj
         6bzmakW6Vl7sw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Subject: Re: (subset) [PATCH v6 0/3] Add UFS host controller and Phy nodes for sc7280
Date:   Sun, 10 Dec 2023 15:25:38 -0800
Message-ID: <170225073874.1947106.18057937177931917498.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
References: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
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


On Tue, 05 Dec 2023 15:38:53 +0100, Luca Weiss wrote:
> This patch adds UFS host controller and Phy nodes for Qualcomm sc7280
> SoC and enable it on some sc7280-based boards.
> 
> Pick up the patchset from Nitin since the last revision (v4) has been
> sent end of September and is blocking qcm6490-fairphone-fp5 UFS.
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
      commit: c8a074789d71c1e26920f9333125590fac84f8c7
[3/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
      commit: 9b07340c55a8e918f2667fb911e9b2edc428793c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
