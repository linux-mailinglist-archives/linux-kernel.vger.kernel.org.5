Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C17C7AF9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjI0EqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjI0EpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:45:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E21BB84
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:07:09 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41958410e5cso227951cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695787628; x=1696392428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0nMoCs35unZfclTu3DKp3uZsoT22xTXBwaLiGdkdWQ=;
        b=GmrGZwQOhEVqm+OG9/SbQUKxe/HC3FGo0BMMHGQDUJUicFFi6E7LLg49haja2g7jR0
         GH7AIzWgxZgaKiCgEqcbMpiIuteR2fXKdx5V7a6vl7u5V7wRkBoD81BQhUdAI1SBSHFW
         E9BvHRjDotaAohAfYpaDEj0a1BAdFP3qNyy8msx5pdwMBUw0t+zy/NiRCh0NQCXFVuND
         Ff4R6Eee2C3F+EGpBjkSBgLYHFeoKrT0pXeLO8eVUFrZ2JsblxTpiF0jvBSG1LLw3RWN
         ldmY3324yh5Zfbn+h6AU39p3QYDWBn1VmVY5ByHmmZ8sHWcdE/6DR2fkCnGjRh1Dip3C
         bHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787628; x=1696392428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0nMoCs35unZfclTu3DKp3uZsoT22xTXBwaLiGdkdWQ=;
        b=f1JsYBhcUqn2dz1qWDQxVlLEauXMc+xu9gtoWx3ZFBAMOm2pU4plnWb2KM9EgiSbFJ
         Q2jH76V9pyFKTobUhOHYMJ/cVlj2Mr+mzHBbWxwZXkIk8E/FZV3E5mopPsELN8KPsxGp
         axheFZywy6cRc0xjfyczO9ZDYEQKNszNY2bVwKNvpue9oI0S86V7/JuhoefTWr3nv3Tn
         3YVOyQtb3ixsaN6zvK3q0wCg3fqWUkFe7kddP3WqPEwUgGiHLdQuMD68Orc+gSmNx5IY
         4Hm9UCsvosY05Ke98OVAyzkUeSQ5LrhrffUyONxnJQPyYP21AyolQb+uuENOAUGGSBpE
         b8nw==
X-Gm-Message-State: AOJu0YzoYsHe0FAUMKAlS7C4G5t9MbCy0MPlN9TSRc8B0UdGSzupbz/s
        QGShJUF/uCFBjyZX6nleOAXblgNw6OW2LdnuIJvRGw==
X-Google-Smtp-Source: AGHT+IFCXgdLLs1mW7I4BlBzVeMEB6FdpuzGm3k488f4N7W5WLbOWSAiS2RMjWpKOJAXI6lI/9CZr5elbMW47291M04=
X-Received: by 2002:a05:622a:188c:b0:410:9855:acd with SMTP id
 v12-20020a05622a188c00b0041098550acdmr483377qtc.14.1695787627958; Tue, 26 Sep
 2023 21:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com> <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
 <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
In-Reply-To: <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Sep 2023 21:06:56 -0700
Message-ID: <CAP-5=fW7dsMw0i7N-oQ7dcz9sFx1hAtZCpsxuH=NqMz+h+i3ZQ@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Wyes Karny <wyes.karny@amd.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 3:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 20, 2023 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Sep 20, 2023 at 5:24=E2=80=AFAM Wyes Karny <wyes.karny@amd.com>=
 wrote:
> > >
> > > The perf_pmu__parse_* functions for the sysfs files of pmu event=E2=
=80=99s
> > > scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> > > ("perf pmu: Be lazy about loading event info files from sysfs").
> > > However, the paths for these sysfs files were incorrect. This resulte=
d
> > > in perf stat reporting values with wrong scaling and missing units. T=
his
> > > is fixed by correcting the paths for these sysfs files.
> > >
> > > Before this fix:
> > >
> > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >    351,217,188,864      power/energy-pkg/
> > >
> > >           2.004127961 seconds time elapsed
> > >
> > > After this fix:
> > >
> > >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >              80.58 Joules power/energy-pkg/
> > >
> > >              2.004009749 seconds time elapsed
> > >
> > > Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info file=
s from sysfs")
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Applied to perf-tools-next, thanks!

Thanks Namhyung, I think this should be a candidate for perf-tools so
that 6.6 doesn't regress for sysfs events.

Ian
