Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264827F1AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjKTRkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjKTRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:39:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E5110
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700501952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhXhhVOgQcwszvCir7ZuwIMT/79o9ZyKYko3EUjNwGA=;
        b=JpFtLpwIqh3H39y0REmRUnnGqQIVT7LSSvKV17Qw0KwPXtFCOUO1IfsIEJ/dl1hY7wRAw5
        5genqXe9VrHHLWUKQyJpUZPSU5OKSyxU5sEb5NU2ov739gn0Z3HbzColp/RUpiBWFjrmpJ
        5b4Z4SULWUbPEsnRUOAWDvDIEQef2Hw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-5Q5syEyOMsOlFs7vmUlwwA-1; Mon, 20 Nov 2023 12:39:11 -0500
X-MC-Unique: 5Q5syEyOMsOlFs7vmUlwwA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-421af801578so48570791cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501951; x=1701106751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhXhhVOgQcwszvCir7ZuwIMT/79o9ZyKYko3EUjNwGA=;
        b=IK8ospyvqln2VyF5QGPxUVIbRLZE9Tnfva6DZ9hyCjPQd46HOxkRokL+ptYUQYRbio
         +mIkTFpTJ7Zb3LyCjPAvYyMNRx40vSPz4tsDdbp58BbIk07cnA0WQUkjbc451Tkj017w
         wIi/bLRivQNJ0atkDJM6dtttZJwRlrwTolGrBYWLkb4Vn6/Q9X9xAQ9lpaVOSCVCGQ59
         6Az52XaZZePplK5txVjQaxpKE9VqyTgx3kofsdpCDtlh/WyJDWoDWyc6XNON9+0SP1+P
         AXZO19ncJZsz0qfIUdYkPg0Yg9d9V+CqEl/bWXrpepiIsF92kXzgE8qab0CEvqFHsemH
         DQ/g==
X-Gm-Message-State: AOJu0YwGMr1FHIykbtQgIErbKDB14KJpm5P3JUsy7yWIEeBKHN7C8WH2
        /oU9gSN4G7S/7huo3x8PnXN4LEOas7/lSvH9a1EDzvhX2g4xXonWOKPHFxO73G3Nz48axnVuovQ
        QUQCyY+DxTPiT0XBkEgMGWtGy
X-Received: by 2002:a05:622a:120f:b0:418:1c96:8ae9 with SMTP id y15-20020a05622a120f00b004181c968ae9mr7303266qtx.11.1700501950855;
        Mon, 20 Nov 2023 09:39:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJxvMsSQn+upSlfoe1AebhnWLm6yBcWBZBG02zXFFObgKKN1wx2M0hPEp8Q1VD76pdfOlXbA==
X-Received: by 2002:a05:622a:120f:b0:418:1c96:8ae9 with SMTP id y15-20020a05622a120f00b004181c968ae9mr7303241qtx.11.1700501950580;
        Mon, 20 Nov 2023 09:39:10 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id u7-20020ac87507000000b00419b9b1b0b0sm2790034qtq.56.2023.11.20.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:39:10 -0800 (PST)
Date:   Mon, 20 Nov 2023 11:39:07 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix wakeup after probe deferral
Message-ID: <pgmtla6j3dshuq5zdxstszbkkssxcthtzelv2etcbrlstdw4nu@wixz6v5dfpum>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
 <20231120161607.7405-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120161607.7405-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:16:06PM +0100, Johan Hovold wrote:
> The Qualcomm glue driver is overriding the interrupt trigger types
> defined by firmware when requesting the wakeup interrupts during probe.
> 
> This can lead to a failure to map the DP/DM wakeup interrupts after a
> probe deferral as the firmware defined trigger types do not match the
> type used for the initial mapping:
> 
> 	irq: type mismatch, failed to map hwirq-14 for interrupt-controller@b220000!
> 	irq: type mismatch, failed to map hwirq-15 for interrupt-controller@b220000!
> 
> Fix this by not overriding the firmware provided trigger types when
> requesting the wakeup interrupts.

This series looks good to me and makes sense except for one point that
I'm struggling to understand. What exactly is the relationship with this
failure and probe deferral?

Thanks,
Andrew

> 
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Cc: stable@vger.kernel.org      # 4.18
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 10fb481d943b..82544374110b 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -549,7 +549,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>  					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					IRQF_ONESHOT,
>  					"qcom_dwc3 HS", qcom);
>  		if (ret) {
>  			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
> @@ -564,7 +564,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>  					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					IRQF_ONESHOT,
>  					"qcom_dwc3 DP_HS", qcom);
>  		if (ret) {
>  			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
> @@ -579,7 +579,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>  					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					IRQF_ONESHOT,
>  					"qcom_dwc3 DM_HS", qcom);
>  		if (ret) {
>  			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
> @@ -594,7 +594,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>  					qcom_dwc3_resume_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					IRQF_ONESHOT,
>  					"qcom_dwc3 SS", qcom);
>  		if (ret) {
>  			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
> -- 
> 2.41.0
> 
> 

