Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C4802104
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjLCEx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjLCExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:53:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40461FEF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130FEC433AB;
        Sun,  3 Dec 2023 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579130;
        bh=YeuRHBoPNkVCSPmwTY3GoodEH4nWjPlyCrxZ54RUWYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9Uuz6pbGx11AvtiMJ4etSscKGbgihUgEEV3+UHNl3bp/VgPl8B+NO1t2xzo3rgEZ
         U7hmQhb4QZREGGcc0vPGOlZ6Y6eLuSJxpJHu1mQm2lyq9kGaGRuyF5iQbURpAsNhO0
         I8nf38lV1BZotOFB1+s86bGNOJXpfQ9EP6PcTSC3QkG+x/h16Lu9DIMcLLFoUxqrVP
         PhlLDGKJw35bLbOnPciW7mLHTwHLcnI2J1XyHA5EGBtYSV+Wo6r/Dqg45cJ3ZGgXYq
         aFjVFwlFWI81d35Lvcht6Sd0NLVVXMUAHzCQAmiTut7oodWJEiW3X/XsvdXXnx/Vzn
         Mi3L4RUHJsLbw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
Date:   Sat,  2 Dec 2023 20:54:55 -0800
Message-ID: <170157925810.1717511.14579487412126117705.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013164025.3541606-1-robimarko@gmail.com>
References: <20231013164025.3541606-1-robimarko@gmail.com>
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


On Fri, 13 Oct 2023 18:39:33 +0200, Robert Marko wrote:
> QMP PCI PHY PIPE clocks are inputs for the GCC clock controller.
> In order to describe this in DTS, allow passing them as the inputs to GCC.
> 
> This has a benefit that it avoids doing a global matching by name.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
      commit: afc4f14be33c50f066392f1e9671473419ba7ded
[2/2] arm64: dts: qcom: ipq8074: pass QMP PCI PHY PIPE clocks to GCC
      commit: 591da388c344f934601548cb44f54eab012c6c94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
