Return-Path: <linux-kernel+bounces-139764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCA8A076E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51731F22EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6E13C687;
	Thu, 11 Apr 2024 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkEcYWpb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EB13C3ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811697; cv=none; b=sD3Z4rnpYTHo8XJbGDUG25cXeN/fkXCtLdKfrx33ead6vf5SpgpPY9xDl/MVPP9xv+K6FeJGHHjYMX8rScNCkTlTDE6Nt6uZ7xLALJqL2LgLMaRgQRHZm6KYddFtZlxiwyKpL3vYpm0IRRyqprWOqnOCvszog9w0IWNKWBzubq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811697; c=relaxed/simple;
	bh=ILE495P8oj2gzrzyALbLGzTN9NPgyElLRE4whcOeNOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8pGjHCg97+uItQ1xPVNuo6o+klwtuV43E6/WGHSy5QxAtaa1+oNxnpHtOeoL6nx+DTNUnWlIL525yIlO71738EMJ0k++d5herRB1MEd+8ER0Xtmb72lYtpgZjz6fmBeqcmMt6tip35BH3amcsEAagMqBg4uoAfJS633WyZBk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkEcYWpb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so5570714a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712811694; x=1713416494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zPyMdwgo+w+yECqX3qxlIk+FaH/Kv/rlRwtfxjp+4=;
        b=jkEcYWpbNGBopjA+9ariiuoCAmgqwbXVsYsFM0iG/V4uqUGsg3MuyV3HpUm8vv+691
         MQjNtZKMb/HRkfokjp/GBmZQnYwoOW6M1yOtE0UbefcmfB/S6oam9sXrpikXf1cyufeD
         OlfJaGueS1tqaljsgwvgkrd4feZN3IZLGV6XLrG1l/wQv49KZI9Uru/Yow6tqxRecnuH
         I9wHobGyyf9ZwW9kxv7CdPoY+302kk2GM7OcQwhs9ZQaRVlp4/2fm9Qp1svJmL7lt6kt
         G9gbhTAmEaK9B1VMofkXxIF47sk+ChdSZCZ3p2H3veZ9zQnLxV07OfJw5QICaw+zRdm7
         6/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712811694; x=1713416494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5zPyMdwgo+w+yECqX3qxlIk+FaH/Kv/rlRwtfxjp+4=;
        b=Oi314wx7T2TEVHf6TXGJdGlEAzs9OJ/hj8mBKWFoI1N6L4kK1L3CrEBIqAKpqgEEtM
         6tt2MkRJHA5CAxH7V4mxs2TmtvKztPWufOLn3aqpzhgtLa2fDYq0PYy0eCL+2pMsXlpk
         cl2fSZ3LKbzPzfSQuXUEcZzmwGdg0pZ2LnK1t3AIEbI4OI9rKzWR34RWwoutKChBPahf
         OhuNrBme7vDWFOm+XNLz0QbVpjFq8zxFOr7NvBs8DrSDo+e2didOe0yo8/ZytVMq6AlF
         BDpLvwU5GbUlnZfY4bs/dPlUICKuo446GP/W0G9ylrgsqAau+07hzPI/+QFg44M8KheX
         BFsA==
X-Forwarded-Encrypted: i=1; AJvYcCV18AbtTGk1b3s1XkgG+/dqt8I//O0Whj4cjErG/jkkUAWbzj/GYE8cXr369063aoLzYG6U0J3gxjjJtgWpu/3qRkqV/MXzWDE5fdEn
X-Gm-Message-State: AOJu0YzL0tnQXvrfpf/4hqQwerq5VeQnNNLRP55ReBpOzQNvBGBcYXaq
	A76/otf7lFT/IRpmDVha4B0zGybYPSEwmP5+2TEMGCoUMThfKfl06eqYxRLggWmVd/YfwmNNR70
	43IxzQdYWrGB8mr+RJRUEaOMXlSc=
X-Google-Smtp-Source: AGHT+IH8mM3PhWf6bzKNeaYLnokUe4aOJ7koL6q+Vp/F62299NTENTD3A6OoFV7kJcs5NAC5cWgh38xqL8gEdRiEApU=
X-Received: by 2002:a50:9e0f:0:b0:56d:f47c:5308 with SMTP id
 z15-20020a509e0f000000b0056df47c5308mr2416750ede.34.1712811693708; Wed, 10
 Apr 2024 22:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240410145033.5cdb8a41f3a6894a62191f42@linux-foundation.org>
In-Reply-To: <20240410145033.5cdb8a41f3a6894a62191f42@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 11 Apr 2024 13:01:22 +0800
Message-ID: <CAK1f24nfN_cfdKn_q391NAug-dvWsX-LW9NzxcTaRm95Px3Kqw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:50=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon,  8 Apr 2024 12:24:35 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > Hi All,
> >
> > This patchset adds support for lazyfreeing multi-size THP (mTHP) withou=
t
> > needing to first split the large folio via split_folio(). However, we
> > still need to split a large folio that is not fully mapped within the
> > target range.
> >
> > If a large folio is locked or shared, or if we fail to split it, we jus=
t
> > leave it in place and advance to the next PTE in the range. But note th=
at
> > the behavior is changed; previously, any failure of this sort would cau=
se
> > the entire operation to give up. As large folios become more common,
> > sticking to the old way could result in wasted opportunities.
> >
> > Performance Testing
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios =
of
> > the same size results in the following runtimes for madvise(MADV_FREE)
> > in seconds (shorter is better):
> >
> > Folio Size |   Old    |   New    | Change
> > ------------------------------------------
> >       4KiB | 0.590251 | 0.590259 |    0%
> >      16KiB | 2.990447 | 0.185655 |  -94%
> >      32KiB | 2.547831 | 0.104870 |  -95%
> >      64KiB | 2.457796 | 0.052812 |  -97%
> >     128KiB | 2.281034 | 0.032777 |  -99%
> >     256KiB | 2.230387 | 0.017496 |  -99%
> >     512KiB | 2.189106 | 0.010781 |  -99%
> >    1024KiB | 2.183949 | 0.007753 |  -99%
> >    2048KiB | 0.002799 | 0.002804 |    0%
>
> That looks nice but punting work to another thread can slightly
> increase overall system load and can mess up utilization accounting by
> attributing work to threads which didn't initiate that work.
>
> And there's a corner-case risk where the thread running madvise() has
> realtime policy (SCHED_RR/SCHED_FIFO) on a single-CPU system,
> preventing any other threads from executing, resulting in indefinitely
> deferred freeing resulting in memory squeezes or even OOM conditions.
>
> It would be good if the changelog(s) were to show some consideration of
> such matters and some demonstration that the benefits exceed the risks
> and costs.
>

Hey Andrew,

Thanks for bringing up these concerns!

I completely agree that we need to consider such masters and include
them into the changelog(s). Additionally, I'll do my best to show that the
benefits exceed the risks and costs, and then update the changelog(s)
accordingly.

Thanks again for your time!
Lance

