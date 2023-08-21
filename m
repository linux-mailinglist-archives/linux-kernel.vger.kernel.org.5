Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E7782CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjHUPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjHUPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:04:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A732E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:04:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ccc462deca6so3535429276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692630251; x=1693235051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPT7vlsay38RGsLaWzuQCbvS7i7JDhRWagtPvVNEU2k=;
        b=UKYLr1Sl9i0jU9sz+WTnmwg0FDu2FWwGNz5d9VxjqTx3wpXHOdabyMxnWJBjU6hxsi
         +2x9MRE6ssP5u4gcO6xL27W7Iumn0PqYF2FAkyLCgDzkhVMVuAaVVW7RD+eQw4/6U9cC
         BcMsGO8IJr15bp2XGNWDd18peQcjUHZ8b/WPIU4MomO8NoVoEiasskqsXAfOy0JgdeQV
         jSYR79MDOQlENMDSPfGQz3TiaJuKnV+FRcU03HqX/mRggkupYO8jH+gc5fzvWjW03dMB
         hj7RjOTXUmSQDqxcih78w+0Vp4fVfbtHqwVeT7RsvY4cri1omPBYYaLSPikMQF5Qqmiv
         UfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630251; x=1693235051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPT7vlsay38RGsLaWzuQCbvS7i7JDhRWagtPvVNEU2k=;
        b=leHuah+f5t9dZvWXMPgLe2azNOL5dR1bWRsQfmn+u+PHvw3MDYz7CSQQgssbtC5SHz
         AKzrAqkNfG5dO9tfcd1brNcn8aHqIZw7ARJOYL9P4epEi9xnG8DGFcpmXFp/umvgSLhQ
         LPqisVhWhhqp21CnTsE8OqSWAKUmrIIwiO/qxEOVKp8/d4xY0O3deMw/V0VAoe5f1+bX
         Yic+xZg0GWpKW9c4wF70HQ+c4uNUjOuKj9/XtjY61R1KB+0VYNGIVvhtj83exmF0g082
         COaJsmX5rO0uRvcmhwyhjC9uLO0CZUlSUfLuYcJhzeJxNya5k5Xpj/HmNKErZqeHL627
         hglw==
X-Gm-Message-State: AOJu0YwaC/ilS46Z/ZA2FHoCy8uWgOo9DZvl9xh3KGe/JwgOFV+Sid8s
        jpI8aRh/ICIYlutZMtrZ/DiA9eq2mhtIqUw3peW6Uw==
X-Google-Smtp-Source: AGHT+IGF9r2WO+GcLD9n2tqoJoPLXbeAWeEt8cSGR+xGKtXm8xrGa2nXVi4fGPKYUHXAylIaFF3uLchmn/6Xdmhw1Eg=
X-Received: by 2002:a25:aa26:0:b0:d56:7556:93f1 with SMTP id
 s35-20020a25aa26000000b00d56755693f1mr7703142ybi.29.1692630251449; Mon, 21
 Aug 2023 08:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230818164314.8505-1-asmaa@nvidia.com> <20230818164314.8505-3-asmaa@nvidia.com>
 <CAMRc=Mccsc=RY5Evw4-k8LYDrfuxFoWsn6wajybY4SY_89fjNw@mail.gmail.com> <CH2PR12MB38950DCD03CFB45E4DB34E32D71EA@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38950DCD03CFB45E4DB34E32D71EA@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 17:04:00 +0200
Message-ID: <CAMRc=MeLfvM28czSrKpmMxmvbDeHi2rxtm+_FCKV24H9C-RBnA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 2:55=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> > > +MODULE_SOFTDEP("pre: pinctrl-mlxbf3");
> > >  MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
> > > MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
> > > MODULE_LICENSE("Dual BSD/GPL");
> > > --
> > > 2.30.1
> > >
> >
> > It's not clear to me whether this depends on patch 1? If only at run-ti=
me then I
> > guess Linus and I can take the two patches through ours respective tree=
s?
>
> Indeed from a build point of view, there is no dependency so you could ta=
ke the 2 patches through your respective tree. However, at run-time, the gp=
io-mlxbf3.c driver fails to load without the pinctrl-mlxbf3.c driver. Shoul=
d I add a "depends on" in the Kconfig? Then you will have to include both p=
atches in your tree.
>

Linus, are you fine with me taking this patch? It will not break the
build and with you taking the other one, next will be fine too.

Bart
