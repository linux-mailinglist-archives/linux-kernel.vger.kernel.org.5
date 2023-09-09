Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25C799A39
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjIIRQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjIIRP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:15:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EDC7;
        Sat,  9 Sep 2023 10:15:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B15C433C9;
        Sat,  9 Sep 2023 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694279755;
        bh=KhtWGf2zPoyiuxjJnXbblI6vUKh1wZS3V87vTaTu1Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orQqJHz5NHPU9U9e8TwVINUBcesVcDAxcGwZJFOGPzVl/1QfguH4sjWojoPNDENhn
         DN9JYIKOzELAOjDg2ULxs17pWQceUPZom7GFWsnzwT3Zs3ptPQpFzlLU9i5lA4GAlk
         wsmLUPJkUsvTlleAwfHbOgfD2RDCAhR+0SC7lj8mfXwETlfcX19Xk+9pSkuPwhEzH7
         5KuiXaKwaZT82PEgw8F6/uDg8D/QxeULK5DLxhZ4LOD3Ce6D8LaVRMIikTw+s3h0CY
         CiPBrDBhCz7uBMIQ5FTJvPIYDlQIa+8d2n9oJcUD0eYniyKfmlI0vexUL0FJr3ss/E
         8hfdVRhwCupAQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1c504386370so2149444fac.1;
        Sat, 09 Sep 2023 10:15:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx78ceyapgzytwt9pj+vRHGTMEvtpISlAPfdoUK6H1Qz4dshvh+
        3rzlQOZRzBGpye0McjSagebml+fUS9Pnfrr2kko=
X-Google-Smtp-Source: AGHT+IFB4QMpozMyQcYYqjROcK1d0b9AZciucdiHOYXeCZaSUKBl9wA+yiE9RsjNLUevb72OKpxlQpU6vZOn2MWqVuI=
X-Received: by 2002:a05:6870:41cf:b0:1b7:27cf:9709 with SMTP id
 z15-20020a05687041cf00b001b727cf9709mr7079226oac.43.1694279754787; Sat, 09
 Sep 2023 10:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230905190828.790400-1-masahiroy@kernel.org> <1MbRk3-1q6Cp42Bcv-00bwDk@mail.gmx.net>
In-Reply-To: <1MbRk3-1q6Cp42Bcv-00bwDk@mail.gmx.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Sep 2023 02:15:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqCukUFNjT5NOfc7eT6isvh6K70DpMmCu3YkukbA9Tmw@mail.gmail.com>
Message-ID: <CAK7LNASqCukUFNjT5NOfc7eT6isvh6K70DpMmCu3YkukbA9Tmw@mail.gmail.com>
Subject: Re: [PATCH] linux/export: fix reference to exported functions for parisc64
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Sep 6, 2023 at 4:26=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> I think ppc64 is affected too.


I tested ppc64 ABI v1, but did not see a breakage.





> Search for dereference_function_descriptor() in kernel sources, e.g.
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1494564.html
> Helge
>
> -------- Urspr=C3=BCngliche Nachricht --------
> Von: Masahiro Yamada <masahiroy@kernel.org>
> Datum: 05.09.23 21:08 (GMT+01:00)
> An: linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, John Davi=
d Anglin <dave.anglin@bell.net>
> Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Masahiro =
Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
> Betreff: [PATCH] linux/export: fix reference to exported functions for pa=
risc64
>
> John David Anglin reported parisc has been broken since commit
> ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost").
>
> I checked the assembler output, and noticed function references are
> prefixed with P%, so the situation in parisc64 is similar to ia64.
>
> Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> Reported-by: John David Anglin <dave.anglin@bell.net>
> Closes: https://lore.kernel.org/linux-parisc/1901598a-e11d-f7dd-a5d9-9a69=
d06e6b6e@bell.net/T/#u
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I just checked the assembler output, and I created this patch
> based on my best guess. Only compile-tested.
> I hope somebody will run-test this patch.
>
>
> include/linux/export-internal.h | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index 1c849db953a5..45fca09b2319 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -52,6 +52,8 @@
>
> #ifdef CONFIG_IA64
> #define KSYM_FUNC(name) @fptr(name)
> +#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
> +#define KSYM_FUNC(name) P%name
> #else
> #define KSYM_FUNC(name) name
> #endif
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
