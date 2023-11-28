Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2C7FC205
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbjK1RNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjK1RNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:13:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8D12C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:13:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4fac45dbso34615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701191592; x=1701796392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu2vtiWbBmtYlN1qlS9uatfpZo9be+0wU6twFhuZRYg=;
        b=YgJ3R/fD373W5NlIq7+374JDbN3vBwPvGVXFhSJ+D8fKnJpZ9hDmepjUWCLKHSyLXJ
         dEpxkPXjwl/nm+G8shunf2ht2TrkimUpq/TgK+0QM01A2inxKsf4ovPw/qZU2sQFApiI
         Cpg5CljT84hyP0f1a3dilEIkNs5rV/xzFe5C2reXm4vsxonPaBv4i93xlimksuQGOb8i
         stCQ2DoTRBlCak4ZLCg+ljUt5u2pPBhCGGbCFhb/iCZhuT9zm7NajG2skgf1U06EH64y
         tdXj3An5C+VG6kj00rAKX7i8zahILZTwJAcAORs4c3WtV9I8KfEzXn/02OQuRpTvK5cR
         /yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191592; x=1701796392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu2vtiWbBmtYlN1qlS9uatfpZo9be+0wU6twFhuZRYg=;
        b=cqBT682l/QmnQgCk4XU9aN9Yuc3YRn3+ZlzaeM854JKGDgTXyJbHX/DDf5pYx0JmC2
         BFD9u70HN882nUF14yvV/GivWVzvA3f0ptB1YAUePxiLj9d8N6S7JxOq3ovrJ/ru9xq1
         FNDtmVvWekXC+PYPQRc2I+TKlwazhg4Xx2YDWIOYcJS0sKTHUbNUFY1M2tdgJIv6TXoi
         p64A+bt3MsQyX7ScWSX7B6HQeYsveAZoZc10ydOrI1gpjhH260lc0Seu++f6YwEngrfu
         U1m0x/CIeTrzTrMkONstgpyZEzVQc7uEjcVsCKAr0NY3FnIL8bhMlthZrw+tyFF49sQi
         Jo1g==
X-Gm-Message-State: AOJu0Yw8JTr+MSOdhUSnNnZ4eHzxDnzzHPjvBLfORrqsPJpVfuAWLwiK
        1qfP374Abd5vGayYG75MuF2AVe7A4LaerO9LzUH0ng==
X-Google-Smtp-Source: AGHT+IHCtOOW44lgBxMOpE8JHTAO2pi3pR4+1Uvu8reVO/53lVh4n24a6hyUhjW9yxt9ErpNWU8RpT6YYxwXhstBOVc=
X-Received: by 2002:a05:600c:218f:b0:40b:43f4:df9e with SMTP id
 e15-20020a05600c218f00b0040b43f4df9emr346794wme.2.1701191592062; Tue, 28 Nov
 2023 09:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
 <CAM9d7chVZRKUSmXmZS4OyokKfLKp4h8K8RLWehYRpAs5Z4jsbg@mail.gmail.com> <5ab76c0c-6333-4452-ae51-9193926c802c@linux.alibaba.com>
In-Reply-To: <5ab76c0c-6333-4452-ae51-9193926c802c@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Nov 2023 09:12:57 -0800
Message-ID: <CAP-5=fW31eiy8ke0hc_YwCffFRW4PNOUnsN89N_goQq5hgHmJw@mail.gmail.com>
Subject: Re: [PATCH] perf: ignore exited thread when synthesize thread map
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kprateek.nayak@amd.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:23=E2=80=AFPM cruzzhao <cruzzhao@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2023/11/23 =E4=B8=8A=E5=8D=885:05, Namhyung Kim =E5=86=99=E9=81=
=93:
> > Hello,
> >
> > On Tue, Nov 21, 2023 at 6:22=E2=80=AFPM Cruz Zhao <CruzZhao@linux.aliba=
ba.com> wrote:
> >>
> >> When synthesize thread map, some threads in thread map may have
> >> already exited, so that __event__synthesize_thread() returns -1
> >> and the synthesis breaks. However, It will not have any effect
> >> if we just ignore the exited thread. So just ignore it and continue.
> >
> > Looks ok.  But I guess you want to do the same for the leader
> > thread below as well.
> >
> > Thanks,
> > Namhyung
> >
>
> With my testcase, no error is returned even if we don't do the same for
> the leader thread blow. Well, I'll check whether the logic is still
> correct if we do so.
>
> Many thanks for reviewing.

Thanks for looking at this. Could you share the test? It looks like
the thread be removed from the thread map to avoid potential future
broken accesses like below:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/synthetic-events.c?h=3Dperf-tools-next#n887

Some of the race will hopefully get narrowed by switching to a less
memory intense readdir:
https://lore.kernel.org/lkml/20231127220902.1315692-7-irogers@google.com/

Threads racing is an issue in this example:
```
$ sudo perf top --stdio -u `whoami`
Error:
The sys_perf_event_open() syscall returned with 3 (No such process)
for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```

Generally the races are covered by the dummy event that gathers
sideband data like thread creation and exits, which is created prior
to synthesis. It would be nice to have a better threading abstraction
to avoid these races.

Thanks,
Ian

> Best,
> Cruz Zhao
