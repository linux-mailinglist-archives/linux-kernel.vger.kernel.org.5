Return-Path: <linux-kernel+bounces-100729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26A879C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEE4282333
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31714264A;
	Tue, 12 Mar 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bnPxdjWq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963D1E53F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273072; cv=none; b=lwXaQjeN/nGD/HzussOaAzSFHhKC8nD4xCmoVXmfQD028XuIfEKM5neTCuzTyeSFV9CaR3ZqTDooqtNpniyeq/Y5Cw6ZuhObZoFi8zGqW8ys/a1wTgefmP0/IrmkdtL/iY+1oIL9fpjomi8/HUB9QUbPkWrnz7bkR/jy5PAUbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273072; c=relaxed/simple;
	bh=baFDkOOrBeZj42NkldSI6/bBuCihDEm4YBHKKbd/BpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR1E/TTW5Jhac7Gu0FQGA6JZ897ddKmw2naW3zAaXL5FJspTRApW3dR2vJ9L4A5UZJ5WDQQL1g267J2dIYT6ro0+DNYw0iDS0BPLbLdWkzBq5yJ9aqsClddZdi+Ahk/4zELIr6zDvbkGt3T2mPslrHNMPd6ykQgW59T2Ql7sjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bnPxdjWq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4141c4438so92723601fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710273067; x=1710877867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baFDkOOrBeZj42NkldSI6/bBuCihDEm4YBHKKbd/BpA=;
        b=bnPxdjWqwUAdcukdYSGvLLbcuUDyHyN/tUtYYkQc2gbpYbYSGA6nkHItSqHv52WmvO
         H+w0XsCtKn09yrnIwkVahPjCXiuZi2rwz1sbU5f4N/ajnzxzObxjV4wP+K5ja5cx48ua
         JrvKa1nIwkNGEStjINdXKDLcbxgsqGZsMpKwdxKqlv7og3K2ka7Pef4GyCFF/K7nupL/
         a7WiVAZJ1H320Bebf0/SpKy/tR9yzxZIDsOV0F8knX9ewZKDGsOQzuIhO48NpgTkNQdM
         n2lBu3B7Y67taE4o2M/sfitwvYwb+6THrhUovEc2GLb2gmMdszM4Tm0n122W7kQfl8JZ
         cEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273067; x=1710877867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baFDkOOrBeZj42NkldSI6/bBuCihDEm4YBHKKbd/BpA=;
        b=UrOXwrVQsHjbLIgZZMPrvqhbxbwhxAfQg4UL7iEN0SI2DP9MBYr0bPZuD0YdZtE6hq
         9k+gQoU0XZKySqTpo0Dzy8ALlB9yvA2vIGP7yiZR9hjdBfi0mzQxqqIBokCwbBVnKrbG
         QemBlkqhM0dgPlnHg01lXRm3q7u9Tv5W2ijhj1Nki3DjRmhQ+lqJ/TydRE/YikLTdLU9
         trN0IhNqmK/gkIoRMv0UMk2dphQiDDbUHkDNYjDR5IOwqIK1RWREs73gLwRwYsAXZHw0
         Z4iz/96iw6GSLbzDKxolinPw/FTRjqsB3KonqbMd7YTTzHl09avMdWoDL3nHN4bnwP8n
         bR6A==
X-Forwarded-Encrypted: i=1; AJvYcCWADze2xrPsXEal4W4MGrOOIeD+6MfD+3ZbP53bIDlTThvoFheYd06FH0Lycf9ne2RfTOHPNNIO3heAuNRdzj6sE8Y1SeCnmmWC33Rx
X-Gm-Message-State: AOJu0YzNQxW6qxb4HVKnXfPWqyGVdvaBtqktdqFdVYyQPJ8dxjmQVYsB
	TB1P7Kt9CmSRzNSUJTFQYXpF89BK4LvRB3OpV+YNxpa0lJ8TjkCHYF63RPOs1KWY5CI88XSRrJx
	LA+IZsXf5N3TDsU7NWFrvyuwAE91GgPSapO1Y+X5Zt4NqdGEb
X-Google-Smtp-Source: AGHT+IFe9YTQVLfMd91ZALQjsokRk5GYM7O910vUzsLIr5A9y1pj8/SGNzRNmvEtPLAv6HA0eWV/gMFU29HmrNkCenM=
X-Received: by 2002:a05:651c:3c6:b0:2d3:f81b:7f9 with SMTP id
 f6-20020a05651c03c600b002d3f81b07f9mr6192326ljp.21.1710273067017; Tue, 12 Mar
 2024 12:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
 <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com> <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
 <37ed1ddd-f1d0-4582-b6c5-2f4091dc8335@redhat.com> <CAKPOu+_EwyQEEVV9ULEkncp3727eLGvqD5aswpkG5CtaZ=oJBQ@mail.gmail.com>
 <f959c4c4-8118-436c-83fd-d299689f753a@redhat.com>
In-Reply-To: <f959c4c4-8118-436c-83fd-d299689f753a@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 12 Mar 2024 20:50:55 +0100
Message-ID: <CAKPOu+-SMvjfyNGO-Dt8SahF3TOmLaLFE_yP+KQxk0wdHpFeWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:26=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> It's always a good idea to include at least some sentences about
> history+motivation in the cover letter.

Agree, thanks for your review and for the suggestions, that was very
useful. Once somebody points it out, it's suddenly obvious what was
missing in my explanations for others to understand my motivation.
I'll add some more text to the cover letter.

> Okay, so "Fast kernel headers:" is a bit misleading :P

Yeah. It was the name chosen by Ingo Molnar for his header cleanup
project, and some of his work was merged several years ago, so I
thought this phrase would be familiar and would bring back memories
from these discussions.

> (although I don't immediately understand what correctness means in this
> context)

Some sources don't include all the headers they need; but by chance,
this happens to work because deep down the include tree, somebody
includes kernel.h, mm.h or fs.h and that pulls in everything else;
thus incorrect includes are never a visible problem. By reducing
includes to the bare minimum, many of those problems are revealed (by
producing compiler errors that then have to be fixed). I very much
like to write code in a way that the compiler points out some kinds of
mistakes - I rather have a build-time error than a silent runtime
breakage.

Incorrect includes are not just a theoretical problem; imagine all the
asm-generic headers that provide fallback definitions for macros that
are not defined on some architectures (e.g. asm-generic/cacheflush.h).
If, on some sources, the arch-specific header happens to be not
included or defines the macro in the wrong header (I've seen it all),
you suddenly randomly get the correct arch macro or the generic
fallback macro, leading to inconsistencies, hidden ABI breakages that
may lead to severe problems that will be hard to debug. One can
imagine many more ways that code can break silently at runtime due to
incorrect code (that usually works most of the time, but only by
chance). Better be explicit about what you really need to include, and
don't rely on other headers to indirectly include what you need.
Include what you need even if somebody else down the tree had already
included it, because that somebody else may change his mind at some
point, and then your source shouldn't break.

> The problem I see
> is that once your stuff is merged, it will start getting messed up again
> over time. But maybe that's just the way it works.

It is. This is like cleaning your house: the following day, somebody
visits you and brings nice presents (feature patches) but has dirty
shoes, and then you have to clean the house again... that's the
infinite cycle of software development, as we all know it.

Max

