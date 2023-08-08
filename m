Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9077424D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjHHRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjHHRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0061223352;
        Tue,  8 Aug 2023 09:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A186266D;
        Tue,  8 Aug 2023 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA0C433C8;
        Tue,  8 Aug 2023 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691511429;
        bh=LquyrdZz+GPUR7zZtISUW5zHU3sPwKSgexuwZUqAPOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDaJeCfdt4pDphXme6mXY5JL6DM9g3IabESbbEJFcH5sxoW0kMGICOcDHuI+cRmDw
         ZwhLgIFiGexSOJYpa71K9RHKTsXQsq9tA1kD4iS4j4Q9xm+CudmaSydeND0nIGuTU3
         Wb0XTdvskIQ4l3oJvQbneHrBQzu67nHImlrQ8RN/KLmVxTVaNC9gQ5DVBb+Q27iXuc
         66UaWgv11F/mGPolOPYXNCkj2gXMcXYWkH1KmjicCvY/qeLnx/s74gN4pQfpwhum8e
         Fr6Q4vnHKic/v8PVCpv6I/J+gpog/82LIUHD8Nj9ziYD+2Zn/39blRFYD+3ZvXsxIe
         9KBWgavEEESMg==
Date:   Tue, 8 Aug 2023 09:17:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2] Makefile.extrawarn: enable
 -Wmissing-variable-declarations for W=1
Message-ID: <20230808161707.GA2171444@dev-arch.thelio-3990X>
References: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
 <202308081508.EI3CRzQo-lkp@intel.com>
 <CAKwvOdnDEaZt-mD2PvMDmCY1WyaqtrH+oM3M5JgZaiOOWA_0YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnDEaZt-mD2PvMDmCY1WyaqtrH+oM3M5JgZaiOOWA_0YQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:01:38AM -0700, Nick Desaulniers wrote:
> On Tue, Aug 8, 2023 at 1:03 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Nick,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/Makefile-extrawarn-enable-Wmissing-variable-declarations-for-W-1/20230808-005859
> > base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> > patch link:    https://lore.kernel.org/r/20230807-missing_proto-v2-1-3ae2e188bb0c%40google.com
> > patch subject: [PATCH v2] Makefile.extrawarn: enable -Wmissing-variable-declarations for W=1
> > config: arm64-randconfig-r013-20230807 (https://download.01.org/0day-ci/archive/20230808/202308081508.EI3CRzQo-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081508.EI3CRzQo-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308081508.EI3CRzQo-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from lib/test_bitops.c:9:
> >    In file included from include/linux/module.h:13:
> >    In file included from include/linux/stat.h:19:
> >    In file included from include/linux/time.h:60:
> >    In file included from include/linux/time32.h:13:
> >    In file included from include/linux/timex.h:67:
> >    In file included from arch/arm64/include/asm/timex.h:8:
> >    In file included from arch/arm64/include/asm/arch_timer.h:18:
> >    In file included from include/linux/smp.h:110:
> >    In file included from include/linux/preempt.h:79:
> >    In file included from arch/arm64/include/asm/preempt.h:6:
> >    In file included from include/linux/thread_info.h:60:
> >    In file included from arch/arm64/include/asm/thread_info.h:18:
> > >> arch/arm64/include/asm/stack_pointer.h:8:24: error: no previous extern declaration for non-static variable 'current_stack_pointer' [-Werror,-Wmissing-variable-declarations]
> >        8 | register unsigned long current_stack_pointer asm ("sp");
> >          |                        ^
> >    arch/arm64/include/asm/stack_pointer.h:8:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
> >        8 | register unsigned long current_stack_pointer asm ("sp");
> >          |          ^
> 
> I actually don't think that either compiler should warn for variables
> with register storage.  I spoke briefly with some GCC folks on IRC and
> the initial assesment was agreed.  I've filed
> - https://github.com/llvm/llvm-project/issues/64509
> - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110947
> 
> Also, I've received 3 emails from zero day; this is expected as the
> tree is not W=1 clean (actually, I think Arnd has been a lot of
> cleanup around these groups of warnings, so I take that back).  What's
> more curious to me is that none are GCC builds. I wonder if 0day bot
> team is only testing W=1 with clang and not GCC?  That would seem like
> perhaps the bar is higher for LLVM?

As far as I am aware, the 0day bot tests both compilers with W=1. I
think the more likely explanation is that the robot is not testing with
prerelease versions of GCC, which is currently 14.x, which is the only
version of GCC that has this warning implemented.

> Masahiro, Nathan,
> What are your thoughts on how to proceed here? Do we need the tree to
> be free of warnings before it can be added to W=1? Hopefully not; I

No, otherwise we wouldn't be adding it to W=1 ;)

> would think that's the criteria for promoting a warning from being
> hidden behind W=1 to being on by default in the top level Makefile.
> What are your thoughts?

I think the register storage issue should be resolved in at least clang
before this patch is accepted, as that seems to be where the majority of
warnings are coming from so far. Like we talked about, I'll take a shot
at fixing that. Once that is fixed, I'll build mainline with
-Wmissing-variable-declarations to see how many instances there are and
if there are any other interesting edge cases that should be fixed in
the compiler. After that, I think this should be good to go in. Does
that sound reasonable?

Cheers,
Nathan
