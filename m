Return-Path: <linux-kernel+bounces-99246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B3878583
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35506283067
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636104594B;
	Mon, 11 Mar 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5H4sxEC"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2B41211
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174710; cv=none; b=cqEW4vyfneDNeYofRDvw6ZBb810ziIbDm/71fUvceGxSKuwqtoW8aPwkXiWA5x3IFIlvDQuUZpohA7chaeBC1fkzwE8XZrQS5B9j1hWMgoxY0KYMsIoeTmrlSWBeFTEoG9zWitc1F1mnhSv/Yr+kiq9Gc3Zb8CBtS6secUrGgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174710; c=relaxed/simple;
	bh=HTmx+rglP8DyioqNi7J7NVsP/noZw8YF/rOjIVAdCv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfu/WlfiO/RC52v1uirrwxVLr17o88RJVtqruK3Uq2zhZd/MkyPJbMMuOMbk1cb+02wgU9hSrDItvpRLJj/TYaqA1zQIeO+17SIY+5feYSfEVzrfrPkCnhYT8ctEUuYn97pYlkFR4qWpIBEGiNf+qCTlxYGvn6VD7NoRPMyl+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5H4sxEC; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d345250ee1so652345e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710174708; x=1710779508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTmx+rglP8DyioqNi7J7NVsP/noZw8YF/rOjIVAdCv0=;
        b=n5H4sxECl3NdDS4e1fQ8e+AVrKUBP6GCPdrfGTcJJ4QKgn4/4wm1FnTLb0WC9hSX9C
         gLZfygNuzxPnKvnn8YnzDo2YO33+VXhEsJMzPkZyq5RdEWLIi0bP60Dv3EuMsDQc1+Jz
         MbJLCtSvNu/bwCK90EnmYa4t7ESwuK49+gzcu/mdKdoULe0m7UD9CcER6pNWdQS759Q6
         utGPUn1gZF5Ergx+JMw7tsC25zwg1ip+PbRX74A8pQky/aeJPuNOVOmEyKLPKdFKRO+l
         dfQLWIHdXR7d0y/MTfs+ytvel6M8HVaAngYZ1XlyUu20jwyvseW/cf3+qun0Rsy3Omy3
         mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174708; x=1710779508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTmx+rglP8DyioqNi7J7NVsP/noZw8YF/rOjIVAdCv0=;
        b=BR5R35/hWk5E+IZLAqPt1ouUHufB0nfG0fz8rVaJodJJ8egxGsDFWJSWyOsQIDqQr9
         C5XA7xKmYjXxE4VnbvWRrZMhRLFb0bPG44AG/d0vcqAPRWS0lBuFhSaC/xcY1qjCGvAZ
         QKdoBbp2L0UPFNxmDQaxwsdBSXMjxfF43OQ3wAYGjeJgQYUrPxr1/Hmo4L0GRBZ66tPU
         whJCKoJUPQdQ1Vk7lncevWB7BZ4lzmDARUXLs2ms3gYSvDNJw31FJWuoz3Xf9qTANG5u
         xuE4oItoEpsFkwMVPb7PmqNqpWdVYkvVvgBHMPJVMAo7yJjvLzMYbbomA9nqB2VJaEiu
         nPhw==
X-Forwarded-Encrypted: i=1; AJvYcCVLHA18YvPpudnaguq1Gd+WjTEPrLu9aYl1od66mSM7Cwq7D2hzi3FzUtGTdPe9XwXPR3WqwW3dkj8YAa89XWo6KdkDfryNsA2atuz3
X-Gm-Message-State: AOJu0YxuRRwZNDF1Xcg9/DHzhp5uTfN2xvWYX/Z9zmVBVc25FhkxQhfX
	hlOiYnwj/AhQKLZ9Gg4GEUton3W4bDBKvH0s+gRKDx9wQrepv5MuPlo9P1PWdhvJNvYT28Ir5e/
	XdDDBLiHkWd0TJj5wjSMbiW+UyeoNj7JUhuTYIf0wpgt2a0GLrg==
X-Google-Smtp-Source: AGHT+IGG6tjJkSt9OkcKXfNVtLGhqr27OAfuELtJY5krE9OyBu7TM6m3M/iTbZIXQW16F0jLQbSik03g0TSoqevrMS0=
X-Received: by 2002:a05:6122:2a0f:b0:4c8:8149:848e with SMTP id
 fw15-20020a0561222a0f00b004c88149848emr3996116vkb.5.1710174707834; Mon, 11
 Mar 2024 09:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
 <Ze7eKgdajyEgQcpL@elver.google.com> <20240311155927.sbWzLN62@linutronix.de>
In-Reply-To: <20240311155927.sbWzLN62@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Mon, 11 Mar 2024 17:31:09 +0100
Message-ID: <CANpmjNNXd6rL10Vju-tsa1aPsCSMykmfoMg1E1_B-DwKVQw_2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 at 16:59, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-03-11 11:34:18 [+0100], Marco Elver wrote:
> > Unfortunately there's a bug in it somewhere. It can be reproduced with
> > tools/testing/selftests/perf_events/remove_on_exec.
> >
> > (FWIW, the kselftests in that directory are more aggressive test cases
> > that I never figured out how to properly port to the 'perf test'
> > framework: sigtrap_threads is a more aggressive version of the 'sigtrap=
'
> > perf test, and remove_on_exec has no perf test counterpart.)
>
> You posted to warnings, I can only reproduce the second one. Based on the
> backtrace it is obvious what happens and I dare to say that I know why=E2=
=80=A6
> Let me try address them.

I guess I got lucky with hitting 2 warnings instantly. It might be
necessary to run remove_on_exec several times, or even start several
instances of it concurrently (something like "for x in {0..100}; do
(./remove_on_exec &); done" might do the trick).

