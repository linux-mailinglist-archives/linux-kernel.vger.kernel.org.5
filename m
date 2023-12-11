Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0C80DF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjLKXjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 18:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:39:18 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A1CB;
        Mon, 11 Dec 2023 15:39:25 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d053c45897so44436645ad.2;
        Mon, 11 Dec 2023 15:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337965; x=1702942765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ej4vpm5j5oJxsSNlbT7DL94C7tipsVRUtuspta96IQ=;
        b=dH8TVsb0lt7V6sblebmV2m142PsYXE9zQseF0rXFemJKfNQfjDIj8058ccVL71mkz9
         hs6+bvJtD2JjA0Ur+KNpYXXoj3Jq2Iu7K8s0YHqsECHUPk88EkBiji8iH1k3kbbmr5qf
         RsZis7ZiMp39urLwGTeBTeHL/qqlnpbiKUAqee2otBqcVweWPqxTzUMXnZnptDKS8W4C
         3SYBEhYreQBs+iFDypSlFlESZWJO/5QROOgReHX5SagcIiYI62Vljj1WO7YcT1dxerg5
         yuS7+mAbHV1DIjc8wRAwVfYAH/WQDmyFhL+hoWc7HGnlDll7yEFaRelQVy/CmXvL19wH
         nSWw==
X-Gm-Message-State: AOJu0Yx67q1O0Tp1+vtUfW8eIwEDyrCQtl1QnFGrkiM6Ss9VprJ6OKle
        FM5jVnFIf9OvoAqgDAYeVH9AlliUshC0CztojKM=
X-Google-Smtp-Source: AGHT+IF5C8VA/2fRM9kYCCLZlLqYGhV04AmlC3jYIEUQSGbODqh2QipiO9UBwoWd1lb4evyabaTWm6Kl+KluhMt+3Jw=
X-Received: by 2002:a17:902:9a0a:b0:1d0:6ffd:9e1c with SMTP id
 v10-20020a1709029a0a00b001d06ffd9e1cmr4828110plp.110.1702337964847; Mon, 11
 Dec 2023 15:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com> <20231207011722.1220634-2-irogers@google.com>
 <CAM9d7cjUVCWpiy0ZsdaWQ5RtrULJSQsggZwz1wJNfeb1kXBwtw@mail.gmail.com>
In-Reply-To: <CAM9d7cjUVCWpiy0ZsdaWQ5RtrULJSQsggZwz1wJNfeb1kXBwtw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 11 Dec 2023 15:39:13 -0800
Message-ID: <CAM9d7cjjSC+_SEvc3ji4tYWqP6_Ay5VTJRVzK9mxhZhx6awyGQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
To:     Ian Rogers <irogers@google.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 3:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Dec 6, 2023 at 5:17 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The u64 values are either absolute or relative, try to hint better in
> > the parameter names.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/map.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 3a3b7757da5f..49756716cb13 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
> >  }
> >
> >  /* dso rip -> ip */
> > -static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> > +static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip)
> >  {
> > -       return ip + map__start(map) - map__pgoff(map);
> > +       return rip + map__start(map) - map__pgoff(map);
> >  }
> >
> > -static inline u64 map__map_ip(const struct map *map, u64 ip)
> > +static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip)
>
> I'm afraid it's gonna be more confusing.  Can we say just 'rip'?

Oh.. I think it should be 'ip'.

>
> >  {
> >         if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
> > -               return map__dso_map_ip(map, ip);
> > +               return map__dso_map_ip(map, ip_or_rip);
> >         else
> > -               return ip;
> > +               return ip_or_rip;
> >  }
> >
> > -static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> > +static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
>
> Ditto.
>
> Thanks,
> Namhyung
>
>
> >  {
> >         if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
> > -               return map__dso_unmap_ip(map, ip);
> > +               return map__dso_unmap_ip(map, ip_or_rip);
> >         else
> > -               return ip;
> > +               return ip_or_rip;
> >  }
> >
> >  /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >
