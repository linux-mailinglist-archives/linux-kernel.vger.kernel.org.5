Return-Path: <linux-kernel+bounces-118926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997A88C14B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B355F1C20A85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695F6F06F;
	Tue, 26 Mar 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWJvw+bR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501411E485;
	Tue, 26 Mar 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454118; cv=none; b=RRfn3wbGfwaWMkXjaT79j1PJ0XARdYoYtMnDhK63gW6Pw81C3vnCfWMuXNqRoIy2oecQlh68RimxqOE/z0lO2WObNSE/udoQ5TRzj02xewl7jA2duw0RYKfay7OSH+F1VIZWvUjNc+RU9g/H8gk7PMu3m4eyHT8pSAfXTyqV2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454118; c=relaxed/simple;
	bh=uCcHRj1EPqJseqwLf22pNV9+UeLCYFNEJtYoMZqpZh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTZ0Rg5Kli23QWqb3lh2ao9euSFF/fwwGoE0TfjUNJ3wvUYyIlJlWqHLTn6GBf3kNBwMV5IFE5HueNUpF6K9hsRk0YdwuGI+Hk65BiStxA0wkusyKxi5QY0TON2Nfq/neOktHGdwA5l/Y8wJSvdXa5ZWEbHXbNpasEwJvHRDFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWJvw+bR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46d0a8399aso1070146066b.1;
        Tue, 26 Mar 2024 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711454114; x=1712058914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr/4I2RJUe85l43HNxbnkFvc01YkMgJpGYtWHzCf1GQ=;
        b=XWJvw+bRAsiEQ+0qGNbbKn0G2JJVPnSjfOk7wNE+W4zfWzH5VcyodArHA5PVj3Iy0g
         NCcs4HGgO3LPSdaH99AWWHP3mNBySm+YDqAORfmpwWgfL67XzxkUe/WsD5K5WLfLs04x
         D0JXORkuTBnSdCKWT8lwfvSy2IxwpmjT7Kwaufx3QndwpBupfQztsHz576nXLFuA3u2u
         5zK9/jGTzlGmF1z3bzCP4AghKKC6hWQSs/Yb+cn3yERyFC3qDKiKS8AfMwYLSNeU2nZ4
         NHYol5O+blQqhvnlftuGPOVLUiipqyjxeRevEsX2sAMVe3/RuaRPZt2eWt/L4XL4nYi7
         gtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454114; x=1712058914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr/4I2RJUe85l43HNxbnkFvc01YkMgJpGYtWHzCf1GQ=;
        b=XhpGPq1JTYgdB27QgrxgB/KQ+mZ8rL2FqSeunrPnAIrZRrppB6VwAb4F/serb3Vdgg
         Td+hK1nXPHyBLUS6ngbNVfBztaBhTuQBoRLXMCWgkwJfAwVpPlTCutqg4sWE1kY5cepe
         EY3KIMugEQKXl3h+fBqIBSb6rwwHZg5C4UOz8fHNILk5/E1aIwZp5QVVAtUzPptJtDAx
         sEg6fVgl+6OG9H/29wh+o1oHaE4kz6mLQTipklTKnFyFZhGut59ZvV3S60thQlk1tAsC
         +8eD/ysQfXIc9F/O2/t5adHNDcfDzZogknRXAwMLOJdNLz2wYJWZ+v+dTje6Z/l/XP4C
         f6sA==
X-Forwarded-Encrypted: i=1; AJvYcCVGeSHjy6L4qn4vmpJgRryBABb6T879N0rcmsQf5Tu/7VXof4OeG+ZC+KCWgPZvoYVTiHkX23fGD86knmh4gMdQ7PuMXDQmPRkvVce43qF4G85zh2lR5pxvMi2JIUA2yK/AVIXP2K1Q9XY/oMwLFT76FrrACZo4Z8AMV/hydbnIi8bzxqtJ1CNHU/NESCsHL8mm5J+9zaTvIhHeD+7kXFgPJ6yBBACexQ==
X-Gm-Message-State: AOJu0YyXKOlJyKA3eoMKddgCUj1JTkQe8wUJ6BvB26dOsMm+HlNPAge/
	CfpoksbSm0qDB2AJmktJeR0mpx4zbE8I8TJU/WXs0wGxQIp6Jlyl
X-Google-Smtp-Source: AGHT+IGj7Coyzs0BQ3HvVy0I0XPj/KsFEkGhQjLHg0IkJe32C19rYisvF2RsktnUZUadBtnSCF4VYA==
X-Received: by 2002:a17:907:97d5:b0:a47:4563:e5ba with SMTP id js21-20020a17090797d500b00a474563e5bamr1293548ejc.19.1711454114378;
        Tue, 26 Mar 2024 04:55:14 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:400::5:35a3])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b00a4a38d10801sm1958414eju.35.2024.03.26.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:55:14 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:55:12 +0000
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <45ei3cgqjuwcatz622nodyb4eal4ue4diclswpahc36gctdvri@2gfjlmljrisg>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <Zf+d9twfyIDosINf@gmail.com>
 <syviklbpdblcwr3l2seuwyzfrg2hy2shx5f6ho6yf4s4ce63tc@nbo4by247y6z>
 <CAEf4BzZnUcFEk+7r39n8=zopBeK96wfQ4Vtndd2tY2ymqOpCtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZnUcFEk+7r39n8=zopBeK96wfQ4Vtndd2tY2ymqOpCtA@mail.gmail.com>

> > > Have you considered/measured per-CPU RW semaphores?
> >
> > No I hadn't but thanks hugely for suggesting it! In initial measurements
> > it seems to be between 20-100% faster than the RW spinlocks! Apologies for
> > all the exclamation marks but I'm very excited. I'll do some more testing
> > tomorrow but so far it's looking very good.
> >
> 
> Documentation ([0]) says that locking for writing calls
> synchronize_rcu(), is that right? If that's true, attaching multiple
> uprobes (including just attaching a single BPF multi-uprobe) will take
> a really long time. We need to confirm we are not significantly
> regressing this. And if we do, we need to take measures in the BPF
> multi-uprobe attachment code path to make sure that a single
> multi-uprobe attachment is still fast.
> 
> If my worries above turn out to be true, it still feels like a first
> good step should be landing this patch as is (and get it backported to
> older kernels), and then have percpu rw-semaphore as a final (and a
> bit more invasive) solution (it's RCU-based, so feels like a good
> primitive to settle on), making sure to not regress multi-uprobes
> (we'll probably will need some batched API for multiple uprobes).
> 
> Thoughts?

Agreed. In the percpu_down_write() path we call rcu_sync_enter() which is
what calls into synchronize_rcu(). I haven't done the measurements yet but
I would imagine this has to regress probe attachment, at least in the
uncontended case. Of course, reads are by far the dominant mode here but
we probably shouldn't punish writes excessively. I will do some
measurements to quantify the write penalty here.

I agree that a batched interface for probe attachment is needed here. The
usual mode of operation for us is that we have a number of USDTs (uprobes)
in hand and we want to enable and disable them in one shot. Removing the
need to do multiple locking operations is definitely an efficiency
improvement that needs to be done. Tie that together with per-CPU RW
semaphores and this should scale extremely well in both a read and write
case.

Jon.

