Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4445753D85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjGNOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjGNOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:33:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374235A9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:32:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba03becc6so3993978e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689345152; x=1691937152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1NAGJKSZNME/ufDdSZLdTSg+2nkMD1y8BbgNjzMbFc=;
        b=aTOWcE1zHEq2JiQ2evcaK1j562NOcJxwlxyiM1wNh/nY/Aq3L7Kycdk5ueWoDrY6Z4
         WNqOV1tx/tunxBW1wRzGZeajlyCW1Cuc9Gw6Ll1W95Yp9GVUdtRz4iIVv/UJUEU3nu3f
         5qA5PquwRg6IBJ8fQ/327K1Y35FQDfrXVssEDy02pgn4o1QNnBr7OoCUzW0Z8S3vQZax
         fawycB+sRbWj28D3bzKIMzLtsbHlZsMKnTp+GKPjguOMJ3GlxEz+vBE2/ofv/o/sROxf
         WJAkYp7SG7mKssOzZvcGFq+VycZu4jCOyiJ4YtcoqMwG2mVyocJJEEGMNTk78OMe55UC
         74kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345152; x=1691937152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1NAGJKSZNME/ufDdSZLdTSg+2nkMD1y8BbgNjzMbFc=;
        b=e2ed3KFxs30DraI5fpHhYbaRhFhG4utrkZ0VonuEbHsHO/HiYA0jdXYDwD1FJgn2er
         CBx1OQBIcHmZ3mloah1w+8/fR63eG+qQQ1HLCI8XsqsOg5s/eaWA+FQCf8EzHbfBo+Hw
         CvJW4PGwy/MMNX7mYmkzFQ5Feyr9V0OjGtN8gL2thlW/jxFbER4aQmnfIrKHya4mzQDc
         23syzjP6wMKvcg9yw4/zxUi5FZXPA59YdnmAa7c8wxi8dIEdVSh5lRfVRZwn6xgJOvca
         YyiTG2ijBrYcb5snAoPCqH7x6ypS40j9lF+NPp6i2NWIxKWpqE4JxZx71zE02Bx/g356
         tySA==
X-Gm-Message-State: ABy/qLb8kq5o6WHV4H98fV3IZgxoaHZjjyw0y3rFhQs+s188xAgj/GwJ
        xALc/CalujbfWw6Rx+LiQDdaTw==
X-Google-Smtp-Source: APBJJlGtbkPxQHR9k71996y+hIr9CmSCiybVaqnnmBBjO1lkXWyFmx/JesUalIfC2HQ1ymc4p5D39g==
X-Received: by 2002:a05:6512:202d:b0:4f8:6253:540 with SMTP id s13-20020a056512202d00b004f862530540mr1005744lfs.19.1689345152563;
        Fri, 14 Jul 2023 07:32:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id d28-20020ac244dc000000b004fba1288ab9sm1518364lfm.99.2023.07.14.07.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:32:31 -0700 (PDT)
Message-ID: <ebfbfdf5-2537-e3ce-8416-d80a9bd862d1@linaro.org>
Date:   Fri, 14 Jul 2023 16:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
Content-Language: en-US
To:     Ninad Naik <quic_ninanaik@quicinc.com>, andersson@kernel.org,
        agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppareek@quicinc.com,
        psodagud@quicinc.com, quic_kprasan@quicinc.com
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2023 08:10, Ninad Naik wrote:
> SA8775 and newer target have added support for an increased number of
> interrupt targets. To implement this change, the intr_target field, which
> is used to configure the interrupt target in the interrupt configuration
> register is increased from 3 bits to 4 bits.
> 
> In accordance to these updates, a new intr_target_width member is
> introduced in msm_pingroup structure. This member stores the value of
> width of intr_target field in the interrupt configuration register. This
> value is used to dynamically calculate and generate mask for setting the
> intr_target field. By default, this mask is set to 3 bit wide, to ensure
> backward compatibility with the older targets.
> 
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

one nit below

>  drivers/pinctrl/qcom/pinctrl-msm.c     | 9 ++++++---
>  drivers/pinctrl/qcom/pinctrl-msm.h     | 2 ++
>  drivers/pinctrl/qcom/pinctrl-sa8775p.c | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2585ef2b2793..6ebcaa2220af 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1038,6 +1038,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>  	const struct msm_pingroup *g;
> +	u32 intr_target_mask = 0x7;
This could be GENMASK(2, 0)

Konrad
>  	unsigned long flags;
>  	bool was_enabled;
>  	u32 val;
> @@ -1074,13 +1075,15 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	 * With intr_target_use_scm interrupts are routed to
>  	 * application cpu using scm calls.
>  	 */
> +	if (g->intr_target_width)
> +		intr_target_mask = GENMASK(g->intr_target_width - 1, 0);
> +
>  	if (pctrl->intr_target_use_scm) {
>  		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
>  		int ret;
>  
>  		qcom_scm_io_readl(addr, &val);
> -
> -		val &= ~(7 << g->intr_target_bit);
> +		val &= ~(intr_target_mask << g->intr_target_bit);
>  		val |= g->intr_target_kpss_val << g->intr_target_bit;
>  
>  		ret = qcom_scm_io_writel(addr, val);
> @@ -1090,7 +1093,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  				d->hwirq);
>  	} else {
>  		val = msm_readl_intr_target(pctrl, g);
> -		val &= ~(7 << g->intr_target_bit);
> +		val &= ~(intr_target_mask << g->intr_target_bit);
>  		val |= g->intr_target_kpss_val << g->intr_target_bit;
>  		msm_writel_intr_target(val, pctrl, g);
>  	}
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 5e4410bed823..1d2f2e904da1 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -59,6 +59,7 @@ struct pinctrl_pin_desc;
>   * @intr_status_bit:      Offset in @intr_status_reg for reading and acking the interrupt
>   *                        status.
>   * @intr_target_bit:      Offset in @intr_target_reg for configuring the interrupt routing.
> + * @intr_target_width:    Number of bits used for specifying interrupt routing target.
>   * @intr_target_kpss_val: Value in @intr_target_bit for specifying that the interrupt from
>   *                        this gpio should get routed to the KPSS processor.
>   * @intr_raw_status_bit:  Offset in @intr_cfg_reg for the raw status bit.
> @@ -100,6 +101,7 @@ struct msm_pingroup {
>  	unsigned intr_ack_high:1;
>  
>  	unsigned intr_target_bit:5;
> +	unsigned intr_target_width:5;
>  	unsigned intr_target_kpss_val:5;
>  	unsigned intr_raw_status_bit:5;
>  	unsigned intr_polarity_bit:5;
> diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> index 8a5cd15512b9..8fdea25d8d67 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
> @@ -46,6 +46,7 @@
>  		.intr_enable_bit = 0,		\
>  		.intr_status_bit = 0,		\
>  		.intr_target_bit = 5,		\
> +		.intr_target_width = 4,		\
>  		.intr_target_kpss_val = 3,	\
>  		.intr_raw_status_bit = 4,	\
>  		.intr_polarity_bit = 1,		\
