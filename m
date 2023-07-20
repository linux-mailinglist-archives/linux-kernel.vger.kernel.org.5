Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1F75B706
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjGTSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E11734;
        Thu, 20 Jul 2023 11:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44AA61A40;
        Thu, 20 Jul 2023 18:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D0C433C8;
        Thu, 20 Jul 2023 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878552;
        bh=TC9hFAm5FzPCcTzlWemQuqEqyzdn/TZqli8KeGlTOnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VS9JzEixheRn2pvzsCNeL++0GU7/Qp/gr3+DB/z0qwjvYOfUdC6lguLE2U7FScTea
         fTwm4Wwh3CZRaqjNLo63K0F2BRox3n8aVEMWaUEoqfgtoqyjcXTxS6tTJqEyRdHhLF
         aupXayZlRqZIeCqtkwFVBhsu13fZZX5GarDtIUf6iAbN9Nme/hJsyTrrONQnpbmhL1
         B5FO9yBoevnrQil0Qow/GLlKQkaeSyfs4AeQKuF/iSx//5J8O9rYydrqp9fkd0GkQg
         A7/aarnhdqGKGyIQ+3wBtgTVlrwKSehQ/+U+t4cNQXolxnVbocHDT/tAHtQqajg6hS
         j8jSaH5vte5uA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a36b30aa7bso805856b6e.3;
        Thu, 20 Jul 2023 11:42:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLZz2S/ci0QKl53f1RoL+YGq/Bgy3z7wySJ57sADvRtJkLSAk6Ld
        hXF1QPIGCyaDIubRvl8GOSuSljrf1EKwnKnVpkI=
X-Google-Smtp-Source: APBJJlHUzB5ceURiJajwV2UnIytRYcNXW70aGyQ5ZWMD2up88148v10jxz3om0mzSyLqSTypmg/ifLCzWfpUNU6q6kE=
X-Received: by 2002:aca:1b02:0:b0:3a4:2c76:fedc with SMTP id
 b2-20020aca1b02000000b003a42c76fedcmr390792oib.1.1689878551372; Thu, 20 Jul
 2023 11:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-kbuild_rpm_dtbs-v1-1-99693e8faaaf@jannau.net>
In-Reply-To: <20230712-kbuild_rpm_dtbs-v1-1-99693e8faaaf@jannau.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 03:41:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASd9aCEJcAutVN+rPZKfbs28qayY2H-qO7KPu-kr_Q3QA@mail.gmail.com>
Message-ID: <CAK7LNASd9aCEJcAutVN+rPZKfbs28qayY2H-qO7KPu-kr_Q3QA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: Add dtbs support
To:     j@jannau.net
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 12, 2023 at 3:42=E2=80=AFPM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> Based on the dtbs support in builddeb. Both Fedora and openSUSE kernel
> rpm install their dtbs in "/boot/dtb-${KERNELRELEASE}". There seems no
> other popular rpm based distributions which would benefit from dtbs
> support and are not derived from those two.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  scripts/package/mkspec | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 8049f0e2c110..a170b0c0a93f 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -28,6 +28,14 @@ else
>         M=3DDEL
>  fi
>
> +# Only some architectures with OF support have the dtbs_install target
> +if grep -q CONFIG_OF_EARLY_FLATTREE=3Dy include/config/auto.conf && \
> +   [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
> +       D=3D
> +else
> +       D=3DDEL
> +fi

This is unneeded. See below.



> +
>  __KERNELRELEASE=3D$(echo $KERNELRELEASE | sed -e "s/-/_/g")
>  EXCLUDES=3D"$RCS_TAR_IGNORE --exclude=3D*vmlinux* --exclude=3D*.mod \
>  --exclude=3D*.o --exclude=3D*.ko --exclude=3D*.cmd --exclude=3DDocumenta=
tion \
> @@ -38,6 +46,8 @@ EXCLUDES=3D"$RCS_TAR_IGNORE --exclude=3D*vmlinux* --exc=
lude=3D*.mod \
>  # Labels:
>  #  $S: this line is enabled only when building source package
>  #  $M: this line is enabled only when CONFIG_MODULES is enabled
> +#  $D: this line is enabled only when CONFIG_OF_EARLY_FLATTREE is enable=
d and
> +#      the arch has a dts directory
>  sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>         Name: kernel
>         Summary: The Linux Kernel
> @@ -103,6 +113,7 @@ $S
>         %endif
>  $M     $MAKE %{?_smp_mflags} INSTALL_MOD_PATH=3D%{buildroot} modules_ins=
tall
>         $MAKE %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers=
_install
> +$D     $MAKE %{?_smp_mflags} INSTALL_DTBS_PATH=3D%{buildroot}/boot/dtb-$=
{KERNELRELEASE} dtbs_install



Like deb-pkg, you can check CONFIG_OF_EARLY_FLATTREE
while building the package instead of while creating the spec file.

 if grep -q CONFIG_OF_EARLY_FLATTREE=3Dy include/config/auto.conf; then
     $MAKE %{?_smp_mflags}
INSTALL_DTBS_PATH=3D%{buildroot}/boot/dtb-${KERNELRELEASE} dtbs_install
 fi

(please note it is untested)


The reason for $S and $M is because they determine
whether the kernel-devel package is needed.
But, I regret the implementation was too ugly.
I will clean up mkspec.
Please submit v2 after the code clean-up.



>         cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>         cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M   rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
>
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230712-kbuild_rpm_dtbs-d055a3780bbe
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>


--
Best Regards
Masahiro Yamada
