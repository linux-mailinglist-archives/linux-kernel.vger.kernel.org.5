Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923A47A7C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjITMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjITMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:00:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DDDC;
        Wed, 20 Sep 2023 05:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E87C433D9;
        Wed, 20 Sep 2023 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211228;
        bh=7+a+uAHSC7OO3XQfH2arscb7AzKCNbmMMLk8wqn0vsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/lIJRSxCPB+5p7f3G1Ajfn2qqX/tE0cpwCITQxi+/PIchJFouA/fvycyzSAWEtoy
         vZVpjLxdrhYNzxEnVT5N44TE016Uwds4qfY6/G8FH7VA/xSu8CmUS5Q4Pk32GcdxR5
         M2eDlL0Ep5Y87U58MQPbFeiFp2MRl6z7XD3rsMV8w8TcyTdKXMTj4pNC122tvVu+Gw
         lZl0uPbzxG9mZ9BWHs0FD2QUlJpFht4AyWAtIGjlLJ89R7SIghY1RWIT4lXs8KgqIF
         OjkYqCfy27g/JS9U8ERwmQxXaxhphmjwYxJFNNV2jy5krHM33whRZcwa0hT8oS4SvT
         tUZbsMtPW1QQw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5731fe1d2bfso3560158eaf.3;
        Wed, 20 Sep 2023 05:00:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy9iNND5Cukoq8LXAl3/LkZ9A/J9gljVJ5QzFJLHvoWG4mfTwwe
        vbDz5zY5lFUmHtLC7VVZjRhT/YtUo3/tQlBAM0k=
X-Google-Smtp-Source: AGHT+IFacjCfE9QLw4t2LilDhTkbFLM6Ag1SJY8p8K1VUW2unuqEzeBOzExdeLRwU+74XE39uVC4FBrJVod9wxEl+p4=
X-Received: by 2002:a05:6871:291:b0:1bb:eb37:1d69 with SMTP id
 i17-20020a056871029100b001bbeb371d69mr2712706oae.14.1695211227907; Wed, 20
 Sep 2023 05:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230920015559.1877441-1-aik@amd.com>
In-Reply-To: <20230920015559.1877441-1-aik@amd.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 20 Sep 2023 20:59:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
Message-ID: <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
Subject: Re: [PATCH kernel] kbuild: get rid of unwanted "+" when
 CONFIG_LOCALVERSION is set
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Alexey Kardashevskiy <aik@amd.com>=
 wrote:
>
> The scripts/setlocalversion script correctly tries not adding "+" when
> CONFIG_LOCALVERSION is defined.

I am afraid you are misunderstanding the script.

CONFIG_LOCALVERSION and the "+" sign is unrelated.


> However, instead of grepping for it
> (as it is done for CONFIG_LOCALVERSION_AUTO=3Dy), it relies on LOCALVERSI=
ON
> set in the shell which is not.
>
> Export LOCALVERSION so scripts/setlocalversion could see it and not add
> unwanted "+" at the end of the kernelrelease.
>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>


So, scripts/setlocalversion will always see
defined LOCALVERSION.

With your patch, LOCALVERSION would be set to an empty value,
which would make the following condition always false.

elif [ "${LOCALVERSION+set}" !=3D "set" ]; then


Your patch is equivalent to deleting
line 175-183 of scripts/setlocalversion.

Of course, that is wrong and unacceptable.







> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 57698d048e2c..fc45bed69790 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -368,7 +368,7 @@ include $(srctree)/scripts/Kbuild.include
>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
>  KERNELRELEASE =3D $(call read-file, include/config/kernel.release)
>  KERNELVERSION =3D $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBL=
EVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> -export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> +export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION LOCALVERS=
ION
>
>  include $(srctree)/scripts/subarch.include
>
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
