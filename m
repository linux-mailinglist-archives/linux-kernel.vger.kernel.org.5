Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CC80E772
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjLLJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbjLLJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:22:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABEC7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:22:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031C3C433C9;
        Tue, 12 Dec 2023 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702372948;
        bh=y2xsGb6RdvYsGGAGFOAQIzQJ6okr5i37jR6Lpnt+43M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/psbpJYEtYuZTuyXHJYvdka47RF94LB1JwEiJqaCq8YO02yaAkQwWAA6h6sm65Lv
         uwGeEhiMRXz+lJNZeFdSCV76zkKw7BPgKub/g+75bZp4L80iJt+p8M+b0Ob24tCD6R
         aXxO3B6ajO10HKbB8POwK6y7BybkjlF/eYo6HrJ8WZTz7OjSMKig1CISScmJrtO4fp
         wyha1ZLLOrlVb1fjkO+06DypQiRhFyVNNHC22SXwNsN4wWn4rJyUcxyx8tmzbYXOtf
         3/nU8Kq9P3sNAFejXy1tEzei4kSSVvIfd10FYKemXQxLDeqJFd3vzh3/2zr6kjER9q
         U8PY9Ra9FA2WA==
Date:   Tue, 12 Dec 2023 09:22:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marco Elver <elver@google.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Robert O'Callahan <robert@ocallahan.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/4] perf/bpf: Remove unneeded
 uses_default_overflow_handler.
Message-ID: <20231212092221.GB28174@willie-the-truck>
References: <20231211045543.31741-1-khuey@kylehuey.com>
 <20231211045543.31741-3-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211045543.31741-3-khuey@kylehuey.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 08:55:41PM -0800, Kyle Huey wrote:
> Now that struct perf_event's orig_overflow_handler is gone, there's no need
> for the functions and macros to support looking past overflow_handler to
> orig_overflow_handler.
> 
> This patch is solely a refactoring and results in no behavior change.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 16 ++--------------
>  3 files changed, 8 insertions(+), 20 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
