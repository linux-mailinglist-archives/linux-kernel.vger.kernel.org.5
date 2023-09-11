Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16E79B3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjIKUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbjIKTEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:04:09 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5B1B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:04:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so4297678276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694459043; x=1695063843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mIhjm/gLeN7AiCgdCxfDsRxYuO98ZVwAg1FCQmb0mU=;
        b=p8WVrllAJyQCLoA/1qN8QfJCaW3cGPNAXyGO0Q3ICA1zIFS0+B/Qlp+jzrvSkIFIhG
         ynWRVPhJS0hMzDdfPQ7qMgU9EPUvLIxwYgpbJJRkJ4LEQ0oNdguHYseQRNFubFvrWOOk
         aQ2DNkZk+BKcshDaPavp6fJR8Lg6Mzz0oQy0GQJ3PIQrxaZZYU9JQv7ufmunyvlxA/W8
         3vw1SZHCZFo7dlImtSJ34r3ToPnPyU1i/WncQHH/ATgb0OyWhoZIkn8xbaiPJfcX5XWr
         RkECrvo7Vn9BQ6tha91zasMQF9By6PIUgzjYlookB4WzK5mAiDzH06psG06lnG8mAiME
         pvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694459043; x=1695063843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mIhjm/gLeN7AiCgdCxfDsRxYuO98ZVwAg1FCQmb0mU=;
        b=UqeT0HyI2j0NVapaUjDM6IGdHEbLxny01WlQQO8+nkKGziEgPr+413LR8o7FJDF31e
         EpFQuVJeC2KflY+ClA5NQbAFwbNhJ06kkCHp9P94vHZ1DhEnI/3ubG1UPTk3Ycp/aXDm
         Xe9SOZuC4KLE9PdVV/n/zHNjm/ozHYI0LiH8BqFAPXAwblJnCYd6BC0mTXx5SEXUte3H
         WhTjuyt1lMtEvP5nRTqk3kq4wA6dsEyFXTuUKUeSBMK9affO+2rq6cdt4pY2FXDcIpgx
         qb2x35OEmz+Rlj1lPfFFgz9yNR68wG1HaYAxRlijukZM2HZPeksLH/I9SjtkUi/YtwvE
         gf5Q==
X-Gm-Message-State: AOJu0YxHfxWLymhd+c1TUsUt1TU20pFBWNeNqkfJCwDB0VxsWVqewCQA
        Ng88gmgXBUQ7qMPc8HWm1JLkIZ2NdWUrcX9LBxOh3Q==
X-Google-Smtp-Source: AGHT+IFFgWuTRbzhCVUTHa6+RUuMDSdrXvH9fWKAG4dfXv6IHaq3trCC5F8d4kpaXMrx7rWDK0F3jt+hV8eP+spO7lM=
X-Received: by 2002:a25:ae96:0:b0:d39:fa2f:8b63 with SMTP id
 b22-20020a25ae96000000b00d39fa2f8b63mr10189018ybj.25.1694459043718; Mon, 11
 Sep 2023 12:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org> <20230829-topic-8550_usbphy-v1-1-599ddbfa094a@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v1-1-599ddbfa094a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Sep 2023 22:03:52 +0300
Message-ID: <CAA8EJpr-q5wJW082zXXzPQO=DjGYEj1bC=z18udSMxEfs+-yQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 23:59, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> There are two instances of the POWER_STATE_CONFIG1 register: one in
> the PCS space and another one in PCS_USB.
>
> The downstream init sequence pokes the latter one while we've been poking
> the former one (and misnamed it as the latter one, impostor!). Fix that
> up to avoid UB.
>
> Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 2 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

[skipped]

> @@ -23,6 +23,7 @@
>  #define QPHY_USB_V6_PCS_EQ_CONFIG1                     0x1dc
>  #define QPHY_USB_V6_PCS_EQ_CONFIG5                     0x1ec
>
> +#define QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1       0x00

Konrad, could you please send v2, fixing this to be _V6_ rather than
_Q6_. I'll rebase my series on top of this.

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
