Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54D7AEDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjIZNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjIZNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:05:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE4F3;
        Tue, 26 Sep 2023 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695733518; x=1727269518;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=FmbKCqSsz0kqTsakPv8EB8BnPpBLaPEGLkuj5LldCX8=;
  b=n2FTKXNsD4VcQuW/7woIiQB8CBUHmagBUXGWf6PltQpjzRz9RYUr73M2
   k3xFB2A8GiuAkR6Q9S6KQd+Ep/TFk1jpNHGoo31fCnLTrRT39I8Fo8h4p
   2Wcyct+52Wuug5qZzHN2ixRMmqI/72ERV/1Ng5RkHgmAIdbBuYiScr783
   pNklhXhKOhXXuyjON+tpOgZfUkQMY/zGPjgmiyDscbjQaFnpD/ZUk/YKd
   qZrMMWFrWG1u91NZo2JDSqH4IZH0dFqmLue9NOlnKGAuzznOzqPqdDB3B
   udFHXBJk3uitTEIGecGgK+wYL7gb4VvJbWnAa4teyHHtlIiXMzs4ohkMy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448055579"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448055579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922409490"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922409490"
Received: from hongy-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:05:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175436.work.031-kees@kernel.org>
References: <20230922175436.work.031-kees@kernel.org>
Subject: Re: [PATCH] platform/surface: aggregator: Annotate struct
 ssam_event with __counted_by
Message-Id: <169573350863.5370.3148602716407027239.b4-ty@linux.intel.com>
Date:   Tue, 26 Sep 2023 16:05:08 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:54:37 -0700, Kees Cook wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ssam_event.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/surface: aggregator: Annotate struct ssam_event with __counted_by
      commit: 9cf63f3a33e929f7eca36409914b8c12102b9984

--
 i.

