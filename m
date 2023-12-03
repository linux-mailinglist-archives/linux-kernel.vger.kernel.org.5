Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90FD8020BC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjLCEvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjLCEvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7B118
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD57C433CB;
        Sun,  3 Dec 2023 04:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579102;
        bh=mSFcpxgFtaT67VtAi3ZJBJECaLDzlAVHXScB3GicCTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSGYE2lTh+6Iskz1gv5L8Cb3Ls6t+ykrqkzct8dHQx51/DAQPWaiR8smpYnSqK5Lg
         Yoj77MPsCwQ488kY+uUM450SujZ/gl84vTe7IhpglbZKt5C83FqK+Bk/9So077jUxx
         0Hida6oJdz09c+kaxXkUsKVd58jB+nTMi4Ccxt3E76tUy7UQwWhnRWxwlObxsmEx4G
         mATaGkP7Ft0xPSZOkTvku/F2afRRnn5qzZs5k5CUVs5mgykYzniSEzXPNpqG3f+Kt6
         rXkPja4VniLrzE2d4QZbKjegF1hTv1t2NDMSkSwcQvEBata6d5m8kiso7MuFqA23Ck
         WTQBWbZw0gXAw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add DDR sleep stats
Date:   Sat,  2 Dec 2023 20:54:33 -0800
Message-ID: <170157925821.1717511.425797126957735781.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Nov 2023 15:58:20 +0100, Konrad Dybcio wrote:
> RPMh LPM stats are quite extensive, but we can extract even more data by
> poking the AOSS QMP. This series adds DDR stats using this approach,
> setting it up on 8280 as an example.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sc8280xp: Add QMP handle to RPMh stats
      commit: bcaa71f13cc7160f2d5f9a401e9c58215612f79e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
