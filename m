Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19E17C545D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjJKMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjJKMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:53:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1D9D;
        Wed, 11 Oct 2023 05:53:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F85C433CC;
        Wed, 11 Oct 2023 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697028802;
        bh=BAn9cTmPCgYcwvId5a7izdOqRdwYY/SugU+kfhYDqmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ckftw/lZlJbPMA/dzRJmM/VrLm2xFZ2zbn7DGTxWiomWSOVP6zZhFIJ2BNZzOzfmi
         WNdYzaNnpb0li5MHShlQK3oR77qATwhquIfYtbS2qcxouWrx/tYNXq544lAjKFQDpA
         Vz9LMECi3pswPXznVM4zmgrfwP36gbWZmEY2zgeCDANjr1COzuPDnQPEfA7i1xQ8p8
         bSEXGRHusQV4L7Fpb8YmVEuiGDQpTc2IAutv3bYkXEraZvYfx3GpqleFpTlduIcfsH
         rSwOf/YNc5EZyzIbjBjWlirtlOXEah9MWUIUlTA8o9qnOzmXTT7DWL5nce0eSzTi43
         DQnyck+GuK7pA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1e9872c88aaso587888fac.1;
        Wed, 11 Oct 2023 05:53:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHOHJUfFReogwm/1+towp+E2ZY+EngBesVYO8udKmEpgd7SVBF
        9AvlR7IXBlVApKiAYmvNE3FwDb1vuk/XJEI8g18=
X-Google-Smtp-Source: AGHT+IHunqCCf3/TPbLbNP9iC+WACbBVYbi8Ckvhhj1/4uAEKkWSBuHMfzGgLhnmZ11rboJKnGC/Z4MWi+rIZcz3AOo=
X-Received: by 2002:a05:6870:5611:b0:1d1:3a58:14a5 with SMTP id
 m17-20020a056870561100b001d13a5814a5mr26035580oao.25.1697028802212; Wed, 11
 Oct 2023 05:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-4-masahiroy@kernel.org> <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
In-Reply-To: <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Oct 2023 21:52:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
Message-ID: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
To:     Guo Ren <guoren@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 9, 2023 at 8:42=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:

> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -131,12 +131,6 @@ endif
> >  libs-y +=3D arch/riscv/lib/
> >  libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> >
> > -PHONY +=3D vdso_install
> > -vdso_install:
> > -       $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> > -       $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
> > -               $(build)=3Darch/riscv/kernel/compat_vdso compat_$@)
> > -
> >  ifeq ($(KBUILD_EXTMOD),)
> >  ifeq ($(CONFIG_MMU),y)
> >  prepare: vdso_prepare
> > @@ -148,6 +142,9 @@ vdso_prepare: prepare0
> >  endif
> >  endif
> >
> > +vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.dbg
> > +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/comp=
at_vdso.so.dbg:../compat_vdso/compat_vdso.so
> Why do we need ":../compat_vdso/compat_vdso.so" here?




All architectures except riscv install vdso files
to /lib/modules/$(uname -r)/vdso/.



See the following code in arch/riscv/kernel/compat_vdso/Makefile:


quiet_cmd_compat_vdso_install =3D INSTALL $@
      cmd_compat_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/compat_vdso/$@




Riscv copies the compat vdso to
/lib/modules/$(uname -r)/compat_vdso/.



This commit preserves the current installation path as-is.

If the riscv maintainers agree, we can change the
installation destination to /lib/modules/$(uname -r)/vdso/
for consistency.



--=20
Best Regards
Masahiro Yamada
