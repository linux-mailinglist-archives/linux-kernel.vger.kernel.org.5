Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB45F7DE3C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjKAPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjKAPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:35:31 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF912C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:35:21 -0700 (PDT)
Date:   Wed, 1 Nov 2023 16:35:15 +0100
From:   Guilherme Amadio <amadio@gentoo.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH next 2/3] perf tests make: Remove the last egrep call,
 use 'grep -E' instead
Message-ID: <ZUJwM871HsAZbBXT@gentoo.org>
References: <ZUEdtblE8qDAQkBK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUEdtblE8qDAQkBK@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 31, 2023 at 12:31:01PM -0300, Arnaldo Carvalho de Melo wrote:
> One last case, caught while testing with amazonlinux:2, centos:stream,
> etc:
> 
>    4     7.28 amazonlinux:2                 : FAIL egrep: warning: egrep is obsolescent; using grep -E
>    8    13.87 centos:stream                 : FAIL egrep: warning: egrep is obsolescent; using grep -E
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Guilherme Amadio <amadio@gentoo.org>

Looks good.

Reviewed-by: Guilherme Amadio <amadio@gentoo.org>

Cheers,
-Guilherme

> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/make | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index d9945ed25bc5ae96..8a4da7eb637a8abd 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -183,7 +183,7 @@ run += make_install_prefix_slash
>  # run += make_install_pdf
>  run += make_minimal
>  
> -old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
> +old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| grep -q -E "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
>  
>  ifneq ($(old_libbpf),)
>  run += make_libbpf_dynamic
> -- 
> 2.41.0
> 
