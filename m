Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A321782EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHUQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjHUQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:50:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE48510F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso4356312a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636647; x=1693241447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpjLrb+pKSYIjqjv7xW6/veZs90sc4TEOdIEA9zoCfI=;
        b=chcp+PeZ+xvcYwbyusqzVgY0wU3/uVO5C5iNJc1hgmzlUAGGpFgDNNtBPIjzjCOKMo
         sbLfrq8xqBMwdoMrnw6JQV3cbspkwRjfRAacg89410uYmLKAkxz4T3fp2O5FLiwxQ6L5
         g9wokEXVEtBfN1D7svVS8fE2Z2kPTB4NJ2FW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636647; x=1693241447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpjLrb+pKSYIjqjv7xW6/veZs90sc4TEOdIEA9zoCfI=;
        b=AQ9i/QvBlSZMuCO4bfaoS5mFtFGHWaBXG8ewCPI5BKfoZ0hhnNg1mwCSNy3mC7PBXG
         1psrded65QeDcOER7v9YCrfRvrsFUVBOb7fsYdC5rlWzF675jq1v3cAjZMgrybwkCIF8
         IVeF0uxHKGXF7XIiW1SC5sVEU1/ZpqQ7fTqxVEREjPGRklboSKQOiyNu8jyc+2r4unCX
         UvwYlr6KIFJj8315O3DrzFMU1bw/F0XvXaw/bxruq5RYjDfdLUVNrKu3mf6cvotgx5/g
         UBseBQ8lGUVezFWR0XtjWMibLcvMyRSHAiDL0V82tIBMVCAyCKgMOdpM1LL6oLag0xUV
         Q4Dg==
X-Gm-Message-State: AOJu0Ywy9zBMGYW++xCfujk1zVDJRrkcQZALQ33RouEjlad/2XdkVTkT
        zx51uv5E+aUghBI4rfQ7ZNLA75tjo4Qu6aPw5noHXuOM
X-Google-Smtp-Source: AGHT+IEqd+vlkO/h+CJIDB+kUAZp21IRADIY+AQn1AQxnDDHzLXt5sLm2Q+x6IlxQUmgZUkDiXruNA==
X-Received: by 2002:a17:906:3caa:b0:99d:f056:5d6b with SMTP id b10-20020a1709063caa00b0099df0565d6bmr6019557ejh.20.1692636646868;
        Mon, 21 Aug 2023 09:50:46 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id ss21-20020a170907039500b00992076f4a01sm6787926ejb.190.2023.08.21.09.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:50:46 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fef56e85edso1695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:46 -0700 (PDT)
X-Received: by 2002:a05:600c:518f:b0:3fe:5228:b7a2 with SMTP id
 fa15-20020a05600c518f00b003fe5228b7a2mr598wmb.5.1692636645902; Mon, 21 Aug
 2023 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <7d678e7b55e88e630491086f59120253fabeb386.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <7d678e7b55e88e630491086f59120253fabeb386.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:50:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHvi-2GPxXsDaiPKzgJHqBpX1a6+0CUwp1y8vfr8-Xtg@mail.gmail.com>
Message-ID: <CAD=FV=VHvi-2GPxXsDaiPKzgJHqBpX1a6+0CUwp1y8vfr8-Xtg@mail.gmail.com>
Subject: Re: [PATCH 3/6] regulator: core: simplify nested locking
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> Simplify regulator locking by removing locking around locking.
> rdev->ref check when unlocking is moved inside the critical section.
>
> This patch depends on 12235da8c80a ("kernel/locking: Add context to
> ww_mutex_trylock()").

nit: when I run checkpatch, it always wants me to put the word
"commit" before the git hash when I refer to a commit. ;-)


> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 921c7039baa3..87e54b776a0f 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -34,7 +34,6 @@
>  #include "internal.h"
>
>  static DEFINE_WW_CLASS(regulator_ww_class);
> -static DEFINE_MUTEX(regulator_nesting_mutex);
>  static DEFINE_MUTEX(regulator_list_mutex);
>  static LIST_HEAD(regulator_map_list);
>  static LIST_HEAD(regulator_ena_gpio_list);
> @@ -143,23 +142,18 @@ static inline int regulator_lock_nested(struct regu=
lator_dev *rdev,
>  {
>         int ret =3D 0;

nit: remove initialization of "ret" to 0 since changing "return ret"
to "return 0" below. Those changes belong in one of the previous
patch, too.


> -       mutex_lock(&regulator_nesting_mutex);
> -
>         if (!ww_mutex_trylock(&rdev->mutex, ww_ctx) &&
> -           rdev->mutex_owner !=3D current) {
> -               mutex_unlock(&regulator_nesting_mutex);
> +           READ_ONCE(rdev->mutex_owner) !=3D current) {
>                 ret =3D ww_mutex_lock(&rdev->mutex, ww_ctx);
> +
>                 if (ret =3D=3D -EDEADLK)
>                         return ret;
> -               mutex_lock(&regulator_nesting_mutex);
>         }
>
>         rdev->ref_cnt++;
>         rdev->mutex_owner =3D current;
>
> -       mutex_unlock(&regulator_nesting_mutex);
> -
> -       return ret;
> +       return 0;
>  }
>
>  /**
> @@ -186,16 +180,13 @@ static void regulator_lock(struct regulator_dev *rd=
ev)
>   */
>  static void regulator_unlock(struct regulator_dev *rdev)
>  {
> -       mutex_lock(&regulator_nesting_mutex);
> +       if (WARN_ON_ONCE(rdev->ref_cnt <=3D 0))
> +               return;
>
>         if (--rdev->ref_cnt =3D=3D 0) {
>                 rdev->mutex_owner =3D NULL;
>                 ww_mutex_unlock(&rdev->mutex);
>         }
> -
> -       WARN_ON_ONCE(rdev->ref_cnt < 0);
> -
> -       mutex_unlock(&regulator_nesting_mutex);

I guess the "fix" you talked about in the cover letter is moving the
WARN_ON up? That could be done in patch #1 and marked as a "Fix",
right?

I'm not 100% sure why we needed the "regulator_nesting_mutex" to begin
with. I'm also not 100% sure why we depend on commit 12235da8c80a
("kernel/locking: Add context to ww_mutex_trylock()"). Could you add
something to the commit message to make this more obvious so I don't
need to work so hard to figure it out? ;-)
