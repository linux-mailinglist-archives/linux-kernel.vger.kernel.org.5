Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B27D1E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjJUPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJUPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F34135;
        Sat, 21 Oct 2023 08:54:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D94FC433C8;
        Sat, 21 Oct 2023 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697903698;
        bh=RX/aqLDP1xRIhQbjEx9lk7WX42AI/4GHzOPjcXiwNd8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IMw0w5lgnQVLGFX1NMn08Lnthv/evMHQmiMO1+p7tAU3QC2QnJz0NqW7NAFdZ5P8S
         7PtP8BD1zW8GS9iO+Y8ucjA49uUzIGnIGnwr3wE2B8Ve2xRZLWF2d2kYM8l81b6QZU
         g77+gXxiSNncBnsZopqbMhAli8ARoIco1S/tOFX6L7BIq4j7nKZkAL41HGLzOsg2dN
         wF8bOC2sbDTo2Erc1eHjwubSfFKm5DdeJnpq4GiCGD19xCQMh7t3mH6QsOPwMvjTTc
         +QGKbPdyvSvJvCba/BV327ulnoqViqv8qUM1qH/RKmrTj3BOOq3Efyzp0bEwZZeVNs
         zdt0DwWq53Ffg==
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
Date:   Sat, 21 Oct 2023 08:58:33 -0700
Message-ID: <169790390713.1690547.10661636631598722761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697781921.git.quic_varada@quicinc.com>
References: <cover.1697781921.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

[1/9] clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
      commit: 6a15647d0adc686226045e8046369f34d6ab03ed
[2/9] clk: qcom: clk-alpha-pll: introduce stromer plus ops
      commit: 84da48921a97cee3dd1391659e93ee01d122b78b
[3/9] clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
      commit: 267e29198436a8cb6770213471f72502c895096a
[4/9] clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
      commit: 5b7a4d3d2b33398330aef69e0ff5656273483587
[5/9] clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
      commit: 00331227f42045314b3775957f2f7809fb3ac32f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
