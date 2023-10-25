Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B026F7D6152
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjJYFwE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 01:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYFwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:52:03 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1E12F;
        Tue, 24 Oct 2023 22:51:54 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso3670181a91.1;
        Tue, 24 Oct 2023 22:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213113; x=1698817913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TMBfJBS6+PFjOoTjREUjGF4g9nD1G3ML89T7sHAIHE=;
        b=II2AkRLF6IPNL205+OTGUatUsEU3SWGKh68OXC4qkEjkHvv7/v6H3vwlLPjc8GgMdC
         N2qkBfEF82oYLnuVIuMoLNduH0n6Rr47LzNvOMi0Td3E0+tbHasPHdgCg2i/R3mxA9D+
         XFGjvLD0qpR7oQCbc0HsZ0SsbCRlCjJ0eA5YfYUNNvB2W1shJ9bp0bAxzZufjsajFepN
         5WGyW7LCdCoIfNNkdfALHkIrNBD+GUW+aeyYbyoHy0nJ8CnXPKeXUrVkwAvX/fMhXpt4
         yhimHvBMxQeZDUycJeC22P4WTpAP6euCZujB6D3Z5hLZ3AxBltjeOtSTX+fxt+uNAzRb
         4xcw==
X-Gm-Message-State: AOJu0Yy4OVnmG1wOX1fmaWfryP4i+MNWYVHJnomzOw1T1MQYVd5I1ZMB
        zak7GpKpqMam8geZqhrOsPIAcg2ItnrEXjUrMks=
X-Google-Smtp-Source: AGHT+IHs6VkUGZcdZf7cWbqnymCoL3HDLsrq7a6rHvnt2eg1riPr61FqkJKAeE2+gtViW6QDTWgTrhrfzcetKAkILH4=
X-Received: by 2002:a17:90b:3784:b0:27d:8fbd:be95 with SMTP id
 mz4-20020a17090b378400b0027d8fbdbe95mr11992237pjb.28.1698213113310; Tue, 24
 Oct 2023 22:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <87pm15vw5r.fsf@linux.intel.com>
 <CAM9d7ch504cnFzTL1qPh349uSrbEZop19kB-DbUsnoOKEvtFBQ@mail.gmail.com> <ZTh41epbjwGsMPaB@tassilo>
In-Reply-To: <ZTh41epbjwGsMPaB@tassilo>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Oct 2023 22:51:41 -0700
Message-ID: <CAM9d7cgin9=dh-cypSzpvfZu_N7qv8Gxg0VVGdOm+VXB8i1FAQ@mail.gmail.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 7:09 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> >
> > >
> > > The main difference seems to be that mine was more for perf script
> > > (e.g. i supported PT decoding), while you are more focused on sampling.
> > > I relied on the kprobes/uprobes engine, which unfortunately was always
> > > quite slow and had many limitations.
> >
> > Right, I think dealing with regular samples would be more useful.
>
> My code supported samples too, but only through perf script, not report.
>
> See
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git/commit/?h=perf/var-resolve-7&id=4775664750a6296acb732b7adfa224c6a06a126f
>
> for an example.
>
> My take was that i wasn't sure that perf report is the right interface
> to visualize the variables changing -- to be really usable you probably
> need some plots and likely something like an UI.

I see.  Your concern is to see how variables are changing.
But it seems you only displayed constant values.

>
> For you I think you focus more on the types than the individual
> variables? That's a slightly different approach.

Right, you can see which fields in a struct are accessed
mostly and probably change the layout for better result.

>
> But then my engine had a lot of limitations, i suppose redoing that on
> top of yours would give better results.

Sounds good, thanks.
Namhyung
