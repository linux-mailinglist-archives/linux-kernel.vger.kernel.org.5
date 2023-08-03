Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2776E024
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHCGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjHCGYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C0272C;
        Wed,  2 Aug 2023 23:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B04A61BCB;
        Thu,  3 Aug 2023 06:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7002C433C7;
        Thu,  3 Aug 2023 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691043833;
        bh=c0JHcFWSrvgrEKbKHMqRatXBy4xurhcTfvhzOa3/rMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LhJ4s0mBnqlUpKTpz/ZfiLWMAjkBfJivhO78YYpjvpp98K/7XaxMJ22R5MjmUxYiY
         DnF7xEnVJ5JgVMMSDmPTwgljaEs0+Fm7gfXFUWsft+g60DivdUP2JdCYomlhxFQ7ku
         hbtzC2txmSbDwvz2x1eaHIfPE14coONsAPoPgS/W7cDYmjow6py2tn5E2i1ajDM7gG
         XQvW6Y2e0miNnZ4zGuXmSSzUlecDaXKwCQDfruoTosK2GYmRFoBSBPWb0eovodb4Nm
         U6MFoAkDJUsi4pN7PkcsVLMMPD07P4csc0kr5mbE9OdamDbZacBOe+yQgmViU0hAB9
         /F6ir3ZcA37VA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso408017fac.3;
        Wed, 02 Aug 2023 23:23:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy/g9OIKeiqX4GbX5dAiI7bK1sE8KM2HI5T2J3PPQvZifb1OjLg
        RPyZX2bSAeAIMCgvxoDd7xJ1jI4cRUO4bT0oDhw=
X-Google-Smtp-Source: APBJJlHZISAIW58S4+F0CHFF+rfZwlOud1fMZQMIsCAoK6tWr6hhNrVRwg0zBE6v1lrQ2I6RwEDqVDogSJMiuviPelI=
X-Received: by 2002:a05:6871:89f:b0:1bf:61d1:a4d4 with SMTP id
 r31-20020a056871089f00b001bf61d1a4d4mr3405692oaq.6.1691043833000; Wed, 02 Aug
 2023 23:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230801174922.333700-1-bmasney@redhat.com> <20230801174922.333700-3-bmasney@redhat.com>
In-Reply-To: <20230801174922.333700-3-bmasney@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Aug 2023 15:23:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-nhy1_xFYiwuvOKvfUVSjvnEb4ZnJ8EMWo7uJun89Zg@mail.gmail.com>
Message-ID: <CAK7LNAQ-nhy1_xFYiwuvOKvfUVSjvnEb4ZnJ8EMWo7uJun89Zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] scripts: add kconfig lookup script
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:49=E2=80=AFAM Brian Masney <bmasney@redhat.com> wr=
ote:
>
> Add a script that allows looking up the full Kconfig entry based on
> the symbol name. Documentation and example usage is found at the top
> of the script itself.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  scripts/kconfig/lookup.sh | 77 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100755 scripts/kconfig/lookup.sh



Everyone tends to have their own utility scripts
on their machines.

I think this patch set falls into that category
as "create a wrapper script of grep" is what everyone
does to reduce typing.




FWIW, I have the following scripts in my ~/bin directory.



$ cat ~/bin/kgrep
#!/bin/sh

exec find . -name .repo -prune -o -name .git -prune -o -type f \
\( -name 'Kconfig*' -o -name 'Config.in' \) \
-print0 | xargs -0 grep --color -n "$@"


$ cat ~/bin/mgrep
#!/bin/sh

exec find . -name .repo -prune -o -name .git -prune -o -type f \
\( -name 'Makefile*' -o -name 'Kbuild*' -o -name "*.mk" \) \
-print0 | xargs -0 grep --color -n "$@"




