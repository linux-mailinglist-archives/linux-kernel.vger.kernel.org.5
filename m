Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B07F4382
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjKVKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjKVKTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:03 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582B91
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:18:59 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9cbba16084so6038420276.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700648338; x=1701253138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9c11pFvupFPnQhEf8NQ0gBbEB8fE0d+93nnxiRUqcLg=;
        b=BYpeWtKG4FPPf+N/7yMjOQrL26G6lczdxEJyDrRdJaKy2sMRVyk9ra2Zb0Ir8UraU1
         zRkbX2AVsBzH7voibXe+CtveWstVDh8vU40FpDnpYZOAB4wHJu6nSfBqQ6PurNk5J9mf
         cQInJWQtuJ/Ds5EkF0Ese2ZfAdOwKSNKum7fYTRtww4llKmIx8CHN0px6j4N+HhbDdtW
         K+OYJZAvCt6UM1T6eKow//PgRpJDVrvIOKsS21rfHgkb+O83vUukVO0AO2aZ1y1bE/r+
         NRvwjMoR8gMh69sv0YLICwm+UMmPVUBqN2LLbE2XqurJ9sCQgD8Rf1VbCf3abEIBwF3q
         3/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648338; x=1701253138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c11pFvupFPnQhEf8NQ0gBbEB8fE0d+93nnxiRUqcLg=;
        b=fDUlSRspqAsHqnAOuPWw/QcHr72sdUF0Oovhb5zrnkVJbwiirlW3dqI518wVMFNtSR
         dlP1QKhHObllACKWtxMaiQnhsSKlIPpknafUrKNWALw7TTNc9dOOjB2yxzqQZYChDTKX
         pm0tXMUq1GNj9GBneDQTo0vNBf7j5qyvqdW6Hey6fT5OrAUBu74GiXSHMexG9iCgU8T3
         BzvE2Uiks2cVS9V3ZbF3aFviBJf7kYS7dHEost9vy4v8s+M44B+uapPxSrIAiQygH7Od
         Us+NvX0IxPUCQ9F3RFZPn5/JDjGNCx4v+lO1SvUL5L8bI2u+PUaDtcx4fe0G+iARIzrH
         kAZA==
X-Gm-Message-State: AOJu0Yy98lky5+pDTfNK00b4GrtX9aGpK0OmzayFpSgWnO2kHYls+wi3
        iyN5PVjv6XGe9T6hDYOigI5xDlXBLVi5jk2WYJ1zBw==
X-Google-Smtp-Source: AGHT+IHbEev2I5tUtnx8XY+aYZY4ijq+jp+sr4M76Qn2LzFRDutzsRzlkmQ4g5DWOee0/SQLVPpI4jwELA55NaoeLVE=
X-Received: by 2002:a5b:4d1:0:b0:da0:622b:5539 with SMTP id
 u17-20020a5b04d1000000b00da0622b5539mr1470086ybp.58.1700648338139; Wed, 22
 Nov 2023 02:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-4-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-4-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:18:47 +0200
Message-ID: <CAA8EJpouPmst-ZcJSZ-qMPB2regi1saTyjczQnN5E=zE57C-Fg@mail.gmail.com>
Subject: Re: [PATCH 4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB.
> Add the new PCS USB specific offsets in a dedicated header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
> new file mode 100644
> index 000000000000..dbb75964cef7
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
> +#define QCOM_PHY_QMP_PCS_USB_V7_H_
> +
> +/* Only for QMP V6 PHY - USB3 have different offsets than V5 */

V7

> +#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG1            0xc4
> +#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG2            0xc8
> +#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG3            0xcc
> +#define QPHY_USB_V7_PCS_LOCK_DETECT_CONFIG6            0xd8
> +#define QPHY_USB_V7_PCS_REFGEN_REQ_CONFIG1             0xdc
> +#define QPHY_USB_V7_PCS_USB3_POWER_STATE_CONFIG1       0x90
> +#define QPHY_USB_V7_PCS_RX_SIGDET_LVL                  0x188
> +#define QPHY_USB_V7_PCS_RCVR_DTCT_DLY_P1U2_L           0x190
> +#define QPHY_USB_V7_PCS_RCVR_DTCT_DLY_P1U2_H           0x194
> +#define QPHY_USB_V7_PCS_CDR_RESET_TIME                 0x1b0
> +#define QPHY_USB_V7_PCS_ALIGN_DETECT_CONFIG1           0x1c0
> +#define QPHY_USB_V7_PCS_ALIGN_DETECT_CONFIG2           0x1c4
> +#define QPHY_USB_V7_PCS_PCS_TX_RX_CONFIG               0x1d0
> +#define QPHY_USB_V7_PCS_EQ_CONFIG1                     0x1dc
> +#define QPHY_USB_V7_PCS_EQ_CONFIG5                     0x1ec

Some (most) of these registers do not belong here, they are the same
as the generic PCS register names. Please drop them.

> +
> +#define QPHY_USB_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL   0x18
> +#define QPHY_USB_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2  0x3c
> +#define QPHY_USB_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L                0x40
> +#define QPHY_USB_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H                0x44

Drop the _USB_ part, please, there is already PCS_USB3 prefix.

> +
> +#endif
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
