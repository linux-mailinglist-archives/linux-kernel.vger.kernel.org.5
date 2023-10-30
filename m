Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACA7DC02F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjJ3TBJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Oct 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjJ3TBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:01:07 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529FD3;
        Mon, 30 Oct 2023 12:01:05 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4190599b3a.2;
        Mon, 30 Oct 2023 12:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692465; x=1699297265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EccxOXdyEiVBJR4JsYbksdY+qQDRXxpoqTxDKJNnKo4=;
        b=l4XL4OxzDoWFtuzkHBAIuvmkACiYrAg/vaulctmhQSwwqhESM/y+aeBSuAuPWwAa3W
         uAl8I2GiY0xX9vfCytstw6QYHEGNFVJ3s07gc2AtNySXw+fXJyMbuNEZe7Gh7ZBYhlM8
         VvJMqbrC4fQzr5DOSVW/YXR2OrfXXOaghPjxFrDqatuqjWz3wbf2ts7bdh5/zkTyLVde
         +2ZuCnLXtv2Hkf5VujLyghO1Sr4Mmw55vv6nHEmVqRrGxy5OlKns+BB1hx3diqeC8qLV
         oLKEoBMKIil/Hfw5pEFDVgsm8Dht2PYHTTSuLAVG40LWGvN+gKIux6uPPn21mgPywFI1
         oZog==
X-Gm-Message-State: AOJu0YwyQPlKTDR4HClaQX1T42PRQrn2wZqW3lxfMaZLUqUP8GZsYm5D
        C4P9Xqyd+Tspubp4czbKN9NmmuGaEgPG8lAofyY=
X-Google-Smtp-Source: AGHT+IHFuyF4BbsT4e0KeVL/IIS75StuE3RCihAqdEwed4Pg2vmvC79HcXunyaMZjS5ueT6lqx7J8grl7zRSiTzV57E=
X-Received: by 2002:a05:6a00:140d:b0:6bd:3157:2dfe with SMTP id
 l13-20020a056a00140d00b006bd31572dfemr9835694pfu.7.1698692464997; Mon, 30 Oct
 2023 12:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com> <8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com>
 <CAP-5=fWk12jKjVmV+aJ_U5A=ao7L1ha-wOHaM+ytO9oF0nP9zA@mail.gmail.com>
 <CAP-5=fURbve928P5CGi-dQ7Y8mZhxRmi9wucFc_gP+aDGMftYw@mail.gmail.com>
 <CAP-5=fU5W=97NFvL1yUKw+rrbBrcd8c-S_y3=86SYv+pszNjmQ@mail.gmail.com> <CAM9d7cjRac8i9+VWYNfWxNr5iz3bUUxc0-Phfcbk0RdfwXqr6w@mail.gmail.com>
In-Reply-To: <CAM9d7cjRac8i9+VWYNfWxNr5iz3bUUxc0-Phfcbk0RdfwXqr6w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Oct 2023 12:00:54 -0700
Message-ID: <CAM9d7cgihtEmwOXhs8xxD4b6BRLqx6Kcg6E=K_JFQH__=kJUiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Oct 25, 2023 at 9:20 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 2:56 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Oct 5, 2023 at 3:16 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Sep 27, 2023 at 6:47 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 2023-09-26 4:59 p.m., Ian Rogers wrote:
> > > > > > Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
> > > > > > isn't present and the broadwellx style cbox PMU should be used
> > > > > > instead. Fix the tma_info_system_dram_bw_use metric to use the server
> > > > > > metric rather than client.
> > > > > >
> > > > > > The associated converter script fix is in:
> > > > > > https://github.com/intel/perfmon/pull/111
> > > > > >
> > > > > > Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > >
> > > > > Thanks Ian. The whole patch series looks good to me.
> > > > >
> > > > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > >
> > > > Would be good to pick this up in perf-tools-next.
> > > >
> > > > Thanks,
> > > > Ian
> > >
> > > Ping.
> >
> > Thanks Namhyung for picking this up. There were two other patches in
> > the v2 patch set that Kan reviewed:
> > https://lore.kernel.org/all/8a6b9556-c82c-4253-a4c1-74d696ad26df@linux.intel.com/
> > that I don't see in perf-tools-next.
>
> Sorry about that.  I'll take care of them too.

Applied to perf-tools-next, thanks!
