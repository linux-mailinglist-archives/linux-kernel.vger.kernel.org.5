Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F537BE46D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376899AbjJIPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbjJIPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:17:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06768110;
        Mon,  9 Oct 2023 08:16:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C207C433C9;
        Mon,  9 Oct 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696864605;
        bh=gyjT+k3AHCiRmdkHp4cLqbLW9JDEEgp8ck+rIXkHvJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJGiEP+weJoUqeSv3oPzBGav0eFeFLFN82uF7EZyUcIhjA1EyjtYEuvkTlDrGhT0u
         /V6nqwJvEQiqK7quVzb9Mqx6BtYpts9uQj3DVjcVXHHivYIhQ8ORfVnqzTdkWRU/v3
         wRVA8NX3ZkKN/h5XCbjRIjaE1hm1JmzPLBMtM4y2Gk9/cEEB1mNGHUHod+l4SFMh87
         ENpghqeBL286Kg9eUYfedeZX8BZqcVmxCDaPAm36D7+yzAV2vClCWTidtcI5CjIMGr
         Iaf2JFtfAf0CPD/R07NCGZNx8VciV8lRbmV+YXEK/ywMrYBtVO7HWBOJg77NV1ICFl
         AhwayJmx43TWQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so8404436a12.3;
        Mon, 09 Oct 2023 08:16:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYwm5UTDUdaHvmaxjXROKTM1aYxYE+RYMGyfIO25emcCmkwrX1
        khn0NUbptVF5Mt3xvSctUQeuzukz0UYHY4vp4sk=
X-Google-Smtp-Source: AGHT+IGSLEtp8/ZbK1MsosRqbvxV8azkLSHz9Otz3nXZ+lvSbGwGVYiT2aLKFzSbqavypW8JCUPmWuuVmeizyQ6W5pM=
X-Received: by 2002:a05:6402:3445:b0:52f:a5d4:1f5b with SMTP id
 l5-20020a056402344500b0052fa5d41f5bmr12782747edc.9.1696864604058; Mon, 09 Oct
 2023 08:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 9 Oct 2023 23:16:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
Message-ID: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
Subject: Re: [PATCH 1/5] csky: remove unused cmd_vdso_install
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 8:42=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> You cannot run this code because arch/csky/Makefile does not define the
> vdso_install target.
>
> It appears that this code was blindly copied from another architecture.
Yes, I do that. Thx for pointing it out.

Acked-by: Guo Ren <guoren@kernel.org>

>
> Remove the dead code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/csky/kernel/vdso/Makefile | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makef=
ile
> index 299e4e41ebc5..ddf784a62c11 100644
> --- a/arch/csky/kernel/vdso/Makefile
> +++ b/arch/csky/kernel/vdso/Makefile
> @@ -58,13 +58,3 @@ quiet_cmd_vdsold =3D VDSOLD  $@
>  # that contains the same symbols at the same offsets.
>  quiet_cmd_so2s =3D SO2S    $@
>        cmd_so2s =3D $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
> -
> -# install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso.so: $(obj)/vdso.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso.so
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
