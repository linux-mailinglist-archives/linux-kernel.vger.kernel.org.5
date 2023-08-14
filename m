Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875877C10A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjHNTux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHNTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:50:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7B120
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:50:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so6423767a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692042647; x=1692647447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kb0ShcqIWwZ8vW68RmG3NUpdS0I2e+OEWn7VJy9tC8I=;
        b=p7Xr9z9CgGfjbk1IAKIOwD9ld694ltUV7RN8+ZuB7qTLE1J6/sxlZO1hOWSIkWQeJN
         11ouGSEo8MLRPtghAaFRukq9fNzdOT5rc822C1IPpvEgmxJviR96P0dJRIHA/+DZdOD8
         PGOQTfCjTJ9OKhVxrt/FAyg+fl4FRs6C94bHSEd4of/VlH3keIramBJiiL21lKhXME8t
         9RIITI8Ta0M+6qmG7B0eG/wKharpn0qKlpkVg60d4QdwfjoBTKrDOyLQOxQACPMKrMlD
         Dzxrddtjpj284VFg/doZB0CYOk4kCdX0N8N6DconY1djR0fW9i6MzbQ1pMzZyMUfOi6U
         mtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042647; x=1692647447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb0ShcqIWwZ8vW68RmG3NUpdS0I2e+OEWn7VJy9tC8I=;
        b=AkkmoeyEyUj/pbeDXIiayUcgKJbuRTIFRVbyfqVY/6M1FpHg08DJz89yX0Euju0tcb
         q+IcGgnXBxlMCWmHgQJyWPQyHpWiGROzrzczwXPKzyOJ1WkTYMA+U30XbXwEmCYZiwTZ
         ZoT/jXPMKqg3oSxxDLpkeB9VaUU/z1LGd+AtaxuMb1/oLiaWzWGLlMkcsR4ynMUVuFjj
         11F/kuJ0zpSQa81LMhNqlmFTPdfGZ1ziUSq7FrlFV8yQ8XawYFXPYqnZMRZO2vR3szh4
         ZGktuWd17VVA/RBJeH7O0hHTS1GvJbVOpDAg0K+adZt5kn571hVfiXFI4dSbY9PBTGbT
         JqKQ==
X-Gm-Message-State: AOJu0YyGLN6yYfxTDqRkr4W/uDz/CfLXQeCYyaIuZAznKHGZghe/8ync
        NjE4QzkYzFkA3Ay2me3W0En6xA==
X-Google-Smtp-Source: AGHT+IGL6psO4RUxjx2ppNu36MtOVlPU0IKFkwRw1TipnuJpYturHbZk78Q/rpmmMNBUB7mR3fGWqA==
X-Received: by 2002:aa7:d1d5:0:b0:523:102f:3ce0 with SMTP id g21-20020aa7d1d5000000b00523102f3ce0mr8543673edp.21.1692042647690;
        Mon, 14 Aug 2023 12:50:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id t9-20020aa7d709000000b0051df54c6a27sm5868404edq.56.2023.08.14.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:50:47 -0700 (PDT)
Message-ID: <b224ccaf-d70f-8f65-4b2f-6f4798841558@linaro.org>
Date:   Mon, 14 Aug 2023 21:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, pankaj.dubey@samsung.com,
        swathi.ks@samsung.com, ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chandrasekar R <rcsekar@samsung.com>,
        Suresh Siddha <ssiddha@tesla.com>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
 <20230814112539.70453-3-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814112539.70453-3-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 13:25, Sriranjani P wrote:
> The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
> The binding that it uses is slightly different from existing ones because
> of the integration (clocks, resets).
> 
> For FSD SoC, a mux switch is needed between internal and external clocks.
> By default after reset internal clock is used but for receiving packets
> properly, external clock is needed. Mux switch to external clock happens
> only when the external clock is present.
> 
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Suresh Siddha <ssiddha@tesla.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---


> +static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int ins_num)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *syscon;
> +	unsigned int reg;
> +
> +	if (np && of_property_read_bool(np, "fsd-rx-clock-skew")) {
> +		syscon = syscon_regmap_lookup_by_phandle_args(np,
> +							      "fsd-rx-clock-skew",
> +							      1, &reg);
> +		if (IS_ERR(syscon)) {
> +			dev_err(&pdev->dev,
> +				"couldn't get the rx-clock-skew syscon!\n");
> +			return PTR_ERR(syscon);
> +		}
> +
> +		regmap_write(syscon, reg, rx_clock_skew_val[ins_num]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsd_eqos_clk_init(struct fsd_eqos_plat_data *plat,
> +			     struct plat_stmmacenet_data *data)
> +{
> +	int ret = 0, i;
> +
> +	const struct fsd_eqos_variant *fsd_eqos_v_data =
> +						plat->fsd_eqos_inst_var;
> +
> +	plat->clks = devm_kcalloc(plat->dev, fsd_eqos_v_data->num_clks,
> +				  sizeof(*plat->clks), GFP_KERNEL);
> +	if (!plat->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < fsd_eqos_v_data->num_clks; i++)
> +		plat->clks[i].id = fsd_eqos_v_data->clk_list[i];
> +
> +	ret = devm_clk_bulk_get(plat->dev, fsd_eqos_v_data->num_clks,
> +				plat->clks);

Instead of duplicating entire clock management with existing code, you
should extend/rework existing one.

This code is unfortunately great example how not to stuff vendor code
into upstream project. :(

> +
> +	return ret;
> +}
> +
> +static int fsd_clks_endisable(void *priv, bool enabled)
> +{
> +	int ret, num_clks;
> +	struct fsd_eqos_plat_data *plat = priv;
> +
> +	num_clks = plat->fsd_eqos_inst_var->num_clks;
> +
> +	if (enabled) {
> +		ret = clk_bulk_prepare_enable(num_clks, plat->clks);
> +		if (ret) {
> +			dev_err(plat->dev, "Clock enable failed, err = %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		clk_bulk_disable_unprepare(num_clks, plat->clks);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsd_eqos_probe(struct platform_device *pdev,
> +			  struct plat_stmmacenet_data *data,
> +			  struct stmmac_resources *res)
> +{
> +	struct fsd_eqos_plat_data *priv_plat;
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret = 0;
> +
> +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> +	if (!priv_plat) {
> +		ret = -ENOMEM;

return -ENOMEM

> +		goto error;
> +	}
> +
> +	priv_plat->dev = &pdev->dev;
> +	data->bus_id = of_alias_get_id(np, "eth");

No, you cannot do like this. Aliases are board specific and are based on
labeling on the board.

> +
> +	priv_plat->fsd_eqos_inst_var = &fsd_eqos_clk_info[data->bus_id];
> +
> +	ret = fsd_eqos_clk_init(priv_plat, data);
> +
> +	data->bsp_priv = priv_plat;
> +	data->clks_config = fsd_clks_endisable;
> +	data->rxmux_setup = dwc_eqos_rxmux_setup;
> +
> +	ret = fsd_clks_endisable(priv_plat, true);
> +	if (ret)
> +		goto error;
> +
> +	ret = dwc_eqos_setup_rxclock(pdev, data->bus_id);
> +	if (ret) {
> +		fsd_clks_endisable(priv_plat, false);
> +		dev_err_probe(&pdev->dev, ret, "Unable to setup rxclock\n");

The syntax is: return dev_err_probe().

> +	}
> +
> +error:
> +	return ret;
> +}

....


Best regards,
Krzysztof

