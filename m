Return-Path: <linux-kernel+bounces-55623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5B84BF24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EAF1C22B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0341B953;
	Tue,  6 Feb 2024 21:19:19 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED271B949;
	Tue,  6 Feb 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254358; cv=none; b=A2cZDqVaTSdOQJb+8oxSSxYcS5LSjuGLhocb+KK2VREMpYiS/JVVk2UBBsTMHfH9CSWsGyi/G7o7iYA12oG2Bhu/Y1vYAJ9txGjoQxXN2ze6EwEWBjcOrFvrbZJ+QK+68R+Anpg+dU+3vOvH4rl4PgzA/CBubyGMpY4xl7kTngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254358; c=relaxed/simple;
	bh=JERqMQ96ksA+8SNr6Sb2aF7oJ+HCIrtvFbhpArvNsPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzjeIB0oki/CcNiKNT4yDd0NTEemudg0+XNKm4Xphb6YKGCPktqdct9uh4hOA2WMdzOyS+1MI6VBWkcaCuqhiSkb09rORROPcOP/ZhHxpmizmLVB86Mu33afqkL/mPRZFHLqK34Mu5/q6Pw9XZ+WLqJg/gJHl3qGQreVu808iaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e05d958b61so727809b3a.2;
        Tue, 06 Feb 2024 13:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707254356; x=1707859156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Qx9B0ZnSFBsqRDrOP1gg0dYTMVEEBnv/fg/4P2Dug=;
        b=gE3iXnCZ6j1GIq16Q6Ax+iwcWvVAMKbnRP+UIjeYu4EAFfc9wABWD/F/doMyCcXudN
         etT4Uu2WOpnJV+BfD1HB2b3EOS4EAed0C36rBNLNWNohIfy2nrAyG5lnMMlaPTN6QLnb
         9bvfswjNo1JP0WKqj3EihiqmifYCWqtPBBXL1oJbj/kuzqSawXddEvcJmy8L3d59vOv+
         2Ss2JlEEOkK5OoaWKF9QbtMclyF0YRjF5LPOumrwai8FQYEi92aumh++1YI1CduSsdsi
         ai/nEYFvAS4WabgZe6jQWJwmPHaf24LMKUhszAecKhT7B4jifvTR6aoR/WkNDEHcGS+h
         ui+A==
X-Gm-Message-State: AOJu0Ywy4IL/HYEVA6LviznGQ0Ulr77KDR+wKtcFt+LaQsDyoEaI905W
	EmS0BHxzl6ajhmvjQyIQl4Zz8U6IrPgvsQvE6rq8pMJYT3fHNzmFY/1bmqXBDJsuhK/2g1xg3+U
	pFI416Lo/GhDfLvq5U8Ae1msT4+o=
X-Google-Smtp-Source: AGHT+IEe9lCvb+yV4P8niK2REAzqF734Mpq5zUhD0bIadcPA/gp1AVaf31fRBdBA7kSzNXn/ebfFVwVt9G0TgyRK9Rg=
X-Received: by 2002:a05:6a00:4e4e:b0:6e0:4b8f:f585 with SMTP id
 gu14-20020a056a004e4e00b006e04b8ff585mr718484pfb.7.1707254356244; Tue, 06 Feb
 2024 13:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216072830.1009339-1-namhyung@kernel.org> <ae648bc4-b32c-4b15-8dfc-9dbd481bb927@linux.intel.com>
 <CAM9d7cgVHHAA0ZHaTYNx9Lmw0+hJJu_EfQRnX8K3AtLCVMznOw@mail.gmail.com>
In-Reply-To: <CAM9d7cgVHHAA0ZHaTYNx9Lmw0+hJJu_EfQRnX8K3AtLCVMznOw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 13:19:05 -0800
Message-ID: <CAM9d7cjHJ2FYU-P0B2LA=vX1WUCOwCqC1j4LGFWMYDLFRKPCnA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Fix out of range data
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, stable@vger.kernel.org, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping!

