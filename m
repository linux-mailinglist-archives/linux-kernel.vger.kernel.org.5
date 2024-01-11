Return-Path: <linux-kernel+bounces-24081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDD82B68A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786CAB23EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2035812F;
	Thu, 11 Jan 2024 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JZ9fE5x"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3E58120
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-467021612acso1440014137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705008044; x=1705612844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV8E3GY3Bf8X4jIpwdPtDTsqut4T51x4SGgA0WQsHBg=;
        b=3JZ9fE5xote49FhIjSUNfJ2QyZuZ/cGQ3Msh4at9C73v4YVITT51p7izDtUJmdYThy
         VYtkFeC3C9X/PHgsY9E07ypfDbLz3u99Ig2RrhGn7t0RphOyYOYS8zA/2NSmtxPjfkze
         fk448XSLJldloTM7Yhn9qc7o+nyP6hNeHHhGBdkUNcPAT4etYh//xHSPplHBS5d/8uSM
         ZJ18mXf444jmVgxrQZzLnqAxTOv9ZkmUdfqXtgHWI3cjD+Mlh/85zETulYLzPpgzlVI9
         n6WCJqPTA4tMaby52qXh5tduSuBS1c9p1JiYidCjAm/FCdVFo55V2GIfM9tRSt0T3aBs
         Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008044; x=1705612844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV8E3GY3Bf8X4jIpwdPtDTsqut4T51x4SGgA0WQsHBg=;
        b=o8496b7Uot3uJbgPVaVJ2aO1ckodygRPNkmgy4QmhPJNMVVwSE5ZqhIXwzKI5abu2l
         EXPT5i65OyQWCyQVWC0B8kl1PqHAEUCbm0teLsCyZYUrfwtwWwm6KRcSh+rRjSYY5J5q
         tMFpRQtUf0zuq4vQYgBXEKCZ7PtK3tbjBkvI+gcy6BCsIzii5se+QBXuWbnCOMJrXAUU
         lO1wtkzrmNegRpk1P8EN6zIIZwfT1ppwYO06jnl6NCJYnlmafCrctSzPfYP0x7TQFlf1
         VMHdk+I7EL2axxE6/Fy5+hgCgP9suYCtDDDOv4rxRlwoS6MWyRhaPptc/NcOpGa1uLFQ
         ZWSw==
X-Gm-Message-State: AOJu0YweSbCZUv8G4CcOx79n5rUigSSJ7C3Apngm+2ryRz9aBBsL3MRt
	rDpwXqch2PXMJuXTP6eCP+PWgDobdadf6lGzjsx5SByEA8gV
X-Google-Smtp-Source: AGHT+IGD0yFAepkYBqAzxYxiPmzH2nLXLz0AQf5J6Kh1QXElngJUOD9LfOmgQyL5SKVkBz4lh0erKjErSzCLxOG6bbo=
X-Received: by 2002:a67:f2d4:0:b0:468:1083:39ea with SMTP id
 a20-20020a67f2d4000000b00468108339eamr448515vsn.20.1705008043947; Thu, 11 Jan
 2024 13:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111001155.746-1-carlosgalo@google.com> <202401120052.rdFjpivG-lkp@intel.com>
In-Reply-To: <202401120052.rdFjpivG-lkp@intel.com>
From: Carlos Galo <carlosgalo@google.com>
Date: Thu, 11 Jan 2024 13:20:30 -0800
Message-ID: <CABtOLRJ8=fPePsAG1-QyF_uo2X=sOGXcgsU_fJJXk3mFyOVN+w@mail.gmail.com>
Subject: Re: [PATCH] mm: Update mark_victim tracepoints fields
To: kernel test robot <lkp@intel.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	oe-kbuild-all@lists.linux.dev, android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:08=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Carlos,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Galo/mm-Upd=
ate-mark_victim-tracepoints-fields/20240111-081635
> base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
> patch link:    https://lore.kernel.org/r/20240111001155.746-1-carlosgalo%=
40google.com
> patch subject: [PATCH] mm: Update mark_victim tracepoints fields
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/2024011=
2/202401120052.rdFjpivG-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240112/202401120052.rdFjpivG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401120052.rdFjpivG-lkp=
@intel.com/
>

Sorry, I missed a comma in my final editing.
I posted a V2 here:
https://lore.kernel.org/lkml/20240111210539.636607-1-carlosgalo@google.com/

Thanks,
Carlos

> All errors (new ones prefixed by >>):
>
>    In file included from include/trace/define_trace.h:102,
>                     from include/trace/events/oom.h:206,
>                     from mm/oom_kill.c:54:
>    include/trace/events/oom.h: In function 'trace_raw_output_mark_victim'=
:
> >> include/trace/stages/stage3_trace_output.h:6:17: error: called object =
is not a function or function pointer
>        6 | #define __entry field
>          |                 ^~~~~
>    include/trace/trace_events.h:203:34: note: in definition of macro 'DEC=
LARE_EVENT_CLASS'
>      203 |         trace_event_printf(iter, print);                      =
          \
>          |                                  ^~~~~
>    include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAM=
S'
>       45 |                              PARAMS(print));                  =
 \
>          |                              ^~~~~~
>    include/trace/events/oom.h:74:1: note: in expansion of macro 'TRACE_EV=
ENT'
>       74 | TRACE_EVENT(mark_victim,
>          | ^~~~~~~~~~~
>    include/trace/events/oom.h:93:9: note: in expansion of macro 'TP_print=
k'
>       93 |         TP_printk("pid=3D%d uid=3D%u comm=3D%s oom_score_adj=
=3D%hd",
>          |         ^~~~~~~~~
>    include/trace/events/oom.h:95:17: note: in expansion of macro '__entry=
'
>       95 |                 __entry->uid
>          |                 ^~~~~~~
> >> include/trace/trace_events.h:203:39: error: expected expression before=
 ')' token
>      203 |         trace_event_printf(iter, print);                      =
          \
>          |                                       ^
>    include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLAR=
E_EVENT_CLASS'
>       40 |         DECLARE_EVENT_CLASS(name,                             =
 \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/trace/events/oom.h:74:1: note: in expansion of macro 'TRACE_EV=
ENT'
>       74 | TRACE_EVENT(mark_victim,
>          | ^~~~~~~~~~~
>
>
> vim +6 include/trace/stages/stage3_trace_output.h
>
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  4)
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  5) #undef __entry
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03 @6) #define __entry field
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  7)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

