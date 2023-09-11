Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7979ADA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbjIKVzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbjIKODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:03:10 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8001DCE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:03:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6beff322a97so3112425a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694440985; x=1695045785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htSTLHjXjD8vt5EAYXqSVCO6HargxzSV7gX/AB30oB8=;
        b=pQ8DucXuZEPvnGjYPK6Xp6eHioid+dT2sQzVmKr7+vDnV6OsM7bPZeg4uE8b79zsv5
         obCWZrboJP2tNwW+xt6Si608UY1uBJcTAqIK7QtpmwX429uEytiJ2w1JSEUMGBR+bQxn
         DUL8oyRp6vGnqKKJ33js55BqS2bOVPgd24IcsZrHBAkZU92ZFT/mMYkfNktvPLnM3i5H
         sxkme+ZYw2zigoIehhygpTpYSsxcKOvIs1UKzxKzUMiVd71Fq4cb9XTDmMlPVdtNU4im
         D0LQchJyidfyTyJKQkLWt87DLb3EZ8oTy+YpobA2Uv3IYGpj+J71umZgbfZncoRxwPBL
         V3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440985; x=1695045785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htSTLHjXjD8vt5EAYXqSVCO6HargxzSV7gX/AB30oB8=;
        b=Wrl4nm2IPT8uOmx/d9c8gaRUqY0IPsSGGcg10RkH3BUEymEtncIhykniQ78KNa9nOn
         FsppJxjAhzbA9Emx2vIAJ3BJU0tTiyd6KKenUpr9rrWENJpC6g6KxCdy3dk/Du0Ti96C
         5MKfJSu8Y0LSrwfR3T0HQWATGgchtrbD7Ig4aRS+MsYe/uZWmcGmK9IRandjzGFtuoWV
         KMsQJltcCg3AFXfCGMPpQwtJVOXU7oexwPEQxg4tie9sc+HsYMSPQ0ULVeMeiGHr0Vmx
         XPO2eh02cmzzLCKCZuRNC66Yx0kVxJrI8RJHtBh4PqXNRtTsfUuyw3mm4D4HBCZboCyK
         kT3g==
X-Gm-Message-State: AOJu0YxXplkUnQ34o73LU5uHWdtALwkXImfGrRrg5DDFksxa9WW3Lxrf
        uiZLd3DCVd9sDMTpK8RKBsSE898L/5m0v1otsaLUpg==
X-Google-Smtp-Source: AGHT+IE9jU1FIU4/f7jfsz9Rxe7QJ58u0dK8sOWYKbT++bpDZ1zCqq2z618I6/2zgrXrXtGljoG5HE5wpdQJfoU3BhM=
X-Received: by 2002:a05:6830:457:b0:6b9:9e4f:5f4c with SMTP id
 d23-20020a056830045700b006b99e4f5f4cmr9593916otc.29.1694440984758; Mon, 11
 Sep 2023 07:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230828140849.21724-1-tmaimon77@gmail.com> <20230828140849.21724-3-tmaimon77@gmail.com>
In-Reply-To: <20230828140849.21724-3-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 16:02:53 +0200
Message-ID: <CACRpkdZk8dKGx2HUoRhkRo6DBkycKh5EkYiGWcFot3OOZnvdpg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 4:09=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> =
wrote:

> Add pinctrl and GPIO controller driver support to Arbel BMC NPCM8XX SoC.
>
> Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> period time.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

As mentioned the patch is already applied, consider the following
as nitpicks you can address in followup patches.

> +struct npcm8xx_gpio {
> +       struct gpio_chip        gc;
> +       void __iomem            *base;
> +       struct debounce_time    debounce;
> +       int                     irqbase;

You're not really using this are you? Delete it.
Also the assignment further down: you do not use it I think.

> +       int                     irq;

You're not using this either. Delete it.

> +       struct irq_chip         irq_chip;

Not this either. Delete it.

> +static int npcm8xx_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                 struct device_node *np_config,
> +                                 struct pinctrl_map **map,
> +                                 u32 *num_maps)
> +{
> +       return pinconf_generic_dt_node_to_map(pctldev, np_config,
> +                                             map, num_maps,
> +                                             PIN_MAP_TYPE_INVALID);
> +}
> +
> +static void npcm8xx_dt_free_map(struct pinctrl_dev *pctldev,
> +                               struct pinctrl_map *map, u32 num_maps)
> +{
> +       kfree(map);
> +}

Can't you just call the generic functions directly?

> +static const struct pinctrl_ops npcm8xx_pinctrl_ops =3D {
> +       .get_groups_count =3D npcm8xx_get_groups_count,
> +       .get_group_name =3D npcm8xx_get_group_name,
> +       .get_group_pins =3D npcm8xx_get_group_pins,
> +       .dt_node_to_map =3D npcm8xx_dt_node_to_map,
> +       .dt_free_map =3D npcm8xx_dt_free_map,

Here?

(...)
> +static int npcm8xx_gpio_request_enable(struct pinctrl_dev *pctldev,
> +                                      struct pinctrl_gpio_range *range,
> +                                      unsigned int offset)
> +{
> +       struct npcm8xx_pinctrl *npcm =3D pinctrl_dev_get_drvdata(pctldev)=
;
> +       const unsigned int *pin =3D &offset;
> +       int mode =3D fn_gpio;
> +
> +       if (pin[0] >=3D 183 && pin[0] <=3D 189)
> +               mode =3D pincfg[pin[0]].fn0;

These magic numbers should really be definies.

> +static void npcm8xx_gpio_request_free(struct pinctrl_dev *pctldev,
> +                                     struct pinctrl_gpio_range *range,
> +                                     unsigned int offset)
> +{
> +       struct npcm8xx_pinctrl *npcm =3D pinctrl_dev_get_drvdata(pctldev)=
;
> +       int virq;
> +
> +       virq =3D irq_find_mapping(npcm->domain, offset);
> +       if (virq)
> +               irq_dispose_mapping(virq);
> +}

I would just rename "virq" to "irq", it is a Linux IRQ, not really
"virtual" which is what the "v" sometimes stand for.

Yours,
Linus Walleij
