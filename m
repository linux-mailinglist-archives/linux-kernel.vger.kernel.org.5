Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AD78E09A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjH3U1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbjH3U1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:27:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E82D46
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:23:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so604555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693426927; x=1694031727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axjZpoy0fsRceXZWl0+b6PXrTV3YKhJ6mUApTZrRnqQ=;
        b=cNKruMfYhAldllF056NXfGtjONztSudMiNjwV9i/zWhYX8vD66/5Q0mpIPPYSrryFP
         C/bhBoa2juGkLwnAuL38PHZr03O9HcGT9JKfJZW9YTdLs9u5YJIaF4897+T6gwsxu3Gk
         3LyjPFwXZiXFoW2Xmsy7u0I6Y0KD8sBOyBQW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426927; x=1694031727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axjZpoy0fsRceXZWl0+b6PXrTV3YKhJ6mUApTZrRnqQ=;
        b=l39IFGd/ivI8wmZXOjjAG95YNrv6kzaZmat8XrIQ4tSJbulvj58RglB7EQuXNVta0+
         lBnnMhC6LhJcVEK+vYyyCqjuQ9kUv1Y5nz6dSb9R0HEAw3y2yMM4awuGCV+Y3FrU/lkg
         vWqA4efEgT6hZGpR85qKrbKi5eOYJUTWDqWuh5ICGvf8ReXkGlS7qK/a56Ce22G0UW9O
         YmXY0y0Ph8B74rNksgTln6bE5EjPQqEHcyl1L+9HMAHUfyAKiofmiF9DGdteeKA6YGvu
         XJ3b+AXILJoJKf2AF3uHqwIcdcUPpPDnP3YorjTmC8Jomw7hSD0VK5Bm/IkHSOTBDK5d
         aGew==
X-Gm-Message-State: AOJu0YzK+FBT+cSlX1lTvBsc8uXIPdMEfpGGRiq1IZuLyyTDqCSfvL37
        UGKkh5aihBNxW2wO1fGRm2160PXUNpn/ZldIgDiHHHPh
X-Google-Smtp-Source: AGHT+IEwgyPWejueGtIUeqQbz7rCfz/1HZcSFvQiVPBChsLfUmFnsfYNBQK5dsbvmVsnGdY4CDWO6Q==
X-Received: by 2002:adf:f108:0:b0:317:e766:d5e9 with SMTP id r8-20020adff108000000b00317e766d5e9mr2742030wro.3.1693426926997;
        Wed, 30 Aug 2023 13:22:06 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d4c7000000b00529fa63ef6fsm7167808edr.57.2023.08.30.13.22.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:22:06 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so27535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:22:06 -0700 (PDT)
X-Received: by 2002:a05:600c:5113:b0:3fe:ef25:8b86 with SMTP id
 o19-20020a05600c511300b003feef258b86mr33014wms.4.1693426926192; Wed, 30 Aug
 2023 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl> <85bcd0af56521209f40e76e0cac626c4f02b7df5.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <85bcd0af56521209f40e76e0cac626c4f02b7df5.1693416477.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 13:21:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXANhfLQfxYuuEWS_=ZcjR5LrmzAvXThrOECwqXhe5hw@mail.gmail.com>
Message-ID: <CAD=FV=WXANhfLQfxYuuEWS_=ZcjR5LrmzAvXThrOECwqXhe5hw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] regulator/core: regulator_lock_contended: wrap
 ww_mutex lock sequence restart
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
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

On Wed, Aug 30, 2023 at 10:35=E2=80=AFAM Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
>
> Wrap locking a regulator after a failed ww_mutex locking sequence with a
> new function.  This is to deduplicate occurrences of the pattern and make
> it self-documenting.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e89c12d27a9d..7201927c5d5b 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -154,6 +154,22 @@ static inline int regulator_lock_nested(struct regul=
ator_dev *rdev,
>         return 0;
>  }
>
> +/**
> + * regulator_lock_contended - retry locking a regulator
> + * @rdev:              regulator source
> + * @ww_ctx:            w/w mutex acquire context
> + *
> + * Locks a regulator after a failed locking sequence (aborted
> + * with -EDEADLK).
> + */
> +static inline void regulator_lock_contended(struct regulator_dev *rdev,
> +                                           struct ww_acquire_ctx *ww_ctx=
)

nit: IMO "inline" should be reserved for places where it would be a
serious problem if the function wasn't inlined. For cases like this,
let the compiler do its job and decide whether we'll be better off
with the code inlined or not.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
