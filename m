Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E57AC49C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjIWTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIWTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:06:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F3FA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:05:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59c0281d72dso48267267b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695495953; x=1696100753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFL+5lcBJ/nrnITAKwCUKDYJilYrmnGgFjGhXDhm8mM=;
        b=GBv3oHB/8hYhhDpLfT/y7FpZCmSqafVZlUic4ZIqnOnI63IOvtfvAH+RaV5iexYsgR
         FDRM7hkzKQPP0E7j+0GiKWiV+K39LzavieVfU3lR5QS0jJegGH/GGTFaAaQNWR+K4WVi
         gviaVv+/RsVbg5NvRKtJEQECEm1iP+6nHzN85P3Egmt/5ZeAr+lhiV0RNnY/o7BfFjJB
         W1blkphX6V/zORNcmNiubgk4wc9ad4037GbIG0VkPWX8Ik9W3wB/zc9D+5L9Sg3yqNOH
         fXvzz8pIkknmSzSE9wUlNcnTBdCZjB7/q6lQTQQ/pC443Bng55toYTmW53jBlQeh7iMM
         nCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695495953; x=1696100753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFL+5lcBJ/nrnITAKwCUKDYJilYrmnGgFjGhXDhm8mM=;
        b=oWJdROK/w33s0HDv60jgVebXdv/R315PPvrCkBS86bCbI4vePyS7V0V4rIRFwaZe/n
         5YN0eBGWEseoDMjWrk818yJqSlkA1AWnLA9hdZ/wyGv5G2g/K6Kwe0GSatzRWMtRWtRl
         QEYJCTjCdGBLzVhF/C7k8Gq1Mv7sGqxBff15EWTIlTjrZ6znCfPTm6+N2TD8k7hNNuyH
         fdHZryRNkld28KTmudE2lomfxLGXzB0pGQSAUVy1OEX7cTLMV8FSYifq+xYtiuCKMY7P
         0J7h8its+E0mqUeWVFtqMTR8EQrwKa+RKZfyxOdoTHA6NgCLmVZF65OWGzAVt31M02TG
         Ajyw==
X-Gm-Message-State: AOJu0Yx87xim9JVHGR/213UF5/6ArzsG7QGebY71CRAfQR73s7m5rPm0
        AIIJpuLnz+7iyVEdwzu12HYM++04drKG5QfAk/QYQQ==
X-Google-Smtp-Source: AGHT+IGlYwKLVwocwF6z6WNa52eYGdnbaatbJsEwu8MrUBiZ1F3bXydJv77tBuIkEWpF2xz26FoCsFWui4i7Eav+CeM=
X-Received: by 2002:a81:6907:0:b0:59b:be67:84cb with SMTP id
 e7-20020a816907000000b0059bbe6784cbmr2579568ywc.26.1695495953557; Sat, 23 Sep
 2023 12:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com> <20230922083801.3056724-2-quic_fenglinw@quicinc.com>
In-Reply-To: <20230922083801.3056724-2-quic_fenglinw@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:05:42 +0300
Message-ID: <CAA8EJpo7puWxNte5YHiy6=3GdQSeTYCZMe024-b4N0vnxCV0dQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 1/3] input: pm8xxx-vib: refactor to easily
 support new SPMI vibrator
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com
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

On Fri, 22 Sept 2023 at 11:38, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
> Currently, all vibrator control register addresses are hard coded,
> including the base address and the offset, it's not flexible to support
> new SPMI vibrator module which is usually included in different PMICs
> with different base address. Refactor this by defining register offset
> with HW type combination, and register base address which is defined
> in 'reg' property is added for SPMI vibrators.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 122 ++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> index 04cb87efd799..d6b468324c77 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -12,36 +12,44 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>
> +#define SSBL_VIB_DRV_REG               0x4A

SSBI_VIB....

