Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0097E388F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjKGKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGKNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:13:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C2BD;
        Tue,  7 Nov 2023 02:13:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33326C433D9;
        Tue,  7 Nov 2023 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699351988;
        bh=Cg4JwaJXW8aMk6Qj7g4lmGbdb7QNI/tQxPjTSIHA4cI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E9qs8z8Pa11Gk/j3gjROyokcLYP+l4xLI1lHV3xWnhyg0LQ0U8uOpjOcn/hEW9OTF
         ZdITV/OhXcb232d0UChDa052Ps3y8qj4PT+8VNWdN9M8OwA2sY5SgYBDtzqaSR757a
         niCxWZIuS1kkh6zGlP/r5JSXxpOV1cESigRhT2FtbQKuZD1iyISYrl0qkBdvH8kypD
         +lef6brGjvFr9mwQj57If6qwaOmv8ijAUea4NVYowJuJNz96Mv7LK5Nm1k/dTYM0EV
         Sc1XTO0ARFS12pAdp2IREit7vc90+OWrW9T3NS7dE0p5Uxs/Jw7cfk4rEeQfQB6wWP
         B5f/fFoEcvtcg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso3339493fac.2;
        Tue, 07 Nov 2023 02:13:08 -0800 (PST)
X-Gm-Message-State: AOJu0YyDLbj3EdRRjf+wmRpMTNs5N8431wiaW6fiqTB7A7YbMwh7vod/
        Wjmj2ge4GLJhnc7OYBlK8RVyykhuCjjKgUxlVC4=
X-Google-Smtp-Source: AGHT+IFwtR8QOdDBWrS1H5FNaUKUWfGRVbBjcpHDHqyziVmjexyzWBylcif12dO1O6q6SYxwYaTHrq9GWlK5eM+N8l0=
X-Received: by 2002:a05:6871:67c2:b0:1ea:131f:5fb1 with SMTP id
 yb2-20020a05687167c200b001ea131f5fb1mr2554285oab.34.1699351987327; Tue, 07
 Nov 2023 02:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org> <20231104194207.3370542-3-sjg@chromium.org>
In-Reply-To: <20231104194207.3370542-3-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Nov 2023 12:12:30 +0200
X-Gmail-Original-Message-ID: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
Message-ID: <CAK7LNASVOdz2qdg5dwWN8HJwqJ1q_OgdeuapLhvmD6beavUqPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: boot: Use double quotes for image name
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> The use of single quotes in the image name causes them to appear in
> the image description when the uImage is created. Use double quotes, to
> avoid this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Split double-quote change out into its own patch
>
>  scripts/Makefile.lib | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 68d0134bdbf9..03e79e319293 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -487,7 +487,7 @@ UIMAGE_OPTS-y ?=3D
>  UIMAGE_TYPE ?=3D kernel
>  UIMAGE_LOADADDR ?=3D arch_must_set_this
>  UIMAGE_ENTRYADDR ?=3D $(UIMAGE_LOADADDR)
> -UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
> +UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
>
>  quiet_cmd_uimage =3D UIMAGE  $@
>        cmd_uimage =3D $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
> --
> 2.42.0.869.gea05f2083d-goog
>


NACK.


This is because you are doing *WRONG* in 3/3.

Look at your code closely.

https://lore.kernel.org/linux-kbuild/20231104194207.3370542-4-sjg@chromium.=
org/T/#me2fb68151d6f4f330808406f9a711fffee149529



In the mainline kernel, the quotation appears
only in the definition of UIMAGE_NAME.


masahiro@zoe:~/ref/linux(master)$ git grep UIMAGE_NAME
scripts/Makefile.lib:UIMAGE_NAME ?=3D 'Linux-$(KERNELRELEASE)'
scripts/Makefile.lib:                   -n $(UIMAGE_NAME) -d $< $@


The single quotes are consumed by shell.






This is mainline + your patch set.

masahiro@zoe:~/ref/linux(simon-v2)$ git grep UIMAGE_NAME
scripts/Makefile.lib:UIMAGE_NAME ?=3D "Linux-$(KERNELRELEASE)"
scripts/Makefile.lib:                   -n "$(UIMAGE_NAME)" -d $< $@
scripts/Makefile.lib:                   --name "$(UIMAGE_NAME)" \


You quoted the definition of UIMAGE_NAME,
and also variable references.




See how it is expanded.


--name "$(UIMAGE_NAME)"


 =3D=3D>


--name ""Linux-$(KERNELRELEASE)""


 =3D=3D>


--name Linux-$(KERNELRELEASE)




You added double quotes in a row, just to cancel it.



--=20
Best Regards
Masahiro Yamada
