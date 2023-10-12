Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A97C78B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347416AbjJLVjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbjJLVjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:39:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE2C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b70b9671so28115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697146750; x=1697751550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZaBwnc9uNu74MX7ZLYzqaku34OafJp0HOL1x0Q9+w4=;
        b=CR6QYJgBByrcU3jzoq4+xYPe90tnQmRd+2Djhg9VwBkgphGj2vMgwOss9aSKirGItl
         dnBS3BSySfWc2zsbFAAOiGTRgnOhtFGZ6HI10YRJpRAXZCJf/f5mqFOLh0oHJwPHqgfI
         s+1x310LBt9gTrF+xKOLALF4GptCvIbHF3/5tH7kTl9zuExl2bKigKvY5QZz1vjwvdLu
         9riHrpk51rWTy3J0SLSDjxhyyq0HQfRaBpFe/0to8Dzln94YbMBvZkbsGru4sNH+3wQG
         LhobMSZpCQ855seLxJgUX9bSdQ6YF/lMBlkx1Iln/adpVeIbIHU6M6rzNEyzz460Lsju
         R8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146750; x=1697751550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZaBwnc9uNu74MX7ZLYzqaku34OafJp0HOL1x0Q9+w4=;
        b=eN68jg1+O/ZKxoCm2Rl4lxfcx7Tue92Qjpm8AePDIgDAD3ht5r1Fnfk2HRXUHprBVm
         h5GkD5EO0TJT5fMHMpFg4g/gVmmieFNpvaECgGCCCHHbGCAGRYK/XKbmQA9SfhJ0nNP8
         d/JUPYsoQmD4nEa9Kg87CFHZDxMRU9sDM5n63iueRjTMKivfJW5q6HAVJNuGOJqKU0Bl
         4DvgTldY1qpi7n86+9MweQ1junJA/fGxZWF+jpRr+pl0Kfss5bxDNBQVcR96LBXDE95Z
         +rhpWG3jGZHc0FRydBUIhF6tUitb6v7Z8wIFdEawM+DWfp6OxxRVPZB9bjZ5JI+TvCkM
         F9rA==
X-Gm-Message-State: AOJu0YywWhr9L4m9ZqkfVVgISYMxvoG8gCsPBq2Oy2YpKnB/LXJtyTNR
        J6NyUl32qD979ni1JQPb/ZSJ8qNVmyWLvhrMIN1wRQ==
X-Google-Smtp-Source: AGHT+IHYfc8IcgbTLPAkxELNwiOXnqgBWr+m3vbfGn3tda4JkEDig7mFMjwz2dSvHJZSuXgEFJjYQPqFixYh0QCwwag=
X-Received: by 2002:a17:903:40c1:b0:1b8:9551:de55 with SMTP id
 t1-20020a17090340c100b001b89551de55mr70184pld.26.1697146749794; Thu, 12 Oct
 2023 14:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <20231010032117.1577496-4-yosryahmed@google.com> <CALvZod5nQrf=Y24u_hzGOTXYBfnt-+bo+cYbRMRpmauTMXJn3Q@mail.gmail.com>
 <CAJD7tka=kjd42oFpTm8FzMpNedxpJCUj-Wn6L=zrFODC610A-A@mail.gmail.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com> <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
In-Reply-To: <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Oct 2023 14:38:58 -0700
Message-ID: <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Yosry Ahmed <yosryahmed@google.com>, michael@phoronix.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 2:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> >
> > Yes this looks better. I think we should also ask intel perf and
> > phoronix folks to run their benchmarks as well (but no need to block
> > on them).
>
> Anything I need to do for this to happen? (I thought such testing is
> already done on linux-next)

Just Cced the relevant folks.

Michael, Oliver & Feng, if you have some time/resource available,
please do trigger your performance benchmarks on the following series
(but nothing urgent):

https://lore.kernel.org/all/20231010032117.1577496-1-yosryahmed@google.com/

>
> Also, any further comments on the patch (or the series in general)? If
> not, I can send a new commit message for this patch in-place.

Sorry, I haven't taken a look yet but will try in a week or so.
