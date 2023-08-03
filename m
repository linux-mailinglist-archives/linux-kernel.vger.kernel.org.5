Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C876E01C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjHCGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHCGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B15BA;
        Wed,  2 Aug 2023 23:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEDE61BF0;
        Thu,  3 Aug 2023 06:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1EFC433C7;
        Thu,  3 Aug 2023 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691043695;
        bh=BMvagv46eboB4wxHgk5Bx5js/lPld9HalXVIRLAltfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLCPuc9+yNWN8PblNqN6rzZbusW2z+4N3SExL/FCBtW7zbRhtYa4HZCyVYNxKQ8yU
         bFGbj+F5R0IY7UnLGIs90lWgwKwez2dSwZk7xY5XliZHRLoGynZZsLJ8QqKkQTC9C8
         vx5er2nWjb7COBC5Z6HuToDETOarNg4jQZYHBrc/dG2arCgEGFHqJDTbqiBV1fAcw6
         pAgup6bLxe8Yk5mswJV1pmzBnLbqfvNlVEYZzz7S2fDywrkwySrT20Rf+HAVRuAKyk
         Igyj9u6c6s9lhh0JbvahvhsMLkt1QSyVT10VtZdnHFPpvG2zR+SKs3HvtmQdmAmBV+
         8kvgaarj0WVIw==
Date:   Thu, 3 Aug 2023 11:51:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Patrick Whewell <patrick.whewell@sightlineapplications.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>
Subject: Re: [RESEND PATCH v2] clk: qcom: gcc-sm8250: Fix
 gcc_sdcc2_apps_clk_src
Message-ID: <ZMtHarMt5T1BMNZ1@matsya>
References: <20230802210359.408-1-patrick.whewell@sightlineapplications.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802210359.408-1-patrick.whewell@sightlineapplications.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-23, 14:04, Patrick Whewell wrote:
> GPLL9 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
> didn't update its configuration" error when booting. Set .flags =
> CLK_OPS_PARENT_ENABLE to fix the error.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
> ---
> Changes in v2:
>     - Updated commit messaage to mention GPLL9 not being on by default
>       being the cause of error
>     - Moved Signed-off-by line to the bottom.
> 
>  drivers/clk/qcom/gcc-sm8250.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
> index b6cf4bc88d4d..d3c75bb55946 100644
> --- a/drivers/clk/qcom/gcc-sm8250.c
> +++ b/drivers/clk/qcom/gcc-sm8250.c
> @@ -721,6 +721,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>  		.name = "gcc_sdcc2_apps_clk_src",
>  		.parent_data = gcc_parent_data_4,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
> +		.flags = CLK_OPS_PARENT_ENABLE,
>  		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
> -- 
> 2.25.1

-- 
~Vinod
