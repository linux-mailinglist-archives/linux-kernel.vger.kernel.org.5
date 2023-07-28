Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E627667E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjG1Ixo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjG1IxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22A44BD;
        Fri, 28 Jul 2023 01:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0862762066;
        Fri, 28 Jul 2023 08:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6129DC433D9;
        Fri, 28 Jul 2023 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534325;
        bh=vlJpUCrv2ALxslQErLAhvVvaZrwz4OsGjEvmf2Y+iu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CBi6cn4Lj2WE+3ndu8ojTuLCbCpK7Pkmx9A6xtinX0HCBOZXhEZF98ugJzTOeLFAu
         +0XMAZNEYpti4YI8V6nchFBp+xpcfTWTHZps6mKo9/8VGwdADXksAATF9qh3LJsTTB
         /h1qfr19Z4W4JEDvguLAMduLZRTpPYOcqcmk0arqtOaHQwE4cvmDthraAt5bzOw9M1
         aVv1xh2gTuR7awDFF4SXPauublFBaHAFoLy+vhYC3DRRLSTVPs3IJz2RFLX2+HnKdc
         qKaF7MGOAQHIF057Hd7Wa1bbsBT16hXTF2FulnhU0N3iOGJXgPcvq03ROV6GFoLYK6
         tIfGzXbc2MbVA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a412653335so1461556b6e.1;
        Fri, 28 Jul 2023 01:52:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ64PSMxY91tVYIaDyhEm1HO01BrSBrR5J5KwrtXD/eyQ5qzMr4
        csBqHukhW9Fib/Z/EzuNXjHJF+xlRaunCNcTGg0=
X-Google-Smtp-Source: APBJJlHDe8hfWrxF/nfBaQSGuEQ6bNQXuA7hrJmGUDKgzOxljYyC1ls87OOK7YRy0OrT3TlhYCmy7eRtQ7kYiLbq06Q=
X-Received: by 2002:a54:400b:0:b0:3a3:ed22:6b51 with SMTP id
 x11-20020a54400b000000b003a3ed226b51mr2282641oie.50.1690534324598; Fri, 28
 Jul 2023 01:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230728043013.27776-1-rdunlap@infradead.org>
In-Reply-To: <20230728043013.27776-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Jul 2023 17:51:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
Message-ID: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:30=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Use "select"s to ensure that the required kconfig symbols are set
> as expected.
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
> Link: lore.kernel.org/r/202307141416.vxuRVpFv-lkp@intel.com
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
>
>  arch/um/drivers/Kconfig  |   14 ++------------
>  arch/um/drivers/Makefile |    2 +-
>  sound/Kconfig            |    2 +-
>  3 files changed, 4 insertions(+), 14 deletions(-)
>
> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -111,24 +111,14 @@ config SSL_CHAN
>
>  config UML_SOUND
>         tristate "Sound support"
> +       select SOUND


This would be the only instance that select's SOUND.
Perhaps, this could be 'depends on SOUND'.
(in that case, arch/um/configs/*_defconfig needs modification).

Just my two cents.


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>








--=20
Best Regards
Masahiro Yamada
