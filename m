Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D77B8DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbjJDUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbjJDUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:22:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C0DD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:22:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so289839a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696450943; x=1697055743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mbt0TmvMuhni3vtowqeLm74FeVQbN/EJlrFIRwD6Dg=;
        b=LTaVvTcgi7bM1Xt5KBlNW0tlYzK/nfQcGgk8Ejh/Zllug3boa2aDmpLnjAuZuyVmRI
         H5LBAYFkrgA8Yju2sq8za7Q+DzTuAFJSaobX8e2AKSlTVYqyYcmiDmchktEjPg8GN7MB
         bmpOKhlLe/X304bGxilDCGAB66THJeh34TvVFcaHq+qQUTwrhegO14cqIMq1DSZm/tBV
         JwPaEF6f/CWqYfvgokjGCZQwXuLtw0qQqNW1/bDQMZw3bCyiBmVj8UXyRLtksMBkcrmi
         KMGyxgp08aZNLSzKO3tatVoASdBXNuo9uEAMjnIjXLm5aJI19W6lfmi65Jtua+m/kEBT
         6O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450943; x=1697055743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mbt0TmvMuhni3vtowqeLm74FeVQbN/EJlrFIRwD6Dg=;
        b=ERvE9DRaH+UeRi+OlSqoEI8jLzvlEvqHMkxLvqnSaWoyIXsJB1gCR3+/NcV45AhXPo
         o0fV/ClkgVk5xTulEjItXNDD1iqxI2fPi/+xQoKXVw6TUVPLR7kzCoJ30FTqNra8olyN
         FD324By8TuCcTWi7GP4ExhNXd3ySiGW0KATn10Fw4M+MrHEBmv1MIBDXoaRUn5PFels3
         DtbtE+36LSKGUO2G8qyTI4HOyNEThtBChYExhBXUzDksXRf+iIhfqB4NlRVW2RXoq/nO
         KYAAJs19EFkk7Mdb/414eGjRYk2Y+N1PAo1Lb6vVjZKWFAgKZF4NHrQZWQd0xWHOI0LP
         VWnQ==
X-Gm-Message-State: AOJu0Yxesgx32u3+pOU7ZCMcf8X4oa7jd8cXPDKjS9Iso+OqO2iVb+GM
        wp1qwphSODBR/knBwbi13ME9xm7QKeXL5mjchi0=
X-Google-Smtp-Source: AGHT+IGqzunMaRN/3uw7iRHSFZeK7Mzia1dP9K6VjR+9oK7VZkrT26V2lAcQRmg4kBzBzJ00WOT1E/sylua8cgFnEQE=
X-Received: by 2002:a05:6402:699:b0:522:3a89:a7bc with SMTP id
 f25-20020a056402069900b005223a89a7bcmr2528381edy.42.1696450943354; Wed, 04
 Oct 2023 13:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
 <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com>
 <CAFULd4YRHmQVnwaORm7=7kUs7DYG7SfwdTXAitDt=bxiMU5AoQ@mail.gmail.com>
 <CAHk-=whKc9UCsrZ6sNRb=T2Yhy4Dhr=LUBi9r-gPhfwCmuOeZA@mail.gmail.com> <CAHk-=wgcTXGJ7-cS_V4pWakQKh7rViKbzjxAfiaQ=nDvF7s+gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgcTXGJ7-cS_V4pWakQKh7rViKbzjxAfiaQ=nDvF7s+gQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 4 Oct 2023 22:22:12 +0200
Message-ID: <CAFULd4b2vmJrUReQw1TXvndzB=DfmHOvNwM9=bU_4O86s4UO3g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 10:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 4 Oct 2023 at 13:12, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 4 Oct 2023 at 13:08, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > You get a store forwarding stall when you write a bigger operand to
> > > memory and then read part of it, if the smaller part doesn't start at
> > > the same address.
> >
> > I don't think that has been true for over a decade now.
> >
> > Afaik, any half-way modern Intel and AMD cores will forward any fully
> > contained load.
>
> https://www.agner.org/optimize/microarchitecture.pdf
>
> See for example pg 136 (Sandy Bridge / Ivy Bridge):
>
>  "Store forwarding works in the following cases:
>   ..
>   =E2=80=A2 When a write of 64 bits or less is followed by a read of a sm=
aller
> size which is fully contained in the write address range, regardless
> of alignment"
>
> and for AMD Zen cores:
>
>   "Store forwarding of a write to a subsequent read works very well in
> all cases, including reads from a part of the written data"
>
> So forget the whole "same address" rule. It's simply not true or
> relevant any more.

No problem then, we will implement the optimization in the compiler.

Thanks,
Uros.
