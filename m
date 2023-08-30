Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88178E0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbjH3Umq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbjH3Uml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:42:41 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019494B10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:30:40 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58c92a2c52dso2296677b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693427380; x=1694032180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgGcuZzmr94KnU1bouNuOO19+UEQyecBFbXFTDXATYI=;
        b=dN1wUBPwhK6nNYvc2RZE3yJ+T4cO28vEhJsyQcaXjJxMajSZTuUu0u2Z/lc/2lsCLs
         5Si5gDcyaoTqbLfJUOaMeObswUBw8CTkf1GXmXyAWHmt+24DGfEdEHTZA5LrhB0y3jGi
         BnCTy1AhxCfqXam5tsCY3kwZpUwJs3ywxOZWrg/vG1zar0vvgnVzby5ahFMD9vEALm2a
         tpGDkAh1c+81bBq0XnXtEaHg3g7bQ2jKmAGY8SzgmTRTt5mmn8stZPBHy/rhqc+pkMc+
         ONRLE3P4+2Vb0I4hOwmihSaTFJjDJvzpe/5GNx06gbzLDAUAlWgFCjq79/4So5o8OXe4
         7ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427380; x=1694032180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgGcuZzmr94KnU1bouNuOO19+UEQyecBFbXFTDXATYI=;
        b=cF5wAuCes/pr/ra32EMqTm4q0r1wGJtZDQiFoK/012cD+VXfS6sL1W4tHxVxZnvtVO
         uFjymEZlt+VeKgs2SB96TJXzpDBsB92V7O3JSJQSsaU/Z4CZ5Zz1kTSbNrAbKTBWBVxc
         O85IKNKyoh3XhaoKyPO22YQQLAu9JBMKK3Tc7w9bblQB/59h3vVQ/ITCYGfpU+JHd3lD
         7o0WkOSDz8RkvBVofC1z5BzRk59mAiCWo+YsoukESFchNw9UfbIV5sYaCirHCx3nkGuz
         Uz6yn1LjbtPglxu3mL3cy2mpHvZR+KuCjzq/QwjJDiy9g/XxU8p2wEzF9X9TpVoN8xPY
         xHEg==
X-Gm-Message-State: AOJu0YyitqCkbBCxTU3nQ4HZtRxkLxz8YKYJ4pvZ2SJfLWK3iAa3Q8s4
        V06M34Qkyr6Pm12MoDU+1U7c+xXzYV1UwI4E3hPfWCFtMyYO8NPw
X-Google-Smtp-Source: AGHT+IHQgtmM/qEVU0UPeKqjFQmhQ59kgaPGxMwjXFavmatbWZ/rYVEWaDpXKACaogW7azdD4O9hjOLZ+ECSgh1rHzs=
X-Received: by 2002:a25:8481:0:b0:d7b:986e:9999 with SMTP id
 v1-20020a258481000000b00d7b986e9999mr3320097ybk.42.1693426316786; Wed, 30 Aug
 2023 13:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230825093531.7399-1-quic_nsekar@quicinc.com> <20230825093531.7399-6-quic_nsekar@quicinc.com>
In-Reply-To: <20230825093531.7399-6-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:11:45 +0300
Message-ID: <CAA8EJppvNS_hy=L+zgk5HAB5iDEZE_j5LvEmQgAfcnwfy_7wNA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq5018: Enable USB
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Amandeep Singh <quic_amansing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 12:37, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Enable USB2 in host mode.
>
> Co-developed-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Amandeep Singh <quic_amansing@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index e636a1cb9b77..cdf5e22ec54e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -70,3 +70,15 @@
>  &xo_board_clk {
>         clock-frequency = <24000000>;
>  };
> +
> +&usbphy0 {
> +       status = "okay";
> +};
> +
> +&usb {
> +       status = "okay";
> +};
> +
> +&usb2_0_dwc {
> +       dr_mode = "host";
> +};

Let me sort these for you:

- usb
- usb2_0_dwc
- usbphy0

Like in a dictionary.

-- 
With best wishes
Dmitry
