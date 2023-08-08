Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A17749F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjHHUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjHHUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1265B7;
        Tue,  8 Aug 2023 11:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 405B362A29;
        Tue,  8 Aug 2023 18:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3427C433CC;
        Tue,  8 Aug 2023 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520151;
        bh=V6GroEZc1Lu3vGnXokTIyovbvq0wBDOW55yP+hahU6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4m2RHbU6fAbgWmSdoAWbgQEoaDcaUQGChAFTP4SADAbV47uhHRot6kzc1dz/e0LN
         mCwEAgUUlUdLTwP87Q2rLRcc9OnD+nnDUN8NGN6sFwKEJdw4ZVEbIOv4vYGYl/u4vG
         rzNxTEPoPspUDXBitPV3uv5C0xRx2aeNcNnYd07ulDsx9+12PlToIQJXo0gZqnmOrT
         0H5ai6W+um/YAMCaY6IuPa2H+IFJQOTvOZkLaYH6gjYssDXr2mroiLlgrNhKQLyFyi
         +7BhobP6j6FJ716VBNHWtSdO4zjAVVuYH4A4parGctxuEa4ywID2iYEM5Gy5mbKnhM
         MaugWFmdqVoWg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bd0c953fd9so376887a34.3;
        Tue, 08 Aug 2023 11:42:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkjRQau+gz96eVR9LD/hmiHCFn7cGnt7sKy81dsrWbVBFzVbpZ
        4faApCIViaPgj65WD6SsOXGaDPzWnj4rU1If57Q=
X-Google-Smtp-Source: AGHT+IE1kMeMgxlH7/iv9E5yoRpEJ5vphNEnh/q42PUxCdJKK/TnVq6TRswiiGhcSR90D+t3Qb4t+irdcQz0aPNdZ74=
X-Received: by 2002:a05:6870:9a19:b0:1ad:4a74:9d63 with SMTP id
 fo25-20020a0568709a1900b001ad4a749d63mr553799oab.53.1691520150864; Tue, 08
 Aug 2023 11:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
 <202308081508.EI3CRzQo-lkp@intel.com> <CAKwvOdnDEaZt-mD2PvMDmCY1WyaqtrH+oM3M5JgZaiOOWA_0YQ@mail.gmail.com>
 <20230808161707.GA2171444@dev-arch.thelio-3990X>
In-Reply-To: <20230808161707.GA2171444@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Aug 2023 03:41:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8NqjZTWz_Yhp=pzv2rRLjiwk1eYFc_BB+ptYKO7pc+A@mail.gmail.com>
Message-ID: <CAK7LNAS8NqjZTWz_Yhp=pzv2rRLjiwk1eYFc_BB+ptYKO7pc+A@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.extrawarn: enable -Wmissing-variable-declarations
 for W=1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 1:17=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Aug 08, 2023 at 09:01:38AM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 8, 2023 at 1:03=E2=80=AFAM kernel test robot <lkp@intel.com=
> wrote:
> > >
> > > Hi Nick,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulnie=
rs/Makefile-extrawarn-enable-Wmissing-variable-declarations-for-W-1/2023080=
8-005859
> > > base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> > > patch link:    https://lore.kernel.org/r/20230807-missing_proto-v2-1-=
3ae2e188bb0c%40google.com
> > > patch subject: [PATCH v2] Makefile.extrawarn: enable -Wmissing-variab=
le-declarations for W=3D1
> > > config: arm64-randconfig-r013-20230807 (https://download.01.org/0day-=
ci/archive/20230808/202308081508.EI3CRzQo-lkp@intel.com/config)
> > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.=
git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > reproduce: (https://download.01.org/0day-ci/archive/20230808/20230808=
1508.EI3CRzQo-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202308081508.EI3CRzQo=
-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    In file included from lib/test_bitops.c:9:
> > >    In file included from include/linux/module.h:13:
> > >    In file included from include/linux/stat.h:19:
> > >    In file included from include/linux/time.h:60:
> > >    In file included from include/linux/time32.h:13:
> > >    In file included from include/linux/timex.h:67:
> > >    In file included from arch/arm64/include/asm/timex.h:8:
> > >    In file included from arch/arm64/include/asm/arch_timer.h:18:
> > >    In file included from include/linux/smp.h:110:
> > >    In file included from include/linux/preempt.h:79:
> > >    In file included from arch/arm64/include/asm/preempt.h:6:
> > >    In file included from include/linux/thread_info.h:60:
> > >    In file included from arch/arm64/include/asm/thread_info.h:18:
> > > >> arch/arm64/include/asm/stack_pointer.h:8:24: error: no previous ex=
tern declaration for non-static variable 'current_stack_pointer' [-Werror,-=
Wmissing-variable-declarations]
> > >        8 | register unsigned long current_stack_pointer asm ("sp");
> > >          |                        ^
> > >    arch/arm64/include/asm/stack_pointer.h:8:10: note: declare 'static=
' if the variable is not intended to be used outside of this translation un=
it
> > >        8 | register unsigned long current_stack_pointer asm ("sp");
> > >          |          ^
> >
> > I actually don't think that either compiler should warn for variables
> > with register storage.  I spoke briefly with some GCC folks on IRC and
> > the initial assesment was agreed.  I've filed
> > - https://github.com/llvm/llvm-project/issues/64509
> > - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D110947
> >
> > Also, I've received 3 emails from zero day; this is expected as the
> > tree is not W=3D1 clean (actually, I think Arnd has been a lot of
> > cleanup around these groups of warnings, so I take that back).  What's
> > more curious to me is that none are GCC builds. I wonder if 0day bot
> > team is only testing W=3D1 with clang and not GCC?  That would seem lik=
e
> > perhaps the bar is higher for LLVM?
>
> As far as I am aware, the 0day bot tests both compilers with W=3D1. I
> think the more likely explanation is that the robot is not testing with
> prerelease versions of GCC, which is currently 14.x, which is the only
> version of GCC that has this warning implemented.
>
> > Masahiro, Nathan,
> > What are your thoughts on how to proceed here? Do we need the tree to
> > be free of warnings before it can be added to W=3D1? Hopefully not; I
>
> No, otherwise we wouldn't be adding it to W=3D1 ;)
>
> > would think that's the criteria for promoting a warning from being
> > hidden behind W=3D1 to being on by default in the top level Makefile.
> > What are your thoughts?
>
> I think the register storage issue should be resolved in at least clang
> before this patch is accepted, as that seems to be where the majority of
> warnings are coming from so far. Like we talked about, I'll take a shot
> at fixing that. Once that is fixed, I'll build mainline with
> -Wmissing-variable-declarations to see how many instances there are and
> if there are any other interesting edge cases that should be fixed in
> the compiler. After that, I think this should be good to go in. Does
> that sound reasonable?


Sounds reasonable!
Thank you.





--=20
Best Regards
Masahiro Yamada
