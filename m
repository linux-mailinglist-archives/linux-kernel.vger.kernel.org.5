Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64E7F4DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjKVRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:05:05 -0500
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289A11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:05:01 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700672699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=104QOQ5hEY0RkqRaNEmxReWHLK4LQLrcVAu7ReXzItk=;
        b=bdxT/MSq/mhr3LycsyubYA0F0Hu/Y8N2nuriSNHcum/SOEADVHMHODsibQ2/s+N81ScnMy
        MVwv3NIwU1Wj05pke97e1iSDCD0/fD5FMjFe128atet1S8YYB5zQGIYHlIy22k9/QpzS7h
        XAjUsGF5a4dUdv22yurd032PnwlE8YA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
Message-ID: <ZV40tp7uiaTk-Qp1@linux.dev>
References: <20231122022805.511839-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122022805.511839-1-irogers@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers wrote:
> The necessary files for generating sysreg-defs.h need adding to the
> perf tool MANIFEST that lists the files for packaging the perf tool
> source code. Fix for the following:
> 
> ```
> $ make perf-tar-src-pkg
> $ tar xvf perf-6.7.0-rc2.tar
> $ cd perf-6.7.0-rc2
> $ make -C tools/perf
> ...
>   PERF_VERSION = 6.7.rc2.gc2d5304e6c64
> make[3]: *** No rule to make target 'perf-6.7.0-rc2/arch/arm64/tools/gen-sysreg.awk', needed by 'perf-6.7.0-rc2/tools/arch/arm64/include/generated/asm/sysreg-defs.h'.  Stop.
> make[2]: *** [Makefile.perf:456: arm64-sysreg-defs] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:242: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory 'perf-6.7.0-rc2/tools/perf'
> ...
> ```
> 
> Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
> ---
> Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

I had sent out fixes for both of your comments [*], no preference as to
which gets applied. So, FWIW:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

[*] https://lore.kernel.org/linux-perf-users/20231121192956.919380-1-oliver.upton@linux.dev/

-- 
Thanks,
Oliver
