Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359277B022
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjHNDZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHNDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA3110;
        Sun, 13 Aug 2023 20:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5996627FA;
        Mon, 14 Aug 2023 03:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E32C433D9;
        Mon, 14 Aug 2023 03:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983509;
        bh=gydjJyUCO/5hN3ZK6M7GS4n9Rqgo6EY8zQTaNi5iMRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lpk8jvFjXD9GDqAOfWP63nus5HXu8IUdnL26enLEdQlVcNxw18mn6RJt8a3MjlFdx
         yxM5SrWe9G5cGmFcr02YhnO6pTF+nOsNjNY+sLot73CPAQ7zyuAfcRpovYQehkeY6O
         X4Yo/J2TT/pdg2m+cQVM3OKytqwt33rJ6AJMP3C89pjBuJM0w/+CushykAopJHygnL
         Wis0/FJtNKAm0xS23MZbvnw2ecKB4+Zcawr09rN7ZXa62y2VfXfLdpyCWnK+bHpgCW
         31aNocKb6ArgoAtBk+N2TFRzIh/atnwagHD6FWu2s8zOYKW2t7617u0xKlgE0htJnE
         isO5n9pXqANKQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/6] MMCC MSM8998 fixes
Date:   Sun, 13 Aug 2023 20:27:38 -0700
Message-ID: <169198364310.2443702.11310037157299492335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Aug 2023 21:20:23 +0200, Konrad Dybcio wrote:
> 8998 has a couple of issues related to its clock controllers. This series
> attemps to fix some of them.
> 
> The DT patch should go in first for bisectability, otherwise
> clk/pd_ignore_unused will need to be used, as the SMMU GDSC is no longer
> considered always-on.
> 
> [...]

Applied, thanks!

[3/6] clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      commit: a6f1e8623836bb6ce64c347d110ecb6259ae73c4
[4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
