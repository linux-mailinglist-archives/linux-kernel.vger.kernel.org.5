Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CD79916E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbjIHVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:17:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5CE46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:17:48 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so1467344241.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694207867; x=1694812667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnJ9NkW8BTRsxIdMlLXJ5rwc8+Tbh47+Ek7xSWs8OfM=;
        b=OilBPMwBnD6CB8x3GiL/W35O4gGGJfOjL0P/jVrOFGwKuPieMQgKVmCVi8XJYVqihu
         heJKjoBKW9Ale7th/QQ/JogSPFuCMrUFpgje9MLHVldC1t5O+6eot6Bx4HRzrqcPPYEF
         Tq20AruRm70MC2Ed9fKTbQP4TLaDKsJ3Z4Bb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694207867; x=1694812667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnJ9NkW8BTRsxIdMlLXJ5rwc8+Tbh47+Ek7xSWs8OfM=;
        b=t8cjyTfCCwFfLU9eg1FtMARuMjFv04uCrifC9fMPaPffg1N9jHsK4RtcLL22cUIiJB
         gkLFW6SJZj1tvbavMTbCrCOcLQXACnvppnJCyhYqHXEeuJBV3FjCWD+mVFs7q9BKALBH
         t/qHhgnFVg6d1YTHZBXfGrQRsAOYi6FOP3a/XGzpOevixIOQekOAvwqQG4hG6GcdFWJq
         +QJyvvdT3RJ47N2uVONgGITI8xmvIOtueTPuqJmopg9FvKSWqlJh6a57paALIn0CjceU
         fKsaZJYWleAbfzLoOiDf0IwnjRtA1/2LqcEGkUOLxB/089PjU/2svvXVf7VkDnd3m0C4
         J56g==
X-Gm-Message-State: AOJu0Yx3QHW2THgfJ6dH3/hx1SMdL6HP4XETUtY908X9HuxGHZH8O+/D
        prJJXx+ZoeJ8Nk0vi/pTF1V+v3iONJUZDdz3DIY=
X-Google-Smtp-Source: AGHT+IEHEwPzBdtwepGeogFu99LoSk5QNnT5mo3cjRawSi79JIybh+mmAHBPuEcooIo8xd1mMFpsrw==
X-Received: by 2002:a1f:ff07:0:b0:495:c8bb:f0f8 with SMTP id p7-20020a1fff07000000b00495c8bbf0f8mr929792vki.3.1694207867146;
        Fri, 08 Sep 2023 14:17:47 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id h17-20020ac5cbd1000000b00486549ecdfcsm485686vkn.40.2023.09.08.14.17.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 14:17:46 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-49441300156so1118462e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:17:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4012:b0:64b:926a:e7fc with SMTP id
 kd18-20020a056214401200b0064b926ae7fcmr9448898qvb.21.1694207845301; Fri, 08
 Sep 2023 14:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org> <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 8 Sep 2023 23:17:11 +0200
X-Gmail-Original-Message-ID: <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
Message-ID: <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kexec: Fix kexec_file_load for llvm16 with PGO
To:     Song Liu <song@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song

On Fri, 8 Sept 2023 at 01:08, Song Liu <song@kernel.org> wrote:
>
> Hi Ricardo and folks,
>
> On Fri, May 19, 2023 at 7:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > When upreving llvm I realised that kexec stopped working on my test
> > platform.
> >
> > The reason seems to be that due to PGO there are multiple .text section=
s
> > on the purgatory, and kexec does not supports that.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> We are seeing WARNINGs like the following while kexec'ing a PGO and
> LTO enabled kernel:
>
> WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> kexec_load_purgatory+0x37f/0x390
>
> AFAICT, the warning was added by this set, and it was triggered when
> we have many .text sections
> in purgatory.ro. The kexec was actually successful. So I wonder
> whether we really need the
> WARNING here. If we disable LTO (PGO is still enabled), we don't see
> the WARNING any more.
>
> I also tested an older kernel (5.19 based), where we also see many
> .text sections with LTO. It
> kexec()'ed fine. (It doesn't have the WARN_ON() in
> kexec_purgatory_setup_sechdrs).

You have been "lucky" that the code has chosen the correct start
address, you need to modify the linker script of your kernel to
disable PGO.
You need to backport a patch like this:
https://lore.kernel.org/lkml/CAPhsuW5_qAvV0N3o+hOiAnb1=3DbuJ1pLzqYW9D+Bwft6=
hxJvAeQ@mail.gmail.com/T/#md68b7f832216b0c56bbec0c9b07332e180b9ba2b

