Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A678F965
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbjIAH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjIAH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36410D5;
        Fri,  1 Sep 2023 00:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31EE1619C0;
        Fri,  1 Sep 2023 07:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938B1C433CB;
        Fri,  1 Sep 2023 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693555154;
        bh=GYFYHNBwiYIMyxXYhNMZBkYnxr8aCSZaJphpVUbR/gI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AaRktxRVhEkyJ9abOTUx7V1990sLCQZsTcFUleQ9gIPImVoGeS5XT88pEptizfQDW
         nHQgbPUErQ/EtGTelQCn2JhACffAb906a3fJ4in3B4pCmK6qM0io61lBIOnhXZ01m0
         H5w1WWX4mbREPA9UDC2fe+zlPL9TSAvCy5V5R8UagFmSy8vYheYL0hPJCXf5I91b7T
         TooNiVCUoUTRJvGRT3I4IL6EjI/AcDVnd0G4O3HqcJT1EWm5mQPzH+sLC+Ivo0edUD
         zFOJ+InUvPaokhPEzGYCjmb5rvDpXKLESGTzYoF9j92Jto02sA1aNf4Ycj8NwKOsMP
         OOd4SSi9NU49A==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-565f2567422so1029779eaf.2;
        Fri, 01 Sep 2023 00:59:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHxt8pryf/b0cpE2pc/Q6Inko8eAZKEnCyticjoXT1niukTkrK
        Hg1jnAwhmzV2gV96VeErkN+8mvvNTzpeyzQW+Mo=
X-Google-Smtp-Source: AGHT+IHWr1PcUpOyQTzQJYAg/TVFLv3Ywby9u7RUE31cJ6C0yBF+em+y7ml6sODmNo5t9DAFJN+2Shqq08kJwtSujfQ=
X-Received: by 2002:a4a:919c:0:b0:56e:4921:deb0 with SMTP id
 d28-20020a4a919c000000b0056e4921deb0mr1662294ooh.8.1693555153843; Fri, 01 Sep
 2023 00:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230831191335.give.534-kees@kernel.org>
In-Reply-To: <20230831191335.give.534-kees@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Sep 2023 16:58:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATENQQy6LrWS10S-EXsyAvTraSj2WA=O7rFsS9Ht6a+3g@mail.gmail.com>
Message-ID: <CAK7LNATENQQy6LrWS10S-EXsyAvTraSj2WA=O7rFsS9Ht6a+3g@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Show marked Kconfig fragments in "help"
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Fri, Sep 1, 2023 at 4:13=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Currently the Kconfig fragments in kernel/configs and arch/*/configs
> that aren't used internally aren't discoverable through "make help",
> which consists of hard-coded lists of config fragments. Instead, list
> all the fragment targets that have a "# Help: " comment prefix so the
> targets can be generated dynamically.
>
> Add logic to the Makefile to search for and display the fragment and
> comment. Add comments to fragments that are intended to be direct targets=
.
>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> v3:
> - Use Makefile logic from Masahiro Yamada
> - Use "# Help: " prefix, but only on desired fragment targets
> v2: https://lore.kernel.org/all/20230825194329.gonna.911-kees@kernel.org
> v1: https://lore.kernel.org/all/20230824223606.never.762-kees@kernel.org
> ---
>  Makefile                                   |  1 -
>  arch/arm/configs/dram_0x00000000.config    |  1 +
>  arch/arm/configs/dram_0xc0000000.config    |  1 +
>  arch/arm/configs/dram_0xd0000000.config    |  1 +
>  arch/arm/configs/lpae.config               |  1 +
>  arch/arm64/configs/virt.config             |  1 +
>  arch/powerpc/configs/disable-werror.config |  1 +
>  arch/powerpc/configs/security.config       |  4 +++-
>  arch/riscv/configs/32-bit.config           |  1 +
>  arch/riscv/configs/64-bit.config           |  1 +
>  arch/s390/configs/btf.config               |  1 +
>  arch/s390/configs/kasan.config             |  1 +
>  arch/x86/Makefile                          |  4 ----
>  kernel/configs/debug.config                |  2 ++
>  kernel/configs/kvm_guest.config            |  1 +
>  kernel/configs/nopm.config                 |  2 ++
>  kernel/configs/rust.config                 |  1 +
>  kernel/configs/tiny.config                 |  2 ++
>  kernel/configs/x86_debug.config            |  1 +
>  kernel/configs/xen.config                  |  2 ++
>  scripts/kconfig/Makefile                   | 15 ++++++++++++---
>  21 files changed, 36 insertions(+), 9 deletions(-)
>


Just one thing.





> diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
> index 00009f7d0835..60a4b6d80b36 100644
> --- a/kernel/configs/tiny.config
> +++ b/kernel/configs/tiny.config
> @@ -1,3 +1,5 @@
> +# Help: Size-optimized kernel image


I will drop this.


We already have a hard-coded help message.

  tinyconfig   - Configure the tiniest possible kernel




Then, some lines below, again.

  tiny.config               - Size-optimized kernel image



tiny.config is for internal use for tinyconfig.




--=20
Best Regards
Masahiro Yamada
