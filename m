Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844257CD003
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJQW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:26:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C346C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:26:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so10725716a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697581572; x=1698186372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp96MNyT4CvGx8BgoCKI8MBtXKv0iatQDCMkj4fahr4=;
        b=Hx7eH/HTwLgAJivKXA57u91p39mydnyegPlYukAdYqAb03sKMsfVXFodV9eiTTXaD8
         QV6d+A7rSluZXb/2pFiWe1e1uek96yNfSNvGSV0uLxZwfr82jT7mE9C1nt988lMXw9bz
         7PAIUFBkZi7a+H9zl9kC3sB7RXa0H3hiHZ/SWcLP/6S27G6Zv15fRDLE4adZzIaJMJXa
         8Lf+4tL0IQGrTtztBj9hhQviPZEgdbos55dZyRyS4uNuMsum5UG9sCaQ3DVnm96FY3U+
         3lpfP7NSKQLy5r1xL7WI6WdiY+YKL/LKDH0g2Ss+O/SiFwunEUY6MkfkFNo2JmkwBU4h
         fZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697581572; x=1698186372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp96MNyT4CvGx8BgoCKI8MBtXKv0iatQDCMkj4fahr4=;
        b=joGfnmfIVwdyHJqfzXWf5kSnpjJog+stRx0SC3xQYdOT+6eRvT9KsXEGZuAgbCftDd
         oHFOTWqXqqLpqu13cHmArwWfsd7vMSR93uXYl9aFYbFjQ6/hwCcYhijv6WTMqH9l8m82
         ioSTnOypYvZJW3Yp+gA0osqxHQ4fnkb9qiUDGNO1Fpk1DzQ69EE9FF3W7vr1JuF9Lnq/
         iEyYM0cX9mnd6qfnRXvUouWYi8OjaosmntHyOXcXjpNFvMoArqMbn7BZdtJM/kr1pAOF
         OZHz20x0b6OC9Nio9BATOJRojRee+IhyZP8Cown+rc6lC4UiCTWntqS9+EoGCrzuQeTx
         IATw==
X-Gm-Message-State: AOJu0Yxwz6QqT5A8X9fTWPrayCS5iNpYRRmfLo9MhewmG5nhU9Li/LpB
        GBNlOCmwchmaGG1kKf1KHaC6koPI4ZxXEJ038CIjew==
X-Google-Smtp-Source: AGHT+IHxsN+TQx6uE7iRVzZOAHEvWw5QYqXOgJqCk9dwzbCPQxD5DPQ90BNQqJihFCe+pa/1nlHu4axwP3EZDYkr+4w=
X-Received: by 2002:a17:907:84b:b0:9ad:ef31:6efc with SMTP id
 ww11-20020a170907084b00b009adef316efcmr2650933ejb.21.1697581572248; Tue, 17
 Oct 2023 15:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-6-axelrasmussen@google.com> <ZSMr2P031R6hbYCE@debian>
