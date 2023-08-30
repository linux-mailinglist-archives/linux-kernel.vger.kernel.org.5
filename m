Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD378E060
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbjH3TVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243242AbjH3K2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:28:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D281B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:28:28 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 35ED241D37
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693391307;
        bh=0x71Jiks4crbLYMF8B7w24UzcWpOCQauPfqR/sxZV0g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pm+uIcVEjgoNMMPEU15DjGahvJopLjdyEsZ3lVBRLnnEoZGajFmXcmGJCxNnhMGlo
         289uAiPO3Hcxnfwd1Cdq6AaPH9clsR0nIzdp8j5vLvsXBEO1ZZ/FOqQAF8M1cdyd2U
         9fbU1Y5jfkKDPEtHosWfG2JSEOSJXGO/MKZMPPFy9iMWVOpj/6EhSoMMIreZbdKKbv
         iMEFDZS1i8GZgtjhPbYEosrb3udYZDAWtOXEMRLKOELKH54HMjlPHBptcrZ+/YudOA
         K8/Fz1dMHcpak0lrnkaCK5MzYBaPnbAM1Uo7aXSNTCMUrdAFyNnyulmlMr3n8yYcxk
         M7BkdOumReMrw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4131d4bc82dso13030131cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391305; x=1693996105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x71Jiks4crbLYMF8B7w24UzcWpOCQauPfqR/sxZV0g=;
        b=b3qDBPIPowDpBwQ9LO2Kb9o+5aMyn9kF8UwKb3UxB9JFmRig760yPG4gQFrYgIYpB5
         oQSZJzJVtWvTT9QLNeZzOrhqisd37f6ba+72C4wv3Zcl1vzYpB8j1joU/v+X8FJKz8Yy
         tXjW13Ku7j5nBEPWxFqmW0UhvSY5aud8ag+t6uu8HJCUtXGyw3ik6pN08Ah8V9uVfZ6v
         nWvgl+goaNDPQjZ5ciPYQQvtIX7TYOgQcZmRRxdu3M0Xcv3IHGROSDMrRurAFeVNI0FK
         V0GG1EZYHG5UKqZAO4DYJjjzXuqCdbYKZM5nDhJLdDLKSTwGNZBcr+W3wPOZm3x/Z1Ht
         UUPA==
X-Gm-Message-State: AOJu0YwyJTr0OPNU6KZCB1wRx7WvquAVJsZiQBA5pZk9jzuEJ9EO3p0F
        j87zIpUm9bW5may5O5R2hUSVMGgo+u6DN/+69amI8jD8J69xpgdpUwwKOfP/bl/Uk3vGIF6ePMd
        pj34gm5o24rWdjnf21OmoUhTng0Z/SmLvcLCj5hAQPA8mNQd61lQSeTa2mw==
X-Received: by 2002:ac8:4e89:0:b0:403:e958:b456 with SMTP id 9-20020ac84e89000000b00403e958b456mr2057145qtp.19.1693391305194;
        Wed, 30 Aug 2023 03:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUywKtZ9QBvF7SXkZ/+FtfBV0akTc4+5p56GkjMS3vEHZ1SMFeY9wEQ5cijc1CJI92RxPk+2KWSd+Z7E9kvN8=
X-Received: by 2002:ac8:4e89:0:b0:403:e958:b456 with SMTP id
 9-20020ac84e89000000b00403e958b456mr2057124qtp.19.1693391304908; Wed, 30 Aug
 2023 03:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230830031846.127957-1-william.qiu@starfivetech.com> <20230830031846.127957-3-william.qiu@starfivetech.com>
In-Reply-To: <20230830031846.127957-3-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 30 Aug 2023 12:28:08 +0200
Message-ID: <CAJM55Z9CL8DN+uEhRoR7ZUuwtVudTUzA1+Q4Hn_rukCfT+SXeQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: starfive: Change tuning implementation
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 05:21, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Before, we used syscon to achieve tuning, but the actual measurement
> showed little effect, so the tuning implementation was modified here,
> and it was realized by reading and writing the UHS_REG_EXT register.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  drivers/mmc/host/dw_mmc-starfive.c | 131 ++++++++---------------------
>  1 file changed, 37 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
> index fd05a648a8bb..593c995e49f5 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -20,14 +20,6 @@
>  #define ALL_INT_CLR            0x1ffff
>  #define MAX_DELAY_CHAIN                32
>
> -struct starfive_priv {
> -       struct device *dev;
> -       struct regmap *reg_syscon;
> -       u32 syscon_offset;
> -       u32 syscon_shift;
> -       u32 syscon_mask;
> -};
> -
>  static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         int ret;
> @@ -44,117 +36,68 @@ static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         }
>  }
>
> +static void dw_mci_starfive_hs_set_bits(struct dw_mci *host, u32 smpl_phase)

"set bits" is very generic. Maybe dw_mci_starfive_set_sample_phase()
or something more descriptive.

> +{
> +       /* change driver phase and sample phase */
> +       u32 mask = 0x1f;
> +       u32 reg_value;
> +
> +       reg_value = mci_readl(host, UHS_REG_EXT);
> +
> +       /* In UHS_REG_EXT, only 5 bits valid in DRV_PHASE and SMPL_PHASE */
> +       reg_value &= ~(mask << 16);
> +       reg_value |= (smpl_phase << 16);
> +       mci_writel(host, UHS_REG_EXT, reg_value);
> +
> +       /* We should delay 1ms wait for timing setting finished. */
> +       mdelay(1);
> +}

