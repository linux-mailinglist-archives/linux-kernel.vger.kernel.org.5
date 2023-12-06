Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE3807C54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379666AbjLFX3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjLFX3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:29:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D08B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:29:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so606e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701905350; x=1702510150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMyxDYpYdGVS1iOMrG0zbYmZLRYHYZE/F0CfAEDnOOw=;
        b=YELjP8tviiaFZ42uQYTYo2Ul9TjOi6tOFQ8YZUF0z5YUaA9/wbmtl9sBb+kDUKY3Vf
         XbyofOKWczVx/JkcdBXQSkY6phd/zVHgYUsmipqNSTPDZjUPxNlMSAV3lrAA57Si1j9y
         5QWLu1E6ns0d5l64XdUkNohH+VeYrm2dBPUIMLHFQG4Y0joETGNpc/7aijCHH+yqeA7k
         EJHIl7hkj+sUxyWmfkKQNrV2qqWLydzy13wYbABK8V5jW6++F7SQNlMX7EJpGf5cbc73
         Z8oBZZC/3t+cT6gvYjOKUICkGvnom05B2xuwkLGPeHcflW5JshERWh/k/n6TXOXWkPbs
         lpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905350; x=1702510150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMyxDYpYdGVS1iOMrG0zbYmZLRYHYZE/F0CfAEDnOOw=;
        b=bsPxsFs4IOxpDoe7bWvof/qJslx/RsW1JOrE6niVwI5hOPfuJtzLhYUqLXZUvOYdxT
         s1Mf/KPMnW2w2q5cSDVnS9YzPpoazvnAFFDP/d3RAHB1le0GFtqx2E2OVtKmF20Ithgi
         F1vpkjbGWDvlP2TgutYo0gyY0VG9mZKdGHYuZtNNCswDgJ4Ac5l0RkRTxvaKwAL/keRb
         mWySIZIZLPoVOs239n9bUY4ZmDubbicd5vzSLb7XB1KosBbz7EuWKNurxrs7PYpVk8DG
         7+wmGNHnMUj2qf2hHYjeiwAVK4nT1QhZbnIfxaUZEQRusbfpo507M/WvanuvQwIJ5yji
         iw7w==
X-Gm-Message-State: AOJu0YzmTnMulg+dMNyVoje5/W+ZLDdMWQJVqmCOF+WmW36rS31g88TE
        9fVsCxp5/5DHLuT74a+28EUoKXt5yTCRt0Jga+IS4Q==
X-Google-Smtp-Source: AGHT+IG7JVEMzZg6QO8/hfUswbkKBGrfYt+Rdguj0uvhDEh3QBI7JQXhxyDyyhjREAx5AVQnl68uToXxXVedT9qzCGg=
X-Received: by 2002:a05:6512:534:b0:50b:fc76:42c with SMTP id
 o20-20020a056512053400b0050bfc76042cmr84976lfc.2.1701905350178; Wed, 06 Dec
 2023 15:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-17-irogers@google.com>
 <CAM9d7cgj4Wj+0ZFQ3XfG12kkp4ThE4RT1+g=A1aSOinCXM9w+Q@mail.gmail.com>
In-Reply-To: <CAM9d7cgj4Wj+0ZFQ3XfG12kkp4ThE4RT1+g=A1aSOinCXM9w+Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 15:28:58 -0800
Message-ID: <CAP-5=fX2FFsF5C2DAZq1YrmDQFDq1fknCZ1kkpiQQyK1RpUscQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/50] perf maps: Add remove maps function to remove a
 map based on callback
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Dec 4, 2023 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Removing maps wasn't being done under the write lock. Similar to
> > maps__for_each_map, iterate the entries but in this case remove the
> > entry based on the result of the callback. If an entry was removed
> > then maps_by_name also needs updating, so add missed flush.
> >
> > In dso__load_kcore, the test of map to save would always be false with
> > REFCNT_CHECKING because of a missing RC_CHK_ACCESS.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> A nitpick below,
>
> > ---
> [SNIP]
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 72f03b875478..30da8a405d11 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1239,13 +1239,23 @@ static int kcore_mapfn(u64 start, u64 len, u64 =
pgoff, void *data)
> >         return 0;
> >  }
> >
> > +static bool remove_old_maps(struct map *map, void *data)
> > +{
> > +       const struct map *map_to_save =3D data;
> > +
> > +       /*
> > +        * We need to preserve eBPF maps even if they are covered by kc=
ore,
> > +        * because we need to access eBPF dso for source data.
> > +        */
> > +       return RC_CHK_ACCESS(map) !=3D RC_CHK_ACCESS(map_to_save) && !_=
_map__is_bpf_prog(map);
>
> RC_CHK_EQUAL(map, map_to_save) ?

Done in v6.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +}
> > +
> >  static int dso__load_kcore(struct dso *dso, struct map *map,
> >                            const char *kallsyms_filename)
> >  {
> >         struct maps *kmaps =3D map__kmaps(map);
> >         struct kcore_mapfn_data md;
> >         struct map *replacement_map =3D NULL;
> > -       struct map_rb_node *old_node, *next;
> >         struct machine *machine;
> >         bool is_64_bit;
> >         int err, fd;
> > @@ -1292,17 +1302,7 @@ static int dso__load_kcore(struct dso *dso, stru=
ct map *map,
> >         }
> >
> >         /* Remove old maps */
> > -       maps__for_each_entry_safe(kmaps, old_node, next) {
> > -               struct map *old_map =3D old_node->map;
> > -
> > -               /*
> > -                * We need to preserve eBPF maps even if they are
> > -                * covered by kcore, because we need to access
> > -                * eBPF dso for source data.
> > -                */
> > -               if (old_map !=3D map && !__map__is_bpf_prog(old_map))
> > -                       maps__remove(kmaps, old_map);
> > -       }
> > +       maps__remove_maps(kmaps, remove_old_maps, map);
> >         machine->trampolines_mapped =3D false;
> >
> >         /* Find the kernel map using the '_stext' symbol */
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
