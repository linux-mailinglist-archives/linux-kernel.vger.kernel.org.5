Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C707D49E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjJXIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjJXIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA69109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698135717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9F/759QdJCkoh5wUbqRsVVyJH0HQU33MHabrg7gucw=;
        b=HIhMQioMxxhBitcGgKPcq/itZD9HDhUhvg0uaZcu/hms3uEaB0jdfb1ITznWTezoNhTZMb
        GAJeiT3kWuVPpeJ7VbTDemmvYTOFglKeaCfJ7jeBITlbhPUoQYW2eSw4LauzAh8VR8bbRn
        6Lk8pnPWBvuv8j4dCoTNVxJQvmyv+pM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-R_6h8aWIMmeAcYFGwUCuKw-1; Tue, 24 Oct 2023 04:21:55 -0400
X-MC-Unique: R_6h8aWIMmeAcYFGwUCuKw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7a681c87811so145872039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698135715; x=1698740515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9F/759QdJCkoh5wUbqRsVVyJH0HQU33MHabrg7gucw=;
        b=Uhit1izo3UvAWSWPAva5LN4TwaIXCrnLmxURTZxWBPtQbZInmAHWXulnCbyB5qDDbo
         Mup7PMsXgVMPDYS+olGfvIMrKQa9mWOUNv/ios2siAWWhdpB0pNIeA0wU6bhnW6WM+t9
         bUBX3leccQtW2tabEvBLg0PSA071t146OcFlbIgX+OsNmPUCC3koM/t2DVcr1TdXALSf
         8lFXuoH2xxEtgAYyyCpY3J1SpISza0Klmipm2WagrBMijKFiQn62PxAIG4jq44eo17KP
         vNDPSmbF2xVG4uXE+3uVFx3vYEqJbgAeaQYU0iVC8O/0bU0wivJoJGl7ZfYGOmwlHSR6
         eBpg==
X-Gm-Message-State: AOJu0Yy5MpSk3qLEXKYm2u1Cc1D6WyDJ43M7M+9lBwkpg+4Y+PK0WWPH
        bpOEp8nkrP/cuOWGuAz2m7LscRv4WZ3zyDPqS4m+Ae/6lMIdFKou8jfs2Ow2pcZM9JoV97DdOHf
        4MYJ56DvHuPjpQa1wVGiTU1ffRFQ7RA1w5/YBLjAE0JpuZ989oxROxw==
X-Received: by 2002:a05:6e02:340f:b0:357:a1e6:faa2 with SMTP id bo15-20020a056e02340f00b00357a1e6faa2mr9540747ilb.1.1698135714964;
        Tue, 24 Oct 2023 01:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs5j/Ki8ENVYMDh5TqMLyDGlGrcLuKR1wgMn33Mz/47/X53gsVLUWynC+Dmjci6LUeGL/EzY6bWxS8AZarSwI=
X-Received: by 2002:a05:6e02:340f:b0:357:a1e6:faa2 with SMTP id
 bo15-20020a056e02340f00b00357a1e6faa2mr9540735ilb.1.1698135714685; Tue, 24
 Oct 2023 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZRt2ToOHm2XT8MlU@desktop>
 <CAMj1kXH--86-pqHp6W0gsRDAMw-iuYKrgHEpmZzaJnpsVTkkxw@mail.gmail.com> <ZTau5kbdB-9iRfcm@desktop>
In-Reply-To: <ZTau5kbdB-9iRfcm@desktop>
From:   Dave Young <dyoung@redhat.com>
Date:   Tue, 24 Oct 2023 16:21:37 +0800
Message-ID: <CALu+AoQbBr0RyBG6JxyKO81Ur=0uG_FxZq3=-QYhF2OxV7+F7g@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 01:37, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> On 23 13:22:53, Ard Biesheuvel wrote:
> > On Tue, 3 Oct 2023 at 04:03, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> > >
> > > On 12 09:00:51, Ard Biesheuvel wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Now that the EFI stub boot flow no longer relies on memory that is
> > > > executable and writable at the same time, we can reorganize the PE/COFF
> > > > view of the kernel image and expose the decompressor binary's code and
> > > > r/o data as a .text section and data/bss as a .data section, using 4k
> > > > alignment and limited permissions.
> > > >
> > > > Doing so is necessary for compatibility with hardening measures that are
> > > > being rolled out on x86 PCs built to run Windows (i.e., the majority of
> > > > them). The EFI boot environment that the Linux EFI stub executes in is
> > > > especially sensitive to safety issues, given that a vulnerability in the
> > > > loader of one OS can be abused to attack another.
> > >
> > > This split is also useful for the work of kexecing the next kernel as an
> > > EFI application. With the current EFI stub I have to set the memory both
> > > writable and executable which results in W^X warnings with a default
> > > config.
> > >
> > > What made this more confusing was that the flags of the .text section in
> > > current EFI stub bzImages are set to
> > > IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_MEM_READ. So if you load that section
> > > according to those flags the EFI stub will quickly run into issues.
> > >
> > > I assume current firmware on x86 machines does not set any restricted
> > > permissions on the memory. Can someone enlighten me on their behavior?
> > >
> >
> > No current x86 firmware does not use restricted permissions at all.
> > All memory is mapped with both writable and executable permissions,
> > except maybe the stack.
> >
> > The x86 Linux kernel has been depending on this behavior too, up until
> > recently (fixes are in -rc now for the v6.6 release). Before this, it
> > would copy its own executable image around in memory.
> >
> > So EFI based kexec will need to support this behavior if it targets
> > older x86 kernels, although I am skeptical that this is a useful
> > design goal.
>
> I don't see this as an important goal either.
>
> > I have been experimenting with running the EFI stub code in user space
> > all the way until ExitBootServices(). The same might work for UKI if
> > it is layered cleanly on top of the EFI APIs (rather than poking into
> > system registers or page tables under the hood).
> >
> > How this would work with signed images etc is TBD but I quite like the
> > idea of running everything in user space and having a minimal
> > purgatory (or none at all) if we can simply populate the entire
> > address space while running unprivileged, and just branch to it in the
> > kexec() syscall. I imagine this being something like a userspace
> > helper that is signed/trusted itself, and gets invoked by the kernel
> > to run EFI images that are trusted and tagged as being executable
> > unprivileged.
>
> I've been experimenting with running EFI apps inside kernel space instead.
> This is the more natural approach for signed images. Sure, a malicious EFI
> app could do arbitrary stuff in kernel mode, but they're signed. On the other
> hand running this entirely in user space would at least guarantee that the
> system can not crash due to a misbehaving EFI app (at least until
> ExitBootServices()).
>
> The question of whether or not to make this the job of a userspace helper that
> is signed must have come up when kexec_file_load syscall was added. It would
> have also been an option at the time to extend trust to a signed version of
> the userspace kexec tool.
>
> Why was kexec_file_load created instead of restricting kexec_load to a signed
> version of the kexec userspace tool?

I think one of the reasons is that it is hard to handle dynamic linked
libraries, not only the kexec-tools binary.

Thanks
Dave

