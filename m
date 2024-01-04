Return-Path: <linux-kernel+bounces-17329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21760824BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE261F25665
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58512D601;
	Thu,  4 Jan 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8ITE3M+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCE2D051
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaf2f00d1so473e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704410990; x=1705015790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1ItoplfV1JX6AcITsa7L9kuWOogDN6iRQE45K/jnlw=;
        b=c8ITE3M+9ZeXFgsu1KsbQt/JyOHH8VYSi2rb8ZzB8A4HrIvSJ482sPP13mZ2GeK9Ga
         2aEZoue25pihJU+mmaCHHjjv0HUsIfgMqyKyS68DZzgYDQflgeymBVlVan/LH5AXZRS2
         BEE7B1MhJnuf3iqwfvNtYEyaXtWec16hCt/mprql9YbeLMWJ8Bsr7OvFL2TPaz1r2In6
         1gVVj4ylnmtRpPYCw7LXTqHvm5l/d/99yBHpT/ixgktoUF/xWDCOLtVwpeTvJDZNK6ud
         L16YpKu27Kg0pUfsjrxz8TWZ2HleIphqjrIuV8qDiAirA8TLPSiNZ53u7Fe/vX/AR0Mf
         wtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410990; x=1705015790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1ItoplfV1JX6AcITsa7L9kuWOogDN6iRQE45K/jnlw=;
        b=JMNoHWf3qxZvkYGArN4jnKBZmv+JEjVv7Cso/EDOB6S7hLmYi6iBJn6A6XotNCILMR
         rngumjCAwGlQClM0NbQrhwuMmlJKZdBQs2XR4L370DYcN0P/p9mC4colaYNfTOGTrshI
         AiU+73S9lNZKdASMHP6mx7nl4SjVyldKjl7hHw9uoDztp5a1DZTtLaBEgFztbdgZ6InJ
         O9XujiV5yeHoy+jg4g6TDNaugnxcxUzVK9m3PiZWpJ0t10J8UMnTKRU+bTODx+WJrvZG
         zKKJDhusAG4NKZ9ST41oaSmM3oLNodpP06hdob6ofZRD5EwKDZZ0oda2BdTDTXvK8AK9
         Vt9w==
X-Gm-Message-State: AOJu0Yz362yrBJpUUW1Y/RQhDzqzfNx0pn2mEptkTIPtNx4p04trbbja
	YV1dk+lMkv78t3GMwnQmqOc8DB7rLBnNyybaX5U3Y1aYOOEK
X-Google-Smtp-Source: AGHT+IGAK/DXuXapY19eMLxBHwxotH1bZgf2uNLq4g8r0W0sLlOYMHO8R1dkrD+fCgpOge4ZJZiNUQ5NxowH3RxLuV8=
X-Received: by 2002:ac2:4430:0:b0:50e:7f67:dd0f with SMTP id
 w16-20020ac24430000000b0050e7f67dd0fmr14921lfl.1.1704410989471; Thu, 04 Jan
 2024 15:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com> <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
 <ZZcdDyyADG8dP8LM@kernel.org>
In-Reply-To: <ZZcdDyyADG8dP8LM@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jan 2024 15:29:34 -0800
Message-ID: <CAP-5=fVfCnPG0O51rRXVqkGRU4eW7n0B1YGr9pL8CbwxG+V8jQ@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 1:03=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Jan 02, 2024 at 11:30:39AM -0800, Ian Rogers escreveu:
> > On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > uniq will write one command name over another causing the overwritten
> > > string to be leaked. Fix by doing a pass that removes duplicates and =
a
> > > second that removes the holes.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping for this series, no comments since sent.
>
> I applied the first one, the fix for uniq(), but somehow the second
> didn't work for me as in your examples, nor the third, the output is the
> same as before.

I tried to repro the failure with a rebase but couldn't. I suspected
libsubcmd wasn't being rebuilt or something like that. I suspect now
that you have ~/.perfconfig with help.autocorrect set, which means the
output will vary as it will automatically try to run the autocorrected
command. Could you check for me?

Thanks,
Ian