masahiro@zoe:~/ref/linux(master)$ kgrep -A5 TSL2772
./drivers/iio/light/Kconfig:564:config TSL2772
./drivers/iio/light/Kconfig-565- tristate "TAOS TSL/TMD2x71 and
TSL/TMD2x72 Family of light and proximity sensors"
./drivers/iio/light/Kconfig-566- depends on I2C
./drivers/iio/light/Kconfig-567- help
./drivers/iio/light/Kconfig-568-   Support for: tsl2571, tsl2671,
tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
./drivers/iio/light/Kconfig-569-   tmd2672, tsl2772, tmd2772 devices.

masahiro@zoe:~/ref/linux(master)$ mgrep efivarfs.o
./fs/efivarfs/Makefile:6:obj-$(CONFIG_EFIVAR_FS) +=3D efivarfs.o
./fs/efivarfs/Makefile:8:efivarfs-objs :=3D inode.o file.o super.o vars.o



That's my local way to satisfy my demand.
I do not intend to force my way or merge it in the upstream.










>
> diff --git a/scripts/kconfig/lookup.sh b/scripts/kconfig/lookup.sh
> new file mode 100755
> index 000000000000..d1ff52b23835
> --- /dev/null
> +++ b/scripts/kconfig/lookup.sh
> @@ -0,0 +1,77 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
> +# Written by Brian Masney <bmasney@redhat.com>
> +#
> +# This script takes as input one or more Kconfig symbols and outputs the=
 full
> +# entry from the Kconfig file. It can be invoked by reading a list of sy=
mbol
> +# names from either stdin or as command line arguments. Example output:
> +#
> +#   x1:~/src/linux$ ./scripts/kconfig/lookup.sh TSL2772 SOUND
> +#   # drivers/iio/light/Kconfig
> +#   config TSL2772
> +#     tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and pro=
ximity sensors"
> +#     depends on I2C
> +#     help
> +#       Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl257=
2, tsl2672,
> +#       tmd2672, tsl2772, tmd2772 devices.
> +#       Provides iio_events and direct access via sysfs.
> +#
> +#   # arch/um/drivers/Kconfig
> +#   config SOUND
> +#     tristate
> +#     default UML_SOUND
> +#
> +#   # sound/Kconfig
> +#   menuconfig SOUND
> +#     tristate "Sound card support"
> +#     depends on HAS_IOMEM
> +#     help
> +#       If you have a sound card in your computer, i.e. if it can say mo=
re
> +#       than an occasional beep, say Y.
> +
> +
> +process_kconfig()
> +{
> +       KCONFIG=3D"${1/CONFIG_/}"
> +
> +       FOUND=3D0
> +       for KCONFIG_FILE in $(git grep -E "^(config|menuconfig) ${KCONFIG=
}$" | \
> +                             awk -F: '{print $1}') ; do
> +               echo "# ${KCONFIG_FILE}"
> +               awk "/^(config|menuconfig) ${KCONFIG}$/{ m=3D1; print; ne=
xt; } \
> +                    /^(choice|comment|config|end|if|menuconfig|source)/ =
{ m=3D0; } m" \
> +                   "${KCONFIG_FILE}"
> +               FOUND=3D1
> +       done
> +
> +       if [[ "${FOUND}" =3D "0" ]] ; then
> +               echo "Skipping ${KCONFIG} since Kconfig symbol is not fou=
nd" >&2
> +               return 1
> +       fi
> +
> +}
> +
> +# Run this script from the toplevel kernel source directory.
> +SCRIPT_PATH=3D$(readlink -f "$0")
> +cd "$(dirname "${SCRIPT_PATH}")/../.." || exit 1
> +
> +RET=3D0
> +if [[ $# =3D=3D 0 ]] ; then
> +       # Read Kconfig names from stdin
> +       while read -r KCONFIG ; do
> +               if ! process_kconfig "${KCONFIG}" ; then
> +                       RET=3D1
> +               fi
> +       done
> +else
> +       # Read Kconfig names from the command line arguments
> +       for NUM in $(seq 1 "$#") ; do
> +               if ! process_kconfig "${!NUM}" ; then
> +                       RET=3D1
> +               fi
> +       done
> +fi
> +
> +exit "${RET}"
> --
> 2.41.0
>


--
Best Regards

Masahiro Yamada
