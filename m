Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878597E5F76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKHUs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:48:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6211FFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:48:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE109C433C7;
        Wed,  8 Nov 2023 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699476535;
        bh=bAnaPB12EhMMxlOPREjkkP5xb54JhV/TtGOOJB6uzf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgadgllr5jTXFXidg1mZbniQ9QzWyHD0VkgNcAfMM50BAd76WfQ9jgO9vaD0wS5Lv
         0Dq/cs9mvrHY8EeF6Yycz5jUeuv3D2o7MkliQoOY7SFyhMddkbqF9EtHmfmOSKX8Vg
         isPNc0tLVeYMjQxXKNfvKXYMDo3iFUo8b46TT/WNmtpQmiCJN4gEqWCQOhmzw1ib7S
         pipEly93WVHxWz+Y+yyJFnpilVahDEO9QyOpyva7Jd8QhWaD6rgkNU6AIuXBv93w/3
         LVF6FYuFOqE3neMhzJHk2W9xlWHYfh8bYr9Z7vsYcSK78MkIeHSoFshkz8QEgVxwOp
         HoBtXVrYv4m+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8BAAA40A1E; Wed,  8 Nov 2023 17:48:52 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:48:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] perf test: Add option to change objdump binary
Message-ID: <ZUv0NKS7d4vYQMxy@kernel.org>
References: <20231103113501.490012-1-james.clark@arm.com>
 <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
 <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 07, 2023 at 09:37:32AM +0000, James Clark escreveu:
> 
> 
> On 03/11/2023 15:41, Ian Rogers wrote:
> > On Fri, Nov 3, 2023 at 4:35 AM James Clark <james.clark@arm.com> wrote:
> > > 
> > > All of the other Perf subcommands that use objdump have an option to
> > > specify the binary, so add the same option to perf test.
> > > 
> > > This is useful if you have built the kernel with a different toolchain
> > > to the system one, where the system objdump may fail to disassemble
> > > vmlinux.
> > > 
> > > Now this can be fixed with something like this:
> > > 
> > >    $ perf test --objdump llvm-objdump "object code reading"
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > There is also "perf config" for things like this.
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks,
> > Ian
> 
> That seems a bit better for this use case so I added it in V2.

Have you posted it?
 
> Thanks for the review.
> 
> James

-- 

- Arnaldo
