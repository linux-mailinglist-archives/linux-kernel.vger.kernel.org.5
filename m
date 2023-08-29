Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1017278C8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjH2PkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjH2Pjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:39:45 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147831B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:39:41 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-799761430c2so1664033241.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693323580; x=1693928380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnzm799P6Q3j74LZPQjfhcA/lU7vvWbHsfU0R3jlCdA=;
        b=21bL9sgc2nberDTHd8JR2kcJpnJThYAPI+w+wEl/2TE70wClWsQXUKQtxDRy+i0rtP
         XyYc3bYl+wlHw4DhaTvnupahq//RRbeLSvoUnZikhM6PdxUpeC8n36+KN/A5MJBMJcI+
         KyWGLe5XdNSGSw6FUYlq6sxc98Rq3oZwmtbpA5zPxdAxdpDgUinCD2hTw1Ob0+vtu4Bx
         NiQaZhnQGGRUclNw78fljAstc+Hn68o7Phzrc2oa4Bwu5eQqLYz65P+UtBJiGlF1JQLt
         JZ6SGRo/y9dmH6AiWjXD91jGoem9/zBIzFBbV6EO4qGEqcIxAY2KD7TBdXRORtaLnQ0p
         RjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323580; x=1693928380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnzm799P6Q3j74LZPQjfhcA/lU7vvWbHsfU0R3jlCdA=;
        b=jcfT8FqA0XtGvVb8nHkYo2Hy7jGaRkTyUCl8pHRbjq/YvfpwJAhWTX4SuCz5W5oyBL
         HCUuJyV12cGGoiDfn4OZm0hADFCiOqto5pSXvoov9ty/Qh7ImNtyeGJC1D9xM6+chzuc
         Cew5kUpc5rNsFYo9WC8Rp+9BnDGWPEWyEkgAcUTpZjPB3khiLKbbNVfD4v9gxr2LxVIi
         K6fcLFVunDUpNcHT42hfjwwn0cpRRKBIMhYUY8dK88p0pu/7MsjpodsVBcle2op8Ytnr
         WQJ8WmNqkbZu5phsmfAn+4zvWDK8C3p6Lx/C8ZRbRihkOetfL2bgi/fhbE7xb5EB5rHW
         55Og==
X-Gm-Message-State: AOJu0YyU7JXnwbUQ5DZI9G70wWDoiDewVnoPSFyI+WMlHw+JLNTsbMrW
        i3TqW0aOJJruvBeHMumAQJgWiodp9AJuXbyfeV0hSFTB8ogo05DcaF1JVg==
X-Google-Smtp-Source: AGHT+IFgQBf6W91PZLktY29myj7AxhMFsuzp9YBkQzOUK+EHpYkPHFHRJFOWCwRTC6PQXEYtheCVljru3JQYuH8tDTQ=
X-Received: by 2002:a05:6102:358:b0:44e:d85c:ac48 with SMTP id
 e24-20020a056102035800b0044ed85cac48mr3766077vsa.5.1693323580026; Tue, 29 Aug
 2023 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230828153142.2843753-1-hca@linux.ibm.com> <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com> <ZO0k1Par4i4FBCWF@google.com>
 <20230829074854.7031-A-hca@linux.ibm.com> <51f70b0ad37f469a93242db9cfc6d9e8@AcuMS.aculab.com>
In-Reply-To: <51f70b0ad37f469a93242db9cfc6d9e8@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Aug 2023 08:39:29 -0700
Message-ID: <CAKwvOdkrCUchQzCT48dReOgxT4xFc5jOtz1YNDAYJp8FqdeHzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
To:     David Laight <David.Laight@aculab.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 1:32=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Heiko Carstens
> > Sent: 29 August 2023 08:49
> >
> > On Mon, Aug 28, 2023 at 03:51:00PM -0700, Nick Desaulniers wrote:
> > > On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> > > > From: Heiko Carstens
> > > > > Sent: 28 August 2023 16:32
> > > > >         if (strlen(uid.vduit) > 0)
> > > >
> > > > Does the compiler know enough to optimise that brain-dead test?
> > > >
> > >
> > > For the purposes of skipping diagnostics, no; clang performs semantic
> > > analysis BEFORE optimization (which is handled by LLVM). As such, cla=
ng
> > > will produce diagnostics on dead code.
> > >
> > > Partly because LLVM isn't very ergonomic at emitting diagnostics from
> > > the backend, partly because Clang code owner and developers don't wan=
t
> > > clang to emit diagnostics dependent on optimization level.
> > >
> > > I disagree with my compatriots, and you can read more thoughts here:
> > > https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end=
-
> > diagnostics/69261?u=3Dnickdesaulniers
> >
> > Maybe I misunderstand what you write above, however clang (latest+great=
est)
> > does indeed optimize the strlen() away and generates code which only te=
sts
> > if uid.vduit[0] is zero or not.
> >
> > Unlike gcc, which does not optimize this away and which uses the strlen=
()
> > inline assembly provided via string.h...
>
> And, if -ffreestanding is set (as in some kernel builds), the compiler
> can't assume what strlen() does.

Exactly.

But triple checking if -ffreestanding is being used in arch/s390/ I only se=
e:

arch/s390/purgatory/Makefile
26:KBUILD_CFLAGS +=3D -fno-zero-initialized-in-bss -fno-builtin -ffreestand=
ing

arch/s390/Makefile
28:KBUILD_CFLAGS_DECOMPRESSOR +=3D -ffreestanding

---
So I don't think -ffreestanding is at play here.
--=20
Thanks,
~Nick Desaulniers
