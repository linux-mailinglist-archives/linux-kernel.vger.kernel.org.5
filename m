Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8A7D0FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377215AbjJTMaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:30:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8711B;
        Fri, 20 Oct 2023 05:30:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12F2C433C9;
        Fri, 20 Oct 2023 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697805022;
        bh=+uf6l8qxqJVbft1lkynnlas3Eiq4n3dk8l8L9rbR2KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdIZAzR2SeCY5X7Hmq7TjcXV2kOHMK1xcGYHqfbP/9kBYVoQauINtdOB2nGXFewPS
         CGu4T/rYw8gHr5+ezTZCMSC78sKZE3tyFg8VrNCfH+ctrcT/SJJoSUQT6rxjz4JdPc
         aAtNHlqzvU3/LPg+hZwVJv8egBBGZsufQhfmq0jDW5Czt0oyqjUKXQ4RwTNbow4zkr
         nlHIfXwI8fBP5KTzRcJw1NYUyRBZdRUg9qpRLx2TMIZVetvgaDe9qGk5UTvQCrskEx
         qwGD8+MTgCZX1CgYEdWa8TM5x05Gc3y0w+XWlx29FR3rnnksWvyQN+ixMjX4MuiUbl
         4lSNYOHxpMZvg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtoe3-0002Q9-1s;
        Fri, 20 Oct 2023 14:30:28 +0200
Date:   Fri, 20 Oct 2023 14:30:27 +0200
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
        quic_shazhuss@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v13 04/10] usb: dwc3: qcom: Add helper function to
 request threaded IRQ
Message-ID: <ZTJy456413VVT8Uv@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-5-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-5-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:18:00PM +0530, Krishna Kurapati wrote:
> Cleanup setup irq call by implementing a new prep_irq helper function
> and using it to request threaded IRQ's.

Please replace this with:

	Refactor interrupt setup by adding a new helper function for
	requesting the wakeup interrupts.

and similarly for Subject ("wakeup interrupts").

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 59 ++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..ef2006db7601 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -535,6 +535,24 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_prep_irq(struct dwc3_qcom *qcom, char *irq_name,
> +				char *disp_name, int irq)

Please rename this one dwc3_qcom_request_irq() so that is obvious what
it does without having to look at the implementation.

This series eventually makes the driver only call this with irq_name ==
disp_name so just drop the latter and rename the parameter as "name" and
mention that in the commit message.

Also move irq before name and add the missing const. That is:

	static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq, const char *name);

> +{
> +	int ret;
> +
> +	/* Keep wakeup interrupts disabled until suspend */
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					disp_name, qcom);
> +

Drop stray newline.

> +	if (ret)
> +		dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);

Please spell out

	"failed to request irq %s: %d\n"

> +
> +	return ret;
> +}

Johan
