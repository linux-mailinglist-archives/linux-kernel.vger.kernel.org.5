Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506787DB5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjJ3JKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:10:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96E9D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:10:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso8708333a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698657016; x=1699261816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viTB2MCu7D6d4/He6yWasnXAPMRVI+rvDuoEeVOmWYM=;
        b=MahlD0m+jOtGjW3nj6u/J3VT63qnruWkkBqfXtxKjp+WpGqIldCtCQIZ2BD1v1rEbA
         cGgb+G+WCIo4FjWl4d5C25kSgRZboVpgVY4jEoU2MmwizF1DLnT46jOlVRCbsGGBm087
         OJsz3hULcaVQ8O3gjJf54Al7g5XGLUmAhVkw2BsH4oM/35kbZiCo4kLEhT43oDTfaCYU
         D5RdNXMeVDhRn4wZWtNPMru75XMFU2/hJUd11qmwrFpUHjsgsWha8DJqX5MygG8ETPWf
         GynEOhS5cZayEOk2x7juQnu7LIgvyyX2WE024x8MyJcbqQKXbELEs2S/Lwpt3PvT1a7+
         9bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657016; x=1699261816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viTB2MCu7D6d4/He6yWasnXAPMRVI+rvDuoEeVOmWYM=;
        b=BMETD9tOQaownNj/H3bUhzaxofZdgthlT6BLGAHfpj9DXpUSHnOWqP6VxFYxktDn3F
         +lLl6WOuxxI1HwK4eyQ1i/ULA5g7VDf2KDHvrdr0viC2hqpEGpkQz/7dTVmGvvuVfvme
         CXqImziGp3Sxf6zEKXnQUKh7V3naf7NtrhJlLorZ6LoWOi0u2U1tPjH/1Jwlv87nZG5S
         fhS/LuFyPFTm4Bpx8KBCEFTf7yZ/uyazF1N/L36rR04rycXjw6PKePIqD48eTnNPCETO
         z47HBiBDxVDtbHCSHSUxcKZh0R6To0XQ4t/vUs46DQ/dieGKn+X32ufcRKqkYjZ8H2TX
         NTJA==
X-Gm-Message-State: AOJu0Yy5ObcLYPz9i9UA2AlKt2OOaBb+GppNZfc7MqMAIxqc1XdGdqkz
        e5RxOu9dv5cv7BoBt+AJEbbjW9JYedh6JTwVAqg=
X-Google-Smtp-Source: AGHT+IHQiE4nfaVALhGU6nMLm+uh2XfIEY2DgrnVzufXJdC70P1H9GMRAx7qT+MD1lK700kDVGvRKGFxyZssBg7/k6U=
X-Received: by 2002:aa7:c68c:0:b0:542:f0af:21e6 with SMTP id
 n12-20020aa7c68c000000b00542f0af21e6mr3950932edq.14.1698657016395; Mon, 30
 Oct 2023 02:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
 <CAFULd4ZBGzceGbRaVLuMJ+qkoUpMv-rdBZB_D=Mni5RAWzgQBQ@mail.gmail.com> <1eb4f2c46e1642519a40924ed3fe3ccc@AcuMS.aculab.com>
In-Reply-To: <1eb4f2c46e1642519a40924ed3fe3ccc@AcuMS.aculab.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 30 Oct 2023 10:10:05 +0100
Message-ID: <CAFULd4Y_yt6onQn0_zQbiK=LCu25=jiFkCaPYQuvmjzTo+LZ1w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
To:     David Laight <David.Laight@aculab.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:05=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Uros Bizjak
> > Sent: 30 October 2023 08:07
> >
> > On Sun, Oct 29, 2023 at 10:42=E2=80=AFPM David Laight <David.Laight@acu=
lab.com> wrote:
> > >
> > > From: Brian Gerst
> > > > Sent: 26 October 2023 17:01
> > > >
> > > > Currently, x86-64 uses an unusual percpu layout, where the percpu s=
ection
> > > > is linked at absolute address 0.  The reason behind this is that ol=
der GCC
> > > > versions placed the stack protector (if enabled) at a fixed offset =
from the
> > > > GS segment base.  Since the GS segement is also used for percpu var=
iables,
> > > > this forced the current layout.
> > > >
> > > > GCC since version 8.1 supports a configurable location for the stac=
k
> > > > protector value, which allows removal of the restriction on how the=
 percpu
> > > > section is linked.  This allows the percpu section to be linked
> > > > normally, like most other architectures.  In turn, this allows remo=
val
> > > > of code that was needed to support the zero-based percpu section.
> > >
> > > I didn't think the minimum gcc version was anything like 8.1.
> > > I'm using 7.5.0 and I don't think that is the oldest version.
> >
> > Please see previous discussion regarding modernizing stack protector
> > on x86_64 [1]
> >
> > [1] https://lore.kernel.org/lkml/20211113124035.9180-1-brgerst@gmail.co=
m/
> >
> > and x86_32 [2]
> >
> > [2] https://lore.kernel.org/lkml/cover.1601925251.git.luto@kernel.org/
> >
> > The conclusion in [2] is:
> >
> > "I'm all in favour of simply requiring GCC-8.1 to build a more secure
> > x86_64 kernel. Gives people an incentive to not use ancient compilers.
> >
> > And if you do want to use your ancient compiler, we'll still build, you
> > just don't get to have stackprotector."
>
> I didn't see a patch that limited 'stackprotector' to gcc >=3D 8.1
> Without that anyone who already has it enabled and is using an
> older compiler will get very broken kernels.

It's this part:

--cut here--
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh
b/scripts/gcc-x86_32-has-stack-protector.sh
index f5c119495254..51f864d76bd6 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,4 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0

-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32
-O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+# This requires GCC 8.1 or better.  Specifically, we require
+# -mstack-protector-guard-reg, added by
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708
+
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32
-O0 -fstack-protector -mstack-protector-guard-reg=3Dfs
-mstack-protector-guard-symbol=3Dstack_canary - -o - 2> /dev/null | grep
-q "%fs"
--cut here--

Uros.
