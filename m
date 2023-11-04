Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67977E0D1F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjKDBtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:49:34 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264CD4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:49:30 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7bac330d396so927168241.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 18:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699062569; x=1699667369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V0CZIhZnqFOrTe30OO9qIEuDvO6VokAQVy132tMynk=;
        b=CO/KYJrxljeLm9aXMukbP/TQeknvIisJ4LoPeIp+y1mD9zebd/iSH9bhyGTPaBCAuq
         iiiQORWgX4zRGmEYnAS0MJKGAYZCzNKi1JqtX6jDaqa5GbFKIa3DahBTy136xqLCIQUb
         lqJ7xyUA7qn5UYXbMtorkeykn3UHQu85vuvVvz/8xaXXzyJg8uNbl5yPHNneg/xTxHfd
         G3x3mYO4xbDMC2mCOH6OAaRrKxU1FAooOHo4L40+TkgcPj9+83+hpmSdG1epn1l48Pex
         40JGwL1Xos6ZZWVOqZT4NEuRtfmRb7zwPZ0OS6XY7UP2FKX8Oo9hZvX0apjmKi0ZPSYi
         8dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699062569; x=1699667369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V0CZIhZnqFOrTe30OO9qIEuDvO6VokAQVy132tMynk=;
        b=rVFBtNywfkggROGTOizT9wB9mM0SwZ+WL6I51+R4zxshuctgJwiO1hmTh/lRm1u0xg
         ZOvgVySOwKfwZY1qcLhc72vPKN1EmIiEpHIdX51GvNCWp4lCF3jzoL7tDdAE3ZwjwIue
         rcqT3ln21AfqRmW19jpyhhsg1yKC+XsZxMstHCm3vAPWlQLpbvoYHSz7A7I0SLlaLkqy
         dhaA1DpGcUpkwa0eX6SCuwm1VRzJ+oJEEunkyC+sEWh3acRUP7zcaeCunYMh/1UnVH2X
         +S7o2VRho3b5BAvvPTs4moAoLp3E8rYfBteW0FrwTDL6R2cMJlCyaybq2Gpl1+GVyCYg
         1dSg==
X-Gm-Message-State: AOJu0YwjNZqs+8fZKCAitcIO55Ec4wt/KnbQDPcesJ4HsdD5EpdztrbS
        1bgGigvXpTA+HAP3Gkvnb7HD3SVFwW7TH+wcamA=
X-Google-Smtp-Source: AGHT+IFS/ZoD5IkqQMvhCqPp8EdoZw17RkxfY3LXxSUrpZT8CPfswhmdyRyc2rFWETdaKqwKnXQoZGcJnSA1SyT7RRA=
X-Received: by 2002:a67:c103:0:b0:45d:9223:9532 with SMTP id
 d3-20020a67c103000000b0045d92239532mr3873392vsj.19.1699062569495; Fri, 03 Nov
 2023 18:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-8-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Nov 2023 19:49:02 -0600
Message-ID: <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] dyndbg: repack struct _ddebug
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> From: Jim Cromie <jim.cromie@gmail.com>
>
> Move the JUMP_LABEL to the top of the struct, since theyre both
> align(8) and this closes a pahole (unfortunately trading for padding,
> but still).
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

let me add, I havent really tested this, nevermind thorough.
specifically, I didnt look for any offset dependence on the static-key
inside their container.
Conversely, maybe theres a free default or something in there.

> ---
>  include/linux/dynamic_debug.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 497130816e9c..b9237e4ecd1b 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -14,6 +14,12 @@
>   * the special section is treated as an array of these.
>   */
>  struct _ddebug {
> +#ifdef CONFIG_JUMP_LABEL
> +       union {
> +               struct static_key_true dd_key_true;
> +               struct static_key_false dd_key_false;
> +       } key;
> +#endif
>         /*
>          * These fields are used to drive the user interface
>          * for selecting and displaying debug callsites.
> @@ -53,12 +59,6 @@ struct _ddebug {
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
>         unsigned int flags:8;
> -#ifdef CONFIG_JUMP_LABEL
> -       union {
> -               struct static_key_true dd_key_true;
> -               struct static_key_false dd_key_false;
> -       } key;
> -#endif
>  } __attribute__((aligned(8)));
>
>  enum class_map_type {
> --
> 2.42.0.869.gea05f2083d-goog
>
