Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF48020EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjLCEwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjLCEwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30B1719
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C83C43391;
        Sun,  3 Dec 2023 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579115;
        bh=A7VTE3QnSrM8Wjx5d/M9Tr6CaBcSbMf8EZFHwWCBKnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbJw/jMDi7dk5/KLyZnLIZfnTrSD77+Yr4Pe3QH3eCihgfCjzI9tUnnu9vDAHNR8C
         k2iGKimpFoHzl5kJSPakDEksqXvvswhnAfs7LCKNoDr9KwfmXuTSIH3LqXCBORaTHl
         e/WEwEjM1kAvhFnwqyr6BaUsEs/CaT5Rjg12zGHIPoDC6MKITd3bTmaKPKmyMDl9tA
         GvZNyCHqabzsJ3y/u+XQVJJSIGs7iUCgVh60PauCSm5A2EtGdnMi3jlIfpaeo3kGkK
         0l1gi5pirKzOA4brSKRw8D+A5mJuD56i0WA3FfOiD97720/7KomF8Qk3XTemjKnOnp
         I3cWnAqVqtVxg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] Add support for HTC One Mini 2 smartphone
Date:   Sat,  2 Dec 2023 20:54:43 -0800
Message-ID: <170157925829.1717511.13771309872564773437.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125-htc-memul-v3-0-e8f4c5839e23@z3ntu.xyz>
References: <20231125-htc-memul-v3-0-e8f4c5839e23@z3ntu.xyz>
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


On Sat, 25 Nov 2023 13:05:32 +0100, Luca Weiss wrote:
> Add support for this smartphone from HTC which is based on the MSM8926
> SoC and codenamed "memul".
> 
> Depends on, runtime-only, bootloader enables watchdog so we need to pet
> it to stay alive:
> https://lore.kernel.org/linux-arm-msm/20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz/T/
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: document HTC Corporation
      commit: d69e34675a8be0affe8c55dbf50f795dac521933
[2/3] dt-bindings: arm: qcom: Add HTC One Mini 2
      commit: bfccc195192ea6ae72a4a49a85c94f1ad8ee7a13
[3/3] ARM: dts: qcom: Add support for HTC One Mini 2
      commit: be0061dcbac1b6a5a1cf681f7cabbb2681ab0e2c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
