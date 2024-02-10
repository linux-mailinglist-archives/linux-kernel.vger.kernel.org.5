Return-Path: <linux-kernel+bounces-60177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BF850111
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E8DB2231A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEDB1102;
	Sat, 10 Feb 2024 00:22:05 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D44366;
	Sat, 10 Feb 2024 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524525; cv=none; b=jLQz7BJ64ZAoQjwwW8LfsrrISstx9GXRhu5Kd5tz1nawNe2gpEgZPYHEDD4eFqEHvmzvWhqjMiC6p6N/+0UQXXkMT1PWWty2m7SkNCrTwgrbG+cq+AKNT63T5zNBhcIe/HTOJDNk/1UsEu/YVk5dy2LYERgg1zuJbxcocnF66Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524525; c=relaxed/simple;
	bh=p4HJtbC7sr9+mRbDPyd1tVdbBoNEAVlwdpQ81uwZGkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZfRnmRn4GV4SZrNHxlBgIHbvFOuXGG2y1tnu+YwziQsMiPsVs39qtfZ4pdCF+HKc/lV6MzFKM3G1pa8Dkm/k7InhdbZv97dLh8BgS6Hj63ZV1dJemcZw2sHUzqlJ8S6DNGjZ/i6UA48D4dhz7YrbZz5L8aFDnfluk2YPOzyv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2970f940b7cso568132a91.2;
        Fri, 09 Feb 2024 16:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524523; x=1708129323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GER+N6at/M+itjVzqKdSOcZKhDVYgoDwe42TsTNQd0=;
        b=cCKia8xDGg+YbGEj4TkMQu/a0EqZ4QIlpEn2Tu8jGXBbHtvpVNIItYgcly6ji4aOij
         OF0AwJ3oWqeUuf1CGQ36QIciocsa37IwNRYjVcDtAeok7mI77lOBihzzl8x8AIJ9Pj0A
         Q1LVzBaMQT6b5ehBCnp2zYpKd+CTt268PyPogd0Rk0SrbTistRlLRX8RkdbcQe39s8TU
         Nu3PbVlz2Fuq/cdd21hh3vWbp5N0lpQv9uE2UogIgfF1wdYpBArO3d5Tymh9JzU4qk5/
         bxnA65stUTCRgh7UN1cZzGwy7pcUXt0PQ1wZVM2kej+vey6az7aNcOwan5pKM0vlSfRZ
         mXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXbJBNv6A8Hb7Dwicbz2JBNnAv4xt4xOTWYjMsxzhDs54Wan+LyaHNTTjIdh3ZS8r8q4Yyr9nSzJUyh9kfQejmisyY6GRT6OB3yO5Tsz/NyiFJxNu4kwV0rRrAW87m53dqAfcMdb13UAC2U3aFd/w==
X-Gm-Message-State: AOJu0YwLo0sqN8bFBdY7MRNb5Xvvgu0SIt+helLTWWuVZrdgBGOGPKS0
	0dHfLfDRWQOD8pCrTOkYRk0RdosEE6b5Qj8oEuhE3j/Xjb6AYJzncHV0/XgdWqmUWcn966AzcS5
	rsBD54VY4xJc510DrvKImh35H8aA=
X-Google-Smtp-Source: AGHT+IEXD3A5dWjGC7KaVKM0HkmFVfazNpWmdE3zsdI9nfzsz03DrCJD6p6G6694QrXqD/84HA7fzF4QKRHzTQXHZbY=
X-Received: by 2002:a17:90b:380e:b0:296:43a:932e with SMTP id
 mq14-20020a17090b380e00b00296043a932emr712507pjb.7.1707524523094; Fri, 09 Feb
 2024 16:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-8-irogers@google.com>
In-Reply-To: <20240201001504.1348511-8-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Feb 2024 16:21:51 -0800
Message-ID: <CAM9d7cih+JqmhVOSoYmRUK2+FRWnknQ6VucYpg5ZC01BYqdv=Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] perf srcline: Add missed addr2line closes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The child_process for addr2line sets in and out to -1 so that pipes
> get created. It is the caller's responsibility to close the pipes,
> finish_command doesn't do it. Add the missed closes.
>
> Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/srcline.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 034b496df297..7addc34afcf5 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct child=
_process *a2l)
>                 kill(a2l->pid, SIGKILL);
>                 finish_command(a2l); /* ignore result, we don't care */
>                 a2l->pid =3D -1;
> +               close(a2l->in);
> +               close(a2l->out);

I was about to ask the stderr, but addr2line_subprocess_init()
sets a2l->no_stderr already.

I wish it could be handled in finish_command() but it seems
the API allows setting external file descriptors (before calling
start_command).  Hmm..

Anyway it looks like an independent fix.

Thanks,
Namhyung


>         }
>
>         free(a2l);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

