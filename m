Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04445771512
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHFMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D48124;
        Sun,  6 Aug 2023 05:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600B4610D5;
        Sun,  6 Aug 2023 12:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE092C4339A;
        Sun,  6 Aug 2023 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691325655;
        bh=nFD7z3c13NvSK1tSfJL2f3eMNutGbhDjiU3cgo+Y5oo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IO2oJBX6fwJLrc50nMXI++iSmix7tqD7GnAj/m5VTrgOPixrlMJ5x7QcwUZ6jv6Xs
         3PLe/6+v6ZNgyWvsePCWSWz2Vxvg9EggO/zhSG0RDe/MO49p3j7gBo5zNHmiBR+8MU
         zNlNer4aEoN7XIhMQ2szELQwzPNhHTcM3BCSTpAMLReY4s9NejkErQxYWyF74MCfjJ
         ZDSjNhl3wAAVsvQ12HJEu85C5RDbCczFO0LZ5/rZo4WaFoFCrHaPQ9LDiQoJ3miHBp
         BFR2JfDM7C4s/2s4i7y0n4iNfvzg/AyIeTtO0yLaudYYzEDSbDrL/gn0fiFD7gacnG
         V0IIykJB0rk8g==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a3df1ee4a3so2006184b6e.3;
        Sun, 06 Aug 2023 05:40:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDRIPfwO4JwdSPlKgse48eFUM2E7kKa4KsBOr8rZJ82wAsCQ3o
        QNN+OhmPhzVcBhsqVtioCYNaeM0X7G+o5hC2tZo=
X-Google-Smtp-Source: AGHT+IGECC3WwLCbh/4btLngvNb293Va8WRKjDpuT4+YY474LsINtVefC2rYRorCpFghi2Glsk6bb5FbAtTZ9/M3pq4=
X-Received: by 2002:a05:6808:918:b0:3a7:4161:44ee with SMTP id
 w24-20020a056808091800b003a7416144eemr5064315oih.6.1691325654832; Sun, 06 Aug
 2023 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802051500.13271-1-rdunlap@infradead.org>
In-Reply-To: <20230802051500.13271-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Aug 2023 21:40:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV8va+4JeYHOxZFh_dLgXAfP1wRVoEqUJ_Uuhj=SKnGg@mail.gmail.com>
Message-ID: <CAK7LNARV8va+4JeYHOxZFh_dLgXAfP1wRVoEqUJ_Uuhj=SKnGg@mail.gmail.com>
Subject: Re: [PATCH v5] um/drivers: fix hostaudio build errors
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:15=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Use "select" to ensure that the required kconfig symbols are set
> as expected.
> Drop HOSTAUDIO since it is now equivalent to UML_SOUND.
>
> Set CONFIG_SOUND=3Dm in ARCH=3Dum defconfig files to maintain the
> status quo of the default configs.
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



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada
