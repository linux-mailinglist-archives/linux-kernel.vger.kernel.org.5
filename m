Return-Path: <linux-kernel+bounces-18489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25C825E51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F295A1C20F3B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A163CA;
	Sat,  6 Jan 2024 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWH2dge5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4163A8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eb9d41d57so718e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704519913; x=1705124713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1noNVxrj4EENUNumxv0YPRHXclTxNJstpxnAMkzn0t4=;
        b=bWH2dge53qnZnXIoK761VPjbYS+9UWOeJs1pnEECUnLnENrhPovJl53M6r4S2MIAf6
         9cUx5w1t1sYlNkYp1PGd0gakNjtrv3FMK1kmjHv3C12nXWwzR2qBOrc/IAmAgwGj70Rs
         r706kFPEhi6/jgAnftIQFUPI/WFgElqmLdWWyYM74ZDGFsYFCNaQfFN/lVXsJrxoxQnY
         IlUd63kcJBRrHJUhlOlFvD5AQHqZ5V0x9CzPpszpSHKdgZiRoUsC7rbhQoh/yDbKxdyU
         LuSh3gX3RxUJCNldAGIiKNiq11A11iVZu6Z4sp0zss5THcJtPVcDsZc62IC5DoVbqdmG
         slbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704519913; x=1705124713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1noNVxrj4EENUNumxv0YPRHXclTxNJstpxnAMkzn0t4=;
        b=a2PKH8onaIt3f17gPb5Q+grfpBBnRPWZaG8QTCZN1vfh8LtqcAFwihvzInz9w77WBK
         7L3RPV9kVuwKnejLD/i+FMz02+mEecWpWYUBpvW6OYoYZ74ommLtUsRRjhO7/PAAQnNF
         6AhSKeDotg/OATk3ABKazHPzMM6P/5/gIMY7FivG72QsJy4ol/ECvkADPECGTcmeBjIf
         SI6Ei7gJ1tMTt14nyL/tWlPSSp9NwqLkx1YgxcqiZ+WRbYOVdVXO6Fcw7THgRobPcBrT
         ZanQ+LjICRglFMUZKV8wCpS0SxYvLm6Rm7/1GLSCIh7ynJEcQ3D7ISEDUPkyGKP1eDTC
         zRDA==
X-Gm-Message-State: AOJu0YxFeWInvR7nEqDTTddTNzZ/4qljW22Fw8R0nETTOZ6B0FxO9Sl8
	ERS/gwQkIPbDfksUKNqXsXGHoKOrzcVZE6gZ6LhCKjnvYCrS
X-Google-Smtp-Source: AGHT+IH3Hg4xauXrzKHj5+s4dCYwB/s8mvGn8oT3ukJXan098RJcKAbj/XSq93CKTDGzyVWyb/P3MHj/7qo1Tif4tnE=
X-Received: by 2002:a19:f503:0:b0:50e:9f94:1c37 with SMTP id
 j3-20020a19f503000000b0050e9f941c37mr30389lfb.7.1704519912976; Fri, 05 Jan
 2024 21:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com> <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
 <ZZcdDyyADG8dP8LM@kernel.org> <CAP-5=fVfCnPG0O51rRXVqkGRU4eW7n0B1YGr9pL8CbwxG+V8jQ@mail.gmail.com>
 <ZZgYBRxSMw_T5EE1@kernel.org>
In-Reply-To: <ZZgYBRxSMw_T5EE1@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Jan 2024 21:44:59 -0800
Message-ID: <CAP-5=fURZ7bEvZYLSzrCM_+cVAZhRd1DU_QD7tc-rgOs2W5ucw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:54=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Thu, Jan 04, 2024 at 03:29:34PM -0800, Ian Rogers escreveu:
> > On Thu, Jan 4, 2024 at 1:03=E2=80=AFPM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > > Em Tue, Jan 02, 2024 at 11:30:39AM -0800, Ian Rogers escreveu:
> > > > On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > > > uniq will write one command name over another causing the overwri=
tten
> > > > > string to be leaked. Fix by doing a pass that removes duplicates =
and a
> > > > > second that removes the holes.
>
> > > I applied the first one, the fix for uniq(), but somehow the second
> > > didn't work for me as in your examples, nor the third, the output is =
the
> > > same as before.
>
> > I tried to repro the failure with a rebase but couldn't. I suspected
> > libsubcmd wasn't being rebuilt or something like that. I suspect now
> > that you have ~/.perfconfig with help.autocorrect set, which means the
> > output will vary as it will automatically try to run the autocorrected
> > command. Could you check for me?
>
> [acme@quaco perf-tools-next]$ perf reccord
> Failed to run command 'reccord': No such file or directory
> [acme@quaco perf-tools-next]$ perf -v
> perf version 6.7.rc6.gcd1e3ef8bfe8
> [acme@quaco perf-tools-next]$ git log --oneline -5
> cd1e3ef8bfe8f827 (HEAD -> perf-tools-next) perf help: Lower levenshtein p=
enality for deleting character
> c5c7365af812728e perf: Suggest inbuilt commands for unknown command
> b6d8b858dbbbd832 (perf-tools-next.korg/tmp.perf-tools-next, perf-tools-ne=
xt.korg/perf-tools-next, number/perf-tools-next, five/perf-tools-next, acme=
.korg/tmp.perf-tools-next, acme.korg/perf-tools-next) perf test: test case =
'Setup struct perf_event_attr' fails on s390 on z/vm
> 1e24ce402c97dc3c (perf-tools-next/tmp.perf-tools-next, acme/tmp.perf-tool=
s-next) perf db-export: Fix missing reference count get in call_path_from_s=
ample()
> bb177a85e82b37d3 perf tests: Add perf script test
> [acme@quaco perf-tools-next]$ perf reccord
> Failed to run command 'reccord': No such file or directory
> [acme@quaco perf-tools-next]$ cat ~/.perfconfig
> [acme@quaco perf-tools-next]$ sudo cat /etc/perfconfig
> [sudo] password for acme:
> cat: /etc/perfconfig: No such file or directory
> [acme@quaco perf-tools-next]$
> [acme@quaco perf-tools-next]$
> [acme@quaco perf-tools-next]$ sudo su -
> [root@quaco ~]# perf -v
> perf version 6.7.rc6.gcd1e3ef8bfe8
> [root@quaco ~]# perf reccord
> Failed to run command 'reccord': No such file or directory
> [root@quaco ~]# cat ~/.perfconfig
> [root@quaco ~]# perf trace -e open*,access* perf reccord
>      0.000 ( 0.006 ms): perf/10791 access(filename: "/etc/ld.so.preload",=
 mode: R)                       =3D -1 ENOENT (No such file or directory)
