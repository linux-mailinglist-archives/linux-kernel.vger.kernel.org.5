Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39D788EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjHYSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHYSnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:43:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11F9211C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:43:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d77f614243aso1239705276.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692989025; x=1693593825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o00pq7f1HXdPmJUSwqDHmd/YCYJRNFDvBasj0ZYO+1c=;
        b=U1EswR/QAAT1Byufmcvon3Xbbtm4oYZqaaePoDcrYw8OE7RJs/tFnehL59cudckT0V
         tF0M1EqO+QBgtwpU8FdhwgfqqwJSQQF3b4IT8KaxQDXgvqv6tv2DSA9HxOFrG2PGFbOJ
         9Gfq8R3G3OQnob5jhftfHmrd/Xrs7UunC0L+aBsZ0VAQ4r10Ax5XZkxRcQRaLW4BfBFf
         11XSPafWwdSu3pjTMEAulDG9wBWplnVlTy7Te79yN9WEN/KY5pLdNl3uhSpIiZsaGA7K
         C1QmMweD4KwV1qVLUt37w11nn5zjwUECL4s9WTL5dJZgDE5l0nyU3iY7nZ3NiPkCbzkd
         GglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989025; x=1693593825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o00pq7f1HXdPmJUSwqDHmd/YCYJRNFDvBasj0ZYO+1c=;
        b=OaFZ0lmotKT7bqRKS54aoFbi5N2SSX9VfqhjklRnqZrl+h9dN9f/FTD365xXB6AvOC
         iMNJ3HM9EC3GTh/bSBmk7LuMmW7Wxg23sPRtEaazYAqPlL5aJzvV3mNr33F9wDnm04Mq
         Vo0hsF1lJcgSxclld/6nQrreCYLtfTpVFzFS+EpQwACeG6CdI2cEtTXx/aHJ4wiqs9M4
         NL24SNDWWMZq1lBGA+xKkWpCYgJgS1l+YfPNnpKN26UbEL3gF8Yb+fj4rsljK7+E5cVz
         4i77mXE+Cd8LFLZitUiOSNh7siEzfCtlwcjZsqQ4v9T7XRQviceTcFhWHJ7SF5Ox7+pR
         TVow==
X-Gm-Message-State: AOJu0Ywl8wiC8OLQpL8T/ndSaqlHaynL60iEJEgiNkBxc/yTMhYhQtD5
        rMnMgiwz8lNHJojY8qqmYgfpgvc5NP76mgd8cmkk3A==
X-Google-Smtp-Source: AGHT+IHkG2JFPCv1RNiU6vNkvuOzi1cfYOcFfi3DgdYI/xAT+Hmd/jmE05nrF9a7gtNU5lNc7jcFEnftJTyx6ApjqB4=
X-Received: by 2002:a25:fc17:0:b0:d77:d565:25c9 with SMTP id
 v23-20020a25fc17000000b00d77d56525c9mr8349537ybd.20.1692989025544; Fri, 25
 Aug 2023 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
In-Reply-To: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 25 Aug 2023 21:43:34 +0300
Message-ID: <CAA8EJppSceyxynBbbRO09DqnGVwW46CfJqfkdadZi_kfF++FBw@mail.gmail.com>
Subject: Re: [PATCH v3] irqchip/qcom-pdc: add support for v3.2 HW
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 23 Aug 2023 at 12:49, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
> IRQ_i_CFG register and requires a change of the driver to avoid
> writing into an undefined register address.
>
> Get the HW version from registers and set the IRQ_ENABLE bit to the
> correct register depending on the HW version.
>
> Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Simplify qcom_pdc_gic_set_type()
> - Used __assign_bit in pdc_setup_pin_mapping()
> - remove BIT() from IRQ_i_CFG_IRQ_ENABLE to be used with __assign_bit()
> - Add Reviewed-by tag
> - Link to v2: https://lore.kernel.org/r/20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org
>
> Changes in v2:
> - Changed IRQ_ENABLE handling based on Maulik's comments
> - Link to v1: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org
> ---
>  drivers/irqchip/qcom-pdc.c | 61 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 13 deletions(-)

This patch in linux-next broke sm8150. On that platform the PDC region
has size 0x400, so reading the version crashes the kernel.
I'll send a patch fixing device tree, but we'd still need to handle
this in a driver too.

