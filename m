Return-Path: <linux-kernel+bounces-77676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161008608D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482771C2128A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E361BE68;
	Fri, 23 Feb 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceiWdK8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5269B674;
	Fri, 23 Feb 2024 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655143; cv=none; b=NEwNOxJuWy3PoX592C6PPndHrHNL5re0YXH3zm1VJ3oZ+EMQCZe7ZX2JTyFDXvISEquft/Ar+alf8bjSFJ7u49HcWUQ2l0yTw8hotJUIIHOHrg3RIRwb4f7Rr7RpKjk6c1DQS0WT6m1euh32yLDwX7ef6bcALr3EpaZRvnjviWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655143; c=relaxed/simple;
	bh=5a15H4gjG9Z8VNMVpz9Ni3AuhpV4Czq4UmRYp26Cahk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWqBPXc4n+/H//paxgF5FIy46/DDuofFqg4N6EXJATEjmc8zbc8VNVQvTvoDrwjdP5ZZdyZfRIXULgRRbzHcYwAg+vCV9R/xMc0mA+RrT2G33U3+liA5t4KjG10QBe/I2CSrlrhmb/zBA6yvPblZNt1nTGXL+pCQtaIUye+b8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceiWdK8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE79C43399;
	Fri, 23 Feb 2024 02:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708655143;
	bh=5a15H4gjG9Z8VNMVpz9Ni3AuhpV4Czq4UmRYp26Cahk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ceiWdK8i45R9/jlFuwzOrVBtzkeXJCgWncbvtP9JDZiYppVhRfLFm+IWKPKVOD7zr
	 6p4W2ahnepM5LVyps8O44sqYdktoki3Aps3NkRh+cdUzU6epRU2xYIkK9nIvOzKPEk
	 gwuXWqQn1bReolpRgOK6mH7O59TTQxNmArVf/dbv6vQ4fY4pzwFTX6quBeh1pf9wke
	 v2EhIkzomYqee7IqNMTxwJYqxlLce0jz/GrRy+kdn9SFRnCxsObQpVhEaekHaNW1l4
	 /tL+mGrK9goTlG8oIKPojos8M6j3aTXECl7mI31dl9QeQAhXWm3SL17kkHmqZ8B6/K
	 MY2yslwhj720A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso5212631fa.1;
        Thu, 22 Feb 2024 18:25:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgqSlTOPPhF83xQLuXqrzRmLqOGEZVuoCphnlkm362sNmBDgdGbw0GN/7aFdHXjJHPGOC0eHM/NojRKzAZxiq/uAFPuscN0qnlnr7Xh+JHNum8cMhDaft9KywfCU6TDMk5rAmFDum3LsS+PyYL7O/PTrg5RioYp7hEnPjr0W7efJ2VzdwBPTzvPz8asQ==
X-Gm-Message-State: AOJu0YwDKnWIfNuwoaaaDRbRgkUF9WP/+C4eCDM8sPAcsJWH0s7o7u87
	jYJNcdcEfJ81UpLNyig1t5dQEY/9DOrb3iL1Cc/U31OXh73loPUtcnAkIgnwUdfIf+hjt/ux8pk
	KhuYY/ZW3WlqrUvzUTi6lYGOsn2U=
X-Google-Smtp-Source: AGHT+IHv/pqSXOqGKS7AHlfuR7hjQALuFEIFDcK1HpkE2N7ySttizVh9qLS0Xl/Y8NUQ9GCaKzp4frWkxaJzXnWCDBs=
X-Received: by 2002:a2e:8613:0:b0:2d2:3b61:a2b with SMTP id
 a19-20020a2e8613000000b002d23b610a2bmr452895lji.11.1708655141667; Thu, 22 Feb
 2024 18:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221134201.2656908-1-masahiroy@kernel.org> <CAM9d7cjQ0wbPu9NWcg_Rj66jcJ=6HoNMcTnfR4wvjaJ47FDVQA@mail.gmail.com>
In-Reply-To: <CAM9d7cjQ0wbPu9NWcg_Rj66jcJ=6HoNMcTnfR4wvjaJ47FDVQA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 23 Feb 2024 11:25:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASch8P49gNagJ3OhMDqFNuzxcRRKatet2iedWFi76qoog@mail.gmail.com>
Message-ID: <CAK7LNASch8P49gNagJ3OhMDqFNuzxcRRKatet2iedWFi76qoog@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove meaningless assignments in Makefiles
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Feb 21, 2024 at 5:42=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > In Makefiles, $(error ), $(warning ), and $(info ) expand to the empty
> > string, as explained in the GNU Make manual [1]:
> >  "The result of the expansion of this function is the empty string."
> >
> > Therefore, they are no-op except for logging purposes.
> >
> > $(shell ...) expands to the output of the command. It expands to the
> > empty string when the command does not print anything to stdout.
> > Hence, $(shell mkdir ...) is no-op except for creating the directory.
> >
> > Remove meaningless assignments.
> >
> > [1]: https://www.gnu.org/software/make/manual/make.html#Make-Control-Fu=
nctions
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > This is a treewide cleanup, but in practice, this is touching mostly
> > perf Makefiles. I am sending this to perf subsystem.
>
> How do you want to route this?  I can take it to perf tree if you're ok.


Yes, that is my expectation because it will reduce the risk
of merge conflicts.

I only included the perf maintainers and ML to To:,
and anything else in CC:




--=20
Best Regards
Masahiro Yamada

