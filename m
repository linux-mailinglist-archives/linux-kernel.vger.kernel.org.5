Return-Path: <linux-kernel+bounces-137538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072E89E399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C552DB221C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEEF157E71;
	Tue,  9 Apr 2024 19:27:58 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312A156F28;
	Tue,  9 Apr 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690877; cv=none; b=kXSoWw6UtlkzlwtZuAy1UM2xDIf5WJH2hUo68tnur2+yy5mHw3ulGOE0DgP7Vw1RjppSaq6wRK80K3GRfcuEbdePNB84zchZ3dzGQaU6/dRN6lu2dSCveDbmLIgmaMOHE9T7SfT6eJ0MX0tvkmBB8hD8I3/dm+u8d5scZwiNKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690877; c=relaxed/simple;
	bh=NBlFKQKXdDSYGy3jDOPVW5jSTQHFXmqLC8ubcBtwg54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjaOac+v4PBja4E22NhbbDfHXiCE44TlvnfYPasXOMDFsQb7ogtYMPumsxFVuWkhG1UcB62PQzaQ7bdyaD2rjnsKE9GLB6lVXfeKMC97FW0cTyyWKEZTkDrzk3+m6QCZwwDVwTUiguQznoBgEHJcK9rXJMFJ0PVqaKOPqWAw3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a5215314a4so1667516a91.0;
        Tue, 09 Apr 2024 12:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712690875; x=1713295675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXBwMc0h/4YLxnhtwXB+DKeKsXV/rxCsNtc2huo+byQ=;
        b=LGav91RS97JIfWh9RMP+qb5CxXwRZiQTKLrfOYxuLMXmk8wfX0O8ttvIf/4LHjXL1O
         umQ/pc/AcQ6rCt4ui0cZEXK3QRapLWdZcSB5K7i8926JOG3QE7Hoj3YsxDp1THHbENpM
         xS8Y7l8i6+eiihSfvgyUzvPpCznH6h9zvYdxnApVo+OcbNB2TE771UaUTReJkhXfxmke
         b3Er4WGImrUbWKo2EaAvks7S+1+ybnZVkjhopioAOl1c0H+BpGzjCWfNI436FZpT6l+5
         ysSCBv9Y0u9/x18VEEYUKjwi/MHbpCbfLo0VzHHp/enJDqTmIPoqU6v463ATodnFSoSv
         NIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXpPmvWa949/GN0Sj62CSdIFHODRinHuf+zi3AvS08PWJZ239SjdDj2uRg7rCEhS+xjNujlvzKteT7WWSfA1nBKlE0X/AwnCP/jPR/+uVMSsbCiavK8xLQYBdAa2f3SvfyWr86RgdwIsdF+sTRf6g==
X-Gm-Message-State: AOJu0Yz8NC307DjGdAgqVWj/DI5kMJZRUb0qfJoDAduLQFF4DzYUpMS7
	lxWYYQiC4++MWW9AmrTC4a6B/Xf2NCxhKnbWQzEQN4Pp46tuBh+t3ABTWOsFnR/zrrwGsV+9bWB
	rrp+SKHBislN3jwfEvq4Q0uSW2vU=
X-Google-Smtp-Source: AGHT+IFiwn6TKeknl8NcxMwdYLJrJyMYKVDsWQOTWyfbswX3lKMej+Au58XwvS5zZcFoFDvHhirmDD001y2DkDHl5Io=
X-Received: by 2002:a17:90a:38a1:b0:2a1:f455:c3d7 with SMTP id
 x30-20020a17090a38a100b002a1f455c3d7mr600957pjb.16.1712690875020; Tue, 09 Apr
 2024 12:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409000659.1727785-1-namhyung@kernel.org> <20240409000659.1727785-3-namhyung@kernel.org>
 <0ec1328a-0731-42a6-b953-163ac5a56deb@linux.intel.com> <CAM9d7cizZLMNa82VxuuvEWEY3vwdbs_iTG9jsogJQBoWMLP7Fw@mail.gmail.com>
 <16587efd-ab12-463a-bd87-7721adfc731d@linux.intel.com>
