Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5A772357
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjHGMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjHGMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:01:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD36173C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:00:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so7225140e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691409641; x=1692014441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/HTBsyr0MohJdbS2bO21jR5mm/zlYlkZCwkIlEc3Z4=;
        b=3YwDd9ZygrOvMwTKNuVBEMfQ+EIQPbAfbuuFkrhZaV32mFn5rGLrO9dRw4gl7BMNQN
         PT+JYJ7S6r0wvtU9gJPNCsv4biEzMn6wsz4r/QefpO+wdgn8L5NfQWDKoadfB2ypxXaf
         cGtadKwPqZGJYLpqYmokScSXoh9J3jC0iewfX4DQMKDof+2Nr0SHx5UZ51xkDKaCMb18
         q/4IO+JQIpc7jxPDWhyxkn7OMSoAOOkUMyvRdUwDDIQ408WgFrgVxXy/LidfI2/QzHFd
         zqNFCP1XDJwdaGZcWRrFzIBd62OkLEuUQAWlW9bi68gheNRIuGZQTLkFo5m2q8IyCd0I
         6dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409641; x=1692014441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/HTBsyr0MohJdbS2bO21jR5mm/zlYlkZCwkIlEc3Z4=;
        b=gOPRp8PYNYzHfK+4qMG+owsSIMxZ3Mi4ZE7cNd0Bata36MHZja5ODOAT4iyhZRKlj+
         FHvDxju53PeYEupOf4WA0FrZabeRzNchHj7/V56rUNWPpkUm4NCluIcuAd/pSETbO3mJ
         OdQAUlPvhnDCzCFNEfVLtjQHC2SVnldQlUMuZafGVrwv+SRlwOjG42Nr/FTGKTcnsfIu
         IhsmptfM4krj+943wfNygo0XHgazLLD0LVEGqJpmMb60siCdGZEKNJCbPzdLAx9MHvFj
         9tDASVP/Rz1AKZqG6oqYYKA4G2/wQcpH9PxQxU442Yf9Ufgn22zXTpCQmx4EDJrn/ajD
         kStA==
X-Gm-Message-State: AOJu0Yy3kLtEbGYDDHk0EEQuRzxod+lx3DQct1APx5W1V5IyGHKpbyUQ
        hjVYBHdHWtoXg3aMbRR+Ba8YjDzZe07YkQQr07QbxrqRMwmy2/gHl29BUQ==
X-Google-Smtp-Source: AGHT+IEJpk9APAtkpkW4PXCsQlb/BOQrQVRJaWgrCIXeL6B+JMDXe4WPRpGKaM5KBYRfwBwOhDpUTOifsBUBuU9DhbM=
X-Received: by 2002:a05:6512:b8b:b0:4fb:89ad:6651 with SMTP id
 b11-20020a0565120b8b00b004fb89ad6651mr6880691lfv.28.1691409641463; Mon, 07
 Aug 2023 05:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230807113545.14743-1-aboutphysycs@gmail.com>
In-Reply-To: <20230807113545.14743-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 15:00:30 +0300
Message-ID: <CAH3L5QpJztEie-OO8QbnBOMpZ3RtLuepMCyrj1bq7pPCZSNV3Q@mail.gmail.com>
Subject: Re: [PATCH] reset: zynq: remove unneeded call to platfrom_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@amd.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:35=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
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
>  drivers/reset/reset-zynq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/reset/reset-zynq.c b/drivers/reset/reset-zynq.c
> index 706bbbbb4ec7..688b512882ec 100644
> --- a/drivers/reset/reset-zynq.c
> +++ b/drivers/reset/reset-zynq.c
> @@ -94,7 +94,6 @@ static int zynq_reset_probe(struct platform_device *pde=
v)
>         priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> -       platform_set_drvdata(pdev, priv);
>
>         priv->slcr =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>                                                      "syscon");
> --
> 2.34.1
>
