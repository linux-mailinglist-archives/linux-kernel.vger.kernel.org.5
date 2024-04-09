Return-Path: <linux-kernel+bounces-137343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8F89E0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A281C22907
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8AF152DEB;
	Tue,  9 Apr 2024 16:53:55 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4815380B;
	Tue,  9 Apr 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681635; cv=none; b=fw+c7V4cjT1zjT6yoPan+fKtjjdNtHJw7AVIeGhzPsQHix4KDGh/wMbf/jj/qIg2yNGzousWrQkx1h4zQkQslTlE0EOuhGhu8cQxVCEcz3CsMwZmc6qh7pBlsui0dL2mms30WnZU9e9wRo/AOOGsGrOmlOawt+qZ1l71F+eTq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681635; c=relaxed/simple;
	bh=yw6TX9lO9P2YshT6dcCarnc+AJgRrHPkoasFjOF6+2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeRZX1bTFQpyVBOEoHQMamJDhU23bL20loUeB/vBiELJUM/rYbdUrRo5kQ07MgIKq9goCiC4EffEycm/9bjtzRB48RGhHiUh7VgQfn2iQS+/C9Y+7vN3McWi+RpGJACfV7dpAk+84hC7TkJADC1eg9i1s1Y/znWYF+TehcXPWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3ff14f249so18056765ad.1;
        Tue, 09 Apr 2024 09:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681633; x=1713286433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHwKssPvQn08dZsaVs6XjTXIcqJ81SMFbyYxihTZRJg=;
        b=oRyC9Aaukr6wCa+jb7H9kyP2nPiATWu+SyYtFUUtrBuUfLhCVDHAEhOfGsAcmBRR5I
         Wcp2vBWhEvpDZRY9XIEziCwwxX61MVUszp5c/VKjiTTjkRa1KCeHEfzwVGJIz9E72kwt
         RRTwjxcWBFQOQ+/O3KU0kU7VKK5IjKF9yzos1nZQ0q/rNzYxfEihI4sY6tGG8TDxdgl7
         IxttjA+8Gg2HT7bpKAuD9HiyZ4BBR/oOR7aY33V7Ufeok2jL48FQhfgNASRipF08ugJL
         njwwYG/DQ8+FARNViqEMVmocpkqD9WG40oB3NhcC6WexVEWhN4tGnwlDuB96JzgDPHHJ
         ihog==
X-Forwarded-Encrypted: i=1; AJvYcCVrp8K+WKuGtPk9oYZqJOTKe/LkChA9F4YZfpyhSrT1cF5gpttPxlw+QWDOBm9hkEn+W/qT6yrPCUkrIL6yx0cjez8n7RBf0iMeUzPIZ5gtAOowLZUjm40M1AWMRtiWseAPEdIb8V97jOB1LUPElQ==
X-Gm-Message-State: AOJu0Yx+J1/gFZodzazZNG3xx+eTGoIbuUnIAriqzk5aL9GU0SF4sonW
	NA6syy94CYvIGNq3fg1Cbtp5Zv9v88PX0/MBSEGp191KyMOQl2odgbr4yeVxIkJh8WA9NE1sltC
	Am6ugXtpBGVclHlHItBt5OezM81A=
X-Google-Smtp-Source: AGHT+IHy7LqReHtQH0H1AIrC8Sfh9+1hRJte0gtid3WoAxon+WzborI/4FgYrswXUv8oZIHx9dQnoOmN4wZ5AxTLfL0=
X-Received: by 2002:a17:902:d14d:b0:1e3:d242:418a with SMTP id
 t13-20020a170902d14d00b001e3d242418amr257214plt.9.1712681633110; Tue, 09 Apr
 2024 09:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409000659.1727785-1-namhyung@kernel.org> <20240409000659.1727785-3-namhyung@kernel.org>
 <0ec1328a-0731-42a6-b953-163ac5a56deb@linux.intel.com>
In-Reply-To: <0ec1328a-0731-42a6-b953-163ac5a56deb@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 09:53:41 -0700
Message-ID: <CAM9d7cizZLMNa82VxuuvEWEY3vwdbs_iTG9jsogJQBoWMLP7Fw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf report: Add weight[123] output fields
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,

