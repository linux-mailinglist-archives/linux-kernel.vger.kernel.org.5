Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C810678E9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbjHaJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHaJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:40:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A331A1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:40:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so11752661fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693474825; x=1694079625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ImdZD1vsEr+AGaaXIhrM+Mnsa6m2krC8EaC0XOQEE4=;
        b=kcTUfES8ZCH2iSvmVkabn2PkAsrKfehw0VqFTjvS6VykXxMYIjYrW+hX4OjDOnSHd3
         hFronZS43kAWL54zMDqkEWPzTFIsqExTsMam7HP8u+ohOvJcPR2FFrYYMKIZ2hqg1r/V
         /6sz12jtAs+5FHqVWTwg5G3S/MvzzB+k/bzl/bD+C80YyH9EJFDYYcJm5LVWWbdK96y9
         gzyrhlPjlHg2S1By5XsYW55xP0Bg7ZUPVIF7IOmh3rHKmILWATNJy3Xi3PetH0pBWMRP
         dmVdpwzhrb1JOhz+F37Sl6Ahjf83QJwKiXJoxlghPrISgwZNzqW7k16hm4Htg7IyBO7/
         qkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474825; x=1694079625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ImdZD1vsEr+AGaaXIhrM+Mnsa6m2krC8EaC0XOQEE4=;
        b=LnlTwpTBO6epSPEntJzoMkgL8V4KbBB6kCgepRXYWqJx1+tiWBnd6kpN4oVKj0BP7a
         /6UDyz/RmXK72dtWCmllzH1xhDD78CgchXKMYQxJW5/fqUWi+7QPMT5+kUxNFfHTAJgc
         I7pexMu9UkLskj6wx/xHBcjV6xKkz/1b6iy1tM/RDQXFKXHRlbdq80IAblPCBpDAYX7Q
         2lqlUaMcyasGc6s9vGGrR3pBby8I1cGpo7qA7Z32LcuWfaFWYSRCD2cpfy1w8lKjUizs
         LJMOxot+d9ejj2dTqWei+YQPt467HDEZ2KB/48qYdcA22tysMEpmTUbjCPF4+bbb2RFx
         WHRQ==
X-Gm-Message-State: AOJu0YxqTiks2cTPVkqBV7WbjxUA3iNfyDTFl6LRCwNoY8EF8bOdEPb+
        5MlAmp111Gy+IBmM7X3JyUM51Kg97FJbj4wndIVbgQ==
X-Google-Smtp-Source: AGHT+IG/9XPgXkKxwzjXLQhhPfZltTKoWPBr6XdliAJzT4/Oc15uyqubFwUvAfaTbCzO0Pqfj+DZAA==
X-Received: by 2002:a2e:90d3:0:b0:2b9:f007:9910 with SMTP id o19-20020a2e90d3000000b002b9f0079910mr3547533ljg.53.1693474825382;
        Thu, 31 Aug 2023 02:40:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e9810000000b002bb99f6f2c7sm227598ljj.90.2023.08.31.02.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 02:40:24 -0700 (PDT)
Message-ID: <6c25444a-0a2a-4d33-be7a-1d9846bab14d@linaro.org>
Date:   Thu, 31 Aug 2023 11:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-msm8996: Remove RPM bus clocks
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.2023 11:39, Konrad Dybcio wrote:
> The GCC driver contains clocks that are owned (meaning configured and
> scaled) by the RPM core.
> 
> Remove them from Linux to stop interjecting the RPM's logic.
> 
> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Evolution of:
> https://lore.kernel.org/linux-arm-msm/20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org/
> ---
+CC Dmitry as b4 apparently didn't think of that

