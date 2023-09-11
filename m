Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C779AEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377938AbjIKW3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbjIKThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:37:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30712A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:37:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9e478e122so3366936a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694461049; x=1695065849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=equAb98+MDoXTFD0Qn2BcTK9XaWv7WQjzYAJlfVROPE=;
        b=UBEaA+R7N4LkgvfN1y9xN5UtpJIwYXcboYlrRfp4E9r+F+m5YqKKu2X5YAJN6rOSOu
         /2xbLg9UBiqVQyeoIrjIzUd63CciKD1+6jUeWo+rvKqnPoH7c+Jw0Aln4eb1RFiYt3/6
         NYqGWcrpuAaUVAnVdvbV0RFdbQjnwGMQkZmg1XggZVgjmFu13+csIaGFM5cDGM9jsbsv
         GpDW3c9C1+KXmJ6YBVtR7RXUJa6K1whn8MA3eaQUUQlKXHvUfBCJg/CSazhcZtf8LjIK
         GTDbx8S4EfynRyUB63DAcZnHdkv4/7CE8exFT0y59BdQUGZqg1EhIRwG/c6s0ty+Qg9h
         smvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461049; x=1695065849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=equAb98+MDoXTFD0Qn2BcTK9XaWv7WQjzYAJlfVROPE=;
        b=Qah8RQIhoiG9xcD21xVO/8oYNJf6CmIrtoExOi2lDEA1cbYIqHJZ9mS2B6P36YmHZy
         ra1L/MI9x7nx7LNf6ONlhn7gohdD7o1tLqmSCrrzKxHEwbr3wHIFtq8FbUTG/PWPNUCV
         O3JbH81a2zwR/iiZHS2vQdF9G4KgyNIohMIbqt3dbB7hpHG/DuiMUby9nzGzSYkhu+5o
         N03pyItPAq1oaiaOxsf8TxT5QRqp2EDHz+JxA+8+fJbtXjFzVos6RPnYc7YPig5sJvn7
         UpRcZfkp4VQDxAndMjAPZoHJHDiA1JN4mA9LnfxexQOTaF/GYoV8V8f37rUbM1y9KWhX
         3jHw==
X-Gm-Message-State: AOJu0Yw0mb8kyqZn6HuWCfCs0I7X7iZZpyvPyExIiRaC6Ge8piVFyp8+
        UTitNCpPGiSyOvyp26BcaSZF14ctWCtSsNfL7QqlkB7pmAvjP26Q
X-Google-Smtp-Source: AGHT+IHlhxgtmO7tiyrDYj+HzY/4j2EIuZNEIP9VA79lo1De8xszz8bgpU9rqTSS45gbydj/7QtcRpuKH4sFAZZm+uk=
X-Received: by 2002:a9d:6e03:0:b0:6b7:4efe:a9a4 with SMTP id
 e3-20020a9d6e03000000b006b74efea9a4mr12026934otr.23.1694461049001; Mon, 11
 Sep 2023 12:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-topic-8550_usbphy-v2-0-a72f43311d19@linaro.org> <20230829-topic-8550_usbphy-v2-1-a72f43311d19@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v2-1-a72f43311d19@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Sep 2023 22:37:17 +0300
Message-ID: <CAA8EJppHVs18rhb3p7_LGrE02wD_tYzTbOMr46cAHV7imG+rDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 22:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> There are two instances of the POWER_STATE_CONFIG1 register: one in
> the PCS space and another one in PCS_USB.
>
> The downstream init sequence pokes the latter one while we've been poking
> the former one (and misnamed it as the latter one, impostor!). Fix that
> up to avoid UB.
>
> Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 2 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index cbb28afce135..843099d314bf 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -859,10 +859,10 @@ static const struct qmp_phy_init_tbl sm8550_usb3_pcs_tbl[] = {
>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG1, 0x4b),
>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG5, 0x10),
> -       QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
>  };
>
>  static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),

And this is still _Q6_

>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
>         QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
> index 9510e63ba9d8..c38530d6776b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
> @@ -12,7 +12,7 @@
>  #define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG3            0xcc
>  #define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG6            0xd8
>  #define QPHY_USB_V6_PCS_REFGEN_REQ_CONFIG1             0xdc
> -#define QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1       0x90
> +#define QPHY_USB_V6_PCS_POWER_STATE_CONFIG1            0x90
>  #define QPHY_USB_V6_PCS_RX_SIGDET_LVL                  0x188
>  #define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_L           0x190
>  #define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_H           0x194
> @@ -23,6 +23,7 @@
>  #define QPHY_USB_V6_PCS_EQ_CONFIG1                     0x1dc
>  #define QPHY_USB_V6_PCS_EQ_CONFIG5                     0x1ec
>
> +#define QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1       0x00
>  #define QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL   0x18
>  #define QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2  0x3c
>  #define QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L                0x40
>
> --
> 2.42.0
>


-- 
With best wishes
Dmitry
