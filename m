Return-Path: <linux-kernel+bounces-84532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A186A7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33061F22F25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407A210EC;
	Wed, 28 Feb 2024 05:21:40 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA55FBED;
	Wed, 28 Feb 2024 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097699; cv=none; b=sSDfyvWMEAS3b7xfx/8AY1fhSdr0UM9P/PXqQ5KCsaPKZm0fhsLbVUPzSi0hJU4V/Z7Y0xkJfGFHx3GEfwNUfkSLlBDJ8YkVW96GG0EKiCXLE95vapW4sUAUqBBU6ENiNjN8PjxpVeaJ1DDYmR9gGhaqXybeUB08A037L5usIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097699; c=relaxed/simple;
	bh=Ow2R0TlpUmNbnSJf5ij/+iai1DTHDjY6QOPLlXU0zc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdkkBBZJgMo/0s+OtTOnOnx5V+WO/IxSmfPkyKKu0Mr6CqK7t83UPCnOqgPbT6q2VXZpIoirQsq+rGm6vmVsrUbRnk1LJCM1VzyGE6kdKgA0LPOE5c8aCDcA/0Uv/HEVhcDRSR5jCw6/+mp8XBodDQ46Os6mlW8P78ScCZSY4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4241980a12.3;
        Tue, 27 Feb 2024 21:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097698; x=1709702498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1WmJyqMev+WboENbkGUCHApJJaW8nM1fC5ljVtpWBs=;
        b=I0t15RF5aAbsU0wGqxr+PfjzUuqtXB2HKWqLqIWVYzy4+Vibhwu+oYpCVUNeMV84vS
         rvULrtiWcJKZs9EfxgNWG8eWjBlb2G4Nm99iNdDDE9vUl5BDZYxk5gQVAewz+Mo81kti
         FwhIO2TpZEmoo0S318T0l/+ArkA0ortbadYul0kAyYz+rEXvFBwxtMq6sG/K6kkO+EGO
         eZsXsq8lJmyUeG08HD5KxoqrEahBIEc5WD8XWUieKB5QEuug2mIHpnKjx0SWVaT+rvht
         ZqJUmpoVMae+MAFZUlWJR2BbwAqm1IWGb5xrgIXxlNw8u53rQM3VHJshThG4ZxkMSrKJ
         me8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVtyRrMYUW4MT0F9fF3cU3kqB5S7ohbpZoJ4l6qL84zCqB/0XPf/WtGcqWm/wPbV/LDwkMsAyoSzhA06bYQZUAHvKJicrQU6UtFUTHJFoxOccdZ/h4LKeqpnyjxd1gMa0lT64aeFDX4QAfkXqFqg==
X-Gm-Message-State: AOJu0YwVi7kpredngGFqxeIQ3FAhnZa32DL/oPFeUDhTtGJSa/+76Z8o
	GJYfk01DbnQQh7eHZKolEucppgsp7cWD5Re74iaeBZoOOGTeWHgo7iVpR3tB/+9TFe3Du+kNn8o
	Y+ZODmY5b+Ut5jQg4cFOWL7NbXVU=
X-Google-Smtp-Source: AGHT+IEmXUYwd4zUGiWr+18jwchD/SW+25T+5J6Tkd8V01Vm22W6u5EyLcCBleqiGTejM4gmzrGqQGXgSKstWqcjeeo=
X-Received: by 2002:a17:90a:17ca:b0:29a:6695:7c74 with SMTP id
 q68-20020a17090a17ca00b0029a66957c74mr9604271pja.45.1709097697922; Tue, 27
 Feb 2024 21:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org> <20240228005230.287113-2-namhyung@kernel.org>
 <CAP-5=fVUqFbvYp_g5PL9e4on=5gF1YE42-w-XMTrFxOZJ+JrXw@mail.gmail.com>
In-Reply-To: <CAP-5=fVUqFbvYp_g5PL9e4on=5gF1YE42-w-XMTrFxOZJ+JrXw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 21:21:26 -0800
Message-ID: <CAM9d7cgnv9BHoA3zsLqJPxJp6JPAZMrH6_T+=an4_det0DPOTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf annotate: Add a hashmap for symbol histogram
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Feb 27, 2024 at 4:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Now symbol histogram uses an array to save per-offset sample counts.
> > But it wastes a lot of memory if the symbol has a few samples only.
> > Add a hashmap to save values only for actual samples.
> >
> > For now, it has duplicate histogram (one in the existing array and
> > another in the new hash map).  Once it can convert to use the hash
> > in all places, we can get rid of the array later.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
[SNIP]
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index 94435607c958..a2b0c8210740 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -12,6 +12,7 @@
> >  #include "symbol_conf.h"
> >  #include "mutex.h"
> >  #include "spark.h"
> > +#include "hashmap.h"
>
> nit: This could just be a forward reference to keep the number of
> header files down.

Sounds good.  Will fix in v2.

Thanks for your review!
Namhyung

