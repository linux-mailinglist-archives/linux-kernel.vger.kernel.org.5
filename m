Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAD79A3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjIKG5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIKG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E710C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694415418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oihrCx/51GvIUOiskZZtCUX0GlK6XGu37mMY6acgYXU=;
        b=WXoZPiSzoCInnog8LpjmD5whInnQPS23UEsHqQveQ4TtnWRk9rr1ZvGqaicc1z5EClpweP
        zrd418gXgspA8243YqCBflnPkFZNtbwVJ4ZEc4+IrOjxEuxP91xlLcV1VSS8RnrBBXsipM
        RLKUWKAR+HZ5Zin47L1vQS8EZvMqFNI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--8rUhatYOKqld6eVqco11w-1; Mon, 11 Sep 2023 02:56:55 -0400
X-MC-Unique: -8rUhatYOKqld6eVqco11w-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-794e7c8ed47so96191239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415414; x=1695020214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oihrCx/51GvIUOiskZZtCUX0GlK6XGu37mMY6acgYXU=;
        b=ryEfQaJiSHV43z5gPQQAUVjxUWe1I4RyvGUot4mH+yQ1KimIBpH6byN04qwCx2shSd
         CJ5YvnPNR0Kn+rFPZ8KWmmGfbAXkg4vSXQ3eLvJvR4ygW5TsJCQumC9hfU01ytGc/g4h
         WV0vdvQDx0Lbfokq+GxM87ZgMqPWilsY5dNUcYO+gBv4m0HfGX9D5Z4yRxzhAhygeMGj
         rkfll5oS7YYTFkHnRlMpPC7UuhW6V1GB8iTQm9aO60lmIc8NKtH3MU63nkl9UeCXK89r
         pxaCnWgfoyJCcnOxf3zIej6KkIRXZfYZpHFFs4Zn7aOz1w98W/Pk+VEBmJxJP5UsX4OF
         FDzg==
X-Gm-Message-State: AOJu0Yw+HnAAaB5FxhFaxVI06V74jYvTAPqlBRX2uPCt29X/FXgr/FLU
        WoEBCPLJoHuDvvQ97MvxDQhe2XRHVfcpYdiiKdGEnLV6SCRpgUQ4IaKf/PKRiGBw6A2TkLE6SVY
        SewXwukPULx05EAyDh/w1+vuZqs93X+7kT+1Whwl/
X-Received: by 2002:a92:c087:0:b0:34f:36ae:e8d2 with SMTP id h7-20020a92c087000000b0034f36aee8d2mr9317088ile.3.1694415414285;
        Sun, 10 Sep 2023 23:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWzVZx4uLY0ZXfBjH7yOsx9fXZt5AC5zvCsH+DVV/WR5BNmh5v2LMfTp2OSLT8oU4BVVDpgnUtvHz5cjmj/5k=
X-Received: by 2002:a92:c087:0:b0:34f:36ae:e8d2 with SMTP id
 h7-20020a92c087000000b0034f36aee8d2mr9317077ile.3.1694415413992; Sun, 10 Sep
 2023 23:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230829114816.GA508985@ziqianlu-dell> <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell> <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell> <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell> <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook> <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
In-Reply-To: <20230909113209.actnan6hczrclz2d@box.shutemov.name>
From:   Dave Young <dyoung@redhat.com>
Date:   Mon, 11 Sep 2023 22:56:36 +0800
Message-ID: <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec list in cc

On Sat, 9 Sept 2023 at 19:34, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Sep 08, 2023 at 06:17:53PM +0200, Ard Biesheuvel wrote:
> > On Fri, Sep 8, 2023 at 5:58=E2=80=AFPM Kees Cook <keescook@chromium.org=
> wrote:
> > >
> > > On Fri, Sep 08, 2023 at 03:32:33PM +0300, Kirill A. Shutemov wrote:
> > > > On Fri, Sep 08, 2023 at 02:02:30PM +0800, Aaron Lu wrote:
> > > > > On Thu, Sep 07, 2023 at 04:14:09PM +0300, Kirill A. Shutemov wrot=
e:
> > > > > > On Tue, Aug 29, 2023 at 10:04:51PM +0800, Aaron Lu wrote:
> > > > > > > > Could you show dmesg of the first kernel before kexec?
> > > > > > >
> > > > > > > Attached.
> > > > > > >
> > > > > > > BTW, kexec is invoked like this:
> > > > > > > kver=3D6.4.0-rc5-00009-g75d090fd167a
> > > > > > > kdir=3D$HOME/kernels/$kver
> > > > > > > sudo kexec -l $kdir/vmlinuz-$kver --initrd=3D$kdir/initramfs-=
$kver.img --append=3D"root=3DUUID=3D4381321e-e01e-455a-9d46-5e8c4c5b2d02 ro=
 net.ifnames=3D0 acpi_rsdp=3D0x728e8014 no_hash_pointers sched_verbose seli=
