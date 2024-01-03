Return-Path: <linux-kernel+bounces-15974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3082367B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8492A1F23B63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA51DA40;
	Wed,  3 Jan 2024 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udP4svhP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD871D542
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so3078a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704313325; x=1704918125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd9S3ndoMFuJRzyZ8UnWtl2hKqIm/X+eOwgfHhCJqOY=;
        b=udP4svhPz/ej7JT03VcIQm0Oolt9M3f0SwvGbC0QPhLvMA84SVwGnz4eJ1taMw0nOZ
         mzoSnvdSWyt8VSfA2kTDyUUDqBdhrA2/2Ap+Tde1HBowiYGVD3mIPmW5n33W3pKMro3E
         Lgv3Ji5w7vW7BZzFM2vcJ95wFYOabRYW+xbmz7jZe/EEsp/wg3tRpT3Hk0Sp/kAYmKL7
         x9cpmh67ieBrHouvgNUkJqhYrJ4+l70IDDReV/1jA369K5SyYdezTkjz857NPHPFfh7x
         7mTRg1btmJH9EiuWiGbFr9AOIvKTCuyGhcDfYathrEzi/s5KbNGbe0VQNZQ/gEHnYBo7
         L/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313325; x=1704918125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd9S3ndoMFuJRzyZ8UnWtl2hKqIm/X+eOwgfHhCJqOY=;
        b=WoXTzRa8vGcTPr46DT+OWaFK4Na896VlSSgfCHyEB5OPmhEQ7DdlPy32tX+0P5Txvq
         2v658jTaIxuH0KQzU8lL0E7OEHNDfSEtxrE2DYL645NWSSMVa/o8Ir0GNkkDUvZ3nriK
         Q4XutFfKpsArd0sqplAo+B5LDb+RXGQS/AygXtQ2Zv7nsEfZHkaRy0i347HSZveDbdEJ
         ZotxcfHUIwE0jU8O/hFjWaLdoGZstTOef+mSrjOxC1wEuf87sTL9KCVWl1RlEnDBd3ht
         veqsc3lPRMUPIZfyGMjAhzG7o0mAY9vwpZDqYDy3vOdfhFi8bhTfIS14lqtpxIpAnTvY
         vwHg==
X-Gm-Message-State: AOJu0YxGFncjG1LaZPVpmnw0VnMf7bL1s97xfBjmK3ar+HzZ6sc8PYdT
	4NXrlYpRH3M1qZfuL5FfadZvbt3YW7GgDN2n42h9s64FGAqpU9Ovyac/hznQ737I
X-Google-Smtp-Source: AGHT+IFOVzuBneaCGuJA11SfW4fHr9glssJ2S8PuedynGsdeUjQ5Dgd4FzbqjNsayTFbPnukJAwKTkJkMj5ntONylnk=
X-Received: by 2002:a50:c34c:0:b0:553:62b4:5063 with SMTP id
 q12-20020a50c34c000000b0055362b45063mr245393edb.4.1704313324839; Wed, 03 Jan
 2024 12:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220083224.3712113-1-visitorckw@gmail.com>
 <CAP-5=fXwa-GSDJX3pO-LSz-D_X7qk2Ck1vtdddtV8ixzsO+5BA@mail.gmail.com> <ZZW+zcfFOa5YgK2j@visitorckw-System-Product-Name>
In-Reply-To: <ZZW+zcfFOa5YgK2j@visitorckw-System-Product-Name>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 12:21:51 -0800
Message-ID: <CAP-5=fWn2xeqKZ2LhSoZ6Pm5QR2VMLrR=9tPd-6CdEBCd92siA@mail.gmail.com>
Subject: Re: [PATCH 0/2] min_heap: Min heap optimizations
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:08=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> On Wed, Jan 03, 2024 at 09:56:29AM -0800, Ian Rogers wrote:
> > On Wed, Dec 20, 2023 at 12:32=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmai=
l.com> wrote:
> > >
> > > Hello,
> > >
> > > The purpose of this patch series is to enhance the existing min heap
> > > implementation. The optimization focuses on both the heap constructio=
n
> > > process and the number of comparisons made during the heapify
> > > operation.
> > >
> > > Kuan-Wei Chiu (2):
> > >   min_heap: Optimize number of calls to min_heapify()
> > >   min_heap: Optimize number of comparisons in min_heapify()
> >
> > Thanks Kuan-Wei,
> >
> > The patch series looks good to me. Given the extra conditions should
> > there be some updates to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/lib/test_min_heap.c
> > to ensure coverage?
> >
> Hi Ian,
>
> Thank you for your review.
>
> The current min_heap test is sufficient to cover all the code changes
> introduced by this patch series, even when only tested with a known
> set of values copied from the data.
>
> Additionally, I'm unsure if the commit message title prefix I used is
> correct. Perhaps I should use "lib:" instead of "min_heap:"?

Yes, "lib:" would be most consistent or "lib min_heap:". Could you
update this in a v2?

Thanks,
Ian

