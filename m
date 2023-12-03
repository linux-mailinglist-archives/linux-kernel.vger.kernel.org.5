Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9746D802102
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjLCExe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjLCEw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3B1FDA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36CAC433CA;
        Sun,  3 Dec 2023 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579123;
        bh=ZBfzcLulAOvvJhQEAYYfDB7Z+ayWI/kok1IjU4/gA0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vn6SCojkEybCRbKi4FmI/T1TXpNxRPhCWP2wj7pMH3R2WZUCVCLVZysPXBuHCL0od
         ixonDRHAvOPLon2y+ZsBogn5n6AtmOIcpXGgLqVuuU0NRRXl96i9c9cU9/eehkySP+
         ptSnrXogUOe2SUN17WreTbIdENSgHynb1Y8Kg4laq50mwjSvtr7bG24Y8fmDlc11nc
         EzVqCnEEAH9FThnzg258TRAHLQfYVP6iSiIUM7Q3HAFNr+cEb2u3E5qFw6XyyyHv2/
         qlEDKWUgx7ikvdj7AiI83/yTiZ/1AuKYjsZWe6ib11T8PXr6DC9yjNjBXEp5p0mrJ5
         d6d8mcSQ3F4jQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.baryshkov@linaro.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: (subset) [PATCH V3 0/3] Add APSS clock driver support for IPQ5018
Date:   Sat,  2 Dec 2023 20:54:49 -0800
Message-ID: <170157925793.1717511.11308464222863488586.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
References: <20230925102826.405446-1-quic_gokulsri@quicinc.com>
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


On Mon, 25 Sep 2023 15:58:23 +0530, Gokul Sriram Palanisamy wrote:
> This series adds support for the APSS clock to bump the CPU frequency
> above 800MHz. APSS PLL found in the IPQ5018 is of type Stromer.
> 
> - The first patch in the series adds the required a53pll compatible.
> 
> - The second patch reuses Stormer Plus PLL offsets, adds configuration values
>   for Stromer.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
      commit: 3e4b53e04281ed3d9c7a4329c027097265c04d54

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
