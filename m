Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A37D3B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjJWP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:58:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA92E9;
        Mon, 23 Oct 2023 08:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FEBC433C8;
        Mon, 23 Oct 2023 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698076712;
        bh=eHQE9AW+TMhNeP+Km14R1yq/+eqHlqagrK1M9EYQg3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uu2nv3x2wZYIXNe6hKG4VpNBSs9klnoB6Bb9jinZaTd8TzjvSgHgniv6jtd9n5vFs
         7kPHt1G0/UyPeCs5f2oc+JOzFHFSzHAaoPLgfK3egiOe/npAd/llQkGThbE92+Rw/j
         NoA8DMcD2UXJbL9U0JXG+m76kB2I5WrB2TB9JCMoub9aaVcgSvGwot81pmP9hd0Xz7
         sD8fyyNRFmCL0zDAjtPkml5IuANJf+/MJWrqXPSdmGnkv3RA7EC5GVijuQnEECGKh1
         3nZJrLxj6l3ouSEfkjosuXJNH/UUEVZ7X4H6++FTg0YturEfuuZr1dmJP+44g3MMKZ
         F+5hYBiCLvW5Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1quxKI-00022S-02;
        Mon, 23 Oct 2023 17:58:46 +0200
Date:   Mon, 23 Oct 2023 17:58:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 07/10] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZTaYNjRyT1Fn4QWX@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-8-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-8-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:18:03PM +0530, Krishna Kurapati wrote:
> QCOM SoC SA8295P's tertiary quad port controller supports 2 HS+SS
> ports and 2 HS only ports. Add support for configuring PWR_EVENT_IRQ's
> for all the ports during suspend/resume.

No need to mention SA8295P as this is needed for all multiport
controllers.

Say something about adding support for multiport controllers generally
instead and mention what the power event irqs are used for.
 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 651b9775a0c2..dbd4239e61c9 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -37,7 +37,11 @@
>  #define PIPE3_PHYSTATUS_SW			BIT(3)
>  #define PIPE_UTMI_CLK_DIS			BIT(8)
>  
> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> +#define PWR_EVNT_IRQ4_STAT_REG			0x238

Not sure these defines makes sense on their own. You now only use them
via the array below.

I think I already asked you whether these offsets depend on SoC and you
said no, right?

> +
>  #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>  #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>  
> @@ -107,6 +111,19 @@ struct dwc3_qcom {
>  	int			num_ports;
>  };
>  
> +/*
> + * Currently non-multiport controller have only one PWR_EVENT_IRQ register,
> + * but multiport controllers like SA8295 contain upto 4 of them.
> + */

Please try not talk about "currently" and as things are likely to
change or, in fact, even *are* changing with your very patch series.

Again, this is not SA8295 specific.

> +#define NUM_PWR_EVENT_STAT_REGS	4

You already have MAX_PORTS, why are you defining a new define that will
always have to be equal to MAX_PORTS?

> +
> +static u32 pwr_evnt_irq_stat_reg_offset[NUM_PWR_EVENT_STAT_REGS] = {

missing const

> +	PWR_EVNT_IRQ1_STAT_REG,
> +	PWR_EVNT_IRQ2_STAT_REG,
> +	PWR_EVNT_IRQ3_STAT_REG,
> +	PWR_EVNT_IRQ4_STAT_REG,
> +};
> +
>  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>  	u32 reg;
> @@ -446,9 +463,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  	if (qcom->is_suspended)
>  		return 0;
>  
> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> +			dev_err(qcom->dev, "HS-PHY not in L2\n");

Error message should contain the port number.

> +	}
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--)
>  		clk_disable_unprepare(qcom->clks[i]);
> @@ -494,9 +513,11 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>  
>  	/* Clear existing events from PHY related to L2 in/out */
> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> -
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		dwc3_qcom_setbits(qcom->qscratch_base,
> +			pwr_evnt_irq_stat_reg_offset[i],
> +			PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);

Again, continuation lines should be indented at least two tabs further.

> +	}
>  	qcom->is_suspended = false;
>  
>  	return 0;

Johan
