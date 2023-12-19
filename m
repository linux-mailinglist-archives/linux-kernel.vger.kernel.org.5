Return-Path: <linux-kernel+bounces-6078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AE819450
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14FE1F238C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCE405C9;
	Tue, 19 Dec 2023 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hEGtwKv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7C3FE33
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a233bf14cafso400639366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703027099; x=1703631899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjlb2xD4zDGVWcimGI9Z7TsBUKL0jEGuKCpV9aRuFgI=;
        b=0hEGtwKvUlf/hwQB8xU2pOtr+BCiQE9cly6bqNT/r4tI5N5Ur+9gXZoMtGKQh+5H+/
         2CRW9lnfGxsCSVeZJ19z172xRjbMLs3bGUMxQxIGoSAIDKZYoCdNVMgDN07LFYAdnvP0
         h1ZfdFsuJoJ0+9v2IxTqIKVWPvcyHS1tDKk/vuELrzJ8w6PH5kGgI97beABkUK/M7fA7
         vEa+HpoinQY7Ar4Mk90RDbsB7s9A3uL1OSFYizNXyyx9SSN993ZYcT9WUpD2fG2TlF1z
         gXqLscZL7hIAaDADkdPMvk2AKeV10Gzq4kq+MNu4ZNxEjlfLvhu1+BYZ5oMAyMlxbdVh
         qkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703027099; x=1703631899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjlb2xD4zDGVWcimGI9Z7TsBUKL0jEGuKCpV9aRuFgI=;
        b=sUl8FOAY6Jz7G9Sq7H/I4wPqpXRXwMKHkMIILU2iZg/rKFz9C7oqzyVF5vlvQJDM+W
         kdQZ/QSKdouM90QfMsvnnc1r4/JyOAUkRaHetndO1b7vwa2JoDbul0/MV90lQU+HkVPf
         5GEUB5Y08NUB2vKL18y/QAnXG+VJxC/04eilq37cFo5ZDEVQq6tbbNi02Kldv+BmrPPD
         bVN0zuOpz46f9YSx5w33RMmr44C+u9BlzX/ZD2fFazcqaCpZXL9D/jl25XIOrooJ19+p
         4yPFRlv8vXWaci9DFbqQ6uFgLNGp5AtlTny8MDORwoogk7wUh6AT81oI8ieD1HngMbtK
         N+DQ==
X-Gm-Message-State: AOJu0Ywtj1y9zgGuYMaCxVnwwGhB+00TS2pbJylmLInKP4IwDp6M4OW9
	msmQQwL80rB8fH/FiPAJgtdzxStVjn9lX2TmxGdhdw==
X-Google-Smtp-Source: AGHT+IEOol19QAQyQLoFhmQKQrZwtShEcJHLRQqN99VwivYG2K+37PLO2dvI6gc85MP+BHjtlaYnTcNPqwUub20I5nc=
X-Received: by 2002:a17:907:6e8a:b0:a23:5dc7:7f16 with SMTP id
 sh10-20020a1709076e8a00b00a235dc77f16mr2637963ejc.89.1703027099172; Tue, 19
 Dec 2023 15:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com> <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com> <CAF8kJuPxCrJHE=7k0hBs7Caqhc=UvwyL0kh7Yk2e9Usboz1Vug@mail.gmail.com>
In-Reply-To: <CAF8kJuPxCrJHE=7k0hBs7Caqhc=UvwyL0kh7Yk2e9Usboz1Vug@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Dec 2023 15:04:21 -0800
Message-ID: <CAJD7tkaZDb_XwdCov1kpGbvY-VfR9_nMagOE_ajCs+bKxC8yQQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in load/store
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:49=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Yosry,
>
> On Tue, Dec 19, 2023 at 1:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > My main concern is that the struct name is specific for the crypto
> > acomp stuff, but that buffer and mutex are not.
> > How about we keep it in the struct, but refactor the struct as follows:
>
> If it is the naming of the struct you are not happy about. We can
> change the naming.
>
> >
> > struct zswap_ctx {
> >     struct {
> >         struct crypto_acomp *acomp;
> >         struct acomp_req *req;
> >         struct crypto_wait wait;
> >     }  acomp_ctx;
> >     u8 *dstmem;
> >     struct mutex *mutex;
> > };
>
> The compression and decompression requires the buffer and mutex. The
> mutex is not used other than compress and decompress, right?
> In my mind, they are fine staying in the struct. I am not sure adding
> an level acomp_ctx provides anything. It makes access structure
> members deeper.
>
> If you care about separating out the crypto acomp,  how about just
> remove acomp_ctx and make it an anonymous structure.
> struct zswap_comp_ctx {
>     struct /* cryto acomp context */ {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
>      };
>      u8 *dstmem;
>      struct mutex *mutex;
>  };

I prefer naming the internal struct, but I am fine with an anonymous
struct as well. I just think it's a semantically sound separation.

>
> Then we remove other per_cpu_load as well.
>
> I also think the original struct name is fine, we don't need to change
> the struct name.

The original struct name makes it seems like the data in the struct is
only used for the crypto acomp API, which is not the case.

