Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02D77F200
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348847AbjHQIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbjHQIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:22:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7E273C;
        Thu, 17 Aug 2023 01:22:29 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca38a6618so6213387a34.3;
        Thu, 17 Aug 2023 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692260548; x=1692865348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5XC1NaMsVWs22A3D1qaphiBxnkMRdlhxzrGkP5toFU=;
        b=EN3OgI2rxHemVBMzLD4yw6kQsQVvj/CuhY0cfxq1rO0HpI0WDbF5lKNxpCEPesu2wj
         Ybp5YjZV8vWxt8LfMo4DepUjPeWqAxkULSlwUZQdu8plLuTbiHlz7zOhzLdNkfNWb5ft
         IYKp4xxoda3JYrNjPqB3TLUVSDrxYHmH+wcCUJlZoAc6IsjpPrBmEJpzjrQn+NZDqMfZ
         L4pCpV/5v/KPGVkreXuQFsqQMyUGztqWF9qeoFMgqBNXeI1daVy4ZHHBuvJNGXsCcQjZ
         5wX94o92Lb6Xvyf8bRm89o1PMgy1bVboFzKX09KICCAFjaIBPnCM9zrj9usJ+JIbUZYd
         o6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260548; x=1692865348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5XC1NaMsVWs22A3D1qaphiBxnkMRdlhxzrGkP5toFU=;
        b=OWJmhqoM224TaemF2XmWhUREWiOQbelVObelKbtxyuwD+N3pD4uWv973zIrbOuOKcx
         U8w7eYHVeYgb5pB5fBsbr6RxpUhQR+W7fJrCaWCjDpeMNCPD7KsUe//WBPweDDiV37Nh
         YAcrbYW5E9lXwkZOxWJensLLn/J25AtJbgxHXhbzGNiCe3s41d/5XN7joPeqQl2Zuv2/
         MhYK4PWwsk5VNbXqr+libEdMap53TTZludF4aWtbFiNyZDpJt/WUF3BS3TgIoSS3EHnh
         MwtRU3ii2DixQGhJC87ZdDGVgiVs1GvXS8o3/vjfLN7b7EhXFlzwLGDkpNKQBNwZZxaC
         VZ6A==
X-Gm-Message-State: AOJu0YzL/tuAhUroawbGc6QGdA56LpJEM8J62XJ5R9Mde4oNo6sz90VW
        0j3YJl/xDuKlVMdmor7xfGBFe9m+FAHB0MnKn2YodN3R2UQuCQ==
X-Google-Smtp-Source: AGHT+IHl6ny0Q80fuusWHH/sAgtDMBJjbrGxzHg75AynGBYtwByNXASXtr0N0cZTB68/qoQsgwWBZyc82m/LXVbwoMI=
X-Received: by 2002:a05:6871:825:b0:1be:9a37:cf12 with SMTP id
 q37-20020a056871082500b001be9a37cf12mr4614971oap.42.1692260548549; Thu, 17
 Aug 2023 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230816154442.8417-1-asmaa@nvidia.com> <20230816154442.8417-3-asmaa@nvidia.com>
 <CAHp75Vdp9TYTod6UBLxG_YrT_vD4azfyrM9dTrau8CPJuH_vrQ@mail.gmail.com> <CH2PR12MB38953114436B7B0768A1C321D715A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38953114436B7B0768A1C321D715A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Aug 2023 11:21:52 +0300
Message-ID: <CAHp75VcEe-2+=2qXCFHp+cxN=nWcsc=oCVYUeinM_cMsPES+mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:28=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
>  > > v1->v2:
> > > - No changes.
> >
> > Is this correct?
> Ah my apologies, I added the wrong comment here. I put it in "v2 1/2".
>
> > > +static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip) {
> > > +       unsigned int id =3D 0;
> > > +       int ret;
> > > +
> > > +       if (chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK)
> > > +               id =3D 1;
> >
> > This id calculation seems wrong to me as I said in v1 review.
> > Why do you think the above is what you want and not just working by luc=
k?
>
> I would like to get the gpio block id which can only be 0 or 1 on BlueFie=
ld-3 (only 2 gpio blocks, one with 32 gpio pins and one with 24 gpio pins).
> The above logic was an "easy" way for me to get the gpio block id. Then t=
he pin_base for each gpio block is:
> pin_base =3D id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK

It's fragile. Use a direct case switch for that, which will be more
explicit and robust (however still can fail for any new chip
revision/version where it might be a different GPIO layout).

--=20
With Best Regards,
Andy Shevchenko
