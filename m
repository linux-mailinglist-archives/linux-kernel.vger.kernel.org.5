Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1775868D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGRVJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGRVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:09:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8C19AF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:09:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b2b60731so34946855ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689714545; x=1692306545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSf1DUfPjj9rR6R8dex4siwYdCCG3zhhBQNvw/BY8zs=;
        b=jxxqZRTK4pC4Gm3RwAxNDLBo/xsEVOT0fiQXouo3xxUl3rnFztWHXL1oeP/7w9BAKt
         UxuzlTFfU1hIY8o0D9ksWN/uv3w+7eSl2sVst5rd/ZVGmKJop/dlawYNk4jdwToJx2iF
         ZPMvoFqh4HGIGMqMHCMbIe5jJVZkV2NwJYx0FMrbntQT0KCiM3a00kGYcjdrORNioHmj
         X0CCx0iGJSqH4d8ib1lmNt+vnOBEqaMrBvD3DSkvx5jY5svhykDLj2oMF8BUHAaCq/eC
         UPFb7cQ1uSSytjMGmpNzSWv+TwPljqoK9vpLeWQnAGaZQveb8uzu/RXkM5VRmsoYU4xF
         hsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689714545; x=1692306545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSf1DUfPjj9rR6R8dex4siwYdCCG3zhhBQNvw/BY8zs=;
        b=Al6eQ24ufbP588y7eWEHE1zuZV75imHSfEcIEe6nf4bXyXpY7mJtf0q29TEg8phaej
         jpz6iqmqDXw1nYehuo9GbKmypBLp6o4bPYkiGYhNZNVpNpQxsyQ4X3v3iKa9w84UzLrY
         jx2jjXbuJP5D0Ssum4a9Sn+3aa586MYDkAnQZG7SZSUdq3+dGDQQUzog/M7vvLU2wOWL
         2gEoeuHRfq5KuG++MhlTtg4eaTNmEixt6K4nyB/1N5Qj6aRZqWMJ8/Bux7VP5VQepTXA
         HPaz3pu4H8o+ShMhhLi0uXAJCzgB/PBq3tBfNGVk89xpiqGtfBPMQxl3EKXCFeBOMxid
         AbAw==
X-Gm-Message-State: ABy/qLZ2F8F+EpLwgOoP2SO5BWPOIuhCfG/sK9HnrjRMlmi5Hw9FiWB/
        VFhiHKqd/S4VrX6wwV0KfMRfiMTu5ZEnpA==
X-Google-Smtp-Source: APBJJlEsvSRi+K4F98zqHSa8MaHap/EE1ekJ/8rYJX72Nrk2ydHLnfXG6goaV47zgd6eLP7DY+7ELQ==
X-Received: by 2002:a17:902:788d:b0:1a9:40d5:b0ae with SMTP id q13-20020a170902788d00b001a940d5b0aemr13124901pll.12.1689714545462;
        Tue, 18 Jul 2023 14:09:05 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id jk16-20020a170903331000b001b8a3dd5a4asm2304168plb.283.2023.07.18.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 14:09:04 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:09:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] lib/bitmap: workaround const_eval test build failure
Message-ID: <ZLb/bioBIHS6bjKc@yury-ThinkPad>
References: <20230717220435.57640-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717220435.57640-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:04:35PM -0700, Yury Norov wrote:
> When building with Clang, and when KASAN and GCOV_PROFILE_ALL are both
> enabled, the test fails to build [1]:
> 
> >> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
>            BUILD_BUG_ON(!__builtin_constant_p(res));
>            ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ^
>    include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
>                            prefix ## suffix();                             \
>                            ^
>    <scratch space>:185:1: note: expanded from here
>    __compiletime_assert_239
> 
> Originally it was attributed to s390, which now looks seemingly wrong. The
> issue is not related to bitmap code itself, but it breaks build for a given
> configuration.
> 
> Disabling the const_eval test under that config may potentially hide other
> bugs. Instead, workaround it by disabling GCOV for the test_bitmap unless
> the compiler will get fixed.
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/1874
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307171254.yFcH97ej-lkp@intel.com/
> Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/evaluations assertions")
> Co-developed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

So, I pushed it in bitmap-for-next. If nothing wrong will appear in
~week, I'll send a pull request, so expect merging it in this cycle.

Thank you for the work!

Thanks,
Yury