In-Reply-To: <ZSMr2P031R6hbYCE@debian>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 17 Oct 2023 15:25:36 -0700
Message-ID: <CAJHvVci_cj15C_8VqraO5f_LkZ6QuMf-2wohmzmH4QYtY2MSyA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 3:23=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi Axel,
>
> On Tue, Oct 03, 2023 at 12:45:47PM -0700, Axel Rasmussen wrote:
> > This is a new feature recently added to the kernel. So, document the ne=
w
> > ioctl the same way we do other UFFDIO_* ioctls.
> >
> > Also note the corresponding new ioctl flag we can return in reponse to =
a
> > UFFDIO_REGISTER call.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  man2/ioctl_userfaultfd.2 | 112 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > index 95d69f773..6b6980d4a 100644
> > --- a/man2/ioctl_userfaultfd.2
> > +++ b/man2/ioctl_userfaultfd.2
> > @@ -380,6 +380,11 @@ operation is supported.
> >  The
> >  .B UFFDIO_CONTINUE
> >  operation is supported.
> > +.TP
> > +.B 1 << _UFFDIO_POISON
> > +The
> > +.B UFFDIO_POISON
> > +operation is supported.
> >  .PP
> >  This
> >  .BR ioctl (2)
> > @@ -890,6 +895,113 @@ The faulting process has exited at the time of a
> >  .B UFFDIO_CONTINUE
> >  operation.
> >  .\"
> > +.SS UFFDIO_POISON
> > +(Since Linux 6.6.)
> > +Mark an address range as "poisoned".
> > +Future accesses to these addresses will raise a
> > +.B SIGBUS
> > +signal.
> > +Unlike
> > +.B MADV_HWPOISON
> > +this works by installing page table entries,
> > +rather than "really" poisoning the underlying physical pages.
> > +This means it only affects this particular address space.
> > +.PP
> > +The
> > +.I argp
> > +argument is a pointer to a
> > +.I uffdio_continue
> > +structure as shown below:
> > +.PP
> > +.in +4n
> > +.EX
> > +struct uffdio_poison {
> > +     struct uffdio_range range;
> > +                     /* Range to install poison PTE markers in */
> > +     __u64 mode;     /* Flags controlling the behavior of poison */
> > +     __s64 updated;  /* Number of bytes poisoned, or negated error */
> > +};
> > +.EE
> > +.in
> > +.PP
> > +The following value may be bitwise ORed in
> > +.I mode
> > +to change the behavior of the
> > +.B UFFDIO_POISON
> > +operation:
> > +.TP
> > +.B UFFDIO_POISON_MODE_DONTWAKE
> > +Do not wake up the thread that waits for page-fault resolution.
> > +.PP
> > +The
> > +.I updated
> > +field is used by the kernel
> > +to return the number of bytes that were actually poisoned,
> > +or an error in the same manner as
> > +.BR UFFDIO_COPY .
> > +If the value returned in the
> > +.I updated
> > +field doesn't match the value that was specified in
> > +.IR range.len ,
> > +the operation fails with the error
> > +.BR EAGAIN .
> > +The
> > +.I updated
> > +field is output-only;
> > +it is not read by the
> > +.B UFFDIO_POISON
> > +operation.
> > +.PP
> > +This
> > +.BR ioctl (2)
> > +operation returns 0 on success.
> > +In this case,
> > +the entire area was poisoned.
> > +On error, \-1 is returned and
> > +.I errno
> > +is set to indicate the error.
> > +Possible errors include:
> > +.TP
> > +.B EAGAIN
> > +The number of bytes mapped
> > +(i.e., the value returned in the
> > +.I updated
> > +field)
> > +does not equal the value that was specified in the
> > +.I range.len
> > +field.
> > +.TP
> > +.B EINVAL
> > +Either
> > +.I range.start
> > +or
> > +.I range.len
> > +was not a multiple of the system page size; or
> > +.I range.len
> > +was zero; or the range specified was invalid.
> > +.TP
> > +.B EINVAL
> > +An invalid bit was specified in the
> > +.I mode
> > +field.
> > +.TP
> > +.B EEXIST
>
> Any reasons for this order, or should we use alphabetic order?

This is the order the conditions are checked in code, but I agree
alphabetic order is better. :) I'll send a v3.

>
> Thanks,
> Alex
>
> > +One or more pages were already mapped in the given range.
> > +.TP
> > +.B ENOENT
> > +The faulting process has changed its virtual memory layout simultaneou=
sly with
> > +an outstanding
> > +.B UFFDIO_POISON
> > +operation.
> > +.TP
> > +.B ENOMEM
> > +Allocating memory for page table entries failed.
> > +.TP
> > +.B ESRCH
> > +The faulting process has exited at the time of a
> > +.B UFFDIO_POISON
> > +operation.
> > +.\"
> >  .SH RETURN VALUE
> >  See descriptions of the individual operations, above.
> >  .SH ERRORS
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
>
> --
> <https://www.alejandro-colomar.es/>
