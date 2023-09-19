Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB787A56BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjISA4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISA4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38A10B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:56:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABA6C433C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695084997;
        bh=nE5P8ufygqbIo8jvx/OEDKHbyHstgT6k4TktwRlOAZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uh1a3Vz09m4eYrMIBw5dUOcOT2b2nusN7GZYwcgx1Mmv+zw6mVGHih5CQqSUTS0mT
         nAkFPLu8HTIU3+IQy64cG+rMer2TB5Yzch/I/AianECJ1pw/bqEa2OFlIFTInhqrzD
         FSo6mYvUq3Lvt4UpzvZcY0Ii4viZe2VCCuckp7++V9THu/0w3A2M5mfWq6SC/4tGDM
         cTOiS4n1VchWOrv9mUh71LDaXgC8H1dw7MRS7Gxlo7ZhL11jB1LiTpmfVgEDz5g7YJ
         JSMEylwzA/dflCP6Vuf+nNo0YlwxBtaOnFRk+1SVedRkRyHcOxqtAiyQflfzKFKt2X
         SOj6DhAplnHzw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a64619d8fbso673104766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:56:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3tcaVztl0ojFHyrrZjf4nXgkm91/82SFQvTYbQyTio8aiQfJ1
        7aVjEuTiBXfmV0jxati23X1SCejMRIJkh4PMUnA=
X-Google-Smtp-Source: AGHT+IEFySirtuTqKHANnvts1iP62VmxSeB/4SElE5cqR3MknDm4Qs17P4QND0TDuwYjr7EQUVxKyS++TSXObEqGeQg=
X-Received: by 2002:a17:906:2921:b0:992:7295:61c9 with SMTP id
 v1-20020a170906292100b00992729561c9mr8693317ejd.69.1695084996069; Mon, 18 Sep
 2023 17:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
 <ZQNWh2DY319jGbfq@smile.fi.intel.com> <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
 <ZQWCeI6E7rm8Akbt@smile.fi.intel.com> <CAAhV-H6dakVH0a4Mt9MdcY8OO3gdne6rW0Z1kK6YRq9hDLP05w@mail.gmail.com>
 <ZQfzDXc0WRHCUeIq@smile.fi.intel.com> <CAAhV-H4HkA=SZAb-4q5QVdyDB1MsEsmjVO_N8h30MkSXzpzimQ@mail.gmail.com>
 <ZQgJB6KKYka6YGNK@smile.fi.intel.com>
In-Reply-To: <ZQgJB6KKYka6YGNK@smile.fi.intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Sep 2023 08:56:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=bNh9s4=ERooLMj1r+WO4J59LyugibZWBU2nk-9FkTQ@mail.gmail.com>
Message-ID: <CAJF2gTT=bNh9s4=ERooLMj1r+WO4J59LyugibZWBU2nk-9FkTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Add missing headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 4:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 18, 2023 at 04:05:50PM +0800, Huacai Chen wrote:
> > On Mon, Sep 18, 2023 at 2:49=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Sep 16, 2023 at 08:05:52PM +0800, Huacai Chen wrote:
> > > > On Sat, Sep 16, 2023 at 6:27=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Sep 15, 2023 at 08:36:24AM +0800, Huacai Chen wrote:
> > > > > > On Fri, Sep 15, 2023 at 2:53=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:
> > > > >
> > > > > > > > Thank you for your patch, can this patch solve the problem =
below?
> > > > > > > > https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ=
-lkp@intel.com/T/#u
> > > > > > >
> > > > > > > Nope, this just adds missing includes.
> > > > > > > No functional change, so warnings will still be there.
> > > > > > But I think a patch should solve a problem.
> > > > >
> > > > > No, that problem is static analyser concern, not the compiler nor=
 linker.
> > > > >
> > > > > > If we don't get a build
> > > > > > error or warning without this patch, does that mean the 'missin=
g'
> > > > > > headers are actually included indirectly?
> > > > >
> > > > > I might be missing something, but I do not see any build error in=
 the above message.
> > > > Hmm, then I think I will take the second patch only.
> > >
> > > Thanks, but can you shed a light why?
> > >
> > > The rule of thumb is to include the headers we are direct users of, w=
e have not
> > > to imply any other inclusions done by others, unless it's kinda same =
family of
> > > headers (like types.h always includes compiler_types.h). Since in you=
r case
> > > the const.h is included the other two are missing and it's even worse=
, as I
> > > understand you rely on the specific headers to be included _before_ u=
sing this
> > > one in the users.
> > I agree with you more or less, but I doubt there is another rule: no
> > break, no fix. Please see:
> >
> > https://lore.kernel.org/loongarch/20221024070105.306280-1-chenhuacai@lo=
ongson.cn/T/#t
> >
> > Obviously static_key is used in page-flags.h and it really causes
> > build errors once before, but at last I removed the inclusion of
> > static_key.h to get that series merged.
>
> This is strange requirement to be honest. Doing like this is to move your
> responsibility and understanding of the code to be a burden of the person=
 who
> volunteers cleaning up the header mess we have in the Linux kernel source=
 tree.
>
> Since I'm the one who tries to fix some mess (in particular kernel.h), I =
am
> pretty much know what I am talking about from the experience.
>
> Cc'ing Guo. Guo, can you shed a light on the rationale of your comment in
> the above mentioned thread?

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5c02720c53a5..9cdef3944a75 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mmdebug.h>
+#include <linux/static_key.h>
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
 #include <generated/bounds.h>

My meaning is riscv needn't include the above header file to support
HVO, and I just tested the above modification with riscv, all passed,
so go ahead.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best Regards
 Guo Ren
