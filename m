Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D075E21F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGWNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7ACA;
        Sun, 23 Jul 2023 06:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC8660CF5;
        Sun, 23 Jul 2023 13:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C140BC433C9;
        Sun, 23 Jul 2023 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690119530;
        bh=tMZNun61+QNkTP5rV6dx7NQaNgUppRYHKxHRX7POL4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/N8JXS/sXwngi0yuMvOdWLP4pHMECEZnWeHce0EaJyIE7X/BegHVqYeJG8Jlb5xB
         gL6zesJpK4R22o7y30LL9wtrJrFFV5rQE7T0xOPBPzF75Gu0y3I3tvEjKKBca2eYAi
         o/6V17jNAhRrQbscALCTVHDza2Z19RhFCM15iYhXp4lbuqBymU1ZRQyg+y0D5HwQyO
         zPBOFqEkRp1399yuByg9jqaw8odrXhZrItIa/i/AQnrO5BWKfK60iK+UYp8LGBlc1K
         ZdWRqUQ5I62kxC69rPARhklFs503l07f3BKpQa1p/VNAQhYJtdipCA5NhQkBhhA8rg
         AGXCrVQmRXwbw==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a36b30aa7bso2357460b6e.3;
        Sun, 23 Jul 2023 06:38:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLbON32JGtAtzmYAuIEFrqfiCoxN/oHQ92gj6+ipU8T0tLNDObrW
        8wlaOzqXRa2BPB0Gj/oDBdSBdwxR/ruOaePt93U=
X-Google-Smtp-Source: APBJJlE0NKPfhfYblh1T1CUR6H3Bf8lihDASc8hvg9nJ6nkdNnmwAAEhT80LeFyB73OZMhltFfE6gBgMF1DhZbuk94E=
X-Received: by 2002:a05:6808:1415:b0:398:2c02:20a2 with SMTP id
 w21-20020a056808141500b003982c0220a2mr7961161oiv.17.1690119530087; Sun, 23
 Jul 2023 06:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230718165848.14392-1-msuchanek@suse.de>
In-Reply-To: <20230718165848.14392-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jul 2023 22:38:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmhksytuzeQ-swyvb3RDqsHy54NNUJjzRnAmA3d17BLQ@mail.gmail.com>
Message-ID: <CAK7LNASmhksytuzeQ-swyvb3RDqsHy54NNUJjzRnAmA3d17BLQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: Hack for depmod not handling X.Y versions"
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
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

On Wed, Jul 19, 2023 at 1:58=E2=80=AFAM Michal Suchanek <msuchanek@suse.de>=
 wrote:
>
> Remove hack for ancient version of module-init-tools that was added in
> Linux 3.0.
>
> Since then module-init-tools was replaced with kmod.
>
> This hack adds an additional indirection, and causes confusing errors
> to be printed when depmod fails.
>
> Reverts commit 8fc62e594253 ("kbuild: Do not write to builddir in modules=
_install")
> Reverts commit bfe5424a8b31 ("kbuild: Hack for depmod not handling X.Y ve=
rsions")
>
> Link: https://lore.kernel.org/linux-modules/CAK7LNAQMs3QBYfWcLkmOQdbbq7cj=
=3D7wWbK=3DAWhdTC2rAsKHXzQ@mail.gmail.com/
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>


Applied to linux-kbuild.
Thanks.

> ---
>  scripts/depmod.sh | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
>
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..fca689ba4f21 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -23,33 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
>         exit 0
>  fi
>
> -# older versions of depmod require the version string to start with thre=
e
> -# numbers, so we cheat with a symlink here
> -depmod_hack_needed=3Dtrue
> -tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> -if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -       if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -               -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin";=
 then
> -               depmod_hack_needed=3Dfalse
> -       fi
> -fi
> -rm -rf "$tmp_dir"
> -if $depmod_hack_needed; then
> -       symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> -       ln -s "$KERNELRELEASE" "$symlink"
> -       KERNELRELEASE=3D99.98.$KERNELRELEASE
> -fi
> -
>  set -- -ae -F System.map
>  if test -n "$INSTALL_MOD_PATH"; then
>         set -- "$@" -b "$INSTALL_MOD_PATH"
>  fi
> -"$DEPMOD" "$@" "$KERNELRELEASE"
> -ret=3D$?
> -
> -if $depmod_hack_needed; then
> -       rm -f "$symlink"
> -fi
> -
> -exit $ret
> +exec "$DEPMOD" "$@" "$KERNELRELEASE"
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
