Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29575748D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGRGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGRGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:44:30 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0BF1A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:44:19 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso4049164276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689662659; x=1690267459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuRVvGF5MNdStKNcCccw8B7IgI3efX2Z3eR7dcrntU=;
        b=lFSv0JUjukZ1kanYA9iBL8H+qZVVkTL/H+pL5pJ7Z7MY3uMSejYyZfSPXBIQI6Jd5o
         BLXsWyNbg7WzLOJMTN5E0i8PDRWO+744BZbQXYWfJGohJ2pfOaowdpLKCehVK29nWd+n
         +aPDuXLNSyJpdOAmzexvvoUmrM9g1HlS2FQXKSDIwT8TxyoLkcpIibI4k+y/2zyjPuBe
         0TVSGmdW50HcOqQ1d/Z8GaTy6Asu1l24klv54kNAsx1BeZE4Ab53P/3DtGGKYElfbVse
         Nie2XWNDdNeyRMKkOpFM1M3ZhXv5W5caU206Ly3eo+9UXwtWuJZBVBA3AXzwW4oTzvPG
         t+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662659; x=1690267459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyuRVvGF5MNdStKNcCccw8B7IgI3efX2Z3eR7dcrntU=;
        b=KgnaOt5joMb5+P9blCsMRfBf43OVJ79yYKYTCVpHYE5arr9P8KpiAiPFRsFHkWY3Lp
         AKeyYJNNM2jDn7D3jA9qdlJzWs5OtLmfkWiGB6kd5TLET67aZZXsN0+q73ms3EiSKwRp
         5rCP5BxbfKXDAkJeZRU95iXawMnQ+KEP5TsAVuzuTpxFhbqcKq3I5U0dmvnA2qpq1dVs
         MK4+s5cmUcE3A8UIY9d+OIB9rm4Sg/n5MZiVuZKbjvq3knG91SSFJQLaR58fXvacTyBD
         v2qKX4vXfPuLhnv3C6IKcX0O9Bg0nVFul13qbalfYsklWKE6sbae5V1guvI6pQwysClo
         tHkQ==
X-Gm-Message-State: ABy/qLYCstVUyhKY+ST/DDws3Qy0SHFNeC2G7w68PzdXofaNW45VBxQL
        UWxRZPGGohjg+25BIciU3Zybl2AX3fsJVtiMjZ51DQ==
X-Google-Smtp-Source: APBJJlGsMDPNRFjvxb4ux2NK5UigVZ2weKPu9bJapRUwQ8N6wZlORi6C48PNLhE38vmFy1F6tIkaOZ+WowLEBKVnol8=
X-Received: by 2002:a25:2f81:0:b0:c80:f701:7467 with SMTP id
 v123-20020a252f81000000b00c80f7017467mr10473630ybv.45.1689662658978; Mon, 17
 Jul 2023 23:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com> <20230718062639.2339589-3-quic_fenglinw@quicinc.com>
In-Reply-To: <20230718062639.2339589-3-quic_fenglinw@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 18 Jul 2023 09:44:07 +0300
Message-ID: <CAA8EJpq_DGu3+kc_ex_2MUyiQFJvZhbWOc7NO6x1pO1Wx4RbNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: pm8xxx-vib - Add support for more PMICs
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 09:27, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
> Add support for vibrator module inside PMI632, PM7250B, PM7325B.
> It is very similar to vibrator inside PM8xxx but just the drive
> amplitude is controlled through 2 bytes registers.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 48 ++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 04cb87efd799..213fdfd47c7f 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -25,6 +25,9 @@ struct pm8xxx_regs {
>         unsigned int drv_addr;
>         unsigned int drv_mask;
>         unsigned int drv_shift;
> +       unsigned int drv_addr2;
> +       unsigned int drv_mask2;
> +       unsigned int drv_shift2;
>         unsigned int drv_en_manual_mask;
>  };
>
> @@ -44,6 +47,42 @@ static struct pm8xxx_regs pm8916_regs = {
>         .drv_en_manual_mask = 0,
>  };
>
> +static struct pm8xxx_regs pmi632_regs = {
> +       .enable_addr = 0x5746,
> +       .enable_mask = BIT(7),
> +       .drv_addr = 0x5740,
> +       .drv_mask = 0xff,
> +       .drv_shift = 0,
> +       .drv_addr2 = 0x5741,
> +       .drv_mask2 = 0x0f,
> +       .drv_shift2 = 8,

I see that you are just expanding what was done for SSBI PMICs and
later expanded to support pm8916. However it might be better to drop
the hardcoded .drv_addr (and drv_addr2) and read address from DT
instead.

> +       .drv_en_manual_mask = 0,
> +};
> +
> +static struct pm8xxx_regs pm7250b_regs = {
> +       .enable_addr = 0x5346,
> +       .enable_mask = BIT(7),
> +       .drv_addr = 0x5340,
> +       .drv_mask = 0xff,
> +       .drv_shift = 0,
> +       .drv_addr2 = 0x5341,
> +       .drv_mask2 = 0x0f,
> +       .drv_shift2 = 8,
> +       .drv_en_manual_mask = 0,
> +};
> +
> +static struct pm8xxx_regs pm7325b_regs = {
> +       .enable_addr = 0xdf46,
> +       .enable_mask = BIT(7),
> +       .drv_addr = 0xdf40,
> +       .drv_mask = 0xff,
> +       .drv_shift = 0,
> +       .drv_addr2 = 0xdf41,
> +       .drv_mask2 = 0x0f,
> +       .drv_shift2 = 8,
> +       .drv_en_manual_mask = 0,
> +};
> +
>  /**
>   * struct pm8xxx_vib - structure to hold vibrator data
>   * @vib_input_dev: input device supporting force feedback
> @@ -87,6 +126,12 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>                 return rc;
>
>         vib->reg_vib_drv = val;
> +       if (regs->drv_addr2 != 0 && on) {
> +               val = (vib->level << regs->drv_shift2) & regs->drv_mask2;
> +               rc = regmap_write(vib->regmap, regs->drv_addr2, val);
> +               if (rc < 0)
> +                       return rc;
> +       }
>
>         if (regs->enable_mask)
>                 rc = regmap_update_bits(vib->regmap, regs->enable_addr,
> @@ -242,6 +287,9 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
>         { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
>         { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
>         { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
> +       { .compatible = "qcom,pm7250b-vib", .data = &pm7250b_regs },
> +       { .compatible = "qcom,pm7325b-vib", .data = &pm7325b_regs },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
