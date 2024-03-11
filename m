Return-Path: <linux-kernel+bounces-99612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2686878AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905221F21E16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035557894;
	Mon, 11 Mar 2024 22:29:27 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107D5786B;
	Mon, 11 Mar 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196167; cv=none; b=E0hlrgy+r/y3onPpYjJroyE2EHqBxjneNZbLaBxAQMemmIqhcDCZf9N6nj24Rz79027RUpqhnFgKpvwSXFnsn27VBEX8GUWQXzYXS19hgvB9ERkcxN7RH6hBeu/+s1BQQ+DIVycprKAHdnC7lBqXkwbaLZQn9AC/FuL70Ym8TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196167; c=relaxed/simple;
	bh=64IRN8BB8NWzcfQhQXiRkoqffUz/4sNxlkK5ICLel/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jx1xHZitenQTtxp+TKY7RLgWBW54nMEInRYECCs61S/GQle6s3CaqnUhHevKoC7AeccGFJi1y/FwhBJesKudlkylRfuARQIZaeilZTlj4lyGchLCxMb7FxVQFBwGzwB0zUkiSqOZMSZDIvpRcv8WcBnXrZLakWhBsysnYMDVUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29be5386b74so1333545a91.3;
        Mon, 11 Mar 2024 15:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196164; x=1710800964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueXoXFA5YWcxkJgIX7h3GbyEpjWYt6UJ+XYCA7cZuX0=;
        b=UakH8Ej0x2sJ6+PH/XKNdfR+BQmV9spTHHRe1QROyrJnQkgFB2Ma0uaA1aS7m0tZz0
         01UUwQMoyqCjbXLeoc4w6RJ1FfqZM6wNfvOP6f0jKtiR6FktCqOKd7ZFbO/dgI8t+j2D
         xDDbKHLhCpe2dQjnKfnKANkal81aF/vlMMivDWAIlifcckoLTj3KY1XLV0bfU1/Du5Fm
         8St43crJBovBc7t/7a2m2XErhyTV4cDeR7m8/lTXx0LPL4Buc779dhKDVrhhODek+m7P
         3seDb4BuHIuNXl4Y/YwcwP84t5kCgfLBIGICgRAx1iuSxHyVxzp5UkIOQRY4qB8pzE/V
         lrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaKx8SzB8G54iihDFvUaTgGzgu9tx60MgeLyhZ8D8g1zkcPGHNd+Li4R0siyc3VStiGCCTk9sIOmh86z+K1gz5izesdy3HocM//bfGVd1v+2xR1yfrFlhoM4DxmPD8j7yS+wRr6InOmR0+ywEE9Q==
X-Gm-Message-State: AOJu0YwmkUStQ1T17ADcTgahLmq4KTqjEzVjmBk0O5FIGMOPZMMxy6Zl
	P2Pz0m8za1eNVr5dC/QS3w4YFq7Nvn2+HU+zuu8FvDlR+QjNcoVi/6kxG58BSice5foCWKcc8r8
	4h49oboxxgL/OUFP2yAk+MKYsWHE=
X-Google-Smtp-Source: AGHT+IGEtIsx/4F2eFU4GPqQGvUk+dKfz4Y4x66uZMxgnHDJv4K0THOmrfMvwi/7m97mEsgp3DRu8NVeRiC1mLGXTbM=
X-Received: by 2002:a17:90a:420d:b0:299:72d7:5b9a with SMTP id
 o13-20020a17090a420d00b0029972d75b9amr253791pjg.24.1710196163919; Mon, 11 Mar
 2024 15:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309132710.1055941-1-retpolanne@posteo.net>
 <CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
 <m2il1sbocg.fsf@posteo.net> <m24jdcbmg3.fsf@posteo.net> <Ze9hH5UzmnkFrTmB@x1>
In-Reply-To: <Ze9hH5UzmnkFrTmB@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 15:29:13 -0700
Message-ID: <CAM9d7chSavuxXJG8M9LMVWZfJXJPjQ3M4aLTKGsixmKef0-bkw@mail.gmail.com>
Subject: Re: [PATCH v1] perf lock contention: skip traceiter functions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anne Macedo <retpolanne@posteo.net>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:53=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 11, 2024 at 07:25:16PM +0000, Anne Macedo wrote:
> > Anne Macedo <retpolanne@posteo.net> writes:
> > > Namhyung Kim <namhyung@kernel.org> writes:
> > >> I think it depends on the kernel version and configuration.  I remem=
ber
> > >> I saw a different symbol on old kernels.  But it'd be hard to handle=
 all
> > >> the cases.  Let's have a single trace text section in the struct mac=
hine
> > >> and use __traceiter_contention_begin only.  If it's not found you ca=
n
> > >> fallback to trace_contention_begin.
>
> > However, if we fallback to trace_contention_begin, we won't be able to
> > filter out both __traceiter_contention_begin and trace_contention_begin
> > at the same time.
>
> I think for ARM we need to skip both, no? I.e. I agree with Anne.

I haven't tested it on ARM, please go ahead if it is needed.

Thanks,
Namhyung

