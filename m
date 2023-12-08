Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146C80A440
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573794AbjLHNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjLHNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:15:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A718C3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:15:13 -0800 (PST)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07CF741516
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702041312;
        bh=c5wUCZP5uxT+D5h6Lc7Bx9+IP9vdWehgZtwy5FF1vNU=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=exiMYCCmxBHZwOOo9vdBdb0LtULtkdlAwUY9fgZnEKXYmJupmqHnRNBiEGWQvIPa4
         O0I7lMoFugw4gDfiE1GdKhXeYKPPTewTWQLO9y616Qx6j3CtgeO/KqB2WyjVEW8tFV
         85NgY/PL7XagpFkoDsguiRMJKo7V6ArJV8LtZoeKjVGMxEUQigY2GCMlPKcsYzwT7M
         JpB2MJwcxu5d4iRcWBXT0LgBsis7YqLSVhqhPN/W1qJ2/ALVEVfc/NiOuJhhMEijtG
         xtj1ql8aX4kgwyUBcLNTAsYA8770BVbPAyoMwwqfn+ntG5/At1YjCPA7zZ2YUPF/DH
         gnbCuOvU4Lndg==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42582386297so24588411cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702041310; x=1702646110;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5wUCZP5uxT+D5h6Lc7Bx9+IP9vdWehgZtwy5FF1vNU=;
        b=BZbDv8u/dIvk0FVx5q5vpkvAfXUN0MCNJlWhgYtVp5MClyk3agFgIkO35sgVVtUZ9R
         Hpw8ur89PN7hQNx59Bd6wDtFj9d/hSPE9nZqbACGha3OSwfqong2ow4INIOKJ/uVwhFY
         XjWT7S36YRsGyjpsik+S9QuXDWWI0qfxzeSeZHSXsYKMYfC4gcLbub1ciFWXKnFTuwiE
         yKNzXwCL7tuebzzUTOmz34DqN490Yh+fGw49RKsE3Lnug5WP2WzMIhaWBMGB9aDL0Opb
         npucNI8yIjtuxb89aJxf4UmFRA7yZfJrCd4HiatJcgwSzgoH4sUjpSu8mjmm6sr8J/SV
         5kAA==
X-Gm-Message-State: AOJu0Yzxx9Kz1dBkbA8yg8zKgLq/XBzTuX4qRy4cerlpgOxdntDYAXcd
        csI6vVt6tfW+J4BqH2OK2q1OzPJo+5ZptNUo5qJZg0kSv9Xh1wSdYQcn7DaZonZNtPIVdn8OizQ
        Q2tVlVYegrddZ9SS+MN5vr3FOFPZbDQ+m+kT6mdNhlzyD7KwuCyHvx/3ETw==
X-Received: by 2002:ac8:59cd:0:b0:425:a282:71ae with SMTP id f13-20020ac859cd000000b00425a28271aemr83641qtf.65.1702041310488;
        Fri, 08 Dec 2023 05:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGznAXIIRyxMLb5pO2qeJrPUYYl2PAXtj36+PqtwjGvaAeZjPNal02cbh/Khten3+rQ2+aY7jlmCUrdPAAgJ9c=
X-Received: by 2002:ac8:59cd:0:b0:425:a282:71ae with SMTP id
 f13-20020ac859cd000000b00425a28271aemr83624qtf.65.1702041310209; Fri, 08 Dec
 2023 05:15:10 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 08:15:09 -0500
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206115000.295825-3-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com> <20231206115000.295825-3-jeeheng.sia@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 8 Dec 2023 08:15:09 -0500
Message-ID: <CAJM55Z9yLeMDifcGprgav_cJgwLUwKPcsPJSyjSxr2-nVw-YrQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] reset: starfive: Convert the word "jh71x0" to "starfive"
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        emil.renner.berthing@canonical.com, hal.feng@starfivetech.com,
        xingyu.wu@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        leyfoon.tan@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sia Jee Heng wrote:
