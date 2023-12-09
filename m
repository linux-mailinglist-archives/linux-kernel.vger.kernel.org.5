Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167080B626
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjLIUCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:02:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D5121
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:02:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587AAC433C8;
        Sat,  9 Dec 2023 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702152162;
        bh=jH9L5HvC+Ae62Fg3wZ8hVeCEhv1fJUiobgIHaIv4BOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WgNC7WlFXYNLYO/saHOXzg8UI1M5bFUo49UL16f2E9NupU5fJefAdxJdFsydfntNa
         GyBwcAE3ZDMNAD6yulE7N0GDFdEH29vAJvbMyUIpIsojhAUziVI2ylESnRNTWVyqGx
         3404ETsVF4Mr7SXXAFXz60qJ/pL5gQxN0jewHeKm9D3ryuxCrv77svOieKR8ymffPb
         FPlodUudZXol3gaoOyTs7GnyYzOpcZXQ6Da5TpNjUZS33paa/aeYvTrcdr3if4Nxw+
         rs85TVWRwdNw0Bi+xjuRiyNbuWWrvIFwRvqiJ8SLF+1qBsTmIe9nApoaCyrPEE4K7E
         2dd2GxTCMV1OA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9e1a3e3f0so1925542b6e.1;
        Sat, 09 Dec 2023 12:02:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzqxcR5gMZ3ANrKINwkIgZdm3gHVvbyJJz+xmo3e92dgRHSmgi1
        u9nshQP8ew6x9M75iy8CZ4rnzzOML74Y170LZTw=
X-Google-Smtp-Source: AGHT+IH8yO8a9hHWT4e+sLk+G0LWSOZK6PiqZI9fJF/nmSs3M/yqpFa1nUwdoV6kz4H7YBhhjTZ9rA9Z2EYcMHqfsfI=
X-Received: by 2002:a05:6870:d917:b0:1f9:496b:e261 with SMTP id
 gq23-20020a056870d91700b001f9496be261mr2820590oab.15.1702152161710; Sat, 09
 Dec 2023 12:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20231205104559.2017320-1-msp@baylibre.com>
In-Reply-To: <20231205104559.2017320-1-msp@baylibre.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Dec 2023 05:02:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxTsORzrQiZ4ywejqys8cWR81m_g1sgoyN4PA3dmQRYA@mail.gmail.com>
Message-ID: <CAK7LNARxTsORzrQiZ4ywejqys8cWR81m_g1sgoyN4PA3dmQRYA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Use KCONFIG_CONFIG instead of .config
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 5, 2023 at 7:46=E2=80=AFPM Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
>
> When using a custom location for kernel config files this merge config
> command fails as it doesn't use the configuration set with
> KCONFIG_CONFIG.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>

Applied to linux-kbuild.
Thanks.




> Notes:
>     Hi,
>
>     This patch helps me to merge_configs with config files that are not
>     .config (set by using KCONFIG_CONFIG=3D<PATH>). I am not sure if I br=
eak
>     something with that change.
>
>     I didn't add any stable kernels as this is a kernel config issue and =
no
>     bug in the kernel code itself.
>
>     Best,
>     Markus
>
>  scripts/kconfig/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 4eee155121a8..106159e75d40 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -99,7 +99,7 @@ config-fragments =3D $(call configfiles,$@)
>
>  %.config: $(obj)/conf
>         $(if $(config-fragments),, $(error $@ fragment does not exists on=
 this architecture))
> -       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m=
 .config $(config-fragments)
> +       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m=
 $(KCONFIG_CONFIG) $(config-fragments)
>         $(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
>  PHONY +=3D tinyconfig
> --
> 2.43.0
>
>


--=20
Best Regards
Masahiro Yamada
