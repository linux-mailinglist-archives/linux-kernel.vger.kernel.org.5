Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD476FE0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHDKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHDKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:04:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284546B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:04:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1713966f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691143443; x=1691748243;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=wRmmMJ0HPgLCCnErClqViv0JGVjCSwWzjpmp9XzOBvQ=;
        b=IEpr2nCRcjfsHIjC0h14j9bNjpY/hRdpQWYa0wF+DpLvhSmBJE8J9SHNKA9hLanAzT
         XrZUGyDjmYSVEPKz9+knyknq78bLuEE9Ha7f2/VuGs25I3YJpyiRKKThMrcGslgtTYQP
         Dcb7wzJkdJB4YBBQYYOrJWTZ7lb/winmygvMmTC9C13bDNhromkfZOxxNJmQr3w7R1lA
         KEetBoEffX+8/5wgkOPyb4/WIPp+H8Gq7phV5HIzTvPGQ65Z7Cd8/kMYpH/d3/U4rmNJ
         iewqIMyp9eHKHr28OGydZTWptKA1bYhxkMU9umInOYcGB7BAqFi6JYtfe8cgq26q0RiP
         5pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143443; x=1691748243;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRmmMJ0HPgLCCnErClqViv0JGVjCSwWzjpmp9XzOBvQ=;
        b=Lup+DSHSSkzqVW8NMFu3iw4x3y/dSpUHrj04mXH1KERFWUSIQuHQtF12oYp2rUevXF
         qH5A2n2ppPu0nGdZSmCWjCro4ADoxgz3UPUoM5WKceXW0a3+G2DlMRpIXE9/OuLq1Ncs
         9d+8zuTwXcOHs3c7eHzf31NLtI0y5DxMMcLW2ZGXmFg5CA5YLBeK0JGy7wEXh/MB85FH
         x06H+kEFvISXe//p9VAd7JI+Sr0mtvuBl4AJl3WGn968Q08IfQBM38PyGTWa/Ev3ncHv
         U5YvQjRX6Y6tCUN326MfM84Ejc62rPKMy0V5Q+cDg4DonTr1Wvj/2Eb6QiusUutDgdrI
         o/Fw==
X-Gm-Message-State: AOJu0YyaS2ae3j7AaR671E+P/XWaqKWQa0G3nfvHXUbstCQmpgVCW4e8
        VBvJNTH4txuLHZpM2x5IUi5B6g==
X-Google-Smtp-Source: AGHT+IEp+pnWLGdyMaoZ+C0S9nVfAxiYGTYwTISALv/MBtsZDW2daFfcXuYYxuyUmnrQXKvEaYJ4Dw==
X-Received: by 2002:a5d:4447:0:b0:317:3d36:b2cd with SMTP id x7-20020a5d4447000000b003173d36b2cdmr810107wrr.71.1691143443322;
        Fri, 04 Aug 2023 03:04:03 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:aeaf:609a:5eef:39a8])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d640d000000b003176053506fsm2104960wru.99.2023.08.04.03.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:04:02 -0700 (PDT)
References: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-0-762219fc5b28@linaro.org>
 <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-2-762219fc5b28@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/9] clk: meson: g12a: add CTS_ENCL & CTS_ENCL_SEL
 clocks
Date:   Fri, 04 Aug 2023 11:59:21 +0200
In-reply-to: <20230803-amlogic-v6-4-upstream-dsi-ccf-vim3-v7-2-762219fc5b28@linaro.org>
Message-ID: <1j1qgjp1im.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 03 Aug 2023 at 14:03, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Add new CTS_ENCL & CTS_ENCL_SEL clocks for the G12A compatible
> SoCs, they are used to feed the VPU LCD Pixel encoder used for
> DSI display purposes.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/g12a.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index ceabd5f4b2ac..5d62134335c1 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -3549,6 +3549,22 @@ static struct clk_regmap g12a_cts_encp_sel = {
>  	},
>  };
>  
> +static struct clk_regmap g12a_cts_encl_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VIID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 12,
> +		.table = mux_table_cts_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_encl_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = g12a_cts_parent_hws,
> +		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,

Why nocache ?
This is usually used when the consumer driver is poking around behind
CCF back.

Any chance this can use assigned-parent or CCF directly ?

> +	},
> +};
> +
>  static struct clk_regmap g12a_cts_vdac_sel = {
>  	.data = &(struct clk_regmap_mux_data){
>  		.offset = HHI_VIID_CLK_DIV,
> @@ -3628,6 +3644,22 @@ static struct clk_regmap g12a_cts_encp = {
>  	},
>  };
>  
> +static struct clk_regmap g12a_cts_encl = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL2,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_encl",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&g12a_cts_encl_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

What is the reason for IGNORE_UNUSED ?
If you need to keep the clock on while the driver comes up, please
document it here.

> +	},
> +};
> +
>  static struct clk_regmap g12a_cts_vdac = {
>  	.data = &(struct clk_regmap_gate_data){
>  		.offset = HHI_VID_CLK_CNTL2,
> @@ -4407,10 +4439,12 @@ static struct clk_hw *g12a_hw_clks[] = {
>  	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
>  	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
>  	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
> +	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
>  	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
>  	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
>  	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
>  	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
> +	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
>  	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
>  	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
>  	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
> @@ -4632,10 +4666,12 @@ static struct clk_hw *g12b_hw_clks[] = {
>  	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
>  	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
>  	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
> +	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
>  	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
>  	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
>  	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
>  	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
> +	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
>  	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
>  	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
>  	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
> @@ -4892,10 +4928,12 @@ static struct clk_hw *sm1_hw_clks[] = {
>  	[CLKID_VCLK2_DIV12]		= &g12a_vclk2_div12.hw,
>  	[CLKID_CTS_ENCI_SEL]		= &g12a_cts_enci_sel.hw,
>  	[CLKID_CTS_ENCP_SEL]		= &g12a_cts_encp_sel.hw,
> +	[CLKID_CTS_ENCL_SEL]		= &g12a_cts_encl_sel.hw,
>  	[CLKID_CTS_VDAC_SEL]		= &g12a_cts_vdac_sel.hw,
>  	[CLKID_HDMI_TX_SEL]		= &g12a_hdmi_tx_sel.hw,
>  	[CLKID_CTS_ENCI]		= &g12a_cts_enci.hw,
>  	[CLKID_CTS_ENCP]		= &g12a_cts_encp.hw,
> +	[CLKID_CTS_ENCL]		= &g12a_cts_encl.hw,
>  	[CLKID_CTS_VDAC]		= &g12a_cts_vdac.hw,
>  	[CLKID_HDMI_TX]			= &g12a_hdmi_tx.hw,
>  	[CLKID_HDMI_SEL]		= &g12a_hdmi_sel.hw,
> @@ -5123,10 +5161,12 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
>  	&g12a_vclk2_div12_en,
>  	&g12a_cts_enci_sel,
>  	&g12a_cts_encp_sel,
> +	&g12a_cts_encl_sel,
>  	&g12a_cts_vdac_sel,
>  	&g12a_hdmi_tx_sel,
>  	&g12a_cts_enci,
>  	&g12a_cts_encp,
> +	&g12a_cts_encl,
>  	&g12a_cts_vdac,
>  	&g12a_hdmi_tx,
>  	&g12a_hdmi_sel,