In-Reply-To: <16587efd-ab12-463a-bd87-7721adfc731d@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 12:27:43 -0700
Message-ID: <CAM9d7cg65=Hr2Utuuh=8EC7v80y-n1iZ-dyCfDU=kreuovLjfQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf report: Add weight[123] output fields
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:18=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-09 12:53 p.m., Namhyung Kim wrote:
> > Hi Kan,
> >
> > On Tue, Apr 9, 2024 at 9:37=E2=80=AFAM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> >>
> >>
> >>
> >> On 2024-04-08 8:06 p.m., Namhyung Kim wrote:
> >>> Add weight1, weight2 and weight3 fields to -F/--fields and their alia=
ses
> >>> like 'ins_lat', 'p_stage_cyc' and 'retire_lat'.  Note that they are i=
n
> >>> the sort keys too but the difference is that output fields will sum u=
p
> >>> the weight values and display the average.
> >>>
> >>> In the sort key, users can see the distribution of weight value and I
> >>> think it's confusing we have local vs. global weight for the same wei=
ght.
> >>>
> >>> For example, I experiment with mem-loads events to get the weights.  =
On
> >>> my laptop, it seems only weight1 field is supported.
> >>>
> >>>   $ perf mem record -- perf test -w noploop
> >>>
> >>> Let's look at the noploop function only.  It has 7 samples.
> >>>
> >>>   $ perf script -F event,ip,sym,weight | grep noploop
> >>>   # event                         weight     ip           sym
> >>>   cpu/mem-loads,ldlat=3D30/P:           43     55b3c122bffc noploop
> >>>   cpu/mem-loads,ldlat=3D30/P:           48     55b3c122bffc noploop
> >>>   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop  =
  <--- same weight
> >>>   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop  =
  <--- same weight
> >>>   cpu/mem-loads,ldlat=3D30/P:           59     55b3c122bffc noploop
> >>>   cpu/mem-loads,ldlat=3D30/P:           33     55b3c122bffc noploop
> >>>   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop  =
  <--- same weight
> >>>
> >>> When you use the 'weight' sort key, it'd show entries with a separate
> >>> weight value separately.  Also note that the first entry has 3 sample=
s
> >>> with weight value 38, so they are displayed together and the weight
> >>> value is the sum of 3 samples (114 =3D 38 * 3).
> >>>
> >>>   $ perf report -n -s +weight | grep -e Weight -e noploop
> >>>   # Overhead  Samples  Command   Shared Object   Symbol         Weigh=
t
> >>>        0.53%        3     perf   perf            [.] noploop    114
> >>>        0.18%        1     perf   perf            [.] noploop    59
> >>>        0.18%        1     perf   perf            [.] noploop    48
> >>>        0.18%        1     perf   perf            [.] noploop    43
> >>>        0.18%        1     perf   perf            [.] noploop    33
> >>>
> >>> If you use 'local_weight' sort key, you can see the actualy weight.
> >>>
> >>>   $ perf report -n -s +local_weight | grep -e Weight -e noploop
> >>>   # Overhead  Samples  Command   Shared Object   Symbol         Local=
 Weight
> >>>        0.53%        3     perf   perf            [.] noploop    38
> >>>        0.18%        1     perf   perf            [.] noploop    59
> >>>        0.18%        1     perf   perf            [.] noploop    48
> >>>        0.18%        1     perf   perf            [.] noploop    43
> >>>        0.18%        1     perf   perf            [.] noploop    33
> >>>
> >>> But when you use the -F/--field option instead, you can see the avera=
ge
> >>> weight for the while noploop funciton (as it won't group samples by
> >>
> >> %s/funciton/function/
> >>
> >>> weight value and use the default 'comm,dso,sym' sort keys).
> >>>
> >>>   $ perf report -n -F +weight | grep -e Weight -e noploop
> >>>   # Overhead  Samples  Weight1  Command  Shared Object  Symbol
> >>>        1.23%        7     42.4  perf     perf           [.] noploop
> >>
> >> I think the current +weight shows the sum of weight1 of all samples,
> >> (global weight). With this patch, it becomes an average (local_weight)=
.
> >> The definition change may break the existing user script.
> >>
> >> Ideally, I think we should keep the meaning of the weight and
> >> local_weight as is.
> >
> > Hmm.. then we may add 'avg_weight' or something.
> >
> > But note that there's a subtle difference in the usage.  If you use
> > 'weight' as a sort key (-s weight) it'd keep the existing behavior
> > that shows the sum (global_weight).  It'd show average only if
> > you use it as an output field (-F weight).
> >
>
> As my understanding, the -F weight is implicitly replaced by the -F
> weight1 with this patch. There is no way to get the sum of weight with
> -F anymore.

Right.

>
> I think that's a user visible behavior change. At least, we have to warn
> the end user with a message, e.g., "weight is not supported with -F
> anymore. Using weight1 to instead". Only updating the doc may not be enou=
gh.

I understand your concern.  I can add the warning.

>
> > The issue of the sort key is that it cannot have the total sum
> > of weights for a function.  It'll have separate entries for each
> > weight for each function like in the above example.
> >
>
> That seems to be a different issue. If the total sum of weights for a
> function is required, we should fix the existing "weight".

Yeah, I guess that's more reasonable behavior.  But I'm not sure
how we can fix it without breaking the existing behavior.

Actually this is my approach to keep the behavior for the "sort" key.
I think users are more familiar with -s (--sort) rather than the -F
(--fields) option.  That's why I'd like to "break" that part only.

Thanks,
Namhyung