On Tue, Jan 9, 2024 at 1:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Sat, Dec 16, 2023 at 4:42=E2=80=AFAM Liang, Kan <kan.liang@linux.intel=
com> wrote:
> >
> >
> >
> > On 2023-12-16 2:28 a.m., Namhyung Kim wrote:
> > > On x86 each cpu_hw_events maintains a table for counter assignment bu=
t
> > > it missed to update one for the deleted event in x86_pmu_del().  This
> > > can make perf_clear_dirty_counters() reset used counter if it's calle=
d
> > > before event scheduling or enabling.  Then it would return out of ran=
ge
> > > data which doesn't make sense.
> > >
> > > The following code can reproduce the problem.
> > >
> > >   $ cat repro.c
> > >   #include <pthread.h>
> > >   #include <stdio.h>
> > >   #include <stdlib.h>
> > >   #include <unistd.h>
> > >   #include <linux/perf_event.h>
> > >   #include <sys/ioctl.h>
> > >   #include <sys/mman.h>
> > >   #include <sys/syscall.h>
> > >
> > >   struct perf_event_attr attr =3D {
> > >       .type =3D PERF_TYPE_HARDWARE,
> > >       .config =3D PERF_COUNT_HW_CPU_CYCLES,
> > >       .disabled =3D 1,
> > >   };
> > >
> > >   void *worker(void *arg)
> > >   {
> > >       int cpu =3D (long)arg;
> > >       int fd1 =3D syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0)=
;
> > >       int fd2 =3D syscall(SYS_perf_event_open, &attr, -1, cpu, -1, 0)=
;
> > >       void *p;
> > >
> > >       do {
> > >               ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0);
> > >               p =3D mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd1, 0);
> > >               ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0);
> > >
> > >               ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0);
> > >               munmap(p, 4096);
> > >               ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0);
> > >       } while (1);
> > >
> > >       return NULL;
> > >   }
> > >
> > >   int main(void)
> > >   {
> > >       int i;
> > >       int n =3D sysconf(_SC_NPROCESSORS_ONLN);
> > >       pthread_t *th =3D calloc(n, sizeof(*th));
> > >
> > >       for (i =3D 0; i < n; i++)
> > >               pthread_create(&th[i], NULL, worker, (void *)(long)i);
> > >       for (i =3D 0; i < n; i++)
> > >               pthread_join(th[i], NULL);
> > >
> > >       free(th);
> > >       return 0;
> > >   }
> > >
> > > And you can see the out of range data using perf stat like this.
> > > Probably it'd be easier to see on a large machine.
> > >
> > >   $ gcc -o repro repro.c -pthread
> > >   $ ./repro &
> > >   $ sudo perf stat -A -I 1000 2>&1 | awk '{ if (length($3) > 15) prin=
t }'
> > >        1.001028462 CPU6   196,719,295,683,763      cycles            =
               # 194290.996 GHz                       (71.54%)
> > >        1.001028462 CPU3   396,077,485,787,730      branch-misses     =
               # 15804359784.80% of all branches      (71.07%)
> > >        1.001028462 CPU17  197,608,350,727,877      branch-misses     =
               # 14594186554.56% of all branches      (71.22%)
> > >        2.020064073 CPU4   198,372,472,612,140      cycles            =
               # 194681.113 GHz                       (70.95%)
> > >        2.020064073 CPU6   199,419,277,896,696      cycles            =
               # 195720.007 GHz                       (70.57%)
> > >        2.020064073 CPU20  198,147,174,025,639      cycles            =
               # 194474.654 GHz                       (71.03%)
> > >        2.020064073 CPU20  198,421,240,580,145      stalled-cycles-fro=
ntend          #  100.14% frontend cycles idle        (70.93%)
> > >        3.037443155 CPU4   197,382,689,923,416      cycles            =
               # 194043.065 GHz                       (71.30%)
> > >        3.037443155 CPU20  196,324,797,879,414      cycles            =
               # 193003.773 GHz                       (71.69%)
> > >        3.037443155 CPU5   197,679,956,608,205      stalled-cycles-bac=
kend           # 1315606428.66% backend cycles idle   (71.19%)
> > >        3.037443155 CPU5   198,571,860,474,851      instructions      =
               # 13215422.58  insn per cycle
> > >
> > > It should move the contents in the cpuc->assign as well.
> >
> > Yes, the patch looks good to me.
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks for your review, Kan.
>
> Ingo, Peter, can you please pick this up?
>
> Thanks,
> Namhyung

