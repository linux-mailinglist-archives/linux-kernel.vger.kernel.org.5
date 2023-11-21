Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A77F221C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKUAWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUAWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:22:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A75C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:22:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aa698b384so1127e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700526156; x=1701130956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSZDmH1lmOHmDaW+5zk2UkeOzV5JR2ghLJakWOUafsQ=;
        b=pCrU05CTRbjjWe1SZAiGYLBkWN12AhHY1l3wsBkVvVGuyF5j7sf77P7w4N08kWZMGZ
         2KrteqZxfhf0h46iO7gqV/6nnkNvjou5jG68K2zE3pC8l5Ua5OXz6RUVGUo4/WhKraM6
         jvJpfXwmwLhzYvzLyqMFSWY/zI1KFKPigAtA11KSi1ubI2thkdJ1bH9kquBo5euBMRbR
         m0XhF5gy4icvUI1+0xBoF0cFdpiOEqwEXfrw+xxbyxn4VKNhmtSVv2yC6BHW6v95A8zr
         mpJ9ikc/bf/7Nq/gsBjWJUcQAXfvW7/Ise0EKwGgi3vjVSEg6ursv/I6s4gGTVmmGJWn
         hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700526156; x=1701130956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSZDmH1lmOHmDaW+5zk2UkeOzV5JR2ghLJakWOUafsQ=;
        b=CeOHG/DIVmW3hC0Ra9nbj3K2vmkOn8ZUY1IadlaG1mMtpPBXzNBz4B+BbHg62MIHXy
         wFqGsmzO9DDy6yPNBQnaAEWm0TsOVaV5D8B3j0lEEIGg7H09+ENizWp4qipwkZu3oh27
         l3SMJ3qX3c2zz95k+msRSCskfVqDuYsdKYmzbpJnq+NjsHO2wlU/M7g0SLnuhSpwpIex
         Z95frs4WIBXIIIWusTFPaS9ZNgTPaBQ6sK1Ib7/zesQ5bu8G9PxEW/L2AMjdAFpzxPK2
         s0Negz9WETFHKSrR1CHs9LYtUt3ft+4YH2d6SQqi7fNfQNN0daQ0MfeHuzP7OikhnsBC
         s7UQ==
X-Gm-Message-State: AOJu0YwzlAmikgEw2V7yG04LgGRIM8DuaX5YHfGWio38P5IEq1fqWoj5
        TJX+rykl+hsfEOlf9LA2Koef2PPh5C3T+6cGJDkEsQ==
X-Google-Smtp-Source: AGHT+IH8hvQTHYXJu/GZqZQTccj5xJ94NpUXMb/QmGRXcQJ27uSCNO6Ggsyzf22kqcVTLpDcZnncKcgovuIIJqHrYUk=
X-Received: by 2002:ac2:54b4:0:b0:505:7c88:9e45 with SMTP id
 w20-20020ac254b4000000b005057c889e45mr215951lfk.0.1700526156322; Mon, 20 Nov
 2023 16:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20231107184020.1497571-1-kan.liang@linux.intel.com> <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
In-Reply-To: <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Nov 2023 16:22:24 -0800
Message-ID: <CAP-5=fVqWc70w1twQdOK3u6dzS_u3ELAtcr--qmiP5x+vkbK+w@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Basic branch counter support
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, tinghao.zhang@intel.com
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

On Mon, Nov 13, 2023 at 8:12=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> Hi Ian,
>
> On 2023-11-07 1:40 p.m., kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Add a basic test for the branch counter feature.
> >
> > The test verifies that
> > - The new filter can be successfully applied on the supported platforms=
.
> > - The counter value can be outputted via the perf report -D
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >
> > Changes since V2:
> > - Update the output msg for the skipped case (Ian)
> >
>
> Any comments for this patch?

Confirmed the wildcard works as expected.
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Kan
>
> >  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 4fbc74805d52..cc207a16ae24 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -11,6 +11,9 @@ err=3D0
> >  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >  testprog=3D"perf test -w thloop"
> >  testsym=3D"test_loop"
> > +cpu_pmu_dir=3D"/sys/bus/event_source/devices/cpu*"
> > +br_cntr_file=3D"/caps/branch_counter_nr"
> > +br_cntr_output=3D"branch stack counters"
> >
> >  cleanup() {
> >    rm -rf "${perfdata}"
> > @@ -154,10 +157,37 @@ test_workload() {
> >    echo "Basic target workload test [Success]"
> >  }
> >
> > +test_branch_counter() {
> > +  echo "Basic branch counter test"
> > +  # Check if the branch counter feature is supported
> > +  for dir in $cpu_pmu_dir
> > +  do
> > +    if [ ! -e "$dir$br_cntr_file" ]
> > +    then
> > +      echo "branch counter feature not supported on all core PMUs ($di=
r) [Skipped]"
> > +      return
> > +    fi
> > +  done
> > +  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev=
/null
> > +  then
> > +    echo "Basic branch counter test [Failed record]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
> > +  then
> > +    echo "Basic branch record test [Failed missing output]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Basic branch counter test [Success]"
> > +}
> > +
> >  test_per_thread
> >  test_register_capture
> >  test_system_wide
> >  test_workload
> > +test_branch_counter
> >
> >  cleanup
> >  exit $err
