Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2D75DFFC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 07:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGWFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWFRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 01:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8B1729;
        Sat, 22 Jul 2023 22:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D478E60C2D;
        Sun, 23 Jul 2023 05:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC3C433CA;
        Sun, 23 Jul 2023 05:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690089435;
        bh=vY3zNiZph0FPTgkavHQidnVxVAFy5p+UdrH06drBU+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p9qL+IKIRulGqw9cN1IuDyeAN9+OnG+wIcxYq47SgU74c/+wmxKFJ5UTuYZItypom
         oTIWwh/7p2uhuKfN/6Rr7H5+wMod1ubgZOE6saO0JZYLncfXTqThYSTqNC67EGaP1Y
         LCpgfPJYpI72gXbJJpiIbhxnVyR9wpjXPJfRHOSx0lj3QpvyZLXXLWq78ib9cUjWHA
         y7CJOMBsdibcUeOXo0NcWSjd+/x1nDIR6g1PPghF1e467/S16HTJoiKIAOJPlQj6yD
         L3L0HB9eGXIkF12seVYyUT50i/u6W3eRG4Zhqe30NNyt4DsytTJ5q7srFpIjW/fh9g
         pAC40EwKbx5KA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-55e04a83465so2075548eaf.3;
        Sat, 22 Jul 2023 22:17:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLZEMQ8sFt4IKase6P3ZPFzlf1rTIfV2iPAHBpeYZacBBxUxpng8
        iyXdqf3ytCc65DGZox9wWZ7xnbPOJ0RSaSsCkgU=
X-Google-Smtp-Source: APBJJlGYYAujjAjTIpMk4wamTm8HUwIM2sfuCn7LDBIQfhMB3gIz6tuqw/zXHC9zy9YdIwYukciDEhv1Th3vTRMMlss=
X-Received: by 2002:a4a:868c:0:b0:566:ef1e:f11c with SMTP id
 x12-20020a4a868c000000b00566ef1ef11cmr4008103ooh.3.1690089434511; Sat, 22 Jul
 2023 22:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230722202548.24746-1-rdunlap@infradead.org>
In-Reply-To: <20230722202548.24746-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jul 2023 14:16:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8R3Kzvu6Fvn3RkspgR2EkSmt9EzLOqsaOiq1=-S8eVw@mail.gmail.com>
Message-ID: <CAK7LNAS8R3Kzvu6Fvn3RkspgR2EkSmt9EzLOqsaOiq1=-S8eVw@mail.gmail.com>
Subject: Re: [PATCH] um/drivers: Kconfig: fix hostaudio build errors
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
        linux-kbuild@vger.kernel.org
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

On Sun, Jul 23, 2023 at 5:25=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Use "select"s to ensure that the required kconfig symbols are set
> as expected.
>
> This fixes build errors when CONFIG_SOUND is not set.
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
> ---
>  arch/um/drivers/Kconfig |   15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -111,24 +111,15 @@ config SSL_CHAN
>
>  config UML_SOUND
>         tristate "Sound support"
> +       select SOUND
> +       select SOUND_OSS_CORE
> +       select HOSTAUDIO
>         help
>           This option enables UML sound support.  If enabled, it will pul=
l in
>           soundcore and the UML hostaudio relay, which acts as a intermed=
iary
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

Yeah, these two should be removed
because they exist in sound/Kconfig.


> -
> -config HOSTAUDIO
> -       tristate
> -       default UML_SOUND


You need to keep this, otherwise
there is no entry anywhere.




> -
>  endmenu
>
>  menu "UML Network Devices"



--
Best Regards
Masahiro Yamada
