Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85E376A523
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGaXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGaXt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAB1198A;
        Mon, 31 Jul 2023 16:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A74EC6135D;
        Mon, 31 Jul 2023 23:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1AC433CC;
        Mon, 31 Jul 2023 23:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847390;
        bh=NrM8D/pRtgA8u9+xv5ucAKjBAYNZkgUlEzf9jXHLqbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNI5iizQxnXgqHw2mROmp7NvMwrPYKp8qS8TOMviNQauzoXKSHDTGlCy6yfsz/Lt7
         ICSk+Swa3F1jdu2kILd8O2pOYkHIXuLMIVAlkIuNcBaWnO89nvTURmN1ysE87Jeaw0
         ZW+Kxtl3ioK0PhYsfEp7k5kWj0tUh8RNuJ48SyKgrpIH2pOS24q606UBTzI+NSQik9
         Sdq3AfMrQAN/3e6llfZe8x5XCHevOobzGwmkJN4Fr0FD4t/hCBtqe5ZiI7OaCQUHkg
         4tmj1OC2u9M5uAZJwjc8Nm75jc+cNSkcAbs3CRpWWGSt7iyP6BvZmHwbHhr5/a2nJ0
         Yxp9Wse0vrpUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] MSM8996 Pro CBF scaling support
Date:   Mon, 31 Jul 2023 16:52:47 -0700
Message-ID: <169084756381.3010488.6982581507928196439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230527093934.101335-1-y.oudjana@protonmail.com>
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 May 2023 12:39:31 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> MSM8996 Pro has a /4 post divisor on its CBF PLL instead of /2, allowing
> it to reach 192000000Hz on the lowest CPU OPPs (compared to 307200000Hz
> on MSM8996). Add a compatible string to differentiate between the two and
> handle the different divisor in the driver. Finally, add peak bandwidths
> to CPU OPPs in msm8996pro.dtsi.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
      commit: 434cb57732cd6b39c41a218f2e1dfddd5373fe1b
[3/3] clk: qcom: cbf-msm8996: Add support for MSM8996 Pro
      commit: bc48641a68dcf9998c78248ce7e79d1a492463c1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