> Function names that consist of the 'jh71x0' naming convention are
> renamed to use the 'starfive' wording.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
>  .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
>  .../reset/starfive/reset-starfive-common.h    |  8 +--
>  .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
>  .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
>  include/soc/starfive/reset-starfive-common.h  |  6 +-
>  6 files changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 6e45c580c9ba..e63353c70209 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -345,7 +345,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
>  static void jh7110_reset_adev_release(struct device *dev)
>  {
>  	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> -	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
> +	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
>
>  	kfree(rdev);
>  }
> @@ -354,7 +354,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  				     const char *adev_name,
>  				     u32 adev_id)
>  {
> -	struct jh71x0_reset_adev *rdev;
> +	struct starfive_reset_adev *rdev;
>  	struct auxiliary_device *adev;
>  	int ret;
>
> diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
> index dab454e46bbf..8d8dec9e5d7a 100644
> --- a/drivers/reset/starfive/reset-starfive-common.c
> +++ b/drivers/reset/starfive/reset-starfive-common.c
> @@ -14,7 +14,7 @@
>
>  #include "reset-starfive-common.h"
>
> -struct jh71x0_reset {
> +struct starfive_reset {
>  	struct reset_controller_dev rcdev;
>  	/* protect registers against concurrent read-modify-write */
>  	spinlock_t lock;
> @@ -23,16 +23,16 @@ struct jh71x0_reset {
>  	const u32 *asserted;
>  };
>
> -static inline struct jh71x0_reset *
> -jh71x0_reset_from(struct reset_controller_dev *rcdev)
> +static inline struct starfive_reset *
> +starfive_reset_from(struct reset_controller_dev *rcdev)
>  {
> -	return container_of(rcdev, struct jh71x0_reset, rcdev);
> +	return container_of(rcdev, struct starfive_reset, rcdev);
>  }
>
> -static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
> -			       unsigned long id, bool assert)
> +static int starfive_reset_update(struct reset_controller_dev *rcdev,
> +				 unsigned long id, bool assert)
>  {
> -	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
> +	struct starfive_reset *data = starfive_reset_from(rcdev);
>  	unsigned long offset = id / 32;
>  	u32 mask = BIT(id % 32);
>  	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
> @@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
>  	return ret;
>  }
>
> -static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
> -			       unsigned long id)
> +static int starfive_reset_assert(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
>  {
> -	return jh71x0_reset_update(rcdev, id, true);
> +	return starfive_reset_update(rcdev, id, true);
>  }
>
> -static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
> -				 unsigned long id)
> +static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
> +				   unsigned long id)
>  {
> -	return jh71x0_reset_update(rcdev, id, false);
> +	return starfive_reset_update(rcdev, id, false);
>  }
>
> -static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
> -			      unsigned long id)
> +static int starfive_reset_reset(struct reset_controller_dev *rcdev,
> +				unsigned long id)
>  {
>  	int ret;
>
> -	ret = jh71x0_reset_assert(rcdev, id);
> +	ret = starfive_reset_assert(rcdev, id);
>  	if (ret)
>  		return ret;
>
> -	return jh71x0_reset_deassert(rcdev, id);
> +	return starfive_reset_deassert(rcdev, id);
>  }
>
> -static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
> -			       unsigned long id)
> +static int starfive_reset_status(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
>  {
> -	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
> +	struct starfive_reset *data = starfive_reset_from(rcdev);
>  	unsigned long offset = id / 32;
>  	u32 mask = BIT(id % 32);
>  	void __iomem *reg_status = data->status + offset * sizeof(u32);
> @@ -97,25 +97,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
>  	return !((value ^ data->asserted[offset]) & mask);
>  }
>
> -static const struct reset_control_ops jh71x0_reset_ops = {
> -	.assert		= jh71x0_reset_assert,
> -	.deassert	= jh71x0_reset_deassert,
> -	.reset		= jh71x0_reset_reset,
> -	.status		= jh71x0_reset_status,
> +static const struct reset_control_ops starfive_reset_ops = {
> +	.assert		= starfive_reset_assert,
> +	.deassert	= starfive_reset_deassert,
> +	.reset		= starfive_reset_reset,
> +	.status		= starfive_reset_status,
>  };
>
> -int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
> -				   void __iomem *assert, void __iomem *status,
> -				   const u32 *asserted, unsigned int nr_resets,
> -				   struct module *owner)
> +int reset_starfive_register(struct device *dev, struct device_node *of_node,
> +			    void __iomem *assert, void __iomem *status,
> +			    const u32 *asserted, unsigned int nr_resets,
> +			    struct module *owner)
>  {
> -	struct jh71x0_reset *data;
> +	struct starfive_reset *data;
>
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>
> -	data->rcdev.ops = &jh71x0_reset_ops;
> +	data->rcdev.ops = &starfive_reset_ops;
>  	data->rcdev.owner = owner;
>  	data->rcdev.nr_resets = nr_resets;
>  	data->rcdev.dev = dev;
> @@ -128,4 +128,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
>
>  	return devm_reset_controller_register(dev, &data->rcdev);
>  }
> -EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
> +EXPORT_SYMBOL_GPL(reset_starfive_register);
> diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
> index 266acc4b2caf..83461b22ee55 100644
> --- a/drivers/reset/starfive/reset-starfive-common.h
> +++ b/drivers/reset/starfive/reset-starfive-common.h
> @@ -6,9 +6,9 @@
>  #ifndef __RESET_STARFIVE_COMMON_H
>  #define __RESET_STARFIVE_COMMON_H
>
> -int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
> -				   void __iomem *assert, void __iomem *status,
> -				   const u32 *asserted, unsigned int nr_resets,
> -				   struct module *owner);
> +int reset_starfive_register(struct device *dev, struct device_node *of_node,
> +			    void __iomem *assert, void __iomem *status,
> +			    const u32 *asserted, unsigned int nr_resets,
> +			    struct module *owner);
>
>  #endif /* __RESET_STARFIVE_COMMON_H */
> diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
> index 546dea2e5811..122ac6c3893b 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7100.c
> @@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>
> -	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
> +	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
>  					      base + JH7100_RESET_ASSERT0,
>  					      base + JH7100_RESET_STATUS0,
>  					      jh7100_reset_asserted,
> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
> index 87dba01491ae..c4dd21761e53 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7110.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
> @@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
>  			      const struct auxiliary_device_id *id)
>  {
>  	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
> -	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
> +	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
>  	void __iomem *base = rdev->base;
>
>  	if (!info || !base)
>  		return -ENODEV;
>
> -	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
> +	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
>  					      base + info->assert_offset,
>  					      base + info->status_offset,
>  					      NULL,
> diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
> index 56d8f413cf18..16df46a074bc 100644
> --- a/include/soc/starfive/reset-starfive-common.h
> +++ b/include/soc/starfive/reset-starfive-common.h
> @@ -6,12 +6,12 @@
>  #include <linux/compiler_types.h>
>  #include <linux/container_of.h>
>
> -struct jh71x0_reset_adev {
> +struct starfive_reset_adev {
>  	void __iomem *base;
>  	struct auxiliary_device adev;
>  };
>
> -#define to_jh71x0_reset_adev(_adev) \
> -	container_of((_adev), struct jh71x0_reset_adev, adev)
> +#define to_starfive_reset_adev(_adev) \
> +	container_of((_adev), struct starfive_reset_adev, adev)
>
>  #endif
> --
> 2.34.1
>