This implementation could use some cleanup. Eg. why do we need the
mask variable?
How about something like this:

#define STARFIVE_SMPL_PHASE     GENMASK(20, 16)

u32 reg_value = mci_read(host, UHS_REG_EXT);
reg_value &= ~STARFIVE_SMPL_PHASE;
reg_value |= FIELD_PREP(STARFIVE_SMPL_PHASE, smpl_phase);
mci_writel(host, UHS_REG_EXT, reg_value);
...

>  static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>                                              u32 opcode)
>  {
>         static const int grade  = MAX_DELAY_CHAIN;
>         struct dw_mci *host = slot->host;
> -       struct starfive_priv *priv = host->priv;
> -       int rise_point = -1, fall_point = -1;
> -       int err, prev_err = 0;
> +       int err = -1;

This variable is always set later so doesn't need initialization and
is better called 'ret' as it's the return value of the function, and
not necessarily an error.

> +       int smpl_phase, smpl_raise = -1, smpl_fall = -1;
>         int i;
> -       bool found = 0;
> -       u32 regval;
> -
> -       /*
> -        * Use grade as the max delay chain, and use the rise_point and
> -        * fall_point to ensure the best sampling point of a data input
> -        * signals.
> -        */
> +
>         for (i = 0; i < grade; i++) {
> -               regval = i << priv->syscon_shift;
> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -                                               priv->syscon_mask, regval);
> -               if (err)
> -                       return err;
> +               smpl_phase = i;

This can now be written

for (sampl_phase = 0; sampl_phase < grade; sampl_phase++)

> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
>                 mci_writel(host, RINTSTS, ALL_INT_CLR);
>
>                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
> -               if (!err)
> -                       found = 1;
> -
> -               if (i > 0) {
> -                       if (err && !prev_err)
> -                               fall_point = i - 1;
> -                       if (!err && prev_err)
> -                               rise_point = i;
> -               }
>
> -               if (rise_point != -1 && fall_point != -1)
> -                       goto tuning_out;
> -
> -               prev_err = err;
> -               err = 0;
> -       }
> -
> -tuning_out:
> -       if (found) {
> -               if (rise_point == -1)
> -                       rise_point = 0;
> -               if (fall_point == -1)
> -                       fall_point = grade - 1;
> -               if (fall_point < rise_point) {
> -                       if ((rise_point + fall_point) >
> -                           (grade - 1))
> -                               i = fall_point / 2;
> -                       else
> -                               i = (rise_point + grade - 1) / 2;
> -               } else {
> -                       i = (rise_point + fall_point) / 2;
> +               if (!err && smpl_raise < 0) {
> +                       smpl_raise = i;
> +               } else if (err && smpl_raise >= 0) {
> +                       smpl_fall = i - 1;
> +                       break;
>                 }
> +       }
>
> -               regval = i << priv->syscon_shift;
> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -                                               priv->syscon_mask, regval);
> -               if (err)
> -                       return err;
> -               mci_writel(host, RINTSTS, ALL_INT_CLR);
> +       if (i >= grade && smpl_raise >= 0)
> +               smpl_fall = grade - 1;
>
> -               dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
> -       } else {
> +       if (smpl_raise < 0) {
>                 dev_err(host->dev, "No valid delay chain! use default\n");
> +               dw_mci_starfive_hs_set_bits(host, 0);
>                 err = -EINVAL;
> +       } else {
> +               smpl_phase = (smpl_raise + smpl_fall) / 2;
> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
> +               dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", smpl_phase);
> +               err = 0;
>         }

Maybe something like:

  if (smpl_raise < 0) {
    smpl_phase = 0;
    dev_err(host->dev, "No valid delay chain, using default\n");
    ret = -EINVAL;
    goto out;
  }

  smpl_phase = (smpl_raise + smpl_fall) / 2;
  dev_dbg(...);
  ret = 0;

out:
  dw_mci_starfive_hs_set_bits(host, smpl_phase);
  mci_writel(host, RINTSTS, ALL_INT_CLR);
  return ret;
>  }
>
> -static int dw_mci_starfive_parse_dt(struct dw_mci *host)
> -{
> -       struct of_phandle_args args;
> -       struct starfive_priv *priv;
> -       int ret;
> -
> -       priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> -               return -ENOMEM;
> -
> -       ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
> -                                               "starfive,sysreg", 3, 0, &args);
> -       if (ret) {
> -               dev_err(host->dev, "Failed to parse starfive,sysreg\n");
> -               return -EINVAL;
> -       }
> -
> -       priv->reg_syscon = syscon_node_to_regmap(args.np);
> -       of_node_put(args.np);
> -       if (IS_ERR(priv->reg_syscon))
> -               return PTR_ERR(priv->reg_syscon);
> -
> -       priv->syscon_offset = args.args[0];
> -       priv->syscon_shift  = args.args[1];
> -       priv->syscon_mask   = args.args[2];
> -
> -       host->priv = priv;
> -
> -       return 0;
> -}
> -
>  static const struct dw_mci_drv_data starfive_data = {
>         .common_caps            = MMC_CAP_CMD23,
>         .set_ios                = dw_mci_starfive_set_ios,
> -       .parse_dt               = dw_mci_starfive_parse_dt,
>         .execute_tuning         = dw_mci_starfive_execute_tuning,
>  };
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
