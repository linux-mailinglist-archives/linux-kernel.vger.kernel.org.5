Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1997828F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjHUM1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUM1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F2BE;
        Mon, 21 Aug 2023 05:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06436335D;
        Mon, 21 Aug 2023 12:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FADC433CA;
        Mon, 21 Aug 2023 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692620870;
        bh=tbL0rgNINgnFM+21Cr7ROc1vB8u0WzHBDcLBlKN2Xas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pa/cCXmzkF5b4lgOV1T8d3dOBgbLm/tQUFdcQJovhm1eNZ7MyG3Ajjk8Jjt8B0lFF
         Es2Y12/LC6GP121b353cqK7bWtpic9j/SYZW6kCo/Vzk9vbG2Y2Wk7ArW8ROKr7Px9
         uxYLWPXoJ12UbY9Dm/eEbyFuIeXP91zvlTpfCiAn5Wf4587IhLGsX/Voe0evzzUJGM
         EQPtNExCxYHDVrGantHeCfDmB2iVhLHxbombof16sPJAzV2fOu/9/2I7F6n5EXJ7Ik
         VAPvRoKcKpLzh3UHQ6JBmubspB9DCASUXpXSxLc8VhrHIQZiTrXh+N5buadyk5efl0
         RPY8b08kGlT7g==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-570deae2594so344692eaf.1;
        Mon, 21 Aug 2023 05:27:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx322nX3PnbDSYLCzoip/rItF8Plc9RiNTbv2bK5ePycAq6s0qE
        qm3e4q+9k+/8r1xhELumSPpD2WEGvvlHNmJ3pgo=
X-Google-Smtp-Source: AGHT+IE6XjPn48mGxrxXnaksaonAPDuCUCrfZEp9+ax3SsHUoqu0FpoAm8qqkg2pkOWmmyJDTOSv010TV0Gs/BOI+Yc=
X-Received: by 2002:a4a:7510:0:b0:56e:9ce3:8d56 with SMTP id
 j16-20020a4a7510000000b0056e9ce38d56mr5655509ooc.6.1692620869335; Mon, 21 Aug
 2023 05:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
In-Reply-To: <20230820073332.GN907732@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 21 Aug 2023 21:27:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
Message-ID: <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Aug 20, 2023 at 5:15=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/08/20 16:21), Sergey Senozhatsky wrote:
> > What the preferred approach would be? Do we want a new KCONFIG_FOO env
> > variable that changes behaviour of one of the targets? E.g.
> >
> >       KCONFIG_LIST_MISSING=3D1 make oldconfig
> >
> > and then have conf list symbols and terminate with exit(1) if there are
> > some unrecognized symbols?
>
>
> Will something like this be OK with you?
>
>
>  KCONFIG_LIST_MISSING=3D1 make oldconfig
>
> .config:6:warning: unknown symbol: DISABLE_BUGS
> .config:7:warning: unknown unset symbol: ENABLE_WINAPI
>
> make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
>


Yup, much better than adding a new target.



> ---
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index fa2ae6f63352..b2c0bcf0e5c1 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -360,7 +360,9 @@ int conf_read_simple(const char *name, int def)
>         char *p, *p2;
>         struct symbol *sym;
>         int i, def_flags;
> +       const char *list_missing;
>
> +       list_missing =3D getenv("KCONFIG_LIST_MISSING");


My (original) hope was to add a single switch, KCONFIG_VERBOSE, to address =
both:

  - A CONFIG option is hidden by unmet dependency (Ying Sun's case)
  - A CONFIG option no longer exists  (your case)
  - Anything else we need to be careful



>         if (name) {
>                 in =3D zconf_fopen(name);
>         } else {
> @@ -448,6 +450,12 @@ int conf_read_simple(const char *name, int def)
>                         if (def =3D=3D S_DEF_USER) {
>                                 sym =3D sym_find(line + 2 + strlen(CONFIG=
_));
>                                 if (!sym) {
> +                                       if (list_missing) {
> +                                               conf_warning("unknown uns=
et symbol: %s",
> +                                                            line + 2 + s=
trlen(CONFIG_));
> +                                               continue;
> +                                       }
> +
>                                         conf_set_changed(true);
>                                         continue;
>                                 }
> @@ -482,6 +490,12 @@ int conf_read_simple(const char *name, int def)
>
>                         sym =3D sym_find(line + strlen(CONFIG_));
>                         if (!sym) {
> +                               if (list_missing) {
> +                                       conf_warning("unknown symbol: %s"=
,
> +                                                    line + strlen(CONFIG=
_));
> +                                       continue;
> +                               }
> +


This should be warned only if (def !=3D S_DEF_AUTO),
otherwise the same warning will be displayed twice.



>                                 if (def =3D=3D S_DEF_AUTO)
>                                         /*
>                                          * Reading from include/config/au=
to.conf
> @@ -530,6 +544,13 @@ int conf_read_simple(const char *name, int def)
>         }
>         free(line);
>         fclose(in);
> +
> +       if (list_missing) {
> +               if (conf_warnings)
> +                       exit(1);
> +               exit(0);
> +       }
> +

This is something different because you are making these
errors instead of warnings.



>         return 0;
>  }



--=20
Best Regards
Masahiro Yamada
