Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D1758537
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGRS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:58:53 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1DF0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:58:52 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4813bc037eeso2356946e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689706731; x=1692298731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCXF+3DQeZRKgnE0AHasBLJEp5/cGqaVsuwTgG7AvaA=;
        b=Jw2vmqEg/Ahsxz82QM9peK2yVJSzgnryXnABWpTFE1snHJQN0vNF5wmdby19z9TNKk
         3p8CpqcJ5z7BGv/tfLWwhfe3SAd6KPVmYQhyuVAMmCG4dYLVWItBdlrSO8amKjlveKR8
         7mt3faCWaI7WZPw/AKUGzRQY/jKBGmkKlGwH0uPZ8DM4wh8Yb1hfCrJj2VFnpqRerxKv
         ySs24bc9rXYk0YCDjqsY/j2vITWjKdlg4PZDMgRFZm4PRABFFB462Ipty1lPYiFaUtZu
         EJJ7QbiGpOkP4WPmrc0YLmN8vWbPI9pmdnP1O60xnVJ8HYLGbkU+9CjNuYUs/BRZ6eLR
         Ndhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706731; x=1692298731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCXF+3DQeZRKgnE0AHasBLJEp5/cGqaVsuwTgG7AvaA=;
        b=hhpTk62e50L6H/x1uCKXXQOswAPWp/gV1NwbaMICFUxMOY5sh4qtgZchNfoDbuD399
         gKlrlGRCxsd7iymfBNFN6NgTebXF0PaJ+Y7NoqUqU+u7D4QJs3iWv0ZJqZ0M2O6l6SWJ
         6PGG9J65fH7MELcSHMU5mtB79WX2dLM+ub9AfNGrdNP+pZ2LluSLqDTu+z7ag9cU5PDP
         +oxuJ2eRaGxCcq8J60gv/GUXjoA4HWpQfwR2RQmYWbBeQg1l43N6yZMuPWvnV9sOmtHU
         K1zF7lQNlee1xr3E6kA4PR6ElZgU33zDYzB+YxJbkZtA3stuRGBZdIJaTgT9VdRASN1s
         /K2Q==
X-Gm-Message-State: ABy/qLYwYY7+Vds0ZVCFlY1IyNboJu0DHLktmK/KcL7n/brnvdyqKeEm
        ANQmjd09qsiZuT5dqGuu9f1xzrtGbO1OZKfdbQqs2Q==
X-Google-Smtp-Source: APBJJlEUB7vj1yaYT8FpBTe95IuQRlr3StaRyYOUt3pqTK2OiSyJTZJQIfIRUKSvNt/euq+mvodnNAVhyeSdjhMyGDM=
X-Received: by 2002:a1f:6dc4:0:b0:471:24c3:6cd3 with SMTP id
 i187-20020a1f6dc4000000b0047124c36cd3mr2339552vkc.11.1689706731222; Tue, 18
 Jul 2023 11:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710214910.31892-1-asmaa@nvidia.com> <CAMRc=MeQBSJ8Y92VfOfiaDjDyW44RunYt-D1aFraNaR_dTRVOQ@mail.gmail.com>
 <CAHp75VcKH4ZJ7HjjY6q_Woi2wAwnhiqyyPySOpK9Amt_SHB8ow@mail.gmail.com> <CH2PR12MB38953B86B91D7529CF6DBEF5D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38953B86B91D7529CF6DBEF5D738A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Jul 2023 20:58:40 +0200
Message-ID: <CAMRc=MdCb1OzeBdQ6YxBw3FMmj7jCs=1SabYiu-+0FdVLdZe9Q@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: mmio: handle "ngpios" properly in bgpio_init()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:39=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> >
> > > Applied, thanks!
> >
> > This has a bug.
> >
> My apologies for this inconvenience. This is not the right patch to be ap=
plied. It was rejected by Andy. I just forwarded to you the patch to apply.
> Its only one patch an dis named:
>  [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()

Yeah, I figured and backed it out.

Bart
