Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19387776DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHJCCI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 22:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHJCCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:02:06 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47769C6;
        Wed,  9 Aug 2023 19:02:06 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d4789fd9317so392267276.1;
        Wed, 09 Aug 2023 19:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691632925; x=1692237725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pg7ID7Bt2SnW3Yar69Ra983Gv0keYFyvDeWnOq+8Bw=;
        b=JZYdfD0ujJkp5v+NPrk6QkHPitiDGWJyD7PK9VSHGN4R6/q8Qj9NFAMHCIy6KgTPgW
         xDnELUvoN1o2kRe9o3w86pT+LUZuVSK1z3kk47vp/vvNjk1TSQaLTt2hwoqFl8z47BvG
         cB8VD4NL5ToLMuIA0K/Nw/cZjqG6jrJua0ypz6KYacQU8Ngtu6zdIGAGbw07Tw2hVa6+
         YcKt7UfU+9W2a9pbjvr4zd6lHCMKpoToiikzJts6JwjakNyEyIJrvG33cBAgbxBi0M/5
         /95+5DAkva99J/1hRhV3n1u7wHyM6kWFOWruA1rLJFto/8z9/Rt1Hx9EmVcDFRzWvh8W
         VPUA==
X-Gm-Message-State: AOJu0YzeUNTbockqAvizfCXVgcrZbKLa1BKe8wDyDBGsMPdKmz95ZOpI
        n020x1EyUnJL15/4/m6nM4o/P0x5l8/7O3PLPOI=
X-Google-Smtp-Source: AGHT+IHvYmVlQmcl/rv2AWIIEO5l1l22fcEAG3AsSxhUORT/eIakT8fMwzlQG7Oir6pbmnODStPB55N8dUzj8sFcBLo=
X-Received: by 2002:a25:2fd2:0:b0:d19:824a:490e with SMTP id
 v201-20020a252fd2000000b00d19824a490emr1243486ybv.31.1691632925276; Wed, 09
 Aug 2023 19:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230728022447.1323563-1-namhyung@kernel.org> <ZMPMHNjX2IxsLbAe@kernel.org>
 <CAM9d7cgqJatFn0tQVOxoQymFUruSzniPi5Okb1sotb6VLt+X_g@mail.gmail.com> <ZNOUb1Q5ifyLju/q@kernel.org>
In-Reply-To: <ZNOUb1Q5ifyLju/q@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Aug 2023 11:01:53 +0900
Message-ID: <CAM9d7ci19a2dHD8EesqJZqmfCA8=MWe2FkecryV9nOEfwvvO6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf build: Update build rule for generated files
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 10:28 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 09, 2023 at 03:56:17PM +0900, Namhyung Kim escreveu:
> > On Fri, Jul 28, 2023 at 11:09 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Thu, Jul 27, 2023 at 07:24:46PM -0700, Namhyung Kim escreveu:
> > > > Let's update the build rule to specify those cases explicitly to depend
> > > > on the files in the output directory.
>
> > > > Note that it's not a complete fix and it needs the next patch for the
> > > > include path too.
>
> > > Applied, testing it on the container builds.
>
> > I don't see these commits in the perf-tools{,-next} yet.
>
> 6 days  perf build: Include generated header files properly     Namhyung Kim    5       -9/+9
> 6 days  perf build: Update build rule for generated files       Namhyung Kim    2       -0/+16
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=7822a8913f4c51c7d1aff793b525d60c3384fb5b
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=c7e97f215a4ad634b746804679f5937d25f77e29
>
> Did I miss something?

Oops, my bad.  I somehow overlooked the commits.
Now I can see it in the perf-tools-next, sorry for the noise.

Thanks,
Namhyung
