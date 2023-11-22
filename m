Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6167F42FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjKVJ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:58:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87619449F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:58:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149E8C433C8;
        Wed, 22 Nov 2023 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700647115;
        bh=wFOz84X6JQkAzM3R0/wXegUEVDcHqoOwN9/NQtwtvm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wf1mV/PkVmEWBKYQSBG9vYSivTRFJ852ePt/q6LjCA0663fSVUQoEc8MSIKQYHi9j
         9GQoEiUCuYB0jtaKMyhiCLXyA+HaXSUe5SLGzyyBC4uT6rSV6nav0M4q19s6zEJa1Q
         zw4Z3zL1QxYPUIWaX7StTBczTpZGjAGP4/jPmiXOkVLPsUc0CDcc6t2L0e2mv1BMcu
         J9YrxCqsGS5I6pUxcX8j5HG13sVGFDJpwmUMrJM9mK4w/Edn0Qdnhyg0+jFYOchkc4
         6Kl5aTIT5sgpgBMxPV42UFSGMc0422tlVAZLrg8oXZ9sawdJYHBt2HmJ9efgbfdy3P
         YMASud1Mubkcg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5k0O-0008Co-2n;
        Wed, 22 Nov 2023 10:58:49 +0100
Date:   Wed, 22 Nov 2023 10:58:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 02/12] usb: dwc3: qcom: Rename dwc3 platform_device
 reference
Message-ID: <ZV3Q2Fa4KL-0hBE8@hovoldconsulting.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-2-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-2-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:10PM -0700, Bjorn Andersson wrote:
> In preparation for the introduction of a direct reference to the struct
> dwc3 in the dwc3_qcom struct, rename the generically named "dwc3" to
> reduce the risk for confusion.
> 
> No functional change.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..a31c3bc1f56e 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -67,7 +67,7 @@ struct dwc3_acpi_pdata {
>  struct dwc3_qcom {
>  	struct device		*dev;
>  	void __iomem		*qscratch_base;
> -	struct platform_device	*dwc3;
> +	struct platform_device	*dwc_dev;

Since "dev" is so overloaded, please name this one "dwc_pdev" instead.

>  	struct platform_device	*urs_usb;
>  	struct clk		**clks;
>  	int			num_clocks;
 
>  static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  {
> -	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc_dev);
>  	struct usb_device *udev;
>  	struct usb_hcd __maybe_unused *hcd;
>  
> @@ -486,7 +486,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
>  {
>  	struct dwc3_qcom *qcom = data;
> -	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc_dev);

Perhaps you can drop the tab while changing this line.

Johan
