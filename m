Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32FF78F854
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbjIAGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjIAGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:04:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD610CE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:04:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so29017371fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1693548271; x=1694153071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfLv56JgUFCXsENsYPIP+yaAFrYcDTTvtusyzWqWSds=;
        b=slRSakWcK1tP3bqgnANhP+oNGiq/OjkfKASuqdhlqUCMYawWKEtXr6Vf3IWT0SfBA9
         DMqVUWZyGiUyHzkLCBp+M82gINN1PaQR3frjEdBz6Ew3kb3b+umV+X7zjWp+lHcqyS+S
         EMuO8rCQtMyOqg87QskFjWpBJOFmN1LeQGWvlMY/eNS2HsH/b0/Gc5tDpV2gJ+SJcQ8+
         dnPb08TnwowHilPdOYUW4lurWBKqRQIX1Pk82ou2CC2nY9WM5hdcTpGxMn7t/krxsmRI
         7tYq9kDXf0DSCac4vi2ycfCnBnY4x6sVeQJrKeKXVrp99dt5sW38ti6EYfvsW73k2/Er
         wheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693548271; x=1694153071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfLv56JgUFCXsENsYPIP+yaAFrYcDTTvtusyzWqWSds=;
        b=UfJu/56of2+3kRyBiuxs3NBrYnoQAC/qKnGgJQPBQPBNPuSwva/B2mOGaqDpr/pZOu
         JYYs/PV/kVVrUJPUJEq7s03zrcMSmq5PDCUcnFJVHgH2KzXug/DrHnY7dC+GRjfVPDgv
         muCRwQDDrgBBqzhy9vCTURdzd/LgtSZgYMytG7f0jCHyXt8dQdv7t+FOKtFUKJ8j2fAo
         iWVFbjQllhxqBjXF0Tjo8tf7H0B85g420p309NTMtnerma4hjKlO/TDVEUxb1DWRXa60
         H+iHXuqCuKc1EJ/Ksixw9IksiEX2vEWZMQLRhpJZgnGW4Z0GMjNelXWS32LWAHqspGpF
         UsmA==
X-Gm-Message-State: AOJu0YyaURQ3oDTndtLkDYeV9Cg0TwdDgpYHOTT1NhbeX/P7Zl5yLmWj
        AwPDjNGXdgjJYZjZtUrDZ63+qRP/HyX6P76vKhWjIwvYVIIiiPmtLvc=
X-Google-Smtp-Source: AGHT+IEgpZQHAs3z6DvwmuZq/nZwOKrD9UgveHCXGqSM66fzWyf44HcZP52Yc4CjR2E4YhagLQL2BpDMpT6jjAl33v8=
X-Received: by 2002:a19:5e1a:0:b0:4fe:ca9:d9bd with SMTP id
 s26-20020a195e1a000000b004fe0ca9d9bdmr687655lfb.56.1693548271262; Thu, 31 Aug
 2023 23:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230828102943.21097-1-aboutphysycs@gmail.com>
In-Reply-To: <20230828102943.21097-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 1 Sep 2023 09:04:20 +0300
Message-ID: <CAH3L5Qpg84+Dc0MzfEWtJmfZYsXwdNHD6OZ6bRTfyB8xcr5HdQ@mail.gmail.com>
Subject: Re: [PATCH] char: hw_random: xiphera-trng: removed unnneded platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, olivia@selenic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 1:29=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/xiphera-trng.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/char/hw_random/xiphera-trng.c b/drivers/char/hw_rand=
om/xiphera-trng.c
> index 2a9fea72b2e0..1fa4b70246f0 100644
> --- a/drivers/char/hw_random/xiphera-trng.c
> +++ b/drivers/char/hw_random/xiphera-trng.c
> @@ -122,8 +122,6 @@ static int xiphera_trng_probe(struct platform_device =
*pdev)
>                 return ret;
>         }
>
> -       platform_set_drvdata(pdev, trng);
> -
>         return 0;

This entire block could become now:

        return devm_hwrng_register(dev, &trng->rng);

>  }
>
> --
> 2.34.1
>