On Tue, Apr 9, 2024 at 9:37=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-04-08 8:06 p.m., Namhyung Kim wrote:
> > Add weight1, weight2 and weight3 fields to -F/--fields and their aliase=
s
> > like 'ins_lat', 'p_stage_cyc' and 'retire_lat'.  Note that they are in
> > the sort keys too but the difference is that output fields will sum up
> > the weight values and display the average.
> >
> > In the sort key, users can see the distribution of weight value and I
> > think it's confusing we have local vs. global weight for the same weigh=
t.
> >
> > For example, I experiment with mem-loads events to get the weights.  On
> > my laptop, it seems only weight1 field is supported.
> >
> >   $ perf mem record -- perf test -w noploop
> >
> > Let's look at the noploop function only.  It has 7 samples.
> >
> >   $ perf script -F event,ip,sym,weight | grep noploop
> >   # event                         weight     ip           sym
> >   cpu/mem-loads,ldlat=3D30/P:           43     55b3c122bffc noploop
> >   cpu/mem-loads,ldlat=3D30/P:           48     55b3c122bffc noploop
> >   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop    =
<--- same weight
> >   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop    =
<--- same weight
> >   cpu/mem-loads,ldlat=3D30/P:           59     55b3c122bffc noploop
> >   cpu/mem-loads,ldlat=3D30/P:           33     55b3c122bffc noploop
> >   cpu/mem-loads,ldlat=3D30/P:           38     55b3c122bffc noploop    =
<--- same weight
> >
> > When you use the 'weight' sort key, it'd show entries with a separate
> > weight value separately.  Also note that the first entry has 3 samples
> > with weight value 38, so they are displayed together and the weight
> > value is the sum of 3 samples (114 =3D 38 * 3).
> >
> >   $ perf report -n -s +weight | grep -e Weight -e noploop
> >   # Overhead  Samples  Command   Shared Object   Symbol         Weight
> >        0.53%        3     perf   perf            [.] noploop    114
> >        0.18%        1     perf   perf            [.] noploop    59
> >        0.18%        1     perf   perf            [.] noploop    48
> >        0.18%        1     perf   perf            [.] noploop    43
> >        0.18%        1     perf   perf            [.] noploop    33
> >
> > If you use 'local_weight' sort key, you can see the actualy weight.
> >
> >   $ perf report -n -s +local_weight | grep -e Weight -e noploop
> >   # Overhead  Samples  Command   Shared Object   Symbol         Local W=
eight
> >        0.53%        3     perf   perf            [.] noploop    38
> >        0.18%        1     perf   perf            [.] noploop    59
> >        0.18%        1     perf   perf            [.] noploop    48
> >        0.18%        1     perf   perf            [.] noploop    43
> >        0.18%        1     perf   perf            [.] noploop    33
> >
> > But when you use the -F/--field option instead, you can see the average
> > weight for the while noploop funciton (as it won't group samples by
>
> %s/funciton/function/
>
> > weight value and use the default 'comm,dso,sym' sort keys).
> >
> >   $ perf report -n -F +weight | grep -e Weight -e noploop
> >   # Overhead  Samples  Weight1  Command  Shared Object  Symbol
> >        1.23%        7     42.4  perf     perf           [.] noploop
>
> I think the current +weight shows the sum of weight1 of all samples,
> (global weight). With this patch, it becomes an average (local_weight).
> The definition change may break the existing user script.
>
> Ideally, I think we should keep the meaning of the weight and
> local_weight as is.

Hmm.. then we may add 'avg_weight' or something.

But note that there's a subtle difference in the usage.  If you use
'weight' as a sort key (-s weight) it'd keep the existing behavior
that shows the sum (global_weight).  It'd show average only if
you use it as an output field (-F weight).

The issue of the sort key is that it cannot have the total sum
of weights for a function.  It'll have separate entries for each
weight for each function like in the above example.

Thanks,
Namhyung

