Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E67DA6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjJ1Log (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1Loe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:44:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A6D9;
        Sat, 28 Oct 2023 04:44:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B8CC433C9;
        Sat, 28 Oct 2023 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698493469;
        bh=Vff3CPNZ027kdW7jf8wJOg2+GsBr6Hyeu9XOKAQdjMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J8R0FXdAs5cqd07eq16gBpzflrQhqkagrD0tO5W6Z405c0F6tyyhfIM+B+HHRlafR
         ae+DWw5gT6XXw147Qca9vmFy1vYG0XlMD8hgWpmbBrfSAQnYSaE+ahPlAFfEgazvUt
         1ksOsluWiaAbDM/TvhXa+ia2dTwTfatkDo5vXJa3j8RZtTO3RfX28Yf6gDnTGqUPa2
         hd+GwHxQE7MvxgFpwgiIjYRuGvYZVYjFN1rg0ZfAE8ToKnNuGAdiXhaq0VdmaXrgwV
         Se/ve6JRxPgpCvr7e0eW5qAk/s0o2VTU/cgmClULSv2PI0r7dJCuwGRjlre6ry4ICN
         cHBQzLL5e8T0Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9ac336589so1934350fac.1;
        Sat, 28 Oct 2023 04:44:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwANAH7nI71GBTfRp7pbIx8LovFclWV6avoODak5G3SFXF1+rMv
        7W1zGWmct+cLWbPTk66Fil3821Fwqm/KHeYT+YI=
X-Google-Smtp-Source: AGHT+IGZKWRaqGUHSnmKhKOXiMB0FTBKmhyAl7lTVczyfGtSkOucOmAlREhmnM+naFzdeRqqhWrE/1iTGmhN3EUBkqA=
X-Received: by 2002:a05:6870:61c9:b0:1bb:84af:bf8f with SMTP id
 b9-20020a05687061c900b001bb84afbf8fmr6123744oah.58.1698493469138; Sat, 28 Oct
 2023 04:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231023090638.935867-1-vegard.nossum@oracle.com>
In-Reply-To: <20231023090638.935867-1-vegard.nossum@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Oct 2023 20:43:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJzjNWaBg+K7wRrwvthup_hWOvxibOg+ezhM_CRPeM4Q@mail.gmail.com>
Message-ID: <CAK7LNAQJzjNWaBg+K7wRrwvthup_hWOvxibOg+ezhM_CRPeM4Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kbuild: clarifications
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 6:06=E2=80=AFPM Vegard Nossum <vegard.nossum@oracle=
.com> wrote:
>
> The kconfig language is subtle. Document a few more non-obvious
> aspects of it.
>
> Also fix a small markup issue while we're at it.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/kbuild/kconfig-language.rst | 53 ++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kb=
uild/kconfig-language.rst
> index 0135905c0aa3..f694d90f83d1 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -42,9 +42,11 @@ Every line starts with a key word and can be followed =
by multiple
>  arguments.  "config" starts a new config entry. The following lines
>  define attributes for this config option. Attributes can be the type of
>  the config option, input prompt, dependencies, help text and default
> -values. A config option can be defined multiple times with the same
> -name, but every definition can have only a single input prompt and the
> -type must not conflict.
> +values.
> +
> +A config option can be defined multiple times (i.e. by multiple menu
> +entries) with the same name, but each definition can have only a single
> +prompt and their types must not conflict.



The kernel code should not do this.

Scattering the elements of the same CONFIG option
results in unreadable, unmaintainable code.


Kconfig supports it, but the actual implementation is incorrect,
and the behaviour is obscure.






>
>  Menu attributes
>  ---------------
> @@ -136,7 +138,10 @@ applicable everywhere (see syntax).
>    below), reverse dependencies can be used to force a lower limit of
>    another symbol. The value of the current menu symbol is used as the
>    minimal value <symbol> can be set to. If <symbol> is selected multiple
> -  times, the limit is set to the largest selection.
> +  times, the limit is set to the largest selection. In other words, if
> +  at least one menu selecting another symbol is ``y``, then the selected
> +  symbol will also be ``y``.
> +
>    Reverse dependencies can only be used with boolean or tristate
>    symbols.
>
> @@ -473,6 +478,22 @@ This is a collection of Kconfig tips, most of which =
aren't obvious at
>  first glance and most of which have become idioms in several Kconfig
>  files.
>
> +Misconceptions about prompts and symbols
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Looking at fragments of common Kconfig usage, it is easy to believe
> +that a symbol can depend on another symbol. In fact, it is not the
> +symbol itself that has a dependency; it is the visibility of the
> +symbol's prompt that has a dependency.




The dependency of a symbol and the visibility of a prompt
are two different things.


Each symbol does track its dependency, so called "direct dependency".
(symbol::dir_dep)


Prompts can have separate visibility.




This is "show by example".



config X86_VSYSCALL_EMULATION
        bool "Enable vsyscall emulation" if EXPERT
        default y
        depends on X86_64




When X86_64=3Dn, X86_VSYSCALL is disabled.


When EXPERT=3Dn, the prompt becomes invisible,
but the symbol itself can be enabled.
X86_VSYSCALL_EMULATION is always y
due to 'default y'.





> +
> +Likewise, since each prompt defines its own dependencies, it is quite
> +possible to have two prompts for the same symbol with different sets
> +of dependencies. As long as the user has at least one visible prompt,
> +they can enable that symbol in their config. Conversely, if there are
> +no visible prompts for a symbol, the user can not change its value,
> +not even by explicitly setting it in their .config. (It may, however,
> +still be selected by other prompts.)



I do not want to advertise this because
there is no beneficial case for doing this.








>  Adding common features and make the usage configurable
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  It is a common idiom to implement a feature/functionality that are
> @@ -567,7 +588,7 @@ distro config owners, but also for every single devel=
oper or user who
>  configures a kernel.
>
>  Such a dependency can be relaxed by combining it with the compile-testin=
g rule
> -above, leading to:
> +above, leading to::
>
>    config FOO
>         bool "Support for foo hardware"
> @@ -692,6 +713,28 @@ e98062ed6dc4    select A -> depends on A        (3)
>  (2) That seems to be the gist of that fix.
>  (3) Same error.
>
> +Experimenting with smaller-scale Kconfigs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It is fully possible to play around with smaller-scale Kconfig fragments
> +instead of using the kernel's full set of Kconfig files. Create a file
> +called ``Kconfig.test`` containing e.g.::
> +
> +  config MODULES
> +          bool "Modules"
> +          modules
> +
> +  config FOO
> +          tristate "foo"
> +
> +  config BAR
> +          tristate "bar"
> +          depends on FOO
> +
> +You can now e.g. use menuconfig on this by simply running:
> +``scripts/kconfig/mconf Kconfig.test``.
> +
> +
>  Future kconfig work
>  ~~~~~~~~~~~~~~~~~~~
>
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada
