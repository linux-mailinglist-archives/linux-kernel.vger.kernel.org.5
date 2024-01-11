Return-Path: <linux-kernel+bounces-23044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0582A69D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E42282314
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054D1FD2;
	Thu, 11 Jan 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dH2G3dS5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B4184D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso5241287e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704944952; x=1705549752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZREJaEipJctQbF5q1fL266eGmJzwCp7vTp7Y0bYWgKs=;
        b=dH2G3dS52IkSTvx6+jXZQe9O9ABj44KT8SfZtTBc2myEyUCcA3VWQ8xMtPnDk6jd+T
         9a0vupJ1+hkOjeHGfE4Q9MbmOyAAlHI5yqXT1AbdSn/h3BjC3EYKqX6gszeD5I50D9oV
         CRQpoHR3v6oZqJeYqeH88Gcxv+QmOJB52WDd71TGdeRKx2ULx40XuyUL0KPKzmejXJky
         68ay7IhKOLBNwSm4Gk+8BnPRjVnJqTniWQBhc78UPofLyg+ZMbD8Zwe/zXrX98Sl56Li
         pNied+vFuLPJoGDSUI9ZKZTFRfXIgkkO2QK7wILbNKfji1TsPBmKH+qDe8TzAOh0vIQF
         L1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704944952; x=1705549752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZREJaEipJctQbF5q1fL266eGmJzwCp7vTp7Y0bYWgKs=;
        b=SNZQQTouX24fsqTI7zXC2IYq9up7+lFyVmr2ebVmJuGT/99nmX+yPJNyWqu3gyB5W7
         ViziLdeR7PA66H5wijQmdnw4bR6qgAkISIQPofKv/UcUNNc7+EquqluyGEoF5cuJQU3Y
         AeJMDW9GwyHCImuDE6b5YIjTlaVK7e/8x/oZcOLvGp3aq9GNq1Lg619HVH0abDHWZtO7
         +S/FWKtewWvtaBM6njz/V0dHV9n9uPLwh5OmLmZxjMwQ7SwfXN2W7eKPapbe6rn0F+VD
         PH38CSowyOJ827vqnZ1LV+hMd9vozQBdkRx8PXOaR+jGkCRQRiw16x/J/BP2OBhEN40k
         Zzeg==
X-Gm-Message-State: AOJu0YyOItJSAEkGEBZOA57Hq/+wG9sLN7Gm1vGfKMgqAZ1oHowzFENd
	Ffe8feyc5VbZmWf+y/j1IyP5hy/jouksE6JpIHFzkWCo8m/u6zDIPBWuXJfsys3TPA==
X-Google-Smtp-Source: AGHT+IGF/3shiovL5bt+rCGdeEdmFeHXR7K8Bzf+732rRzXi7LpsYPdt13D1R5ynHAuFB3WFkd9IcNYYKQ+zbPVbC7I=
X-Received: by 2002:a05:6512:3041:b0:50e:9ba0:5e20 with SMTP id
 b1-20020a056512304100b0050e9ba05e20mr212864lfb.99.1704944952651; Wed, 10 Jan
 2024 19:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com> <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
In-Reply-To: <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 11 Jan 2024 11:48:59 +0800
Message-ID: <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> This sounds dangerous. This is going to introduce a rather large
> unexpected side effect - we're changing the readahead behavior in a
> seemingly small zswap optimization. In fact, I'd argue that if we do
> this, the readahead behavior change will be the "main effect", and the
> zswap-side change would be a "happy consequence". We should run a lot
> of benchmarking and document the change extensively if we pursue this
> route.
>

I agree with the unexpected side effect,  and here I need
to clarify the original intention of this patch.Please see the memory
offloading steps below.


memory      zswap(reclaim)          memory+swap (writeback)
1G                 0.5G                        1G(tmp memory) + 1G=EF=BC=88=
swap=EF=BC=89

If the decompressed memory cannot be released in time,
zswap's writeback has great side effects(mostly clod pages).
On the one hand, the memory space has not been reduced,
but has increased (from 0.5G->1G).
At the same time, it is not put the pages to the tail of the lru.
When the memory is insufficient, other pages will be squeezed out
and released early.
With this patch=EF=BC=8C we can put the tmp pages to the tail and reclaim i=
t
in time when the memory is insufficient or actively reclaimed.
So I think this patch makes sense and hope it can be fixed with a
suitable approaches.

>
> Unless some page flag/readahead expert can confirm that the first
> option is safe, my vote is on this option. I mean, it's fairly minimal
> codewise, no? Just a bunch of plumbing. We can also keep the other
> call sites intact if we just rename the old versions - something along
> the line of:
>
> __read_swap_cache_async_head(..., bool add_to_lru_head)
> {
> ...
> if (add_to_lru_head)
>   folio_add_lru(folio)
> else
>   folio_add_lru_tail(folio);
> }
>
> __read_swap_cache_async(...)
> {
>    return __read_swap_cache_async_tail(..., true);
> }
>
> A bit boilerplate? Sure. But this seems safer, and I doubt it's *that*
> much more work.
>

Yes=EF=BC=8C agree. I will try it again.

> > >
> > > I have the same idea and also find it intrusive. I think the first so=
lution
> > > is very good and I will try it. If it works, I will send the next ver=
sion.
> >
> > One way to avoid introducing folio_lru_add_tail() and blumping a
> > boolean from zswap is to have a per-task context (similar to
> > memalloc_nofs_save()), that makes folio_add_lru() automatically add
> > folios to the tail of the LRU. I am not sure if this is an acceptable
> > approach though in terms of per-task flags and such.
>
> This seems a bit hacky and obscure, but maybe it could work.

