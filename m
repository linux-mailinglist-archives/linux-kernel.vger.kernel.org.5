Return-Path: <linux-kernel+bounces-4734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B0818154
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C506281F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1958495;
	Tue, 19 Dec 2023 06:06:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94578474;
	Tue, 19 Dec 2023 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso2015259b3a.2;
        Mon, 18 Dec 2023 22:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702966014; x=1703570814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaDSv+Q9/rheu8P6LtF9ghPTerGp6FWZxK2q6v1pYGc=;
        b=llfJFRAS0nPuaZcctou26In5DhgMmVGAraF0PWHr5uk9eFtL3fiz95/m0QQRbInzru
         y6C7zsLNADphUN18DzXe/3Yy2fmKkthFEMy6lBTUnm+SiKRbKOZRds2cFCdvAITqvxW3
         w+lH2i03qlzPBMMC0NPbKoJBcjK3rDg2KFifv0lIPR0XoNtwotcNNrYNh/k4B0AVk6lh
         tMZ89J8swqnQ7WX6NREkx8azcrMm1OKOE3ODM90Ab4GtMQYpuWy3xI8tJQSDNDzO2CFH
         FYuFD1O7ur81xREx6fu1+Q4+B1x4+o3UBsKXqqI4nEvcQ7ls0U6iHoLPsAsPjJ8ZIS80
         PKwg==
X-Gm-Message-State: AOJu0YzhuO8j1qpeSdDLH3GYwxfdixB6fwyf/bRolVuBVfSy4m7yZnPn
	7z/UBrFcVMSoVxo5ywWSuzrOzyvlXwc/79COwMpNwnM44zo=
X-Google-Smtp-Source: AGHT+IEVQwJEQZbi+mhOdZfijfrqAW2hEZRhn4eEi/oAmcLANViY/GvVsWxlKeBBtaiCxcwsew2l8ASDMw8HoBA3MYE=
X-Received: by 2002:a05:6a00:2352:b0:6d9:3b54:b37a with SMTP id
 j18-20020a056a00235200b006d93b54b37amr11088pfj.1.1702966014007; Mon, 18 Dec
 2023 22:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com> <20231207011722.1220634-2-irogers@google.com>
 <CAM9d7cjUVCWpiy0ZsdaWQ5RtrULJSQsggZwz1wJNfeb1kXBwtw@mail.gmail.com>
 <CAM9d7cjjSC+_SEvc3ji4tYWqP6_Ay5VTJRVzK9mxhZhx6awyGQ@mail.gmail.com> <CAP-5=fX_vRHM+um7A1D+gOfnMJagzhJfQX5C3jEBj0aMCKQjjA@mail.gmail.com>
In-Reply-To: <CAP-5=fX_vRHM+um7A1D+gOfnMJagzhJfQX5C3jEBj0aMCKQjjA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Dec 2023 22:06:42 -0800
Message-ID: <CAM9d7chH6DRv1Vug7yEByEjz1mqGMTF61_Uhd1QG_dok4m9=ww@mail.gmail.com>
Subject: Re: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:52=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Dec 11, 2023 at 3:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Mon, Dec 11, 2023 at 3:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Dec 6, 2023 at 5:17=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > The u64 values are either absolute or relative, try to hint better =
in
> > > > the parameter names.
> > > >
> > > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/map.h | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > > > index 3a3b7757da5f..49756716cb13 100644
> > > > --- a/tools/perf/util/map.h
> > > > +++ b/tools/perf/util/map.h
> > > > @@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struc=
t map *map, u64 ip)
> > > >  }
> > > >
> > > >  /* dso rip -> ip */
> > > > -static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> > > > +static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip=
)
> > > >  {
> > > > -       return ip + map__start(map) - map__pgoff(map);
> > > > +       return rip + map__start(map) - map__pgoff(map);
> > > >  }
> > > >
> > > > -static inline u64 map__map_ip(const struct map *map, u64 ip)
> > > > +static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip=
)
> > >
> > > I'm afraid it's gonna be more confusing.  Can we say just 'rip'?
> >
> > Oh.. I think it should be 'ip'.
>
> But sometimes it is an ip and sometimes it is an rip, hence the long
> name. I don't think this really affects much so I'd prefer to stick
> with the intention revealing name if possible.

I don't think the intention is to mix ip and rip.

Does it really pass (already mapped) rip to the map function
again?  I know rip and ip can be identical but it doesn't mean
it can use rip to the map function.

Thanks,
Namhyung

