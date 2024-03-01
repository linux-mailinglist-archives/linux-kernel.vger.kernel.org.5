Return-Path: <linux-kernel+bounces-87780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70D86D8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192D8B2110B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11144374D9;
	Fri,  1 Mar 2024 01:36:19 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80BA92E;
	Fri,  1 Mar 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256978; cv=none; b=EuSuP4jOgH/iDKKjXd8cnPLCk0QBSiQh8iQkw+DSBgQEi98fxlq070uSIRwWXJsoFX/CWD5RIihFzjCZgOJ2DVwIp4NtlrGcOJJ06WB+r4yS4j9MsYy7na19xcl+woAzN1wpzc4EBsZS9UHw4z90qNWuT1wiLxVYL8qC3fnf8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256978; c=relaxed/simple;
	bh=wVXrnBTi3TycX+Jfqc1qPh0gqtHz5YmTj8yDDOMQ//w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMpNR10qFaNimHzJSfeyuzSZYJahZK5HqiiJ1Dg0WPUYxFdGA941mBTG0KhTFHbSPA1QR5ijTw5Z0CyGCP0PcFFla0382yBGWg/qPoeaQdPEQ3Fyb8p0B19Cv4TS5ehxCKTYQ9Q3egjVuAjkhv1xQTnCpqGeIh9LkLtQx2e991A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1419726a12.1;
        Thu, 29 Feb 2024 17:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709256976; x=1709861776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOjQrfFkf1F9ouFasWOllB0AHilUi/DGdhN7vfozvZA=;
        b=FsIEuyZLHqt4rG6WF/tm1uNZBu9OgFxklg7+xa8yIZO1zuKbHflLlzasemgFfAlmRJ
         93S20SOaWMCsNcTpX3kHB/W7E5w65x65NQjGiNDpi0Y1qNL8njZQXwpuZxy9wCBro0rg
         s8OoxByFKMJ4dcVSfhUh1sXBDekUhvTheD/lNcO6MLUJHFzo+n2kBsiijzeBXGyQ5G50
         JowW1c9zDgiY1VqlnVlHKFX1aRzwzq27wlBv529T/2gpQrfYy08K9O4mz4Amk+0bjc7e
         +4Cs3ZWriC+y+xb1R5g1yjOsDhnuscbHmvePc5MJDwoq6f4MQEm2fuDjY2OpPhFAz4O1
         Cz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs7g5uibY5svYtxUWIYbUms9Ku5SNfUCQoOLuboKQG95wOAfVqytCEyFikX2yqpXROYdkU9JApQoTx6SPsvXc6RyvZaaB+KCv9btN2HQYkUFUo9rfe1t1plFCUCaOTKOE5C32CSO60ON4V1Zp2Cw==
X-Gm-Message-State: AOJu0Yzpa8Sc8NnQrS+lNVIql2BXOLWQI42onuME/VBcLdW9mrSj/qs/
	GgDlcouqdJ0rRa5ugz8tlVZybb56ETEaEM0Ydz6q7ogtzthDxTs2vDxARvpx8vSiCQnhwVqFZwe
	JE5Ns1gBJz2myaWCwEhWVR5MS6SI=
X-Google-Smtp-Source: AGHT+IFByFlqkYbgdcSEC43hr30l9SEgoYoZtmISoKUtUyRMzY4GKGULeaZm555ANW9kO8fJtvQQAQXg06Ctl1Ml7UU=
X-Received: by 2002:a05:6a20:aea8:b0:1a1:34dd:7d92 with SMTP id
 do40-20020a056a20aea800b001a134dd7d92mr106040pzb.59.1709256976409; Thu, 29
 Feb 2024 17:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com> <20240229063253.561838-5-irogers@google.com>
In-Reply-To: <20240229063253.561838-5-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Feb 2024 17:36:05 -0800
Message-ID: <CAM9d7cj9CgxmvSMLvDa=RM8zPRJpRbKqMkU7_B68HwEX7qo=hg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] perf machine: Move machine's threads into its own abstraction
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:33=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Move thread_rb_node into the machine.c file. This hides the
> implementation of threads from the rest of the code allowing for it to
> be refactored.
>
> Locking discipline is tightened up in this change. As the lock is now
> encapsulated in threads, the findnew function requires holding it (as
> it already did in machine). Rather than do conditionals with locks
> based on whether the thread should be created (which could potentially
> be error prone with a read lock match with a write unlock), have a
> separate threads__find that won't create the thread and only holds the
> read lock. This effectively duplicates the findnew logic, with the
> existing findnew logic only operating under a write lock assuming
> creation is necessary as a previous find failed. The creation may
> still fail with the write lock due to another thread. The duplication
> is removed in a later next patch that delegates the implementation to
> hashtable.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for doing this!  A nit below..

> ---
[SNIP]
> @@ -3228,27 +3258,31 @@ int thread__resolve_callchain(struct thread *thre=
ad,
>         return ret;
>  }
>
> -int machine__for_each_thread(struct machine *machine,
> -                            int (*fn)(struct thread *thread, void *p),
> -                            void *priv)
> +int threads__for_each_thread(struct threads *threads,
> +                            int (*fn)(struct thread *thread, void *data)=
,
> +                            void *data)
>  {
> -       struct threads *threads;
> -       struct rb_node *nd;
> -       int rc =3D 0;
> -       int i;
> +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> +               struct threads_table_entry *table =3D &threads->table[i];
> +               struct rb_node *nd;
>
> -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> -               threads =3D &machine->threads[i];
> -               for (nd =3D rb_first_cached(&threads->entries); nd;
> -                    nd =3D rb_next(nd)) {
> +               for (nd =3D rb_first_cached(&table->entries); nd; nd =3D =
rb_next(nd)) {
>                         struct thread_rb_node *trb =3D rb_entry(nd, struc=
t thread_rb_node, rb_node);
> +                       int rc =3D fn(trb->thread, data);
>
> -                       rc =3D fn(trb->thread, priv);
>                         if (rc !=3D 0)
>                                 return rc;
>                 }
>         }
> -       return rc;
> +       return 0;

Don't we need locking in this function?

Thanks,
Namhyung


> +
> +}
> +
> +int machine__for_each_thread(struct machine *machine,
> +                            int (*fn)(struct thread *thread, void *p),
> +                            void *priv)
> +{
> +       return threads__for_each_thread(&machine->threads, fn, priv);
>  }
>

