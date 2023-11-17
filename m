Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6287EF7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjKQTnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKQTnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:43:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0632D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:43:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507f1c29f25so3288488e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700250209; x=1700855009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipIG35F0M7cxT+tSacDx0LznY+mEw6VNfAkZj1ICT/E=;
        b=Fb5YcGl5Y4exigAennHb1XX54PadkV17CcheSMcGtW9LAeS5OyhRBWc6T8mPNgd5Dm
         kVs7gKsd/u0DaR7RuRVnG4FMYgAOPj1iS1UC6LQ8xQAZOuXkorqMzCO4Lsqz4H69M1M5
         /QPEf3vUa/gJQe1ceuRBPUK7vZLu+VwaY6SJ4QQYRBncsdtTWD4O8fdoAnhQPTCXeAfQ
         CUnRPIpDLOJV8zkuJnzPGnue9pKJlusFXVQa4uEEXyoKPEigjRlDvSQj6otG+jt0fhSL
         VS3NDpKCStV2pZNdE0D8qvfADNkRTrhcL1ciqOnL5Ysl5OYgosKqfomcGeoQMRLgpFSD
         e/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250209; x=1700855009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipIG35F0M7cxT+tSacDx0LznY+mEw6VNfAkZj1ICT/E=;
        b=UJ1oDSXlIg//22ex5yik9RppY7y63VWQZMpN49oxxtXO6ATJZjfStyV0ES5bSY0zlQ
         bvfR+MHq6OSyn5YdO5bbICFpuvQ0Srozl2mlj9VPkiUxcP2mp36h0MlZbvRdFTtQINVn
         l7+NXzuXH4BHauXNzumneVtESBzdPj1InBE7kEGFsOPZ3HtKC5efFBJNLZhYXu/W91MC
         0uc8w2cLWlyrvZ/oojJMl3SgUae6p1uzS3XwrruAM9IBsWVkFNJVKNdCVh2qKXCGmBz2
         E6nJnqnAj+eTGzgJOm64UEqJUvSN5L9+0LtkIgF3b6SVDN2+5sDGPHtuWopr/vsJarSV
         RPAQ==
X-Gm-Message-State: AOJu0Yz/GuVXzHiOCk7Vmw0syoAEAvg6Y0E5fcFe1xuAceBoo8d5ReCb
        i5vvcn41OeylSFqRr5sGb+otSATZtmqXgMhyrg==
X-Google-Smtp-Source: AGHT+IGfrO7WDp9QSec5PtLGBoD827QAkMUQ9tqLFKGZJlLicz1EMsbL11ZK+d6W+FiBstEIeF4kenYZnbC1tic6yyk=
X-Received: by 2002:ac2:5395:0:b0:509:4709:2104 with SMTP id
 g21-20020ac25395000000b0050947092104mr316084lfh.67.1700250208559; Fri, 17 Nov
 2023 11:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20231116191127.3446476-1-ubizjak@gmail.com> <eec64162-263e-4535-b637-4893d23d19a3@zytor.com>
In-Reply-To: <eec64162-263e-4535-b637-4893d23d19a3@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 17 Nov 2023 14:43:17 -0500
Message-ID: <CAMzpN2hY=JJRKPqsXr2BuyPZ5AJP3UzUPyMZoUNzTE00uN3iOw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 1:16=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 11/16/23 11:10, Uros Bizjak wrote:
> > %RIP-relative addresses are nowadays correctly handled in alternative
> > instructions, so remove misleading comment and improve assembly to
> > use %RIP-relative address.
> >
> > Also, explicitly using %gs: prefix will segfault for non-SMP builds.
> > Use macros from percpu.h which will DTRT with segment prefix register
> > as far as SMP/non-SMP builds are concerned.
>
> OK, this is starting to feel silly. One could seriously question the use
> case for supporting !SMP builds x86-64. It isn't like our performance
> for SMP builds on UP systems is significantly worse, it is mostly just a
> matter of code size, and the difference isn't huge, either, especially
> considering that on systems of the x86-64 era the kernel is a rather
> small part of system memory (unlike the very early i386 era, for those
> of us who remember those ancient times.)
>
> The number of UP x86-64 systems is really very small (since
> multicore/SMT became ubiquitous at roughly the same time x86-64 was
> introduced), and as far as I know none of them lack APIC which is really
> the most fundamental difference between SMP and !SMP on x86.
>
> Why don't we simply have %gs_base =3D=3D 0 as an invariant for !SMP?

The reason is stack protector, which is still stuck at %gs:40.  So
GSBASE has to point at fixed_percpu_data, even on a UP build.  That is
corrected by the patch series I recently posted, though.

> If we
> *REALLY* care to skip SWAPGS on !SMP systems, we could use alternatives
> to patch out %gs: and lock (wouldn't even have to be explicit: this is
> the kind of thing that objtool does really well.) We can use
> alternatives without anything special, since it only matters after we
> have entered user spae for the first time and would be concurrent with
> patching out SWAPGS itself.

There is already support to patch out LOCK prefixes when running an
SMP build on a single CPU (.smp_locks section).  Patching out the GS
prefix would only work if the initial percpu area is not freed.
Beyond that I don't think other optimizations are worth the effort,
and would get very little testing.


Brian Gerst
