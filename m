Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0B7E5F31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjKHUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKHUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:31:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6D213A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:31:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C1C433C9;
        Wed,  8 Nov 2023 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699475461;
        bh=oPn6KS+Zvkah5IriBkZDjAISiIA9Wf5qt6C30aHY68U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5F0BU0gws/cuOzT8grC+rUiK7lzjZHV2/AzH61SrghHMHuwEyBLVBy8qlvNndYg7
         efYmP9h55PnkE+wOrMusUV07kygpRTC061HFyC83CdIrUWgpuPq4w6D9Nk7hHLw3Z+
         7l9NgmVAUmae5ncrO6YyBbhNzPxI5JE7z75rNdX6BLhANq8FLH8iI8/vn4HH/wz6Gg
         pG85hHkswC3US32CLAy/s61FazpRSwQa/SoBadbOtZIRUN5OlAgU+nKWNpxufrITgF
         MnivqAAc3gPMMgJpjdQ5JCoJlMQoUA8pSeksSD9L/IFGY2qMkvfqcy8rNNC7Dj9ItE
         /wnOsq7d/uSGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38EC14035D; Wed,  8 Nov 2023 17:30:59 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:30:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests:FIx spelling mistake "whic" to "which"
Message-ID: <ZUvwAzCV2GEog4IX@kernel.org>
References: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
 <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 30, 2023 at 09:30:58AM -0700, Ian Rogers escreveu:
> On Mon, Oct 30, 2023 at 2:12 AM zhaimingbing
> <zhaimingbing@cmss.chinamobile.com> wrote:
> >
> > There is a spelling mistake, Please fix it.
> >
> > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/attr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> > index 61186d0d1..97e1bdd6e 100644
> > --- a/tools/perf/tests/attr.c
> > +++ b/tools/perf/tests/attr.c
> > @@ -188,7 +188,7 @@ static int test__attr(struct test_suite *test __maybe_unused, int subtest __mayb
> >         if (perf_pmus__num_core_pmus() > 1) {
> >                 /*
> >                  * TODO: Attribute tests hard code the PMU type. If there are >1
> > -                * core PMU then each PMU will have a different type whic
> > +                * core PMU then each PMU will have a different type which
> >                  * requires additional support.
> >                  */
> >                 pr_debug("Skip test on hybrid systems");
> > --
> > 2.33.0
> >
> >
> >

-- 

- Arnaldo
