Return-Path: <linux-kernel+bounces-5980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF871819271
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46EB1C22073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBE3D0BC;
	Tue, 19 Dec 2023 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4MVHs9J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2393D0C5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33660cf2296so4090232f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703021994; x=1703626794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqnUL3STGI/mTYPrGHX2qTH/VZgVQ1K394F/fVIBFiQ=;
        b=J4MVHs9JKaoJO8AiodnuHabZObtFwf4Frn2eV+zgp6zXYTaDWJJg9vC1gATlLFs6Jc
         rCgEQZ+85iqUtHcpVrWqu+tSKx37U3+rOufrkwDT/86ryr8hrsOe1/52mbr8PnkEYUv1
         oVNrmqx+yFP6QWI2VBGaRoM2818/jIZB9VwfAcHAJ4UsAq7v/G50zw23QvAwaLhQpFt3
         U1PtKMYQBQEQGIVQXlJeO+tUhVNJUl+5FhsXc8C5vF4fxZOVm0snUg2b7IEaHFEn6t8d
         /A8yoYAJTP6/0XRmTJXlE4ia5hGKPpkFccLjx8+39j+w2ZTyZfOKJ04/gC78e6DNUERJ
         gxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703021994; x=1703626794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqnUL3STGI/mTYPrGHX2qTH/VZgVQ1K394F/fVIBFiQ=;
        b=qdHI2hum8krc3DcjJlISF54clFfBHAJ10f02MNwJ7Kf2dga3lyjmtt8VhOCi28eZ4f
         ymwbreUY2vYvQBimvfVEyvwUpmsHM8XVCm/Vplg6uXgMGFOPGDxbslQJy+sMFCBBxT+5
         gaNqcBOF4V1Q9+CLznyR3GNd9kiT5ZTsNogzWSZmd7McM/5QEsgXDekiUhE8i7eezg/i
         ZdgkJ8ahwHSKb6HjE+5FpKByGD44eGI7KB4B/6YQUI91ZMWZGm0G0vIKdUBS7sDtQ5LG
         jdLAZ/6w4lTIIfVnKQ3sWvCpAtvU0ayUuimM8q9yMSsxEh4leFV+omIrkUWg3YTtl/r/
         ot+w==
X-Gm-Message-State: AOJu0Yzb6dEJmk56mdnmTvmEfAJrXZjL+RVg/6r3d9n13ef38rQn+me9
	A0BhRrL1UQ+FTMjOmeb6j0so2PGkGDZSGbG0MQwh1Q==
X-Google-Smtp-Source: AGHT+IHDjOPMB0Rw4CsegtN+gghw2G+4WfN33bekHI42mt3gv0tuLFeWAGQoVBxh0Y/JHausWNTzYfD+Oecrm6SQwms=
X-Received: by 2002:a5d:6586:0:b0:336:788b:335c with SMTP id
 q6-20020a5d6586000000b00336788b335cmr196486wru.106.1703021993678; Tue, 19 Dec
 2023 13:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
In-Reply-To: <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Dec 2023 13:39:15 -0800
Message-ID: <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:43=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Dec 19, 2023 at 5:29=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Chengming and Yosry,
> >
> > On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> > >
> > > Since the introduce of reusing the dstmem in the load path, it seems
> > > confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mute=
x
> > > now for purposes other than what the naming suggests.
> > >
> > > Yosry suggested removing these two fields from acomp_ctx, and directl=
y
> > > using zswap_dstmem and zswap_mutex in both the load and store paths,
> > > rename them, and add proper comments above their definitions that the=
y
> > > are for generic percpu buffering on the load and store paths.
> > >
> > > So this patch remove dstmem and mutex from acomp_ctx, and rename the
> > > zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
> > > the load and store paths.
> >
> > Sorry joining this discussion late.
> >
> > I get the rename of "dstmem" to "buffer". Because the buffer is used
> > for both load and store as well. What I don't get is that, why do we
> > move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
> > buffer, mutex and acomp_ctx. I think we should do the reverse, fold
> > this three per cpu entry into one struct the acomp_ctx. Each per_cpu
> > load() has a sequence of dance around the cpu id and disable preempt
> > etc, while each of the struct member load is just a plan memory load.
> > It seems to me it would be more optimal to combine this three per cpu
> > entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.
>
> I agree with Chris. From a practicality POV, what Chris says here
> makes sense. From a semantic POV, this buffer is only used in
> (de)compression contexts - be it in store, load, or writeback - so it
> belonging to the orignal struct still makes sense to me. Why separate
> it out, without any benefits. Just rename the old field buffer or
> zswap_buffer and call it a day? It will be a smaller patch too!
>

My main concern is that the struct name is specific for the crypto
acomp stuff, but that buffer and mutex are not.
How about we keep it in the struct, but refactor the struct as follows:

struct zswap_ctx {
    struct {
        struct crypto_acomp *acomp;
        struct acomp_req *req;
        struct crypto_wait wait;
    }  acomp_ctx;
    u8 *dstmem;
    struct mutex *mutex;
};

, and then rename zswap_pool.acomp_ctx to zswap_pool.ctx?

