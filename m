Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DF8128F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjLNHU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjLNHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:20:53 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74010C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:21:00 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ba084395d9so2996122b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702538459; x=1703143259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+lTsJeZ0gUOBqbzzRtKzTHzKA4q+fi1iIj8a7QvU6U=;
        b=RwXTj6pmjGextkpoVS6AXgQDRY4rdKbwAtPqHDsE9/oDp+3Hb+YmZp9xIEUX3wOkxY
         gI9P+A/VoYBB4Dc4SKODdfFyFisHAexXLH0KTGPuKXEzrt1iWDKGWOrzkq0HtCF9PIeA
         DO9tQLc8Ne6r2+k9nOodKuR69AHtwj4xOKpTse70dfxomnMc1/rAoyGJ/4wZmeBqQI+j
         Ds39cfZbmeKSqWbL75IG7hIdQkGd5JXrWXIN1ROC8W32EqGfeE1rf28LGkNgvYpX7mL2
         NNkhZhKCN2nd3e1yjMyGaXjw8OwFKVJHKUdf3lA54y8cLWNFov0bQR6AyS7RdyEiueLH
         59qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702538459; x=1703143259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+lTsJeZ0gUOBqbzzRtKzTHzKA4q+fi1iIj8a7QvU6U=;
        b=ME91F7OJCNn4xnTjQjzWFwmL4OyVrTT0YEQe0Adbl7MjC3kQBWxJErzONJKxEvfhFw
         Vzn7osWbKZ70AbmrG29nJqkCuBhchH3FgLVKVwdOBgdsiZZJaLMTDuVoGAYMUKmH4OB+
         DPyVySGsXE2kma2MhGgdGs7hYDK5MKYTfMkHpQVUWwcHrKVxdXlsg0KsSXdI9cUqaiXw
         DPCJJPNALzKvFEhVX1Qg11OMggrjvWgOBZ5mgjQnICwTH3/0r+cRfAz1Urkx0stzaOsc
         P0BATvz293/Y6E/oENGLaBQF90yZvJSH0muCwpz8fVZ9HJ4NH0mcJUxjB/fhcscaBGio
         EKVg==
X-Gm-Message-State: AOJu0YxgE5A5bzg11JqRrVPci62pL8FiTz2e8FX8XSgkLkS4OsIRFIpP
        SB4SxB2OJfzjixV+OJrmwmiTsiLKrNZcr+E/nlxlyA==
X-Google-Smtp-Source: AGHT+IG+rJCUqFxD37rX/E7u2uLcsa0i45ReRUeOSB/aPceCAS76sfm4WJSdI1aYG+X+Hv7jFYOqLLCYgOhAJjE+HqI=
X-Received: by 2002:a05:6808:320a:b0:3ba:1e0:f1df with SMTP id
 cb10-20020a056808320a00b003ba01e0f1dfmr11721187oib.70.1702538459745; Wed, 13
 Dec 2023 23:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-9-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-9-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:20:49 +0200
Message-ID: <CAA8EJprxUxK5tkWPShuJu8nqz_frDC_5p-b4x7KRZsOxJ=EsjA@mail.gmail.com>
Subject: Re: [PATCH 08/10] pci: qcom: Add support for IPQ5332
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> The Qualcomm IPQ5332 PCIe controller instances are based on
> SNPS core 5.90a with Gen3 Single-lane and Dual-lane support.
> The Qualcomm IP rev is 1.27.0 and hence using the 1_27_0 ops.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds PCIe support in
> Qualcomm IPQ9574
> https://lore.kernel.org/all/20230519090219.15925-1-quic_devipriy@quicinc.com/

The series did not receive updates since the end of May. Should we
expect the next iteration of that series? Otherwise depending on it
sounds like a dead end.

>
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 109df587234e..3d54de1a71df 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>         { .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>         { .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +       { .compatible = "qcom,pcie-ipq5332", .data = &cfg_1_27_0 },
>         { .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>         { .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>         { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
