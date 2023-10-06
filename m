Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5947BB14C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJFF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjJFF4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:56:40 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A54CE;
        Thu,  5 Oct 2023 22:56:39 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-45456121514so840241137.0;
        Thu, 05 Oct 2023 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696571798; x=1697176598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY29Y08ay0W+xkXLRumtt827lBL+uMKkq5CvNdcP13E=;
        b=PoOSMq3vu7euwbRZK4Xpp3tRTZKHb06Rz9Lh0yY7q0qTteIuCLbZYm24AfXcOK7YGo
         xYD76TOzKQ2JmPeN4ORLBCogkMJgo5vD7vksAxoEcKV0em3zpedG5T+6wEWLwBbaO7vu
         Q7IflRmU9Cc1zPXTOqrhqJiANPfvgEBeypeJ3ejjFJER4dV6YMXHRtXksi63gQHIoZhp
         nHvuouUa3Fz6x3nlWci2nFXjV++bnnl93P7OrjsxSQQTBxqsE7chQ1QWq65W75Z5lT89
         7eCZ+Zjc3B8EBMZ8jRSRdgR2cdVGbw+Fg6a8rGr6t9vUk8yljKeYxskTHss4yONJHMAc
         yARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696571798; x=1697176598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pY29Y08ay0W+xkXLRumtt827lBL+uMKkq5CvNdcP13E=;
        b=bylH2dYR7wXINouaNJOi1QOjY5H2yoJQMAjf76VADSzJjAMDRqi12aLI5InAZ96Mas
         fZYohD1iGWveAQZnHBhRsnxrN/wCpYwWH/i27flrG7hZOodBLkrvI+b0zwhN1tsV2TNQ
         0Olna8rSp/BE86kIBFVcUDHND0iJp/dEKAnuuJJX91iBLhLkhzSvf/Y6HYynU3Iolb1U
         BW6CGQosqMlmS1g3u0FRw/XtuBQPAeK2P9RPgkVTsWIGL8/piz8xvaG38qR/3YD3Xukb
         i1lyDcyinMcw0gXKHX5uj38yE1UxgMgszcD/4aextEreyXpeapGfNPB+0bSEBsRZnMyD
         /N3A==
X-Gm-Message-State: AOJu0Yx2kIAw/H+5DRxBgCNWHICSoWGzwttaP0X+k4nK3q1DST1TZSAr
        XFkZn6yoIbwsJP1Ouv/ELm7kuGI1CyvVA31P/2M=
X-Google-Smtp-Source: AGHT+IFwbnqzJTok4tqqL23k/dzZ4YLfSR3JVP9ZVn28yLrZFPAt5hAMPbxe0f9C6ml+I/8af6b4zea6UJY0F6eviE8=
X-Received: by 2002:a67:ee45:0:b0:452:644e:2999 with SMTP id
 g5-20020a67ee45000000b00452644e2999mr7092361vsp.30.1696571798149; Thu, 05 Oct
 2023 22:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231006051801.423973-1-sumit.garg@linaro.org>
In-Reply-To: <20231006051801.423973-1-sumit.garg@linaro.org>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 6 Oct 2023 14:56:26 +0900
Message-ID: <CAB=+i9RGN0+S1siV7qjiZLSpfVMzsSu-8bTQ2yRi_zkRTiRbXQ@mail.gmail.com>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     torvalds@linux-foundation.org, jarkko@kernel.org,
        peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 2:18=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Static calls invocations aren't well supported from module __init and
> __exit functions. Especially the static call from cleanup_trusted() led
> to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=3Dy.
>
> However, the usage of static call invocations for trusted_key_init()
> and trusted_key_exit() don't add any value from either a performance or
> security perspective. Hence switch to use indirect function calls instead=
.
>
> Note here that although it will fix the current crash report, ultimately
> the static call infrastructure should be fixed to either support its
> future usage from module __init and __exit functions or not.
>
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I verified that this patch fixes the original problem.
Thanks!

Feel free to add:
Tested-By: Hyeonggon Yoo <42.hyeyoo@gmail.com>


Hyeonggon

> ---
>
> Changes in v2:
> - Polish commit message as per comments from Mimi
>
>  security/keys/trusted-keys/trusted_core.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/tr=
usted-keys/trusted_core.c
> index c6fc50d67214..85fb5c22529a 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_so=
urces[] =3D {
>  #endif
>  };
>
> -DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->i=
nit);
>  DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->s=
eal);
>  DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
>                         *trusted_key_sources[0].ops->unseal);
>  DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
>                         *trusted_key_sources[0].ops->get_random);
> -DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->e=
xit);
> +static void (*trusted_key_exit)(void);
>  static unsigned char migratable;
>
>  enum {
> @@ -359,19 +358,16 @@ static int __init init_trusted(void)
>                 if (!get_random)
>                         get_random =3D kernel_get_random;
>
> -               static_call_update(trusted_key_init,
> -                                  trusted_key_sources[i].ops->init);
>                 static_call_update(trusted_key_seal,
>                                    trusted_key_sources[i].ops->seal);
>                 static_call_update(trusted_key_unseal,
>                                    trusted_key_sources[i].ops->unseal);
>                 static_call_update(trusted_key_get_random,
>                                    get_random);
> -               static_call_update(trusted_key_exit,
> -                                  trusted_key_sources[i].ops->exit);
> +               trusted_key_exit =3D trusted_key_sources[i].ops->exit;
>                 migratable =3D trusted_key_sources[i].ops->migratable;
>
> -               ret =3D static_call(trusted_key_init)();
> +               ret =3D trusted_key_sources[i].ops->init();
>                 if (!ret)
>                         break;
>         }
> @@ -388,7 +384,8 @@ static int __init init_trusted(void)
>
>  static void __exit cleanup_trusted(void)
>  {
> -       static_call_cond(trusted_key_exit)();
> +       if (trusted_key_exit)
> +               (*trusted_key_exit)();
>  }
>
>  late_initcall(init_trusted);
> --
> 2.34.1
>
