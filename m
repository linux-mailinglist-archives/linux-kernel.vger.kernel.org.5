Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9800E7E1289
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjKEIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:08:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD49C6;
        Sun,  5 Nov 2023 01:08:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A1CC433CC;
        Sun,  5 Nov 2023 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699171736;
        bh=5rsA2TtvetTrEVFVX3AW75cMiJr0GflteQegZdR4OPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XF727T0OxCcRGSuOnzOoEkz8dEeF9lTJr8szeytyoyWHH5DCXo7RT3V7o9szeIe5o
         jCntxtlbvzq/DqWVIS9w10VSnJbrzo/zfM9LjPw9WFj49Zxipa0l6jtyt+tWXUBdiY
         X6MSxxl831WoqvGzIOh0zATz+borRXOEaaL2t7x5pcBgSnfDfQ3v/OB3BZnraoiiyd
         unDP6F4v9ZTKXmsBKKEgHNFeORAaPo+OIpWFsahGYpW1LkJ/nSHZle48Sf9XpSuGYP
         //phxRl5mntN0QR7lQgw/mIezpFFcuOGasK++z10Zr5KNaBqqEwSDuoRIK3ncGEhqy
         PD5QDEL+0HQ1Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1f03fdfcfacso2054138fac.0;
        Sun, 05 Nov 2023 01:08:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPYGCL/u9/nLXwjerOD9dBS9NDAPXrAhWnVBqU/jL6zyALdIes
        IK1X2A5aPyhZLp8gim0WEB60ZZ8llSZAIkiIvVE=
X-Google-Smtp-Source: AGHT+IEtYHz1tuPfOm/db76/IguvKKF83pIUjWSw1hHIUZoME/DTiWkaz66bzhGcRm4TGCXqgrDdBprQw/GhB8L8/Zc=
X-Received: by 2002:a05:6870:1219:b0:1f0:c3c:cb02 with SMTP id
 25-20020a056870121900b001f00c3ccb02mr15980242oan.32.1699171735401; Sun, 05
 Nov 2023 01:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231103234247.4505-1-dmitrii.bundin.a@gmail.com>
In-Reply-To: <20231103234247.4505-1-dmitrii.bundin.a@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Nov 2023 17:08:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
Message-ID: <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: apply short --rules-file option
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 8:43=E2=80=AFAM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> The long --rules-file option might not be available for some older
> versions of dpkg-buildpackage resulting in build failures. The -R option
> has been available since 1.14.17 allowing builds for larger allowing
> builds for larger set of versions of dpkg-buildpackage.
>
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>  scripts/Makefile.package | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 2bcab02da965..0afbf5ad2919 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
>         $(if $(findstring source, $(build-type)), \
>                 --unsigned-source --compression=3D$(KDEB_SOURCE_COMPRESS)=
) \
>         $(if $(findstring binary, $(build-type)), \
> -               --rules-file=3D'$(MAKE) -f debian/rules' --jobs=3D1 -r$(K=
BUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
> +               -R'$(MAKE) -f debian/rules' --jobs=3D1 -r$(KBUILD_PKG_ROO=
TCMD) -a$$(cat debian/arch), \
>                 --no-check-builddeps) \
>         $(DPKG_FLAGS))
>
> --
> 2.17.1
>


The replacement is inconsistent because you replaced
--rule-file, but kept --jobs, both of which are available
since 1.18.8



-j, --jobs[=3Djobs|auto]
   Specifies  the  number  of  jobs  allowed  to be run simultaneously
   (since dpkg 1.14.7, long option since dpkg 1.18.8).

-R, --rules-file=3Drules=E2=80=90file
   Building  a  Debian package usually involves invoking debian/rules
   as a command with several standard parameters (since dpkg 1.14.17,
   long option since dpkg 1.18.8).


I do not think it is a big deal because the version 1.18.8
was released in 2016.




--=20
Best Regards
Masahiro Yamada
