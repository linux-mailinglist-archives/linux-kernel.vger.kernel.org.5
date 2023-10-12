Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261E37C655D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbjJLGVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjJLGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A5A9;
        Wed, 11 Oct 2023 23:21:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACFC433CD;
        Thu, 12 Oct 2023 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697091678;
        bh=s6uI62kWxpmT9BzfhoB8YxDyPpu+xLr4/ShPg1QpyT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WiQIwlhLS8bXp+msMDt6HtWr1T26tfn4w3fKoqOTiDGPR/X8vhmm3wd70eY2PB8eE
         VP2mSP3WUhhNXGnIo64r9818i2nZmyfYofFj6Y+8f/M04/zD+x90U/8EtFjzgzw1LH
         P4nak5HtVqyUQrH9ejeW5JaFpcilPfuCmRR4x4MlyPyv0Jp//XlSYYw0WXlFnh02tJ
         CgSCT2TXndecohYXZhukflQAu3v9m9YFGXM8FpROy4zQpaT/qDNr76/3ynKtZZgOoD
         VNRzW6Dfj2oB4meKo10yzt9RFfc50NjE8uXis0VEAmKjcsWFQxRU9i82uCetg2zv7J
         UNFWPaJyJ8AFQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so1040160a12.2;
        Wed, 11 Oct 2023 23:21:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YyBMStWlXIb2R8B5+bi7pB0Bp8Pg1zZovC1Ma1P/1/jPXU3Z+DA
        Ly7VQsMTU+yguhn5mxKz/K7HAB3BJMrNtSiRQU4=
X-Google-Smtp-Source: AGHT+IHeMn2bhCQxI8gRyeIl8+tWDbyaP2jvXgPlujPGin+1NpHfgUxHO4agK11Du8XZxDTGmxOPLejydycJpfSqufI=
X-Received: by 2002:a05:6402:27ca:b0:53e:197d:a4d with SMTP id
 c10-20020a05640227ca00b0053e197d0a4dmr350877ede.4.1697091677060; Wed, 11 Oct
 2023 23:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-4-masahiroy@kernel.org> <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
 <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
In-Reply-To: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 12 Oct 2023 14:21:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS8Gi+gSPhQcpNj2Yjjr0DZLtOy8S18Am8KtCqRbBLRhw@mail.gmail.com>
Message-ID: <CAJF2gTS8Gi+gSPhQcpNj2Yjjr0DZLtOy8S18Am8KtCqRbBLRhw@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
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

On Wed, Oct 11, 2023 at 8:53=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Oct 11, 2023 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrot=
e:
> >
> > On Mon, Oct 9, 2023 at 8:42=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
>
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -131,12 +131,6 @@ endif
> > >  libs-y +=3D arch/riscv/lib/
> > >  libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub=
/lib.a
> > >
> > > -PHONY +=3D vdso_install
> > > -vdso_install:
> > > -       $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> > > -       $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
> > > -               $(build)=3Darch/riscv/kernel/compat_vdso compat_$@)
> > > -
> > >  ifeq ($(KBUILD_EXTMOD),)
> > >  ifeq ($(CONFIG_MMU),y)
> > >  prepare: vdso_prepare
> > > @@ -148,6 +142,9 @@ vdso_prepare: prepare0
> > >  endif
> > >  endif
> > >
> > > +vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.d=
bg
> > > +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/co=
mpat_vdso.so.dbg:../compat_vdso/compat_vdso.so
> > Why do we need ":../compat_vdso/compat_vdso.so" here?
>
>
>
>
> All architectures except riscv install vdso files
> to /lib/modules/$(uname -r)/vdso/.
>
>
>
> See the following code in arch/riscv/kernel/compat_vdso/Makefile:
>
>
> quiet_cmd_compat_vdso_install =3D INSTALL $@
>       cmd_compat_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/compat_vdso/=
$@
>
>
>
>
> Riscv copies the compat vdso to
> /lib/modules/$(uname -r)/compat_vdso/.
>
>
>
> This commit preserves the current installation path as-is.
>
> If the riscv maintainers agree, we can change the
> installation destination to /lib/modules/$(uname -r)/vdso/
> for consistency.
Yes, but it should be another patch. Thx for the clarification.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
 Guo Ren
