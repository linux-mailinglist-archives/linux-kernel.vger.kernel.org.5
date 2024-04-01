Return-Path: <linux-kernel+bounces-127073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CB89466D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF9A1F2202B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC254BE8;
	Mon,  1 Apr 2024 21:15:30 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEB2A1BF;
	Mon,  1 Apr 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006130; cv=none; b=ZnlDId87wD1NdPTGeiu2UlMf7f6AFypvUSCqenx0hH4xGZWgRxVvUxE7Zg1YQuL57XJxinJcS9qeXwK5Cxvq+jwj0ETj65uRUQzNoyn9rrbeneIK76mrnJfJGSUOJAwNRAmuWSab6KwLEizsYs0SUEUnjFCX/TRp+0vkXYXbmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006130; c=relaxed/simple;
	bh=CC5RoHNood4sNyDuHBo6HDda8sVDACBLUrjlALO7FxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znk7+JFxmMFFLDkSOwPl/3mV4AwEoVtWEMPCGSyRqXa39BKH0t68sl6KEgG4qnKkc44WCT/BpCvmEb/RTEwlbD2oc3xIun+3eu19Z7cr3I/ZbBPMM3YmUZOSfgLCY9s4RcpvAmokkC3kKu1GScGFsQ9uXauJPjlwo9PEz0QiWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0fa980d55so34898435ad.3;
        Mon, 01 Apr 2024 14:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006127; x=1712610927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOjxoedclmTtjqJIWU8Dyy9YgLz8iOnVuv662VeBEBs=;
        b=q6by7IIENRDQwadelYQBr9mwWXV879fg3Mfs2IiAkkS/j1xkCxyuuyNX2QWK9FdFGe
         d0hEXYo+qj+CKaG07vsjMmSOq8bhC3mD+8XkdrabudBbawzHPOJsk93r7xwfqP3SPPeW
         9ZZ3nhAt5juQ1D/DLTMLBiyJIgseHyGOfBVl6Pg8mo5U6xJti5OlNCXUl9z4l9J+AcAx
         mbYiySu4fCORZLAVGiUV3UFdrRN8BvBuqEjYzD17Yu7+3OvvswbR9+wHhH7S6L8DnOKI
         NltHc7Xu2E/EXnlDmK97V7QXDpNXKhNWrI06fMekz3Wgl2KLlh6t1V8TySIqk2G4cMka
         GGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5ZL83jbLnMkiArYu7vzObq4CZAE3C9HLGSoaEVnufedWOC3T53lzA2v8rkdh/VLBvvfD+m7N6Yq4Bfy9F8mcM1SI+Syz7m5P5SyHPLSUR/Az07e2KpO/6JhiUjvJAskBIipElF3o7DNOjFBNsw==
X-Gm-Message-State: AOJu0Yx4PeiH88QuPGgX5tafsNSCGEv6FYae7k6JPBjTwTH2grq+q0dh
	Vql9EDNO07Qwgm8PzxDelXVlAK/G3XYJy3rSh96jsNbTwTlzMHSrUgMhPK5BUJDmUw8jk0Sm/hF
	81wfOl3+9fy7Nmwo+VYqhK9WW8dg=
X-Google-Smtp-Source: AGHT+IHV6W1kjqikzerVzCsJtErA2QPWzzyW4QJsaPChLYQec4LXZLCMJA0Bj48TgrDejpoPP+cxcLM0opkrGV4qte0=
X-Received: by 2002:a17:902:f705:b0:1e2:5e32:4444 with SMTP id
 h5-20020a170902f70500b001e25e324444mr1900698plo.10.1712006127351; Mon, 01 Apr
 2024 14:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-5-weilin.wang@intel.com> <CAM9d7ciqiAOV_1A0N3he_Jiw3ur-ZN6djWpzgR2C+AF2m9an5A@mail.gmail.com>
 <CO6PR11MB56356D30DC2EE8F0EB7ADB30EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56356D30DC2EE8F0EB7ADB30EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 14:15:16 -0700
Message-ID: <CAM9d7chNd70gWCOe+268mTiLHAaGQEeJc9B5TebdexM-s_sB0A@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:08=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Monday, April 1, 2024 2:04 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v6 4/5] perf stat: Add retire latency print fun=
ctions to
> > print out at the very end of print out
> >
> > On Fri, Mar 29, 2024 at 12:12=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add print out functions so that users could read retire latency value=
s.
> > >
> > > Example output:
> > > In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES
> > sample.
> > > Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p retire_latency
> > value, count
> > > and sum are all 0.
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %
> > tma_dtlb_store
> > >          3,195,608      cpu_core/topdown-retiring/
> > >         40,156,649      cpu_core/topdown-mem-bound/
> > >          3,550,925      cpu_core/topdown-bad-spec/
> > >        117,571,818      cpu_core/topdown-fe-bound/
> > >         57,118,087      cpu_core/topdown-be-bound/
> > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > >               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        =
0
> >
> > The output is not aligned and I think it's hard to read.
> > I think it should print the result like this:
> >
> >     <sum>  <event-name>  # <val>  average retired latency
>
> Since we would like to use the average retire latency, I would think put =
average
> at the beginning would be more consistent. So in format like:
> <val> <event-name> <sum> <count> or <val> <event-name> <count> <sum> ?

But it's not consistent with others.  When I see the perf stat
output, I'd expect it shows the total count.  And the average
latency is a derived value so I think it can be treated as a metric.

Thanks,
Namhyung

