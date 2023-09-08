Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056E7798A94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbjIHQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjIHQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:18:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA8B1739
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:18:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414c54b2551so303321cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694189884; x=1694794684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mPUcamzfc2K80JTRcSh37SDRo35tgdoJ7iQ161IJKQ=;
        b=tgrk09aR9Y/YC8cc0sTu0FfXTP87xjLUcmPLolH/wDCxFp5kPlSm8q08qxwtOc+rb7
         r6R2I4ERgrNSfXs2dB3/1SgxWvN2m4kxKyj/uKTvWQw/eM6FTLlYRJbNsEEB0KxxChm3
         Kja0G3aCAsrQf2VlV8z4WsP5V1tmyDBtjOHhunUFqok4twXLNtgUQnjs5yc/FbyrTjZM
         0iGAYAIK1kpu4dkXsgldNe0iagkoTwCncm/52kcqIFMWGIev+7Eqtcn4ELpHpgcNDAyo
         hQZSF9eE/Erlnaxp6Jw7SnNQdSloD6rNS1G1MH2Q0uRJGno+IRcbEYPLWvEtQ46QbG0n
         D5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694189884; x=1694794684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mPUcamzfc2K80JTRcSh37SDRo35tgdoJ7iQ161IJKQ=;
        b=ReXYKbpa+XtKFauzDX7YxjSmpjncjp7yq0tS2NCMZfz0xmoE5AXZ/7hwKLPCtsUJis
         9DWh2qN7aOnmWOia4yUR/kSyCVbt1+dwgYnsjkl4tJ5CZgElZj9KtL0lErm9cVn2u4Jy
         0RylY86696v1pw1AW8kpxOwk9RqMNW02dZhSFpyEx8VWFDOEUtki7vb7WkuFhiGNv1WN
         zu50nJ94n0uNKkKeHk9QCsIiKmmr8o6M8cjTv6MEz4CfVGnqNRgbvak2QdQ4kMDDHRdz
         8TbayEQzMVEKx7iDeK0q1+m4rIEHtCFXe2/XKBBW9bXIb44HkBKL65S9l+4+gDco+mmy
         tAFg==
X-Gm-Message-State: AOJu0YzGURLGgUs+p6qbLIDNwBWpPXxw+6M1pSdqxkPvBF71VA6hIkOQ
        R/o0g5qrXqYsFaE/qTPXiJHI5eE/nnic08SA64gmOA==
X-Google-Smtp-Source: AGHT+IHtLyt9dQcuUoOfYf1XNrLfr+Mr+5RBsmmaFIHjpge9TqIpMpMbRpg9LYwLrIjKFnT+OXss3NklaJ5bD0W+MUw=
X-Received: by 2002:a05:622a:148b:b0:405:47aa:7ffd with SMTP id
 t11-20020a05622a148b00b0040547aa7ffdmr220836qtx.19.1694189884551; Fri, 08 Sep
 2023 09:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230829114816.GA508985@ziqianlu-dell> <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell> <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell> <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell> <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
In-Reply-To: <202309080856.F066F92C98@keescook>
From:   Ard Biesheuvel <ardb@google.com>
Date:   Fri, 8 Sep 2023 18:17:53 +0200
Message-ID: <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
To:     Kees Cook <keescook@chromium.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 5:58=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Fri, Sep 08, 2023 at 03:32:33PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Sep 08, 2023 at 02:02:30PM +0800, Aaron Lu wrote:
> > > On Thu, Sep 07, 2023 at 04:14:09PM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > > > > > Could you show dmesg of the first kernel before kexec?
> > > > >
> > > > > Attached.
> > > > >
> > > > > BTW, kexec is invoked like this:
> > > > > kver=3D6.4.0-rc5-00009-g75d090fd167a
> > > > > kdir=3D$HOME/kernels/$kver
> > > > > sudo kexec -l $kdir/vmlinuz-$kver --initrd=3D$kdir/initramfs-$kve=
r.img --append=3D"root=3DUUID=3D4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro net=
.ifnames=3D0 acpi_rsdp=3D0x728e8014 no_hash_pointers sched_verbose selinux=
=3D0"
> > > >
> > > > I don't understand why it happens.
> > > >
> > > > Could you check if this patch changes anything:
> > > >
> > > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compre=
ssed/misc.c
> > > > index 94b7abcf624b..172c476ff6f3 100644
> > > > --- a/arch/x86/boot/compressed/misc.c
> > > > +++ b/arch/x86/boot/compressed/misc.c
> > > > @@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel(voi=
d *rmode, memptr heap,
> > > >
> > > >   debug_putstr("\nDecompressing Linux... ");
> > > >
> > > > +#if 0
> > > >   if (init_unaccepted_memory()) {
> > > >           debug_putstr("Accepting memory... ");
> > > >           accept_memory(__pa(output), __pa(output) + needed_size);
> > > >   }
> > > > +#endif
> > > >
> > > >   __decompress(input_data, input_len, NULL, NULL, output, output_le=
n,
> > > >                   NULL, error);
> > > > --
> > >
> > > It solved the problem.
> >
> > Looks like increasing BOOT_INIT_PGT_SIZE fixes the issue. I don't yet
> > understand why and how unaccepted memory is involved. I will look more
> > into it.
> >
> > Enabling CONFIG_RANDOMIZE_BASE also makes the issue go away.
>
> Is this perhaps just luck? I.e. does is break ever on, say, 1000 boot
> attempts? (i.e. maybe some position is bad and KASLR happens to usually
> avoid it?)
>
> > Kees, maybe you have a clue?
>
> The only thing I can think of is that something isn't being counted
> correctly due to the size of code, and it just happens that this commit
> makes the code large enough to exceed some set of mappings?
>
> >
> > diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> > index 9191280d9ea3..26ccce41d781 100644
> > --- a/arch/x86/include/asm/boot.h
> > +++ b/arch/x86/include/asm/boot.h
> > @@ -40,7 +40,7 @@
> >  #ifdef CONFIG_X86_64
> >  # define BOOT_STACK_SIZE     0x4000
> >
> > -# define BOOT_INIT_PGT_SIZE  (6*4096)
> > +# define BOOT_INIT_PGT_SIZE  (7*4096)
>
> That's why this might be working, for example? How large is the boot
> image before/after the commit, etc?
>

Not sure why these changes would make a difference here, but choking
on accept_memory() on a non-TDX suggests that init_unaccepted_memory()
is poking into unmapped memory before it even decides that the
unaccepted memory does not exist.

init_unaccepted_memory() has

        ret =3D efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_l=
en);
        if (ret) {
                warn("EFI config table not found.");
                return false;
        }

which looks for <guid, phys_addr> tuples in an array pointed to by the
EFI system table, and if either of those is not mapped, things can be
expected to explode.

The only odd thing there is that this code is invoked after setting up
the 'demand paging' logic in the decompressor.

If you haven't yet, could you please retry the kexec boot with
earlyprintk=3Dtty<insert your UART params here>?
