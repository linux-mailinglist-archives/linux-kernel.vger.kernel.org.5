Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E187D41FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjJWVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:54:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432FBD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:54:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cd566d8dfso107051cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698098096; x=1698702896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5LWS4K5/4iKfNn5YiAzdNMefXt8v/R2dnYlMsD5khk=;
        b=XPBu+AVYy0i7WYJ6aLG/hqwrWSyLlpJKuVXtH44VmBFKck9oy3cGZQ7gCChnxhefpR
         tI0usAvdRT0xIRZ5rqYe085QlgGRf/hY7RQU9VVqnixEB5Q/dg4gk+nQRZE4EZuXcxPH
         6LwT0rrbMXHOdzZ9HLX8386s6GyYNcOpQRnUTAaoG4NRekhG2oamwCS3YLQAXldvCppM
         UcC9QXZUOAfHDfNAQTdpgrSuLY2RyZhM0JEd2j0sxlQUym1bI2p3HZ7F8Qfto4zL6xxu
         kCzAie/BFqD2IRwk1TpSKRmkr+wjqViDgcUuCqkx2uFv5U17W+jqsF22BgENNWruYL+4
         /gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698098096; x=1698702896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5LWS4K5/4iKfNn5YiAzdNMefXt8v/R2dnYlMsD5khk=;
        b=V722CgmTr6BRliGBkLU/VO99MobAOJOX5zRZSrCF0/uCtxYp9oOywy+nBhnk4QaNxk
         t4p+WpPt3OXkz/ClHsOJj5ISEOqGnh6dearqlf5afEei9Jji01ZdPqLT9y6P8OWcpouc
         rUNftxYxlghLGLrTmqjeCRV7ky4bM1m/mzBThvQPOO9eAGt5MJBJDkm8nETkAWfXOXla
         I/RyHIDFq/kAU8xVF10s3HN8aM4sq3ZwevcDuxjCVL+LJ3qrDb2u67aQSIefhugt5t0H
         NLzNUN8Xmz6fNoJa6TLWtqpYnRCnHbGc8bJZnxsSjx/gaICzTc/Pyv7+jZ1Vy78LOWwJ
         CCTQ==
X-Gm-Message-State: AOJu0Yya5lHnBrcbQSbQ48/xrV6wgUfrIXdbPN3DlNR1nbKWgFzAwt4R
        RDAg+TFnsXoQ6dH+cJNJOpdQn1gQqlIB9BXIrSJpAw==
X-Google-Smtp-Source: AGHT+IE2D+QLdS8YjjqB+PJOwtagyXlMsmDom9XQlRavmOeQBvXuC7m/nzHYgfableqs7DnMwXJVVHEPALVV0vUc6AU=
X-Received: by 2002:a05:622a:2282:b0:41e:29ad:8b8b with SMTP id
 ay2-20020a05622a228200b0041e29ad8b8bmr15969qtb.10.1698098095867; Mon, 23 Oct
 2023 14:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231023023121.1464544-1-jsperbeck@google.com> <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
In-Reply-To: <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Mon, 23 Oct 2023 14:54:43 -0700
Message-ID: <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>,
        linux-kernel@vger.kernel.org
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

On Sun, Oct 22, 2023 at 7:42=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 22, 2023 7:31:21 PM PDT, John Sperbeck <jsperbeck@google.com> =
wrote:
> >The physical memory range that kexec selects for the compressed
> >bzimage target kernel, might not be where it runs from.  The
> >startup_64() code in head_64.S copies itself out of the way
> >before the decompression so it doesn't clobber itself.
> >
> >If the start of the memory range selected by kexec is above
> >LOAD_PHYSICAL_ADDR (0x01000000 by default), then the copy remains
> >within the memory area.  But if the start is below this range,
> >then the copy will likely end up outside the range.
> >
> >Usually, this will be harmless because not much memory is in use
> >at the time of the pre-decompression copy, so there is little
> >to accidentally clobber.  However, an unlucky choice for the
> >adress of the kernel and the initrd could put the initrd in harm's
> >way.  For example:
> >
> >    0x00400000 - physical address for target kernel
> >    0x03ff8000 - physical address of seven-page initrd
> >    0x0302c000 - size of uncompressed kernel (about 50 Mbytes)
> >
> >The decompressed kernel will span 0x01000000 through 0x0402c000,
> >which will overwrite the initrd.
> >
> >If the kexec code restricts itself to physical addresses above
> >0x01000000, then the pre-decompression copy and the decompression
> >itself will stay within the bounds of the memory kexec selected
> >(unless a non-default value is used in the target kernel for
> >CONFIG_PHYSICAL_START, which will change LOAD_PHYSICAL_ADDR,
> >but that's probably unsolvable unless the target kernel were to
> >somehow communicate this to kexec).
> >
> >Signed-off-by: John Sperbeck <jsperbeck@google.com>
> >---
> > arch/x86/kernel/kexec-bzimage64.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-b=
zimage64.c
> >index a61c12c01270..d6bf6c13dab1 100644
> >--- a/arch/x86/kernel/kexec-bzimage64.c
> >+++ b/arch/x86/kernel/kexec-bzimage64.c
> >@@ -36,7 +36,7 @@
> >  */
> > #define MIN_PURGATORY_ADDR    0x3000
> > #define MIN_BOOTPARAM_ADDR    0x3000
> >-#define MIN_KERNEL_LOAD_ADDR  0x100000
> >+#define MIN_KERNEL_LOAD_ADDR  0x1000000
> > #define MIN_INITRD_LOAD_ADDR  0x1000000
> >
> > /*
>
> This doesn't make any sense to me. There is already a high water mark for=
 his much memory the kernel needs until an initrd or setup_data item can ap=
pear. This is just a hack, please fix it properly.

The startup_64() code in head_64.S changes behavior based on whether
it's running below or above LOAD_PHYSICAL_ADDR:

#ifdef CONFIG_RELOCATABLE
        leaq    startup_32(%rip) /* - $startup_32 */, %rbp
        movl    BP_kernel_alignment(%rsi), %eax
        decl    %eax
        addq    %rax, %rbp
        notq    %rax
        andq    %rax, %rbp
        cmpq    $LOAD_PHYSICAL_ADDR, %rbp
        jae     1f
#endif
        movq    $LOAD_PHYSICAL_ADDR, %rbp
1:

In my example, we were running from address 0x00400000.  The %rbp
register will start with 0x00400000, but will be changed to 0x01000000
after the check against LOAD_PHYSICAL_ADDR fails.

The 0x01000000 value in %rbp is passed to extract_kernel as the
'output' argument.  Unless choose_random_location() decides
differently, this will be where the kernel is decompressed to.  The
size of the kernel is large enough in my example that the
decompression overruns the initrd.

If the startup_64() code didn't have the LOAD_PHYSICAL_ADDR check and
used %rpb as is, then there would be no issue.  The decompression
would have been to 0x00400000 and would have completed before reaching
the initrd memory.

That is, the kexec code is being careful to ensure that the kernel and
initrd memory doesn't overlap, but isn't paying attention to what
happens if the kernel memory is below LOAD_PHYSICAL_ADDR (the kernel
address is effectively changed to a different location).  My proposed
change makes it aware, and avoids such addresses.
