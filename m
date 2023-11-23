Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3667F65DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjKWSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:00:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96711F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:00:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso13029a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700762411; x=1701367211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC1A8FYWCE9VFXIWJCcHsK/1/70L94HS4n6KVdO2o8A=;
        b=eryl6WgvluWuvqsuvNz+n6Cin8fCM1fVm+YqTcpyHHvgvM1HkxyvVPtynz5R9YOEtw
         lalRDk7PV2k2PUKSYNIT4MZjx2NjV7vPwnaPaufc7h/XqXqz8/jAMi+ZZMmYUst8B2eV
         bWje0hX1zICLBmQol88EnygPKeBOsXYfhEDCwNsY5goWKcreRwutla00Lg7VzBD76HF7
         gaMzI+RNl0fpDio8LxQSHBLGp3rleQp/JKjWcogK28xrJQtJbKDQdJOjOUP+KUDXiKIM
         ch5dSMWzhSQAfMGat9YSJ1CUqqg37N+YuT4+NCF0sj6PyYtLusxpataKI1d/tyWQrEGG
         lwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762411; x=1701367211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC1A8FYWCE9VFXIWJCcHsK/1/70L94HS4n6KVdO2o8A=;
        b=VcgWmIQ4N6+g7defxXeptwKFpLpwShvm3s8EMXaq48vOO7NWHQbWKH+7NjQoymA2Ox
         MXWUbCpALwU4Wo+QIR6kPGlc5+5dBGcsOs95IpBJ7GOBFnBdrPYg8ik1hXHbJtBnl7gp
         Y4hcSAe5R5Vtyg3opzlFhVkAjbyR4eN4XDVI8LgOv3YrsRejvi+mi1uAbO1MBbnRn/bW
         oknXD76Q7LpNE1xP4sLcO/eb27y48/EvfFkMySv4qfUmQUKh+KWAJwn12Gp0Ld2195wZ
         NcmHFPsK8mwDEndGp0ZjE0AeT5O5Ezp8rqT5N1yzEX9uOerUgAfyb4g8Mrgx9bM4aOZ3
         sEdQ==
X-Gm-Message-State: AOJu0YzNRQg+mx8QBvaV/hrTRnhLhkAIos2uT8QEWeQvBIXysNeO/Ek5
        rdLc6suIX/4fu8NQABbEs0aUbSfuyOlrgrkJUvLn2w==
X-Google-Smtp-Source: AGHT+IHoBIIXEGSlxDzz0Dj3khuJipljirn6ek0M2FA+OCRKBDUg44tbPGTWEee8EfzTFB6XoqrHGN7ahfjVHOEnbQM=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr327312edb.1.1700762410841; Thu, 23 Nov
 2023 10:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20231123042922.834425-1-irogers@google.com> <86cyw0zeiu.wl-maz@kernel.org>
 <CAP-5=fXjX2pNmmX3WOY=m0BqUHTR2YPKVki6bbgG3g1Btc2=Ng@mail.gmail.com> <86bkbkzc2p.wl-maz@kernel.org>
In-Reply-To: <86bkbkzc2p.wl-maz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Nov 2023 09:59:59 -0800
Message-ID: <CAP-5=fUU4ZRLUrg7h+ua0f9mJBONfTd2JuCRPaXq2CApk5-_fA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:09=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 23 Nov 2023 15:27:54 +0000,
> Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Nov 23, 2023 at 7:16=E2=80=AFAM Marc Zyngier <maz@kernel.org> w=
rote:
> > >
> > > Again, perf gets shipped in distros, and not necessary as the latest
> > > version. Rather, they tend to ship the version matching the kernel. N=
o
> > > backport, buggy perf.
> >
> > Please complain to the distros. I complained to Debian, we got rid of
> > the horrible wrapper script thing they did. I complained to two
> > separate Ubuntu people over the last two weeks as they still have
> > broken packaging even though they derive from Debian. Fedora is of
> > course perfect as Arnaldo oversees it :-)
>
> In this instance, I don't need to complain to anyone but you. And
> guess what: it is on Fedora that this issue was first discovered.
>
> I also don't see what distro packaging policy has anything to do with
> the issue at hand, but that's beside the point.

Because the latest perf tool is always improved and carries fixes,
just as say gcc or clang. We don't ask these tools to backport fixes
and then deliberately run out-of-date versions of them.

> >
> > > And again, I don't see a bug in the PMU driver.
> >
> > Whether the PMU driver is requested a legacy cycles event or the
> > cycles event as an event code, the PMU driver should support it.
> > Supporting legacy events is just something core PMU drivers do. This
> > workaround wouldn't be necessary were it not for this PMU bug.
>
> Again, *which* PMU bug? What is a legacy event, and when has this
> terminology made it into the kernel? Who has decided that a change was
> necessary? Why haven't you submitted patches upgrading all the PMU
> drivers to support whatever you are referring to?

I did fix ARM's PMU driver for extended types, James Clark took over
the patch. The term legacy has at least been in use in kernel source
code for over 11 years:
http://lkml.kernel.org/r/1337584373-2741-4-git-send-email-jolsa@redhat.com

An issue I face in fixing somebody's PMU driver is it is ever so
useful to be able to test. The work done with James was done blind by
me except for checking for regressions on a raspberry pi 4, which
isn't heterogeneous (nor is the 5 *sigh*). The fact there were bugs in
ARM's PMU driver for so long shows a lack of testing by ARM and we've
been going out of our way to increase testing. Something positive ARM
could do in this area is to update the parse-events test, yes the one
that is supposed to test issues like this, so that the hardcoded "cpu"
PMU assumption that works on most platforms who name their core PMU
"cpu" also works on ARM. For bonus points setting up testing so that
we know when things break would be useful. As mentioned in previous
emails I hope to work away from needing an actual machine to test the
perf tool's correctness, but we're a long way from that. There are
very many BIG.little Android devices in the field where the PMUs are
not set up as heterogeneous, ARM could contribute a CTS test to
Android to make sure this doesn't happen.

Thanks,
Ian

> > This change impacts every user of perf not just a partial fix to
> > workaround ARM PMU driver issues, see the updated parse-events test
> > for a list of what a simple test sees as a behavior change.
>
> When making far-reaching changes to a subsystem, I apply two rules:
>
> - I address everything that is affected, not just my pet architecture
>
> - I don't break other people's toys, which means compatibility is a
>   *must*, not a 'nice to have'
>
> By this standard, your complaining that "ARM is broken" doesn't hold.
> It was working just fine until your changes rendered perf unusable.
>
> Nonetheless, thank you for addressing it quickly. This is sincerely
> appreciated.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
