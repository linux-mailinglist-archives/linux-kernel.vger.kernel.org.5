Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DE765BED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0TPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG0TPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:15:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28962735;
        Thu, 27 Jul 2023 12:15:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99b9161b94aso174696066b.1;
        Thu, 27 Jul 2023 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690485302; x=1691090102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3mLrIEj6i09sZTd8OZW9bqC9iQyhJ5LXxHWMM4QrZY=;
        b=Ed3WOFVlxxamSM13Mr4fMTkJyvhgXdfRjANj6CrginYJFyFM41FDvfaK2vEJ5lwNc0
         GCkIfkbG9ZzIQwucDgCEIA7MmvO+nPemT0JAPfHH9B8cDGWSFaPuX9GjHJc8r6fiF0kn
         c0J2EhpZMe7ibv9H00kQN/D+KPpdnbpTq3ISAInV0aj6BJMX6+Pxd6jbQeiVObPG/t0Y
         I2q5Fq01wTc26v18AQLeyxsN7Nyk7CFrdsz0KsgLwEL5dZ5o7QZ/SdhRZ+ikg/qXYtJQ
         5S1SS6l0X9C0fjahWw+fRxzAs2LRucCLwD9x7LSR5Hbvtetua/jA+LA+qtNO13QNZK+j
         BwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485302; x=1691090102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3mLrIEj6i09sZTd8OZW9bqC9iQyhJ5LXxHWMM4QrZY=;
        b=ca7LUv5yqL4cBmb115mh98kzekTU0Qpgkfb2GVC0Dko8zfj1YB5noyz7G5BDTSrU3d
         B1pafNxNoDWaZeW2Y7t2UECsARAdDke87EQgWXzT4jcbDsvXuh2DH/B7cElOZBZm4+I7
         yMhn+5KGz+ZisrzMWnKeiVlc7DGfpgRPvZLniSvuJtfXNxeto2TgMqXUGD+lIngdavbE
         HGCs6cUHfomyxCdk62iaol3ILAVnj6t8vt1ZiBT7hy4so6jxasfGPXhpOZD4hVkOtiBm
         PrdcpnPiSj8+axcWQZXsSgjhL4eG+dwaxyNFYmXktd0oI6YXLz8jBuOTTCOS5MZEWYxw
         Cf6w==
X-Gm-Message-State: ABy/qLZQcC5zeB+JuF6eHLVugxTH2mRrMbIxIWugAAZfaia0aFkFZVwz
        1qFrkTHs9DocT5UDDGGEqalmfXXMcn51+BQ6ynw=
X-Google-Smtp-Source: APBJJlHqe8Db9+ktxLkIwQKQ2FJd+P31M6a8NsywGTFbag00ryYo1w0bdwp358gbe5zeurhcoNMOkxR2lEulMI9JAmU=
X-Received: by 2002:a17:906:3189:b0:99b:c35a:8865 with SMTP id
 9-20020a170906318900b0099bc35a8865mr113365ejy.1.1690485301887; Thu, 27 Jul
 2023 12:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230725141252.98848-1-avromanov@sberdevices.ru> <20230725141252.98848-2-avromanov@sberdevices.ru>
In-Reply-To: <20230725141252.98848-2-avromanov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 27 Jul 2023 21:14:51 +0200
Message-ID: <CAFBinCBLjE051KeFzFZzjc=0ZuMHOQwRfWasxWRUOSwQO3jqYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drivers: rng: add check status bit feature
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

On Tue, Jul 25, 2023 at 4:13=E2=80=AFPM Alexey Romanov <avromanov@sberdevic=
es.ru> wrote:
[...]
>  static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool=
 wait)
>  {
>         struct meson_rng_data *data =3D
>                         container_of(rng, struct meson_rng_data, rng);
> +       const struct meson_rng_priv *priv =3D data->priv;
> +
> +       if (priv->check_status_bit) {
> +               void __iomem *cfg_addr =3D data->base + priv->cfg_offset;
> +               int err;
Have you considered just creating two separate functions:
- meson_rng_read
- meson_s4_rng_read

Then you don't need all of these if/else.
You can even skip the whole offset description in your new struct
meson_rng_priv.
All of this can make the code easier to understand.

> +               writel_relaxed(readl_relaxed(cfg_addr) | BIT(SEED_READY_S=
TS_BIT), cfg_addr);
Why not just #define SEED_READY_STS as BIT(...) right away?


Best regards,
Martin
