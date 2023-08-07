Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B277235D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHGMDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjHGMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:03:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5471988
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:02:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe44955decso5350532e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691409739; x=1692014539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XEWFnQ6wWwe1R7VCKVrV7mlKuDCVT8DIRevt6MRMfc=;
        b=Vd8Pmqn/MOfQ6NfrYfFsg+cEovms7aUgZEdPiAL6FfaOo40DiYG688XYB7rQmhYZO/
         LZHlbsaFI4SvrPa/hbjGmI3DXU4uPg5T17MHSIPaGnUXme+gdHLIZP2zQXPcxM8AXSK2
         I35SG3AQ+njlSz9PhoHaL4gM7JVBt7MsDX+k7QdQQVvNodKFp/eOdvA8fFzB+5egyvtF
         cGdC+EVQ5wV3cmbtLF6NhzEzxVbNbYtEgF/E8vbAN4jJYkR9ab72r3l8QH7uEYhAfznv
         QGmC1uzALYB7YR7iOPBEIzJAA64sPvugXWtC7taQ3Vs8LCvHXi7XtnqShXBEmKWqRGPG
         cSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409739; x=1692014539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XEWFnQ6wWwe1R7VCKVrV7mlKuDCVT8DIRevt6MRMfc=;
        b=YHJ8FPE4qyzDNwF2bmt+iNys40dM+tsct1inZKIXyBFj1fgSdyqssnZTXx31y8DRN+
         uVOikmKyFgcPhFb7nfOuh9hk8ed5P//QPvZEja/HqMgTnDH3XC3EoQIB77o/sH+Mr4K5
         xue6kfbzaS5KlNBKeRiCU9+7C/oveU/7x/wkOjZoEZQ2Yv1XuVg5j1w9leUAuxoRl+cZ
         WgHkknhEujUss+BpPV/qmOawTtotcknxbfv+ex5Vb6O87mGziI5oA29ngHH/knIFQCNy
         CmX9oJMLXAVBT6sOceQKGlfXmocRWnGFV9QNSYX7M79+Y7tnR1GDWGAxOKElg+e57mze
         CoWQ==
X-Gm-Message-State: AOJu0YyKgTL/u2FAkm5TTXj8YuysDZBbnKskO+NrQzUVbsPKBfl7gxrs
        76Ngb7M9qVO61tpkcomE7eqTnksP1jxrK3mexUZHvg==
X-Google-Smtp-Source: AGHT+IF7cfXe0r1UAs/wpi+FxOMg+fD3LNT0Av1JAc5dMInD8cq8Khad5SYIpY/bZ/psux7GEkRDVH8mjkCDmzfYW+U=
X-Received: by 2002:ac2:528f:0:b0:4fd:f6db:a7d9 with SMTP id
 q15-20020ac2528f000000b004fdf6dba7d9mr1892044lfm.32.1691409738918; Mon, 07
 Aug 2023 05:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230807114344.15076-1-aboutphysycs@gmail.com>
In-Reply-To: <20230807114344.15076-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 15:02:08 +0300
Message-ID: <CAH3L5QoC5rzTCr3SmODm49ms-ThAjaGkM2whoo2-=r9Pq_oUfQ@mail.gmail.com>
Subject: Re: [PATCH] reset: zynqmp: removed unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@amd.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:43=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/reset/reset-zynqmp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 59dc0ff9af9e..510c168d635f 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -107,8 +107,6 @@ static int zynqmp_reset_probe(struct platform_device =
*pdev)
>         if (!priv->data)
>                 return -EINVAL;
>
> -       platform_set_drvdata(pdev, priv);
> -
>         priv->rcdev.ops =3D &zynqmp_reset_ops;
>         priv->rcdev.owner =3D THIS_MODULE;
>         priv->rcdev.of_node =3D pdev->dev.of_node;
> --
> 2.34.1
>
