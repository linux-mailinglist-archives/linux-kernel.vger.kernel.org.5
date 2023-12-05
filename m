Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA006805D91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjLERzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLERy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:54:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5EE135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:55:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bed6c1716so93e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701798903; x=1702403703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmOpp/HChzOl55OcoRdBhcOCGVB40VIIdOg91siiF/E=;
        b=yVB3bDT+TRHHdZEeDwK/qzT0VXvJRuZQ7JIognxmdVhKQCz1IUnZH+wUWYc0lFfA10
         LbRBpQ2hkai70hPS6feWk3kECLJpSj/MIPca5/hd2vl8kzYPkhQX512D5UZyw9VrbKaa
         6FcLU+IprOJcXrVstoWJuvp0W8pwVspVUCioHFuzWJF1SLOKgCvTCMRN97WJlaRufn8e
         q+vd8D7FWghRQuYJzeajuQZoTDEyS1mqJ5UUxQWY+Cr3YdfzYNTCDQTkbsRwtpeZgai6
         wLuWquEctN/ywUn28HjSsMggwlmLcsoGjSSBelgSeZRmpULgQs+j9wqkYiXnkcHxtjYF
         aAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798903; x=1702403703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmOpp/HChzOl55OcoRdBhcOCGVB40VIIdOg91siiF/E=;
        b=gYrxqGJAz9cdFAjtmkLKhJahOZpFpV7TlB+J1z2vhkfFdJfpgZboFWSCsuv8dHk4Pm
         fFxes+XD0R8Larcgs1bxnItuHv9tvJTypkksWCKapiK+lo0Qubwp/quhPRCUpsjdyJ2u
         fo2DLRXFuk/jkaFdb9knNQVzKwywhNfxhAJvF+TXonnCydsitItUKQ4O9XBbCzm5vLCs
         8UwjSdYrNBBiCiYuaBQifdTTvQ6QEKdVU4NgBZ7oIN3yBgdVfQVHUKp02duAoS9Xxo1L
         n1uB+tuVGe5baLPkJMIJYsV8tB6YoWgCjseJgIt7plRhO/diAPwKMD1TUw9Jnnw7S5Ln
         ZxWQ==
X-Gm-Message-State: AOJu0Yxp8JOhJrv5hA16/iyddzFnq7u/oaf89XiCOVySjpdxB1ZVjau+
        G19L1xxHgOyQiyMlRuLtfWAaFepxFK4lodSlrCzmLw==
X-Google-Smtp-Source: AGHT+IGCOkLKTEZ7NpMGhOY8/jIn6m4+6blei1M8sh5poAYCKw1U7ERJmVrE09Cfrkfq1YUBP9o1510QujKJ8s27JvM=
X-Received: by 2002:a05:6512:41a:b0:50b:ea5c:2823 with SMTP id
 u26-20020a056512041a00b0050bea5c2823mr151458lfk.2.1701798903337; Tue, 05 Dec
 2023 09:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
 <CAM9d7chVZRKUSmXmZS4OyokKfLKp4h8K8RLWehYRpAs5Z4jsbg@mail.gmail.com>
 <5ab76c0c-6333-4452-ae51-9193926c802c@linux.alibaba.com> <CAP-5=fW31eiy8ke0hc_YwCffFRW4PNOUnsN89N_goQq5hgHmJw@mail.gmail.com>
In-Reply-To: <CAP-5=fW31eiy8ke0hc_YwCffFRW4PNOUnsN89N_goQq5hgHmJw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Dec 2023 09:54:50 -0800
Message-ID: <CAP-5=fXMvb+rzKmD1ctwuY_Q5sV5rHe_fD49v7gvxF6GZN+s1g@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 9:12=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Nov 27, 2023 at 10:23=E2=80=AFPM cruzzhao <cruzzhao@linux.alibaba=
.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2023/11/23 =E4=B8=8A=E5=8D=885:05, Namhyung Kim =E5=86=99=E9=
=81=93:
> > > Hello,
> > >
> > > On Tue, Nov 21, 2023 at 6:22=E2=80=AFPM Cruz Zhao <CruzZhao@linux.ali=
baba.com> wrote:
> > >>
> > >> When synthesize thread map, some threads in thread map may have
> > >> already exited, so that __event__synthesize_thread() returns -1
> > >> and the synthesis breaks. However, It will not have any effect
> > >> if we just ignore the exited thread. So just ignore it and continue.
> > >
> > > Looks ok.  But I guess you want to do the same for the leader
> > > thread below as well.
> > >
> > > Thanks,
> > > Namhyung
> > >
> >
> > With my testcase, no error is returned even if we don't do the same for
> > the leader thread blow. Well, I'll check whether the logic is still
> > correct if we do so.
> >
> > Many thanks for reviewing.
>
> Thanks for looking at this. Could you share the test? It looks like
> the thread be removed from the thread map to avoid potential future
> broken accesses like below:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/synthetic-events.c?h=3Dperf-tools-next#n887
>
> Some of the race will hopefully get narrowed by switching to a less
> memory intense readdir:
> https://lore.kernel.org/lkml/20231127220902.1315692-7-irogers@google.com/
>
> Threads racing is an issue in this example:
> ```
> $ sudo perf top --stdio -u `whoami`
> Error:
> The sys_perf_event_open() syscall returned with 3 (No such process)
> for event (cycles:P).
> /bin/dmesg | grep -i perf may provide additional information.
> ```
>
> Generally the races are covered by the dummy event that gathers
> sideband data like thread creation and exits, which is created prior
> to synthesis. It would be nice to have a better threading abstraction
> to avoid these races.
>
> Thanks,
> Ian

Fwiw, we hit more of these issues when running the test suite in
parallel. I posted changes to do that along with a similar fix:
https://lore.kernel.org/lkml/20231201235031.475293-1-irogers@google.com/

Thanks,
Ian

> > Best,
> > Cruz Zhao