>  drivers/clk/qcom/gcc-msm8996.c | 237 +----------------------------------------
>  1 file changed, 5 insertions(+), 232 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> index 14dcc3f03668..e7b03a17514a 100644
> --- a/drivers/clk/qcom/gcc-msm8996.c
> +++ b/drivers/clk/qcom/gcc-msm8996.c
> @@ -244,71 +244,6 @@ static const struct clk_parent_data gcc_xo_gpll0_gpll4_gpll0_early_div[] = {
>  	{ .hw = &gpll0_early_div.hw }
>  };
>  
> -static const struct freq_tbl ftbl_system_noc_clk_src[] = {
> -	F(19200000, P_XO, 1, 0, 0),
> -	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
> -	F(100000000, P_GPLL0, 6, 0, 0),
> -	F(150000000, P_GPLL0, 4, 0, 0),
> -	F(200000000, P_GPLL0, 3, 0, 0),
> -	F(240000000, P_GPLL0, 2.5, 0, 0),
> -	{ }
> -};
> -
> -static struct clk_rcg2 system_noc_clk_src = {
> -	.cmd_rcgr = 0x0401c,
> -	.hid_width = 5,
> -	.parent_map = gcc_xo_gpll0_gpll0_early_div_map,
> -	.freq_tbl = ftbl_system_noc_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data){
> -		.name = "system_noc_clk_src",
> -		.parent_data = gcc_xo_gpll0_gpll0_early_div,
> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_early_div),
> -		.ops = &clk_rcg2_ops,
> -	},
> -};
> -
> -static const struct freq_tbl ftbl_config_noc_clk_src[] = {
> -	F(19200000, P_XO, 1, 0, 0),
> -	F(37500000, P_GPLL0, 16, 0, 0),
> -	F(75000000, P_GPLL0, 8, 0, 0),
> -	{ }
> -};
> -
> -static struct clk_rcg2 config_noc_clk_src = {
> -	.cmd_rcgr = 0x0500c,
> -	.hid_width = 5,
> -	.parent_map = gcc_xo_gpll0_map,
> -	.freq_tbl = ftbl_config_noc_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data){
> -		.name = "config_noc_clk_src",
> -		.parent_data = gcc_xo_gpll0,
> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> -		.ops = &clk_rcg2_ops,
> -	},
> -};
> -
> -static const struct freq_tbl ftbl_periph_noc_clk_src[] = {
> -	F(19200000, P_XO, 1, 0, 0),
> -	F(37500000, P_GPLL0, 16, 0, 0),
> -	F(50000000, P_GPLL0, 12, 0, 0),
> -	F(75000000, P_GPLL0, 8, 0, 0),
> -	F(100000000, P_GPLL0, 6, 0, 0),
> -	{ }
> -};
> -
> -static struct clk_rcg2 periph_noc_clk_src = {
> -	.cmd_rcgr = 0x06014,
> -	.hid_width = 5,
> -	.parent_map = gcc_xo_gpll0_map,
> -	.freq_tbl = ftbl_periph_noc_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data){
> -		.name = "periph_noc_clk_src",
> -		.parent_data = gcc_xo_gpll0,
> -		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> -		.ops = &clk_rcg2_ops,
> -	},
> -};
> -
>  static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
>  	F(19200000, P_XO, 1, 0, 0),
>  	F(120000000, P_GPLL0, 5, 0, 0),
> @@ -1297,11 +1232,7 @@ static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mmss_noc_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1464,11 +1395,6 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1498,11 +1424,6 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc1_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1549,11 +1470,6 @@ static struct clk_branch gcc_sdcc2_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc2_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1583,11 +1499,6 @@ static struct clk_branch gcc_sdcc3_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc3_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1617,11 +1528,6 @@ static struct clk_branch gcc_sdcc4_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_sdcc4_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1635,11 +1541,6 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
>  		.enable_mask = BIT(17),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp1_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1977,11 +1878,6 @@ static struct clk_branch gcc_blsp2_ahb_clk = {
>  		.enable_mask = BIT(15),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_blsp2_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2318,11 +2214,6 @@ static struct clk_branch gcc_pdm_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pdm_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2353,11 +2244,6 @@ static struct clk_branch gcc_prng_ahb_clk = {
>  		.enable_mask = BIT(13),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_prng_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2370,11 +2256,6 @@ static struct clk_branch gcc_tsif_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_tsif_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2422,11 +2303,6 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
>  		.enable_mask = BIT(10),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_boot_rom_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2520,11 +2396,6 @@ static struct clk_branch gcc_pcie_0_slv_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_0_slv_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2537,11 +2408,6 @@ static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_0_mstr_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2554,11 +2420,6 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_0_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2606,11 +2467,6 @@ static struct clk_branch gcc_pcie_1_slv_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_1_slv_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2623,11 +2479,6 @@ static struct clk_branch gcc_pcie_1_mstr_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_1_mstr_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2640,11 +2491,6 @@ static struct clk_branch gcc_pcie_1_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_1_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2692,11 +2538,6 @@ static struct clk_branch gcc_pcie_2_slv_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_2_slv_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2709,11 +2550,6 @@ static struct clk_branch gcc_pcie_2_mstr_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_2_mstr_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2726,11 +2562,6 @@ static struct clk_branch gcc_pcie_2_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_2_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2778,11 +2609,6 @@ static struct clk_branch gcc_pcie_phy_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_pcie_phy_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -2829,11 +2655,6 @@ static struct clk_branch gcc_ufs_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_ufs_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3060,11 +2881,7 @@ static struct clk_branch gcc_aggre0_snoc_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_aggre0_snoc_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3077,11 +2894,7 @@ static struct clk_branch gcc_aggre0_cnoc_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_aggre0_cnoc_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3094,11 +2907,7 @@ static struct clk_branch gcc_smmu_aggre0_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_smmu_aggre0_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3111,11 +2920,7 @@ static struct clk_branch gcc_smmu_aggre0_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_smmu_aggre0_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3162,10 +2967,6 @@ static struct clk_branch gcc_dcc_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_dcc_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3178,10 +2979,6 @@ static struct clk_branch gcc_aggre0_noc_mpu_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_aggre0_noc_mpu_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3194,11 +2991,6 @@ static struct clk_branch gcc_qspi_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_qspi_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&periph_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3347,10 +3139,6 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_cfg_ahb_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&config_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3363,10 +3151,6 @@ static struct clk_branch gcc_mss_mnoc_bimc_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_mnoc_bimc_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3379,10 +3163,6 @@ static struct clk_branch gcc_mss_snoc_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_snoc_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3395,10 +3175,6 @@ static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_mss_q6_bimc_axi_clk",
> -			.parent_hws = (const struct clk_hw*[]){
> -				&system_noc_clk_src.clkr.hw,
> -			},
> -			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3495,9 +3271,6 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
>  	[GPLL0] = &gpll0.clkr,
>  	[GPLL4_EARLY] = &gpll4_early.clkr,
>  	[GPLL4] = &gpll4.clkr,
> -	[SYSTEM_NOC_CLK_SRC] = &system_noc_clk_src.clkr,
> -	[CONFIG_NOC_CLK_SRC] = &config_noc_clk_src.clkr,
> -	[PERIPH_NOC_CLK_SRC] = &periph_noc_clk_src.clkr,
>  	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
>  	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
>  	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
> 
> ---
> base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc
> change-id: 20230830-topic-rpmbusclocks8996gcc-78cc0be4d475
> 
> Best regards,
