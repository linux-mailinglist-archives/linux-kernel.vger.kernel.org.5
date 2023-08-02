Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130276D02E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHBOh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjHBOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862C2D72;
        Wed,  2 Aug 2023 07:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD6E619C9;
        Wed,  2 Aug 2023 14:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE81C433C8;
        Wed,  2 Aug 2023 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690987056;
        bh=NMSpb/FedQ2Q1UaqyvIdarexqyjFKk11UMeRZMF1ej8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qd1ieRpQy2h3M3sv7lP41URGQR7hy6GlYIZvavk9oY822YMYvvnr+CcZLuN0DVgEV
         M34L9w11IAq0rVFS30WQESNnZcbZ1kIz7A4AFneFd2X2oCxk7xDWWg8pF1g+ArexLe
         b04FZ16j01/mCLjhbYUl3dQ2Gt9hFS2/d1w5QE890X4jtM/x9prWtziJeWuoTr91Et
         mRDYcJATH4vDDkOi+ZCckfMxgLE+wjWKjamebpBI6qEbb5pOblwC52NWHzY29xc8QH
         6w/tOh6H2xDUqKbltM95l6Tl/l/01KQax+FF/kIjMIdvkxZWmm58WAIq07VQsqExdN
         A0Xez4zPo1kwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A04074012D; Wed,  2 Aug 2023 11:37:33 -0300 (-03)
Date:   Wed, 2 Aug 2023 11:37:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 2/2 Resend] perf build: Support llvm and clang support
 compiled in
Message-ID: <ZMpqLaqcQLHLrGNt@kernel.org>
References: <20230725150347.3479291-1-tmricht@linux.ibm.com>
 <20230725150347.3479291-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725150347.3479291-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 25, 2023 at 05:03:47PM +0200, Thomas Richter escreveu:
> Perf build suports llvm and clang support compiled in.
> Test case 56 builtin clang support provides a test case
> which is always skipped.
> 
> Link perf with the latest llvm and clang libraries and
> enable this test case.
> 
> Use 'make LIBCLANGLLVM=1' to include this support.
> 
> V2: Add Library patch before -lclang-cpp
> 
> Output before:
>  # ./perf test 56
>  56: builtin clang support                  :
>  56.1: builtin clang compile C source to IR : Skip (not compiled in)
>  56.2: builtin clang compile C source to ELF object: \
> 	 				Skip (not compiled in)
> 
> Output after:
>  # ./perf test 56
>  56: builtin clang support                          :
>  56.1: builtin clang compile C source to IR         : Ok
>  56.2: builtin clang compile C source to ELF object : Ok
>  #

Thanks, tested and applied!

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> 
> From Ian Rogers
> Build tested with LLVM 14 and 15 using:
> BUILD_BPF_SKEL=1 LIBCLANGLLVM=1 LLVM_CONFIG=llvm-config-14
> BUILD_BPF_SKEL=1 LIBCLANGLLVM=1 LLVM_CONFIG=llvm-config-15
> 
> Tested-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 2 +-
>  tools/perf/Makefile.perf   | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c5db0de49868..8e1d1fab9b4d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -325,7 +325,7 @@ CORE_CFLAGS += -Wall
>  CORE_CFLAGS += -Wextra
>  CORE_CFLAGS += -std=gnu11
>  
> -CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
> +CXXFLAGS += -std=gnu++17 -fno-exceptions -fno-rtti
>  CXXFLAGS += -Wall
>  CXXFLAGS += -fno-omit-frame-pointer
>  CXXFLAGS += -ggdb3
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 097316ef38e6..158a0733fc9d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -426,10 +426,7 @@ EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
>  LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>  
>  ifeq ($(USE_CLANG), 1)
> -  CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
> -  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
> -  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
> -  LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
> +  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) -lclang-cpp
>  endif
>  
>  ifeq ($(USE_LLVM), 1)
> -- 
> 2.41.0
> 

-- 

- Arnaldo