> +#define SSBI_VIB_DRV_EN_MANUAL_MASK    GENMASK(7, 2)
> +#define SSBI_VIB_DRV_LEVEL_MASK                GENMASK(7, 3)
> +#define SSBI_VIB_DRV_SHIFT             3
> +
> +#define SPMI_VIB_DRV_REG               0x41
> +#define SPMI_VIB_DRV_LEVEL_MASK                GENMASK(4, 0)
> +#define SPMI_VIB_DRV_SHIFT             0
> +
> +#define SPMI_VIB_EN_REG                        0x46
> +#define SPMI_VIB_EN_BIT                        BIT(7)
> +
>  #define VIB_MAX_LEVEL_mV       (3100)
>  #define VIB_MIN_LEVEL_mV       (1200)
>  #define VIB_MAX_LEVELS         (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
>
>  #define MAX_FF_SPEED           0xff
>
> -struct pm8xxx_regs {
> -       unsigned int enable_addr;
> -       unsigned int enable_mask;
> +enum vib_hw_type {
> +       SSBI_VIB,
> +       SPMI_VIB,
> +};
>
> -       unsigned int drv_addr;
> -       unsigned int drv_mask;
> -       unsigned int drv_shift;
> -       unsigned int drv_en_manual_mask;
> +struct pm8xxx_vib_data {
> +       enum vib_hw_type        hw_type;
> +       unsigned int            enable_addr;
> +       unsigned int            drv_addr;
>  };
>
> -static const struct pm8xxx_regs pm8058_regs = {
> -       .drv_addr = 0x4A,
> -       .drv_mask = 0xf8,
> -       .drv_shift = 3,
> -       .drv_en_manual_mask = 0xfc,
> +static const struct pm8xxx_vib_data ssbi_vib_data = {
> +       .hw_type        = SSBI_VIB,
> +       .drv_addr       = SSBL_VIB_DRV_REG,
>  };
>
> -static struct pm8xxx_regs pm8916_regs = {
> -       .enable_addr = 0xc046,
> -       .enable_mask = BIT(7),
> -       .drv_addr = 0xc041,
> -       .drv_mask = 0x1F,
> -       .drv_shift = 0,
> -       .drv_en_manual_mask = 0,
> +static const struct pm8xxx_vib_data spmi_vib_data = {
> +       .hw_type        = SPMI_VIB,
> +       .enable_addr    = SPMI_VIB_EN_REG,
> +       .drv_addr       = SPMI_VIB_DRV_REG,
>  };
>
>  /**
> @@ -49,7 +57,8 @@ static struct pm8xxx_regs pm8916_regs = {
>   * @vib_input_dev: input device supporting force feedback
>   * @work: work structure to set the vibration parameters
>   * @regmap: regmap for register read/write
> - * @regs: registers' info
> + * @data: vibrator HW info
> + * @reg_base: the register base of the module
>   * @speed: speed of vibration set from userland
>   * @active: state of vibrator
>   * @level: level of vibration to set in the chip
> @@ -59,7 +68,8 @@ struct pm8xxx_vib {
>         struct input_dev *vib_input_dev;
>         struct work_struct work;
>         struct regmap *regmap;
> -       const struct pm8xxx_regs *regs;
> +       const struct pm8xxx_vib_data *data;
> +       unsigned int reg_base;
>         int speed;
>         int level;
>         bool active;
> @@ -75,24 +85,31 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>  {
>         int rc;
>         unsigned int val = vib->reg_vib_drv;
> -       const struct pm8xxx_regs *regs = vib->regs;
> +       u32 mask = SPMI_VIB_DRV_LEVEL_MASK;
> +       u32 shift = SPMI_VIB_DRV_SHIFT;
> +
> +       if (vib->data->hw_type == SSBI_VIB) {
> +               mask = SSBI_VIB_DRV_LEVEL_MASK;
> +               shift = SSBI_VIB_DRV_SHIFT;
> +       }
>
>         if (on)
> -               val |= (vib->level << regs->drv_shift) & regs->drv_mask;
> +               val |= (vib->level << shift) & mask;
>         else
> -               val &= ~regs->drv_mask;
> +               val &= ~mask;
>
> -       rc = regmap_write(vib->regmap, regs->drv_addr, val);
> +       rc = regmap_update_bits(vib->regmap, vib->reg_base + vib->data->drv_addr, mask, val);
>         if (rc < 0)
>                 return rc;
>
>         vib->reg_vib_drv = val;
>
> -       if (regs->enable_mask)
> -               rc = regmap_update_bits(vib->regmap, regs->enable_addr,
> -                                       regs->enable_mask, on ? ~0 : 0);
> +       if (vib->data->hw_type == SSBI_VIB)
> +               return 0;
>
> -       return rc;
> +       mask = SPMI_VIB_EN_BIT;
> +       val = on ? SPMI_VIB_EN_BIT : 0;
> +       return regmap_update_bits(vib->regmap, vib->reg_base + vib->data->enable_addr, mask, val);
>  }
>
>  /**
> @@ -102,13 +119,6 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
>  static void pm8xxx_work_handler(struct work_struct *work)
>  {
>         struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
> -       const struct pm8xxx_regs *regs = vib->regs;
> -       int rc;
> -       unsigned int val;
> -
> -       rc = regmap_read(vib->regmap, regs->drv_addr, &val);
> -       if (rc < 0)
> -               return;
>
>         /*
>          * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
> @@ -168,9 +178,9 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>  {
>         struct pm8xxx_vib *vib;
>         struct input_dev *input_dev;
> +       const struct pm8xxx_vib_data *data;
>         int error;
> -       unsigned int val;
> -       const struct pm8xxx_regs *regs;
> +       unsigned int val, reg_base;
>
>         vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
>         if (!vib)
> @@ -187,19 +197,33 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
>         INIT_WORK(&vib->work, pm8xxx_work_handler);
>         vib->vib_input_dev = input_dev;
>
> -       regs = of_device_get_match_data(&pdev->dev);
> +       data = of_device_get_match_data(&pdev->dev);
> +       if (!data)
> +               return -EINVAL;
>
> -       /* operate in manual mode */
> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
> -       if (error < 0)
> -               return error;
> +       if (data->hw_type != SSBI_VIB) {

You can drop this condition, if ssbi_vib_data.drv_addr is 0.

> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
> +               if (error < 0) {
> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
> +                       return error;
> +               }
> +
> +               vib->reg_base += reg_base;
> +       }
>
> -       val &= regs->drv_en_manual_mask;
> -       error = regmap_write(vib->regmap, regs->drv_addr, val);
> +       error = regmap_read(vib->regmap, vib->reg_base + data->drv_addr, &val);
>         if (error < 0)
>                 return error;
>
> -       vib->regs = regs;
> +       /* operate in manual mode */
> +       if (data->hw_type == SSBI_VIB) {
> +               val &= SSBI_VIB_DRV_EN_MANUAL_MASK;
> +               error = regmap_write(vib->regmap, vib->reg_base + data->drv_addr, val);
> +               if (error < 0)
> +                       return error;
> +       }
> +
> +       vib->data = data;
>         vib->reg_vib_drv = val;
>
>         input_dev->name = "pm8xxx_vib_ffmemless";
> @@ -239,9 +263,9 @@ static int pm8xxx_vib_suspend(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
>
>  static const struct of_device_id pm8xxx_vib_id_table[] = {
> -       { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
> -       { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
> -       { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> +       { .compatible = "qcom,pm8058-vib", .data = &ssbi_vib_data },
> +       { .compatible = "qcom,pm8921-vib", .data = &ssbi_vib_data },
> +       { .compatible = "qcom,pm8916-vib", .data = &spmi_vib_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
