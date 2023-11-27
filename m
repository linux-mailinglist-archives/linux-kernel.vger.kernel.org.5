Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40317FA963
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjK0S7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0S72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:59:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F3B10C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:59:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50ba8177c9fso6512e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111571; x=1701716371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/wNL+0r9M3vEkbA09HZd27UVLvLuDyJ6shtN1Fiw18=;
        b=EVpxeUBhEtaaEZLJ2EaBAzJW/AI/02XaVVTWkJZhJQQAj5jji6Jj8B7AtDIxJjlyOw
         eGqrplgxchQsvnIxz3inYTDFeMLX/A9SohlR/+N+Jx8A4dXCA18LMCcWtFWODfTzmm3V
         RZuVEQEhbDShg45MrpyV8+rOPlf7BO1i5aURp/cbwPUt0Ursb+bokAcS9TIkx3w/VWNz
         NXNTFCn01EFadNN+hHuTuTizuN15k/znCEk46opJGDTvMA3NiH7pv+nJeDtHSNkfJ3K2
         IsIjiULNRH9x45uotkZ64IdC15Z+QiOwE1EsPtNOE27HEP7qV3jP5ie3xV8jyxhFLIXZ
         BFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111571; x=1701716371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/wNL+0r9M3vEkbA09HZd27UVLvLuDyJ6shtN1Fiw18=;
        b=dLjm20s7LdrKmyDhTgJIbii2jICER6HPbIYqS5/+wtrQja6LyXGKxk9V8aW9ubGfFM
         BHxQIL1aawDPs+Nuimv3iRTJfJ1NAVhd1XJ20pDNy94hHClJTVa60HiIsmz7nl2ffT0/
         oertWZwa7rCIxO+rnk+HTV9gPMWNd5p1PWrmZawy6OFOGsR+X4WKkAnbrfeihy/GwarE
         zmg07s19F/EIjd7YzhFv0ADNGZ/vNIiukqp/yNqfHogy4/t4CdMmhRT8KWfuCaNRbIlZ
         T7J7mWqBfto6qbxmPDvG9x3zvNU9oJnKyp6Idhydpy1KxaHs+zSbb58ZBZMbCs2u7lW3
         aXVA==
X-Gm-Message-State: AOJu0YzXHOnJRoHZUUoTs2q9uareSIfvYQBHnRbz7HXlB/aQ3+2fRcik
        IqC8BdHXcaenOjWUqtP7xg0AvJIYDWI1iPjcNIPoZw==
X-Google-Smtp-Source: AGHT+IFIAPAtevzEtWkxa9wwhZFABJpCknrBAnmFb4+PZShkXnzqu4GkAv8l8u+FsLttnXvygTx7rM76t/73JCe0nps=
X-Received: by 2002:a05:6512:6ce:b0:4fe:ffbc:ac98 with SMTP id
 u14-20020a05651206ce00b004feffbcac98mr564192lff.4.1701111571318; Mon, 27 Nov
 2023 10:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
 <CAP-5=fXgy95LsYLbbWN85prBs43jvGehOcwYFK-ZK2cOqCyPJA@mail.gmail.com> <CAM9d7ch9pXWZdFKf5zrQZg+nrf_0YpVro5vvkkO+LPfoLTynPQ@mail.gmail.com>
In-Reply-To: <CAM9d7ch9pXWZdFKf5zrQZg+nrf_0YpVro5vvkkO+LPfoLTynPQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 10:59:19 -0800
Message-ID: <CAP-5=fWpNUPfZ6Qs45kw1BkDB0erOu0whzaV0VsYtkLuJhGpAg@mail.gmail.com>
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

On Sun, Nov 5, 2023 at 7:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sun, Nov 5, 2023 at 1:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Sun, Nov 5, 2023 at 9:32=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > The rwsem is only after used for writing so switch to a mutex that =
has
> > > > better error checking.
> > >
> > > Hmm.. ok.  It doesn't make sense to use rwsem without readers.
> > >
> > > >
> > > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex"=
)
> > >
> > > But I'm not sure this is a fix.  Other than that,
> >
> > Thanks Namhyung, it fixes the case that you enable RWS_ERRORCHECK in
> > rwsem.h as the rwsem static initialization is wrong for a mutex.
>
> Sounds like we need a separate fix.  Maybe you need to
> add a static initializer macro depending on the config.

Agreed, but the only use would be here and switching this case to a
mutex gives extra error checking such as the mutex being taken
recursively. Given that, I prefer the existing change and the static
initializer for rwsem can be a follow up when needed.

Thanks,
Ian

> Thanks,
> Namhyung
