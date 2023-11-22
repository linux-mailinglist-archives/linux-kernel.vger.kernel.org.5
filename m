Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFF7F47D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbjKVNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjKVNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:34:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1311A5;
        Wed, 22 Nov 2023 05:34:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a02d91ab195so227201266b.3;
        Wed, 22 Nov 2023 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700660055; x=1701264855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLq5b4Qnnzc05lrLd5F9jEP0bqZahQJ7HMcnCcsQpuU=;
        b=RiIIggGwva9hVd3DEDAlLI2IVyJkrmw4TdtUJwcvOfavW7h5as3lhoJ+Ha2iF8LiOL
         JcIWkuiePyTuhVoR1NF5+eC86AhvPesXQyUAEmpPfhrUiiJXHHT+ZeVBeutEM9HlVgu0
         sbvc1z0hHQe/S0e9i9OIw/BNP/ZQn5kgfrX3sJzQrckn/OWm8lqLT9S6aR7R1xhhknjT
         bQurRJ69U45vqZk90FK3dS2jnpuwFfMlIJhz4LsNVzcs+iWTHJOs8nI6naKWaBeozLmb
         zpATWdt66SOku9ISCOT4p9rPqJCmSfkpFRdjmGIM60lWlZ++TW9JUOCuYslCu1ja+Zvu
         X2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660055; x=1701264855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLq5b4Qnnzc05lrLd5F9jEP0bqZahQJ7HMcnCcsQpuU=;
        b=aAuCLAn8Q5XH/eAebqGHsEJ4uSjD2dFmXaZS5bYo6XJKzlLo8TWadbGn5vrV1q9Mvz
         JxbV0OXE1n02K3lsxOtdu0/saPv2+gWhciKXAoSSoPEqfoNOjjAp8wgwxKUwhWl65jLr
         3yJO6FBV0OaITe4XleAaE8laxgt9mC+O6BUAJx2cUTKuC0uRFA/5eX7rMbK32xsrhSYh
         df9edmCc/FZgbgJA3T1VjQjnhM5b877Cb/i8Xum4xrhOGuYoFLuX28/hkLVwY7TfnhNA
         Z+/kqr9I2XefTwW78AaSxuJVK0dfxCEGCQd6f8EotwncfzGqTB6RWp/4gPZy4XxRdaaJ
         IAQA==
X-Gm-Message-State: AOJu0YwWc4XNgYF5lVTHUrPe6VBJXCWJOTZsyBzrs3aNCjg3fdkpm7TF
        tMlopVKS+CjsDfani1GX8mU=
X-Google-Smtp-Source: AGHT+IG8BfMbHPH1HT18+iwDGrq0HmcWfR8g+5g/QGsygFZaB/ToAgDWUlQu1eRvzTaR7eKzM0e/hg==
X-Received: by 2002:a17:907:d046:b0:9be:77cd:4c2c with SMTP id vb6-20020a170907d04600b009be77cd4c2cmr1649995ejc.28.1700660033136;
        Wed, 22 Nov 2023 05:33:53 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id jz2-20020a170906bb0200b009ddf38056f8sm6633988ejb.118.2023.11.22.05.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:33:52 -0800 (PST)
Date:   Wed, 22 Nov 2023 14:33:50 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZV4DPsL4zkDkAuwj@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
 <ZVz58b0r4gtxyVQy@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <9570dc1c-a437-46d4-95e7-1f3dd399e458@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9570dc1c-a437-46d4-95e7-1f3dd399e458@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
Thanks for your comment.

On Wed, Nov 22, 2023 at 01:42:50PM +0100, Michael Riesch wrote:
> Hi Tommaso,
> 
> On 11/21/23 19:41, Tommaso Merciai wrote:
> > Hi Mehdi,
> > 
> > On Thu, Nov 16, 2023 at 12:04:39PM +0100, Mehdi Djait wrote:
> >> This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> >>
> >> This controller supports multiple parallel interfaces, but for now only the
> >> BT.656 interface could be tested, hence it's the only one that's supported
> >> in the first version of this driver.
> >>
> >> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> >> but for now it's only been tested on the PX30.
> >>
> >> CIF is implemented as a video node-centric driver.
> >>
> >> Most of this driver was written following the BSP driver from rockchip,
> >> removing the parts that either didn't fit correctly the guidelines, or that
> >> couldn't be tested.
> >>
> >> This basic version doesn't support cropping nor scaling and is only
> >> designed with one SDTV video decoder being attached to it at any time.
> >>
> >> This version uses the "pingpong" mode of the controller, which is a
> >> double-buffering mechanism.
> >>
> >> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> >> ---
> >>  MAINTAINERS                                   |    7 +
> >>  drivers/media/platform/rockchip/Kconfig       |    1 +
> >>  drivers/media/platform/rockchip/Makefile      |    1 +
> >>  drivers/media/platform/rockchip/cif/Kconfig   |   13 +
> >>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
> >>  drivers/media/platform/rockchip/cif/capture.c | 1120 +++++++++++++++++
> >>  drivers/media/platform/rockchip/cif/capture.h |   21 +
> >>  drivers/media/platform/rockchip/cif/common.h  |  129 ++
> >>  drivers/media/platform/rockchip/cif/dev.c     |  302 +++++
> >>  drivers/media/platform/rockchip/cif/regs.h    |  127 ++
> >>  10 files changed, 1724 insertions(+)
> >>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
> >>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
> >>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
> >>  create mode 100644 drivers/media/platform/rockchip/cif/capture.h
> >>  create mode 100644 drivers/media/platform/rockchip/cif/common.h
> >>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
> >>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
> > 
> > Just a logigistic comment on my side for now, sorry :)
> > What about use cif-* prefix in front of driver files?
> > 
> > like:
> > 
> > cif-capture.c
> > cif-capture.h
> > cif-common.h
> > cif-dev.c
> > cif-regs.h
> 
> What would be the rationale here?
> 
> IMHO the files are in a folder named cif, so adding this prefix seems
> kind of redundant.
> 
> That said, if there is a good reason I could live with cif-*.{c,h} as
> well, of course. My only request would be to agree on something ASAP.

Others platform drivers are using this pattern prefix.
Please check:

tree -l 2 ./drivers/media/platform/

Would be better for me to align with this common pattern.
But this is my personal idea :)

Thanks & Regards,
Tommaso

> 
> > Thanks & Regards,
> > Tommaso
> > [...]
> Best regards,
> Michael
