Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1525576B2DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHALPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjHALPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B82130;
        Tue,  1 Aug 2023 04:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92426150F;
        Tue,  1 Aug 2023 11:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26363C433C8;
        Tue,  1 Aug 2023 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690888334;
        bh=6xJnLUEmWli4Sg8BYYDGqHkD7X50qXBRRg+P9oWfxWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=asbgjVRS2F6cxeU6FpNpzuvI2yKFsTmlqCuN+fPpeeGw9irwpfreYYqWEEu/cQnP0
         TavALPyqD+f4VoyPf4uMpD/D18ACRo8x2zvgb9l/dF1r4onQZNGKPBZudy91m61rUu
         QQERZJTyfmPkCG6m0C0/BacDvJBSg5+S1vmk/k2vvRoPMCceCqxDGNHe838KrAlsoT
         cbv1Z846wWXGaF7tknN2MF7ix82by8eo7yLMDpUJfGT8bKUgjahpBcoNAoqfirbGoT
         19YBqcddzYGF9PG+lvcmCKa52DJL751lML2vx3O3vPfVb/w8ulZb52UludMZckO2z1
         EGoWD2T8cUOJA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bc9811558cso2361515a34.0;
        Tue, 01 Aug 2023 04:12:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLYrvJmUAsti2yqhpX1MowGnjWDnGOYvkXBx580j722e+E4GHME4
        iaZwegFaY7V4tBoQWnaJZcAqa8d3i0Ok9MmslH8=
X-Google-Smtp-Source: APBJJlF1fcfNFrXijDAvYYZT395hSxnCPp3oosdkuHMjDegV35uuSUXhfNO7tlSE+6JJf73ovDDmQVxKYs9kWwwefw0=
X-Received: by 2002:a05:6870:d784:b0:1bb:a3a8:c7c1 with SMTP id
 bd4-20020a056870d78400b001bba3a8c7c1mr12957380oab.24.1690888333460; Tue, 01
 Aug 2023 04:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230801020507.30392-1-rdunlap@infradead.org>
In-Reply-To: <20230801020507.30392-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Aug 2023 20:11:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBoE19Bipk3KT2z+bTEJ5Mkm3qNesa5U92k0N+a-NQ9A@mail.gmail.com>
Message-ID: <CAK7LNAQBoE19Bipk3KT2z+bTEJ5Mkm3qNesa5U92k0N+a-NQ9A@mail.gmail.com>
Subject: Re: [PATCH v4] um/drivers: fix hostaudio build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Tejun Heo <tj@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, alsa-devel@alsa-project.org
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

On Tue, Aug 1, 2023 at 11:05=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Use "select"s to ensure that the required kconfig symbols are set
> as expected.

Using plural, "select"s, sounds odd now.

Use "select" and "depends on" to ensure ...  ?




As I said in the previous email,
you need to add CONFIG_SOUND=3Dy
to arch/um/configs/{i386,x86_64}_defconfig,
otherwise CONFIG_UML_SOUND is hidden.





> Drop HOSTAUDIO since it is now equivalent to UML_SOUND.
>
> Allow SOUND with UML regardless of HAS_IOMEM. Otherwise there is a
> kconfig warning for unmet dependencies. (This was not an issue when
> SOUND was defined in arch/um/drivers/Kconfig. I have done 50 randconfig
> builds and didn't find any issues.)
>
> This fixes build errors when CONFIG_SOUND is not set:
>
> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_modu=
le':
> hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sou=
nd_mixer'
> ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregiste=
r_sound_dsp'
> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module'=
:
> hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_soun=
d_dsp'
> ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_=
sound_mixer'
> ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregiste=
r_sound_dsp'
>
> and this kconfig warning:
> WARNING: unmet direct dependencies detected for SOUND
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: d886e87cb82b ("sound: make OSS sound core optional")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202307141416.vxuRVpFv-lkp@intel.com
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> ---
> v2: don't delete the HOSTAUDIO Kconfig entry (Masahiro)
> v3: drop HOSTAUDIO and use CONFIG_UML_SOUND for it in Makefile (Takashi);
>     add SOUND depends on "|| UML" to HAS_IOMEM
> v4: use depends on instead of select for SOUND (Masahiro);
>     use Closes: instead of Link:
>
>  arch/um/drivers/Kconfig  |   16 +++-------------
>  arch/um/drivers/Makefile |    2 +-
>  sound/Kconfig            |    2 +-
>  3 files changed, 5 insertions(+), 15 deletions(-)
>
> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -111,24 +111,14 @@ config SSL_CHAN
>
>  config UML_SOUND
>         tristate "Sound support"
> +       depends on SOUND
> +       select SOUND_OSS_CORE
>         help
>           This option enables UML sound support.  If enabled, it will pul=
l in
> -         soundcore and the UML hostaudio relay, which acts as a intermed=
iary
> +         the UML hostaudio relay, which acts as a intermediary
>           between the host's dsp and mixer devices and the UML sound syst=
em.
>           It is safe to say 'Y' here.
>
> -config SOUND
> -       tristate
> -       default UML_SOUND
> -
> -config SOUND_OSS_CORE
> -       bool
> -       default UML_SOUND
> -
> -config HOSTAUDIO
> -       tristate
> -       default UML_SOUND
> -
>  endmenu
>
>  menu "UML Network Devices"
> diff -- a/sound/Kconfig b/sound/Kconfig
> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig SOUND
>         tristate "Sound card support"
> -       depends on HAS_IOMEM
> +       depends on HAS_IOMEM || UML
>         help
>           If you have a sound card in your computer, i.e. if it can say m=
ore
>           than an occasional beep, say Y.
> diff -- a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -54,7 +54,7 @@ obj-$(CONFIG_UML_NET) +=3D net.o
>  obj-$(CONFIG_MCONSOLE) +=3D mconsole.o
>  obj-$(CONFIG_MMAPPER) +=3D mmapper_kern.o
>  obj-$(CONFIG_BLK_DEV_UBD) +=3D ubd.o
> -obj-$(CONFIG_HOSTAUDIO) +=3D hostaudio.o
> +obj-$(CONFIG_UML_SOUND) +=3D hostaudio.o
>  obj-$(CONFIG_NULL_CHAN) +=3D null.o
>  obj-$(CONFIG_PORT_CHAN) +=3D port.o
>  obj-$(CONFIG_PTY_CHAN) +=3D pty.o



--=20
Best Regards
Masahiro Yamada