(assuming x86)

Regards

>
> Please help us fix this properly (as I really don't know much about kexec=
).
>
> Thanks in advance,
> Song
>
>
> Here is readelf -S output on purgatory.ro.
>
> With LTO:
>
> readelf -W -S purgatory.ro
> There are 48 section headers, starting at offset 0x4a10:
>
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size
>  ES Flg Lk Inf Al
>   [ 0]                   NULL            0000000000000000 000000
> 000000 00      0   0  0
>   [ 1] .text             PROGBITS        0000000000000000 000040
> 0000d0 00  AX  0   0 16
>   [ 2] .data             PROGBITS        0000000000000000 001000
> 001000 00  WA  0   0 4096
>   [ 3] .rela.text        RELA            0000000000000000 003788
> 000228 18   I 45   1  8
>   [ 4] .rodata           PROGBITS        0000000000000000 002000
> 0000e0 00   A  0   0 16
>   [ 5] .rela.rodata      RELA            0000000000000000 0039b0
> 000030 18   I 45   4  8
>   [ 6] .bss              NOBITS          0000000000000000 0020e0
> 001000 00  WA  0   0 4096
>   [ 7] .text.purgatory   PROGBITS        0000000000000000 0020e0
> 0000df 00  AX  0   0 16
>   [ 8] .rela.text.purgatory RELA            0000000000000000 0039e0
> 000060 18   I 45   7  8
>   [ 9] .text.warn        PROGBITS        0000000000000000 0021c0
> 000001 00  AX  0   0 16
>   [10] .kexec-purgatory  PROGBITS        0000000000000000 0021d0
> 000120 00  WA  0   0 16
>   [11] .comment          PROGBITS        0000000000000000 003a40
> 000046 01  MS  0   0  1
>   [12] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 003a86
> 000005 00   E  0   0  1
>   [13] .text.sha256_update PROGBITS        0000000000000000 0022f0
> 0008eb 00  AX  0   0 16
>   [14] .rela.text.sha256_update RELA            0000000000000000
> 003a90 000060 18   I 45  13  8
>   [15] .text.sha224_update PROGBITS        0000000000000000 002be0
> 00000c 00  AX  0   0 16
>   [16] .rela.text.sha224_update RELA            0000000000000000
> 003af0 000018 18   I 45  15  8
>   [17] .text.sha256_final PROGBITS        0000000000000000 002bf0
> 0000cd 00  AX  0   0 16
>   [18] .rela.text.sha256_final RELA            0000000000000000 003b08
> 000030 18   I 45  17  8
>   [19] .text.sha224_final PROGBITS        0000000000000000 002cc0
> 0000bd 00  AX  0   0 16
>   [20] .rela.text.sha224_final RELA            0000000000000000 003b38
> 000030 18   I 45  19  8
>   [21] .text.sha256      PROGBITS        0000000000000000 002d80
> 00011d 00  AX  0   0 16
>   [22] .rela.text.sha256 RELA            0000000000000000 003b68
> 000030 18   I 45  21  8
>   [23] .modinfo          PROGBITS        0000000000000000 002e9d
> 000039 00   A  0   0  1
>   [24] .rodata.SHA256_K  PROGBITS        0000000000000000 002ee0
> 000100 00   A  0   0 16
>   [25] .rodata.__sha256_final.padding PROGBITS        0000000000000000
> 002fe0 000040 00   A  0   0 16
>   [26] .text.memcmp      PROGBITS        0000000000000000 003020
> 00000b 00  AX  0   0 16
>   [27] .text.bcmp        PROGBITS        0000000000000000 003030
> 00000b 00  AX  0   0 16
>   [28] .text.strcmp      PROGBITS        0000000000000000 003040
> 000041 00  AX  0   0 16
>   [29] .text.strncmp     PROGBITS        0000000000000000 003090
> 00003a 00  AX  0   0 16
>   [30] .text.strnlen     PROGBITS        0000000000000000 0030d0
> 000039 00  AX  0   0 16
>   [31] .text.atou        PROGBITS        0000000000000000 003110
> 000035 00  AX  0   0 16
>   [32] .text.simple_strtoull PROGBITS        0000000000000000 003150
> 0000b6 00  AX  0   0 16
>   [33] .text.simple_strtol PROGBITS        0000000000000000 003210
> 0001b6 00  AX  0   0 16
>   [34] .text.strlen      PROGBITS        0000000000000000 0033d0
> 00001c 00  AX  0   0 16
>   [35] .text.strstr      PROGBITS        0000000000000000 0033f0
> 00005f 00  AX  0   0 16
>   [36] .text.strchr      PROGBITS        0000000000000000 003450
> 000022 00  AX  0   0 16
>   [37] .text.kstrtoull   PROGBITS        0000000000000000 003480
> 000142 00  AX  0   0 16
>   [38] .text.boot_kstrtoul PROGBITS        0000000000000000 0035d0
> 00000c 00  AX  0   0 16
>   [39] .rela.text.boot_kstrtoul RELA            0000000000000000
> 003b98 000018 18   I 45  38  8
>   [40] .text.memset      PROGBITS        0000000000000000 0035e0
> 00001f 00  AX  0   0 16
>   [41] .text.memmove     PROGBITS        0000000000000000 003600
> 0000a6 00  AX  0   0 16
>   [42] .text.memcpy      PROGBITS        0000000000000000 0036b0
> 0000a6 00  AX  0   0 16
>   [43] .rodata.str1.1    PROGBITS        0000000000000000 003756
> 000032 01 AMS  0   0  1
>   [44] .note.GNU-stack   PROGBITS        0000000000000000 003bb0
> 000000 00      0   0  1
>   [45] .symtab           SYMTAB          0000000000000000 003bb0
> 000948 18     47  68  8
>   [46] .shstrtab         STRTAB          0000000000000000 0044f8
> 0002cd 00      0   0  1
>   [47] .strtab           STRTAB          0000000000000000 0047c5
> 000248 00      0   0  1
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
>   L (link order), O (extra OS processing required), G (group), T (TLS),
>   C (compressed), x (unknown), o (OS specific), E (exclude),
>   l (large), p (processor specific)
>
>
> Without LTO:
>
> readelf -W -S purgatory.ro
> There are 16 section headers, starting at offset 0x4130:
>
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size
>  ES Flg Lk Inf Al
>   [ 0]                   NULL            0000000000000000 000000
> 000000 00      0   0  0
>   [ 1] .text             PROGBITS        0000000000000000 000040
> 00131b 00  AX  0   0 16
>   [ 2] .rela.text        RELA            0000000000000000 003290
> 000480 18   I 13   1  8
>   [ 3] .kexec-purgatory  PROGBITS        0000000000000000 001360
> 000120 00  WA  0   0 16
>   [ 4] .comment          PROGBITS        0000000000000000 003710
> 000046 01  MS  0   0  1
>   [ 5] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 003756
> 000005 00   E  0   0  1
>   [ 6] .data             PROGBITS        0000000000000000 002000
> 001000 00  WA  0   0 4096
>   [ 7] .rodata           PROGBITS        0000000000000000 003000
> 000220 00   A  0   0 16
>   [ 8] .rela.rodata      RELA            0000000000000000 003760
> 000030 18   I 13   7  8
>   [ 9] .bss              NOBITS          0000000000000000 003220
> 001000 00  WA  0   0 4096
>   [10] .modinfo          PROGBITS        0000000000000000 003220
> 000039 00   A  0   0  1
>   [11] .rodata.str1.1    PROGBITS        0000000000000000 003259
> 000032 01 AMS  0   0  1
>   [12] .note.GNU-stack   PROGBITS        0000000000000000 003790
> 000000 00      0   0  1
>   [13] .symtab           SYMTAB          0000000000000000 003790
> 0006d8 18     15  43  8
>   [14] .shstrtab         STRTAB          0000000000000000 003e68
> 00009c 00      0   0  1
>   [15] .strtab           STRTAB          0000000000000000 003f04
> 00022b 00      0   0  1
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
>   L (link order), O (extra OS processing required), G (group), T (TLS),
>   C (compressed), x (unknown), o (OS specific), E (exclude),
>   l (large), p (processor specific)
>
> [...]
>
> > Ricardo Ribalda (4):
> >       kexec: Support purgatories with .text.hot sections
> >       x86/purgatory: Remove PGO flags
> >       powerpc/purgatory: Remove PGO flags
> >       riscv/purgatory: Remove PGO flags
> >
> >  arch/powerpc/purgatory/Makefile |  5 +++++
> >  arch/riscv/purgatory/Makefile   |  5 +++++
> >  arch/x86/purgatory/Makefile     |  5 +++++
> >  kernel/kexec_file.c             | 14 +++++++++++++-
> >  4 files changed, 28 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> > change-id: 20230321-kexec_clang16-4510c23d129c
> >
> > Best regards,
> > --
> > Ricardo Ribalda Delgado <ribalda@chromium.org>
> >



--=20
Ricardo Ribalda