>      0.012 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/etc/ld.so=
.cache", flags: RDONLY|CLOEXEC) =3D 3
>      0.035 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
unwind-x86_64.so.8", flags: RDONLY|CLOEXEC) =3D 3
>      0.084 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
unwind.so.8", flags: RDONLY|CLOEXEC) =3D 3
>      0.128 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
lzma.so.5", flags: RDONLY|CLOEXEC) =3D 3
>      0.170 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
m.so.6", flags: RDONLY|CLOEXEC) =3D 3
>      0.221 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
opencsd_c_api.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.264 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
z.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.305 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
elf.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.348 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
debuginfod.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.386 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
dw.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.428 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
crypto.so.3", flags: RDONLY|CLOEXEC) =3D 3
>      0.480 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
slang.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      0.526 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
perl.so.5.36", flags: RDONLY|CLOEXEC) =3D 3
>      0.575 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
c.so.6", flags: RDONLY|CLOEXEC) =3D 3
>      0.628 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
python3.11.so.1.0", flags: RDONLY|CLOEXEC) =3D 3
>      0.675 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
stdc++.so.6", flags: RDONLY|CLOEXEC) =3D 3
>      0.729 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
zstd.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.772 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
cap.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      0.811 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
numa.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.849 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
babeltrace-ctf.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.895 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
pfm.so.4", flags: RDONLY|CLOEXEC) =3D 3
>      0.940 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
traceevent.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      0.976 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
gcc_s.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.023 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
opencsd.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.071 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
curl.so.4", flags: RDONLY|CLOEXEC) =3D 3
>      1.116 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
bz2.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.157 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
crypt.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      1.216 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
babeltrace.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.260 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
popt.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      1.299 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
uuid.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.341 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
gmodule-2.0.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      1.382 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
glib-2.0.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      1.438 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
nghttp2.so.14", flags: RDONLY|CLOEXEC) =3D 3
>      1.478 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
idn2.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      1.525 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
ssh.so.4", flags: RDONLY|CLOEXEC) =3D 3
>      1.576 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
psl.so.5", flags: RDONLY|CLOEXEC) =3D 3
>      1.621 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
ssl.so.3", flags: RDONLY|CLOEXEC) =3D 3
>      1.663 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
gssapi_krb5.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      1.707 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
ldap.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      1.755 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
lber.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      1.795 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
brotlidec.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      1.852 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
pcre2-8.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      1.899 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
unistring.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      1.948 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
krb5.so.3", flags: RDONLY|CLOEXEC) =3D 3
>      1.997 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
k5crypto.so.3", flags: RDONLY|CLOEXEC) =3D 3
>      2.040 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
com_err.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      2.089 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
krb5support.so.0", flags: RDONLY|CLOEXEC) =3D 3
>      2.132 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
keyutils.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      2.175 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
resolv.so.2", flags: RDONLY|CLOEXEC) =3D 3
>      2.237 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
event-2.1.so.7", flags: RDONLY|CLOEXEC) =3D 3
>      2.288 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
sasl2.so.3", flags: RDONLY|CLOEXEC) =3D 3
>      2.337 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
brotlicommon.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      2.399 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/lib=
selinux.so.1", flags: RDONLY|CLOEXEC) =3D 3
>      9.457 ( 0.006 ms): perf/10791 access(filename: "/etc/selinux/config"=
)                               =3D 0
>      9.719 ( 0.014 ms): perf/10791 openat(dfd: CWD, filename: "/proc/self=
/status")                       =3D 3
>      9.759 ( 0.007 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devic=
es/system/node", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) =3D 3
>      9.786 ( 0.006 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devic=
es/system/node/node0/meminfo")  =3D 4
>      9.825 ( 0.006 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devic=
es/system/cpu/possible", flags: RDONLY|CLOEXEC) =3D 3
>      9.837 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/proc/self=
/status")                       =3D 3
>      9.962 ( 0.005 ms): perf/10791 access(filename: "/home/acme/etc/perfc=
onfig", mode: R)                =3D -1 ENOENT (No such file or directory)
> Failed to run command 'reccord': No such file or directory
> [root@quaco ~]#
> [root@quaco ~]# perf -vv
> perf version 6.7.rc6.gcd1e3ef8bfe8
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> [root@quaco ~]#

Thanks Arnaldo,

I tried b4 am-ing the patches and repro-ing in a clean tree. I'm still
not able to do it. Knowing what is going on in help_unknown_cmd in
tools/perf/util/help-unknown-cmd.c would shed some light on the
matter. I'll see if I can get other ideas.

Thanks,
Ian

