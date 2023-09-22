Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2E7ABBD2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIVWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:34:38 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 15:34:32 PDT
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488AE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:34:32 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:25:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695421545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUtaqf0D4+kd8F29+reRe8AfJZsyK1jKCQl6YrgKT6Q=;
        b=XXsHEoQvZhTuvaPIpzFnTXFtFyZSYIWNJ+Cl7hv8y6BgBNo0e/dD+zddOiNO3qOcrBVx8o
        /o9Ww54gkEyKZlaO5Jx1i0s/3ANxs8cABQ4OQFN9jkltEyeilJnLYTPUFF665UmB5QNvFK
        pwWcQ5htGY1uOBF3am0YTDwgvqNDwnc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with
 __counted_by
Message-ID: <ZQ4UXsxrFfNTNsM7@P9FQF9L96D.corp.robot.car>
References: <20230922175327.work.985-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175327.work.985-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:53:28AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mem_cgroup_threshold_ary.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
