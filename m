Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6377B021
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjHNDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjHNDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B2110;
        Sun, 13 Aug 2023 20:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB897628D1;
        Mon, 14 Aug 2023 03:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F3BC433CC;
        Mon, 14 Aug 2023 03:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983507;
        bh=U/jcmZcSKyShlCLEetgSKW5TVnEqCfOnHUEXUE/SIhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guor22GyB5T/CkuxuEOTvlnXBfHv5FUNf2wndT+P9NUbBq0+sbUe0Y1eLQeQy/xqG
         CoNDybfrNPKJzAE1W+eLX0WwOaPxonohdlioj7GIWLRjSSx/cGxmKKNqINRIzHiKi8
         Y8xq+jKwoHqXcPp7abwuvM/EhUzJxyJKnfofuCOm580Sh9hWsB6VDpyxO6T0qVtL0i
         nJPVdGkcVrYqds6SWu9EjjVnCUc2Zh74QXp1Y1jBoq2Tdl4QPXBTm+lUnhG2zuvHDQ
         qT5lu7BfgBVJ57hv5qRUEx7Lugtg21WvAlJm4CgAklTt84phr5TNOZ76nQdd+mw7os
         i3JDXx7ZE5AWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 0/8] MSM8998 clk cleanups and fixups
Date:   Sun, 13 Aug 2023 20:27:37 -0700
Message-ID: <169198364304.2443702.15824877092057017483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
References: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
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


On Mon, 03 Jul 2023 20:20:04 +0200, Konrad Dybcio wrote:
> The MSM8998 clock controller drivers have some rough edges around whether
> and how Linux should touch them, which this series tries to sand down
> a bit.
> 
> MSM8998 maple seems not to explode, please give it a spin on your boards.
> 
> 
> [...]

Applied, thanks!

[7/8] arm64: dts: qcom: msm8998: Use the correct GPLL0 leg for GPUCC
      commit: 00ada6afea88006187b38bd96b6d1b7d8e3d90cb
[8/8] arm64: dts: qcom: msm8998: Use the correct GPLL0_DIV leg for MMCC
      commit: 63f4e4b447c50ba7e5fc3929644d2d152acb6117

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