>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index d96916cf6a41..5f60a23686c9 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -23,9 +23,22 @@
>
>  #define PDC_MAX_GPIO_IRQS      256
>
> +/* Valid only on HW version < 3.2 */
>  #define IRQ_ENABLE_BANK                0x10
>  #define IRQ_i_CFG              0x110
>
> +/* Valid only on HW version >= 3.2 */
> +#define IRQ_i_CFG_IRQ_ENABLE   3
> +
> +#define IRQ_i_CFG_TYPE_MASK    GENMASK(2, 0)
> +
> +#define PDC_VERSION            0x1000
> +
> +/* Notable PDC versions */
> +enum {
> +       PDC_VERSION_3_2 = 0x30200,
> +};
> +
>  struct pdc_pin_region {
>         u32 pin_base;
>         u32 parent_base;
> @@ -38,6 +51,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
>  static void __iomem *pdc_base;
>  static struct pdc_pin_region *pdc_region;
>  static int pdc_region_cnt;
> +static unsigned int pdc_version;
>
>  static void pdc_reg_write(int reg, u32 i, u32 val)
>  {
> @@ -54,15 +68,22 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
>         int pin_out = d->hwirq;
>         unsigned long enable;
>         unsigned long flags;
> -       u32 index, mask;
> -
> -       index = pin_out / 32;
> -       mask = pin_out % 32;
>
>         raw_spin_lock_irqsave(&pdc_lock, flags);
> -       enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
> -       __assign_bit(mask, &enable, on);
> -       pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
> +       if (pdc_version < PDC_VERSION_3_2) {
> +               u32 index, mask;
> +
> +               index = pin_out / 32;
> +               mask = pin_out % 32;
> +
> +               enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
> +               __assign_bit(mask, &enable, on);
> +               pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
> +       } else {
> +               enable = pdc_reg_read(IRQ_i_CFG, pin_out);
> +               __assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
> +               pdc_reg_write(IRQ_i_CFG, pin_out, enable);
> +       }
>         raw_spin_unlock_irqrestore(&pdc_lock, flags);
>  }
>
> @@ -143,6 +164,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>         }
>
>         old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
> +       pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
>         pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
>
>         ret = irq_chip_set_type_parent(d, type);
> @@ -247,7 +269,7 @@ static const struct irq_domain_ops qcom_pdc_ops = {
>  static int pdc_setup_pin_mapping(struct device_node *np)
>  {
>         int ret, n, i;
> -       u32 irq_index, reg_index, val;
> +       unsigned long val;
>
>         n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
>         if (n <= 0 || n % 3)
> @@ -278,11 +300,22 @@ static int pdc_setup_pin_mapping(struct device_node *np)
>                         return ret;
>
>                 for (i = 0; i < pdc_region[n].cnt; i++) {
> -                       reg_index = (i + pdc_region[n].pin_base) >> 5;
> -                       irq_index = (i + pdc_region[n].pin_base) & 0x1f;
> -                       val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
> -                       val &= ~BIT(irq_index);
> -                       pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
> +                       if (pdc_version < PDC_VERSION_3_2) {
> +                               u32 irq_index, reg_index;
> +
> +                               reg_index = (i + pdc_region[n].pin_base) >> 5;
> +                               irq_index = (i + pdc_region[n].pin_base) & 0x1f;
> +                               val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
> +                               __assign_bit(irq_index, &val, 0);
> +                               pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
> +                       } else {
> +                               u32 irq;
> +
> +                               irq = i + pdc_region[n].pin_base;
> +                               val = pdc_reg_read(IRQ_i_CFG, irq);
> +                               __assign_bit(IRQ_i_CFG_IRQ_ENABLE, &val,  0);
> +                               pdc_reg_write(IRQ_i_CFG, irq, val);
> +                       }
>                 }
>         }
>
> @@ -300,6 +333,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>                 return -ENXIO;
>         }
>
> +       pdc_version = pdc_reg_read(PDC_VERSION, 0);
> +
>         parent_domain = irq_find_host(parent);
>         if (!parent_domain) {
>                 pr_err("%pOF: unable to find PDC's parent domain\n", node);
>
> ---
> base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
> change-id: 20230821-topic-sm8x50-upstream-pdc-ver-114ceb45e1ee
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>


-- 
With best wishes
Dmitry
