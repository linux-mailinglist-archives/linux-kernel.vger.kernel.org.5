Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E879772E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHGS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHGS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:58:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BB1FE0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:57:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1c285690so7504591e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691434650; x=1692039450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBU7EPRLwc6/gHY+xkWa/hJWYuPQd2qbUXf7TBY4Q1E=;
        b=fkjXXDZtNsAvIRJwZta1Ja7LoLnOgQJMSwyuKKZ8+v9i8n5myXhd2WMcXM9t1adFgf
         efAPaZwAdK6Ar/VW0znV01Y5IApm8lX2vtmga4PgsbBT8Ma90n7u2UABzzfiUAe36KQW
         xspOIC3bD3Q8fAM+DnkgiJbxpMOzkeQ+OiW7Ij71lX5F4XVwoNufjr5MewytV0mBspQq
         4H+06CnfogkVGrG/S+8nY0hkWAGyTK42ToNFZklOuUkLX7E6Tk0Xz6dqbLm0CCfyjTXh
         ywcD4XsapyhDy49THBG7Zvifjh5iDiwwhgzSixz33VfQO9IdDtXdGIvypgS6FjXC+qRV
         pfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434650; x=1692039450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBU7EPRLwc6/gHY+xkWa/hJWYuPQd2qbUXf7TBY4Q1E=;
        b=fJLmgm1MVmP/4jiR2U0G7KX82PC3VPWGPBbf8FP9f9Aa4/td1Qd26HGssdqJYomHV5
         5XrM1oeo6R3fJHi8ZxyGjHdzNL0MHGhP4VS8mK5j/1DA1/6fc6DRO0Iu+YoVIZwoNgsP
         s9bRHwlSoGlIozIpucu1pYiq4pYT3R3dh5yw0WwQvJskvx9OR7WFly0kRXqfOgGL5HNy
         AH44FxgMrgYRr9O0ECcZH5BAkio4dlNusBTBom0AhyS2EtP9BQt9QqHeBO0bhKchUtam
         6xYqzWZU1bWzOkAA7r5Gnu5AUb5YeDKqDbCj+RMVuv7ttqdH9BfwDaf7xzVkaEIt/hpP
         dSbQ==
X-Gm-Message-State: AOJu0YzRhBW/9cxr5AOq+zHfSEeKDPrLIfJ/3ZRphlZ3VjBePG8Yj0BY
        hJo0LScdHx5d1OWvBTaT3Zd23a2Y+PTb6zyi78ldcA==
X-Google-Smtp-Source: AGHT+IHThLYIJ59PNOhr78bZy6uOPNX7UESLW3rpMb3ujVD6X0Z0XETEJuyRcdKWNOqsQzskN3trXrk33m0GM3f9Djs=
X-Received: by 2002:a05:6512:3b29:b0:4fd:faa5:64ed with SMTP id
 f41-20020a0565123b2900b004fdfaa564edmr8806125lfv.11.1691434649713; Mon, 07
 Aug 2023 11:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130217.17853-1-aboutphysycs@gmail.com>
 <c867e685-7665-420b-9478-bce6eb067463@sirena.org.uk> <CAH3L5Qrzk-7WoF8+GKMYS40Dj_fxGpiLrTvVB_PJdA_VZVsDAQ@mail.gmail.com>
 <196642e7-4136-4ba6-a918-8c759f27f818@sirena.org.uk>
In-Reply-To: <196642e7-4136-4ba6-a918-8c759f27f818@sirena.org.uk>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 21:57:18 +0300
Message-ID: <CAH3L5QoF1pyexq-QNJAy4j-X_0EFhAvzpt7tD-Tg+JFjymQg1A@mail.gmail.com>
Subject: Re: [PATCH] spi: gxp: removed unneeded call to platform_set_drvdata()
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nick.hawkins@hpe.com, verdun@hpe.com
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

On Mon, Aug 7, 2023 at 9:18=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Aug 07, 2023 at 08:38:27PM +0300, Alexandru Ardelean wrote:
> > On Mon, Aug 7, 2023 at 4:27=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > On Mon, Aug 07, 2023 at 04:02:17PM +0300, Andrei Coardos wrote:
>
> > > > This function call was found to be unnecessary as there is no equiv=
alent
> > > > platform_get_drvdata() call to access the private data of the drive=
r. Also,
> > > > the private data is defined in this driver, so there is no risk of =
it being
> > > > accessed outside of this driver file.
>
> > > That isn't enough of a check here - people can still reference the
> > > driver data without going through the accessor function.
>
> > So, is that like calling `platform_get_drvdata()` in a parent/chid
> > device, to check if the driver-data is set?
>
> That wasn't what I was thinking of, waht I was thinking of was just open
> coding platform_get_drvdata() and looking directly at struct device.

Ah. Right.
I hadn't thought of checking "dev->driver_data" access.

> Another common case is where drivers that support multiple bus types
> will pass around the struct device and use dev_get_drvdata() to read the

Agree. I see that happening with PM routines.
It doesn't look like it's the case in this driver.

> data rather than using platform_get_drvdata().  The driver data can be
> allocated and initialised with bus specific bits before being passed off
> to the generic code.

If I'm looking more closely, I am seeing that the
"platform_set_drvdata(pdev, spifi);" has no equivalent access to
"pdev->dev.driver_data"
Nor by open-coding, nor by "dev_get_drvdata(&pdev->dev)"
But I do see that "spi_controller_get_devdata()" is calling
"dev_get_drvdata()" on a device object allocated here via
"devm_spi_alloc_master()"

So, I agree. That a more thorough check is needed here.

>
> That said the looking at the parent's driver data is definitely a thing
> that happens with MFDs.

Yep. MFDs is one case I was thinking of too (with respect to
parent/child lookup of driver data).
