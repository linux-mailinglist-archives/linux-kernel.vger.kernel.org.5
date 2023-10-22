Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106147D2486
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjJVQYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjJVPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C593A7;
        Sun, 22 Oct 2023 08:46:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22AEC433CC;
        Sun, 22 Oct 2023 15:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989577;
        bh=HvRuPV3FqtsA6ZyEHaakvnvDdaaCIZbT6hNYmWIxek8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mYZVm9UkAsQIYgV+niOicDOLFgCPxlBBq4ORwrqDCH0gv+DtamxSAb/HoGna9MK9+
         ibZ+uxVyZi273lcC0tjLXQUtuJqxH0vI+vCLiefMAK1WIG9FAp8+gxei8fguSFZ+FH
         JANSz0Zr0M6FddS0FVe6BeDbLdAL2S2nvkE4PdT8ELNjG8vHp3CGWjVyOlWUZL7l9e
         Wuj0uRV+MxaqdVOjBDVk2frcsZerYHdhfgp2vepr67FnpyQ1FteUdjDkh1JHMZkMjT
         hqEwtU377FgWtCU9eDF/eX/HsY0iwFbK/aGiwefz4v/eUQu9y3g2pdsK6TDQ3S9HBu
         sSBuP+WF5mtZg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/9] Enable cpufreq for IPQ5332 & IPQ9574
Date:   Sun, 22 Oct 2023 08:50:23 -0700
Message-ID: <169798982279.271027.9280015987469447845.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697781921.git.quic_varada@quicinc.com>
References: <cover.1697781921.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 11:49:30 +0530, Varadarajan Narayanan wrote:
> Depends On:
> https://lore.kernel.org/lkml/20230913-gpll_cleanup-v2-6-c8ceb1a37680@quicinc.com/T/
> 
> This patch series aims to enable cpufreq for IPQ5332 and IPQ9574.
> For IPQ5332, a minor enhancement to Stromer Plus ops and a safe
> source switch is needed before cpu freq can be enabled.
> 
> [...]

Applied, thanks!

[7/9] arm64: dts: qcom: ipq5332: populate the opp table based on the eFuse
      commit: 62073bc9f1ecc0d91fc260e7ae380cbadd33e9fc
[9/9] arm64: dts: qcom: ipq9574: populate the opp table based on the eFuse
      commit: b36074357baf2794c825ea1c145de1d22b15380b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
