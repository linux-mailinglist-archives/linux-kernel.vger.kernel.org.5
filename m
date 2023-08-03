Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237176EB16
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjHCNrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbjHCNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:46:41 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD261BF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:45:21 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-79a2216a22fso337669241.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691070320; x=1691675120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e3MydJCexgcJS41KDiNes4fzeZo2IkSmPU9z8uWo0U=;
        b=wuUmcMKELHOCWF5N6YlhO2Bt61u4phS+WJCTBYLA6OGU58s3W2dSnzeLdz9j72P+cG
         JeCpsln7bOy448ebshmMdeuLl+3ygoLjQ2Te8Jdylwj5yXtGHqUPxMGBe97vSHkvgBWE
         oMqrqW7vyIITu52tohyg92kzzi290tOQyQdwUv3NH2UAfyPfzsYR1jxFMIo5U1La8RRR
         D9M58fW3amcWClSqWEkvtzqRZ4tRk7rcahRAdjtBPTdw9RjoDk5miVFN1FMB9BSDtnmo
         6n3C74On9jW9M1SgGPqXEsdZ7+2+aPaQcFme1U1hjL8EwZx+3vrs+1roJAxcC0XT8bbu
         tJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070320; x=1691675120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e3MydJCexgcJS41KDiNes4fzeZo2IkSmPU9z8uWo0U=;
        b=Sb1CbzRLtXv6FQMER1H4mv1XuVIOsMwC2DSvKoudQZdbNWVKfZFjKbbbMU7OzOTEcg
         5XSnQ4GgcqASdS/oyY92ZNzSKnI86xWtfU5kh15boKPBPCW1/I0syx94FdRieQy56nEr
         IRizTrhV+QK1/sl4Wu5h2rYdyNK8cwtYsS3VlS3AeIqT/QOxHsKPcEprMC15sstTXcYU
         1I6kxm3sE8eQvZ4zCip27wsTPhU3CLRE+bcJ254K+6XnfjmaHRZxQfOXwVW3IjeznB24
         P3k1fX1k3FhDuv5TWSZSFU97DlStdPX9K5y5kxII6lynkkaTwlGZdqvNW/uCSdvIKOha
         A4gw==
X-Gm-Message-State: ABy/qLauAqYv+wjGQgcqAoYq9E5WiCExgGbHi3uM3R074SLsshOM+q6x
        ymz+ENELk9hPYsuEs9qxGUtL8JgqDTUTwqZVgasv8A==
X-Google-Smtp-Source: APBJJlEdOtsjWLAK39zcnxwdWteu7WhsJMDKPU6y5ZRGZK9ZfmIewu5C/aeY6TKOoYDqyQfAVfoF5Na9q2C8vHz3PEM=
X-Received: by 2002:a67:e249:0:b0:43b:2fa9:eb3a with SMTP id
 w9-20020a67e249000000b0043b2fa9eb3amr6452901vse.9.1691070320620; Thu, 03 Aug
 2023 06:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230801073044.4249-1-aboutphysycs@gmail.com>
In-Reply-To: <20230801073044.4249-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 3 Aug 2023 15:45:09 +0200
Message-ID: <CAMRc=McGBAv38LZ0XWSPSpZ-s2iAy4du+6qXW_GSVKVP5Wc09Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: syscon: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:30=E2=80=AFAM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/gpio/gpio-syscon.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 6076937b18e7..afceb7e17ad8 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -249,8 +249,6 @@ static int syscon_gpio_probe(struct platform_device *=
pdev)
>                 priv->chip.direction_output =3D syscon_gpio_dir_out;
>         }
>
> -       platform_set_drvdata(pdev, priv);
> -
>         return devm_gpiochip_add_data(&pdev->dev, &priv->chip, priv);
>  }
>
> --
> 2.34.1
>

Applied, thanks!

Bart