nux=3D0"
> > > > > >
> > > > > > I don't understand why it happens.
> > > > > >
> > > > > > Could you check if this patch changes anything:
> > > > > >
> > > > > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/co=
mpressed/misc.c
> > > > > > index 94b7abcf624b..172c476ff6f3 100644
> > > > > > --- a/arch/x86/boot/compressed/misc.c
> > > > > > +++ b/arch/x86/boot/compressed/misc.c
> > > > > > @@ -456,10 +456,12 @@ asmlinkage __visible void *extract_kernel=
(void *rmode, memptr heap,
> > > > > >
> > > > > >   debug_putstr("\nDecompressing Linux... ");
> > > > > >
> > > > > > +#if 0
> > > > > >   if (init_unaccepted_memory()) {
> > > > > >           debug_putstr("Accepting memory... ");
> > > > > >           accept_memory(__pa(output), __pa(output) + needed_siz=
e);
> > > > > >   }
> > > > > > +#endif
> > > > > >
> > > > > >   __decompress(input_data, input_len, NULL, NULL, output, outpu=
t_len,
> > > > > >                   NULL, error);
> > > > > > --
> > > > >
> > > > > It solved the problem.
> > > >
> > > > Looks like increasing BOOT_INIT_PGT_SIZE fixes the issue. I don't y=
et
> > > > understand why and how unaccepted memory is involved. I will look m=
ore
> > > > into it.
> > > >
> > > > Enabling CONFIG_RANDOMIZE_BASE also makes the issue go away.
> > >
> > > Is this perhaps just luck? I.e. does is break ever on, say, 1000 boot
> > > attempts? (i.e. maybe some position is bad and KASLR happens to usual=
ly
> > > avoid it?)
>
> Yes, it can be luck.
>
> > > > Kees, maybe you have a clue?
> > >
> > > The only thing I can think of is that something isn't being counted
> > > correctly due to the size of code, and it just happens that this comm=
it
> > > makes the code large enough to exceed some set of mappings?
> > >
> > > >
> > > > diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boo=
t.h
> > > > index 9191280d9ea3..26ccce41d781 100644
> > > > --- a/arch/x86/include/asm/boot.h
> > > > +++ b/arch/x86/include/asm/boot.h
> > > > @@ -40,7 +40,7 @@
> > > >  #ifdef CONFIG_X86_64
> > > >  # define BOOT_STACK_SIZE     0x4000
> > > >
> > > > -# define BOOT_INIT_PGT_SIZE  (6*4096)
> > > > +# define BOOT_INIT_PGT_SIZE  (7*4096)
> > >
> > > That's why this might be working, for example? How large is the boot
> > > image before/after the commit, etc?
> > >
> >
> > Not sure why these changes would make a difference here, but choking
> > on accept_memory() on a non-TDX suggests that init_unaccepted_memory()
> > is poking into unmapped memory before it even decides that the
> > unaccepted memory does not exist.
> >
> > init_unaccepted_memory() has
> >
> >         ret =3D efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_tab=
le_len);
> >         if (ret) {
> >                 warn("EFI config table not found.");
> >                 return false;
> >         }
> >
> > which looks for <guid, phys_addr> tuples in an array pointed to by the
> > EFI system table, and if either of those is not mapped, things can be
> > expected to explode.
> >
> > The only odd thing there is that this code is invoked after setting up
> > the 'demand paging' logic in the decompressor.
> >
> > If you haven't yet, could you please retry the kexec boot with
> > earlyprintk=3Dtty<insert your UART params here>?
>
> early console in extract_kernel
> input_data: 0x000000807eb433a8
> input_len: 0x0000000000d26271
> output: 0x000000807b000000
> output_len: 0x0000000004800c10
> kernel_total_size: 0x0000000003e28000
> needed_size: 0x0000000004a00000
> trampoline_32bit: 0x000000000009d000
>
> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_m=
ap_64.c!?
> pages->pgt_buf_offset: 0x0000000000006000
> pages->pgt_buf_size: 0x0000000000006000
>
>
> Error: kernel_ident_mapping_init() failed
>
> It crashes on #PF due to stbl->nr_tables dereference in
> efi_get_conf_table() called from init_unaccepted_memory().
>
> I don't see anything special about stbl location: 0x775d6018.
>
> One other bit of information: disabling 5-level paging also helps the
> issue.
>
> I will debug further.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

