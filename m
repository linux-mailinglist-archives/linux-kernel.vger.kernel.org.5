Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040847B7C38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbjJDJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbjJDJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:36:08 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AEAB;
        Wed,  4 Oct 2023 02:36:04 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57d086365f7so1042358eaf.0;
        Wed, 04 Oct 2023 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696412163; x=1697016963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++/+VKwwqNFyOz2R7GH46nTDcbNI+gQ/eUaaWteP+OM=;
        b=JY9P1l59g3OfhLrw5nQdGQeqIVZ1CoJ1JAGeSQ8uyaeNkylaZLLD8wI0E72sLXp/Ig
         BN7vH1sBjsdIJHOr1h+eZxxI1nmhpvg0rn6JhyrGlTlSnqGy3LJ/Jzjce4eELQk2HzWb
         1T36gLqZZOHRGtyFTdUyCMOxlwM8LiqREtVDxCcEf++/EyMWe5ee3w276h5TbKEXLpo8
         jmcXF5y7n2JzYzxJKAjhRxa6EYmcCEuOiCQFlT8XQjrQ6k/X2m3yxcVjOk1TLyxD+qqQ
         KIznQvtTPZxdbivB0uHiW7HTS8ijkN+lqwN8ObJDNBIWM+mOzbzTmDhSU/quM32cQfvm
         ycjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412163; x=1697016963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++/+VKwwqNFyOz2R7GH46nTDcbNI+gQ/eUaaWteP+OM=;
        b=N2OozQUvsbicg7Qhn4CD0iTS7OaM7Wxm4d4zH8Om5dQ9R9fdaX7/C45cEjQoHb6/kR
         xtogoNtzn0551iE2+Want4PMfXFT64Z6TBU04az6UabmQWH062s1sHS/U0QNtiL+1Cgg
         28ANjoYbUlNtKxQQNYaORpnBIUeBWIX/mExowui9gG2XvKdKLwPGMh+q3x+SiX6lmrVi
         EOdQd8FevQDzXyLHtLzXHxU4vdbbpW1EVYjLFDo/ySTLEpl0vzaN4+MfEIRIqJ6iJFsO
         EdPb+Kdv3nisjSrf5NQHf0bigIxR0VYE/1Gu9eyBZZAp93CYitPQ3YGSIx28B4SCdQe9
         +T8Q==
X-Gm-Message-State: AOJu0YwhCldLVGO9YWWh6U/K2tpGgyQpbWiHhc9hzmJQlO7OpcsGlud8
        VHqgUSQoPOVybGtYvLRjW0g1YrYzjKGBs86fxvy374JPavQ=
X-Google-Smtp-Source: AGHT+IFrgafJOd9G1ZaA6AApDzG2lPkHrbcb4izgpz4yx7zdc89sh7v1Yc+9msg6tjVmXARlsT2KjngR2O4RrMGAj/k=
X-Received: by 2002:a4a:9b11:0:b0:573:bf68:8dbc with SMTP id
 a17-20020a4a9b11000000b00573bf688dbcmr1660882ook.7.1696412163117; Wed, 04 Oct
 2023 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <CACRpkdY03QUkHcmyfTTfvVFbmNujW3qg5GcNJ-=8zj_zvGqDeg@mail.gmail.com>
 <CAMRc=Md7QKYqRaytw2xG8hqTmEDmZGxFfDyGZqoE96h-CvmJcw@mail.gmail.com> <CACRpkdZkQ8tJz=94rKGB4DcEC0z8HJHieZn5FD+-efRU-897Pw@mail.gmail.com>
In-Reply-To: <CACRpkdZkQ8tJz=94rKGB4DcEC0z8HJHieZn5FD+-efRU-897Pw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Oct 2023 12:35:27 +0300
Message-ID: <CAHp75VfWi91WaJuoW0NWrHH9=KRjOcrwwCeiXhnBd6Wg+o2Qow@mail.gmail.com>
Subject: Re: [PATCH 00/36] pinctrl: don't use GPIOLIB global numberspace in helpers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Wed, Oct 4, 2023 at 11:42=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Wed, Oct 4, 2023 at 10:12=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > What is your view on Andy's and Kent's issues with the _new() name
> > suffix?
>
> We have done similar operations in the past, and it is similar to what
> Uwe is doing for the moment with the .remove() callbacks.
>
> Usually the strategy is employed when the work needs to be spread
> out over a few merge windows so it is a bit of a marker that "this is
> in transition".
>
> There is the  horror story of this staying around forever and becoming
> idiomatic: struct napi_struct (include/linux/netdevice.h) where
> "napi" means "new API" - yeah that could have been handled better...
>
> If there is more moaning about it I will simply squash all the patches
> into one and call it a day - the end result will be the same and no
> sign of any *_new suffix anywhere. It was still worth it for reviewing
> the driver changes on a per-driver basis so then it becomes one of
> those Schopenhauer ladders that you can toss away after climbing
> it.

You can go with a compromise and name it better from the start, so at
least the patches that are taking care of renaming back won't be
needed.
Another way to have three or so patches with combined efforts, but still...


--=20
With Best Regards,
Andy Shevchenko
