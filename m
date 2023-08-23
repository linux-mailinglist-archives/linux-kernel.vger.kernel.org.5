Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C66785666
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjHWLHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjHWLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:07:46 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDECEF;
        Wed, 23 Aug 2023 04:07:44 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56e16e4aba7so3430992eaf.2;
        Wed, 23 Aug 2023 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692788863; x=1693393663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMxwzyr+JBbAW3Ha0AziKYmjDQcl5rwdIyhSrkcogfE=;
        b=j2dGaa5oTluwAyuPXsN0pt470G1jJbgtRePPO8pOHB8/D+yE4yyEYeavkIkVII0+cy
         tZOWVA+1MbdwWN5qbY7cRFH5veMjkPzzH6+zbvDXLVsspLHLQZhEOAyLZNN1FvSGFLzg
         mjK9a9tXQbeIK9hB0jHh/f4bW23EYQouIknvmjWT8Akt6MtjdLEjhYMwNHrAhgh1QXu+
         ciX4lqGYsRRoESHE8r0+KoAW7e5/J26Ptl93562exiKjDwtTnoMn96Ft9LFY9F7n+1Yg
         JWPKOAHOoNexz4DGyuLVK8wXc4l6zCNIQMCYHzpxZNyrp9iMAeXfRrUbGkLlYkaCIcK/
         Ar9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692788863; x=1693393663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMxwzyr+JBbAW3Ha0AziKYmjDQcl5rwdIyhSrkcogfE=;
        b=l9SxCizWc8wnxsJZ5xHIOzlwQSalQ1Rr9aFojUTUG2uR1UPJ3wttBNk4/SZ7X6FItq
         pzkWPl3JvXYLt75onDqYvpzb+86RPpRkQgdWZAiYv2rwEpnnTMZ5+btMTgKJ7o0fLjKj
         fGCLy8bp01qd2JtLbkpJ7Tg1JDm+2wR/BbkK10oIBCkLgtWYKaDTa+cDnZ5aQbytUdOu
         p/qz4MRg/V3rrcsT1wEIHhUgShtX7osaAXhV13nDK1rG9xCyMyxpDtDEKDZORMo1FAZM
         j6JM4eVenq26mroAIGw02QjwRNGaK/6zAogCl2RTUOHmRneOhBQfVG8J9/VQKH1eddgB
         dAGg==
X-Gm-Message-State: AOJu0Yxr5eCXcdZNprTEmec+5Q+lp7DNZIaGwSzsanp3kBI0Uo/pzSR0
        59plMF3TlkG1JbEQPCZmajI2IY5VrX4tzd5wDkQ=
X-Google-Smtp-Source: AGHT+IGnDX38QXr5qYl567NatdeZoLt8fnKVtgtElmzQJtpjKatXucVFut5nQ1KMFCJJyHP67LN3iaubeB1snwHsg0g=
X-Received: by 2002:a4a:2a1b:0:b0:571:28d5:2c73 with SMTP id
 k27-20020a4a2a1b000000b0057128d52c73mr124114oof.4.1692788863693; Wed, 23 Aug
 2023 04:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
In-Reply-To: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Aug 2023 14:07:07 +0300
Message-ID: <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/uv: refactor deprecated strcpy and strncpy
To:     Justin Stitt <justinstitt@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Aug 23, 2023 at 1:32=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> destination strings [1].
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy` or `strcpy`!
>
> In this case, we can drop both the forced NUL-termination and the `... -1=
` from:
> |       strncpy(arg, val, ACTION_LEN - 1);
> as `strscpy` implicitly has this behavior.

...

>         char arg[ACTION_LEN], *p;
>
>         /* (remove possible '\n') */
> -       strncpy(arg, val, ACTION_LEN - 1);
> -       arg[ACTION_LEN - 1] =3D '\0';
> +       strscpy(arg, val, ACTION_LEN);
>         p =3D strchr(arg, '\n');
>         if (p)
>                 *p =3D '\0';

https://lore.kernel.org/all/202212091545310085328@zte.com.cn/

...

> +               strscpy(uv_nmi_action, arg, strlen(uv_nmi_action));

strlen() on the destination?!

...

> -                       strncpy(uv_nmi_action, "dump", strlen(uv_nmi_acti=
on));
> +                       strscpy(uv_nmi_action, "dump", strlen(uv_nmi_acti=
on));

Again, this is weird.

--=20
With Best Regards,
Andy Shevchenko
