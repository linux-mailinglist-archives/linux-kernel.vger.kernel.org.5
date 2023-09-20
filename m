Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59737A8A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjITRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjITRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F55A9;
        Wed, 20 Sep 2023 10:10:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D232C43142;
        Wed, 20 Sep 2023 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229817;
        bh=QYX3fNOvU0hTAEO3rl7RQlLTMCi1Wz+F8nJ3IGYH4lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETZVjDxQxJMp+WduqsIlvWWcFzWU96/Yk3yYZ17ZZULSJm8iF8aiuTEBAmRuNg7Nz
         k7oUmq7Ae9vUfPM/jBsSsVE4vB1arVw1tKznw7N+BO8gNbc6A1MEQ4WtNlSiaSHkDH
         YJD033EWSF2tS26D8GUrjxKRi0y/j9193Jr34S13PbdREVkIqMuaVzyXtHmSm2xM+N
         v8K6A3IBfhxlwcGPMX8FwFu+luQu2MpaU/st2QUJwTMS+9DbhC5ucnE8wV7llGyCRt
         WqM2n2ekJYGD1u/AsPy6kdI+aYn1Z/N+y9Cj/c9YPmLwzV3WLPOLdhUqCwAlWUXAmc
         Dtc7z1vTL17zA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: remove ocmemcx_ahb_clk
Date:   Wed, 20 Sep 2023 10:14:04 -0700
Message-ID: <169523004965.2665018.3540985295032371662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230902-msm8226-ocmemcx_ahb_clk-remove-v1-1-8124dbde83b9@z3ntu.xyz>
References: <20230902-msm8226-ocmemcx_ahb_clk-remove-v1-1-8124dbde83b9@z3ntu.xyz>
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


On Sat, 02 Sep 2023 19:34:23 +0200, Luca Weiss wrote:
> According to a commit in the 3.4 vendor kernel sources[0] the
> ocmemcx_ahb_clk clock "is controlled by RPM and should not be touched by
> APPS.".
> 
> [0] https://git.codelinaro.org/clo/la/kernel/msm/-/commit/37df5f2d91b4d5768b37fcaacaeea958dd683ebc
> 
> And indeed, when using MDSS+GPU+OCMEM on MSM8226 and not using
> clk_ignore_unused, when Linux tries to disable the clock the device
> crashes and reboots.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: mmcc-msm8974: remove ocmemcx_ahb_clk
      commit: 471e2875f8904539985e62220afd6c88e70779fa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
