Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE52B80DC17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjLKUvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344856AbjLKUvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:51:21 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8AC8;
        Mon, 11 Dec 2023 12:51:27 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67abaab0bc7so30636696d6.2;
        Mon, 11 Dec 2023 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702327886; x=1702932686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuKB0tiRMyjq3zqgkwtMyPd6sd/CFmnAl3rOjtlfa4Y=;
        b=HDi7hLG+u6hDrNOY6XNQhn3+iN0yMIj5GhkNHNOyTOaKDH0H4kevLMhUnvqUAqyfSr
         g5OIqyEM39TJZHMft5DdYqZgK73AZtW2KKHcP2AqhwVDMhjq+PAj/psKcBJjhYPyaaMm
         lFo4dUp68Lpd4UaT++5aOa8uPYARlB/3OggWTrJ3+jdDO+1xNBXLfyLu0IDlo+MYJoZS
         zIGy3Idlb2BuVg3eSnV0CUdsfXp2zq5H6NQSB9oLCYarvkvviMxh0SpVPlgEqg3drEjF
         Oigh5Mcddod0pmioZSKkY3W8nYbd44se6g9sSdOF4077NM17CcxTXmask6wMh4u9G6kX
         SODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327886; x=1702932686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuKB0tiRMyjq3zqgkwtMyPd6sd/CFmnAl3rOjtlfa4Y=;
        b=UhZGUAeZQAx+B9tRgtKAMlG50s5FtWbxXG3honBf65dbPwwaMzwRKwp5WGJxVvF3qN
         HHNnfwlpGCF8HAfDtpLnptV9w4izlBI9SBaTCVA1gFgXsVPumszM6EsHeXKMlAoEmvNm
         ptgPqs2hDJngDonlWAjSoSEnAaFUG2dea5Qv0fjs+poOaV42kv6INqpnhTFpF7a4eYzv
         nnlZKsWbO/Gn8L9h6kd6xoOLkOP5qwkT6TkodfpoRi+lOyy3CVVROk7U8s0PhRREP6+5
         arhgXCiTNqrI+X4cc5s8GJZR6edxm1srhaoah20S7FGaSs0zo3exiUqRDHiFebMOlSvf
         UNaQ==
X-Gm-Message-State: AOJu0YzHJ+HMcuSXYQxslkT+QXNAludms8goILjWVhsL0kHnuKIuxidl
        VcRBY/6tc0f+qRvF/nUqb/G/XIRMb4lnpknuGYc=
X-Google-Smtp-Source: AGHT+IEA228JMjM/VLsHZ915V9UbK6f03W9ktXAMmg3SwRsG2mOK7pzB/x28D2m6o+77RCPh7w7+VYTc3YWxTeCaMDE=
X-Received: by 2002:a0c:d684:0:b0:67a:a721:9ecc with SMTP id
 k4-20020a0cd684000000b0067aa7219eccmr5100260qvi.125.1702327886385; Mon, 11
 Dec 2023 12:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
 <20231205214359.GF1674809@ZenIV> <CAKwvOdkC0oHWKGJ1Z6k_U9cwkjdcf=iweG-G78jXSJgWFk86Jg@mail.gmail.com>
In-Reply-To: <CAKwvOdkC0oHWKGJ1Z6k_U9cwkjdcf=iweG-G78jXSJgWFk86Jg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Dec 2023 22:50:49 +0200
Message-ID: <CAHp75VeQzjdo1z8-bKSnMNgxvwTzjypADiBu-NJopia9h-YYLg@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Christoph Hellwig <hch@infradead.org>
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

On Mon, Dec 11, 2023 at 10:48=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Tue, Dec 5, 2023 at 1:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> > On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
> >
> > > The tooling Tanzir is working on does wrap IWYU, and does support suc=
h
> > > mapping (of 'low level' to 'high level' headers; more so, if it
> > > recommends X you can override to suggest Y instead).
> > >
> > > arch/nios/ also doesn't provide a bug.h, which this patch is
> > > suggesting we include directly.  I guess the same goes for
> > > asm/rwonce.h.
> >
> > See include/asm-generic/Kbuild:
> > mandatory-y +=3D bug.h
> > ...
> > mandatory-y +=3D rwonce.h
> >
> > IOW, sh will have asm/bug.h and as/rwonce.h copied from asm-generic.
> >
> > Still, includes of asm/*.h had been a massive headache historically
> > and breeding more of those shouldn't be overdone.
> >
> > More painful problem is arch- and config-dependent stuff, though...
>
> Ah, it looks like include/uapi/asm-generic/Kbuild also makes use of
> this pattern using mandatory-y.
>
> So I think we can handle this as a two step translation. We can tell
> the tooling to 'nevermind recommending X, always replace
> recommendations for X with Y <for raisins>', so:
> 1. any recommendation to use asm-generic/foo.h should be replaced with
> asm/foo.h (always, based on those 2 Kbuild files, could autogenerate)
> 2. some recommendations to use asm/foo.h should be replaced with
> linux/foo.h (not necessarily codified anywhere; depends on if there is
> a linux/foo.h, will manually curate this list for now)
>
> Orthogonal but some places in tree can be cleaned up to include
> linux/foo.h rather than asm/foo.h.
>
> Does this sound like an improvement to my mental model of the
> conventions used for kernel header inclusion within the linux kernel?
>
> Tanzir nearly has the above done (for 1, 2 we will probably need to
> iterate on more).  We've also beefed up our local testing to test more
> architectures.  I expect Tanzir to send a v2 of this patch (as a
> series, with the fix for ARCH=3Dsh) later this week, if the above seems
> correct.

Whatever you choose, please make sure it gets documented, so we won't
go another round in the future for something similar.

--=20
With Best Regards,
Andy Shevchenko
