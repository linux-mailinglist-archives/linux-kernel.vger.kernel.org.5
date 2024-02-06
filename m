Return-Path: <linux-kernel+bounces-55717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161184C0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C337A1F241FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE0B1CAB7;
	Tue,  6 Feb 2024 23:17:30 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FD1CD1E;
	Tue,  6 Feb 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261449; cv=none; b=RztH+askcj4jTOFnJI/zx9YlW2IpltsmpBhOL6DfvV3zsQAqIGIOLkkGn/k/0E1WE947K315kIXNjRB0oqX9dBwsltNPdWO8dhEvnnXAX7pWmrPFTm7au8NtqR9fMhEekFPqsonr85WNUBPKrUUJmKicVNg3VtlahzGkRdYc5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261449; c=relaxed/simple;
	bh=4AOVn7dPiifniHPNpKERkiEkEjNlA4Ho18EbBY2UPkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOWzJT59pgx0lPy5VYjxU+YItlBIk303cu+DD+RSxETAvwNzK/KWeUdYZ9o5pveZyIH0Lu3YCIHk86vjZbz+1vNVuV2pAbxrpYgDJQejid3fTGYwS4sZudngf1JFALrlgsZ/jvwjpxPlH44MprOHQxRmUbOOXF/Ry6pAkHne2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so4801918a12.0;
        Tue, 06 Feb 2024 15:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261448; x=1707866248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjlIDiKTtVKJkqS2SEHd4mnJGkqh9s6QaQORvmxD80I=;
        b=jmnK0snrzNzp9P8iylH2KSlSjmRnC8DKaERIx1vBueiCEHFeV/xPV4mUOuZU8zk8/K
         qyqutcKxMAlX8lNz+z2s7sdPd2iqUWQ+b48Hr/yMZoMrLnIdjUvcbPz4GEncQ1p3srMR
         FL3pgEXoQGto6ZdMbkB7Dm/lb9zOmRmEaXxHmBC3yf0fWYv865GRnEpdlls1Ri/zUxje
         4UstI9tLZzjQkb8jcsL08G/9aAW9qhKtz5ah/faEQVC1uXACbdA9GImyo0hPvFWMe4qu
         s2lv3LNiFVEf/nZfY8weCBynO0A6Qn6VdQquMo7UIkNFlipn0wRlkownrhrR44Zs4vrn
         FBCQ==
X-Gm-Message-State: AOJu0Yxvm4J040oorkme1FxNSH8Bisi3E9IkcBG3W0ttTvGS7ijzu3k7
	IJlQ7d8Vzevfp/uL6sDLvh++/Q4y5oUH2Ah0Skl0pOUAxRyOnpTwRjWDZWKCnX/3wdu7CtB3Fel
	dTujnVgL5RCIUYnjJeMih0gHniJQ=
X-Google-Smtp-Source: AGHT+IHTFXP/ZGv31eHT5oiF61JVOKe5gj5zhSh9cpLNWrW3HjOsy+Lvg1+Mo5uKR1IFqNM7DIoCnsGGoM5cUrZ63Ss=
X-Received: by 2002:a05:6a21:680b:b0:19e:a3de:5786 with SMTP id
 wr11-20020a056a21680b00b0019ea3de5786mr654501pzb.3.1707261447712; Tue, 06 Feb
 2024 15:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-10-namhyung@kernel.org>
 <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 15:17:16 -0800
Message-ID: <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
Subject: Re: [PATCH 09/14] perf annotate-data: Handle call instructions
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 7:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > When updating instruction states, the call instruction should play a
> > role since it can change the register states.  For simplicity, mark som=
e
> > registers as scratch registers (should be arch-dependent), and
> > invalidate them all after a function call.
>
> nit: Volatile or caller-save would be a more conventional name than scrat=
ch.

'volatile' is a keyword and 'caller_saved' seems somewhat verbose.
Maybe 'temporary'?

Thanks,
Namhyung

