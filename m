Return-Path: <linux-kernel+bounces-163542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093498B6CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FA31F23CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4131272D5;
	Tue, 30 Apr 2024 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3e+SwDFP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362917F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466058; cv=none; b=Rou0XA7dnQ3V4kjLHcMRWl7C5UhhnpSEUbUrh4QsoCNLgm08A7KyGpeegbDeaZpJcxz9JgjYnpdUBZYf/K4+PdjhVdMgxBsFlKRLoG56KBeRH/hkk4IQvROU7lVhs+4povQTL4XNOuU1dpVTtHltruJrC2/9p249tnlXyT4v2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466058; c=relaxed/simple;
	bh=xzoVJH1FpRrzRN0oXwjSzzG4835DVXEqL0lWmcwYJ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjPeSrb8L34aA94TmRgNOvhjX4gDIQNsUvdxyAuucuFtn7UM2HuVxAAGjIPlUpHLXXEv1X9Fr1blMiZSY8ZrhraKbi9MR+8rELmVKBIeRBwioRlpk/GJgRvQCVfjrArTsWKdpCfUJf8+hf8plA82pyphjcL3Z6sxcXX3m/bDy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3e+SwDFP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a556d22fa93so585359966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714466055; x=1715070855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Bw3WTLhwtlI5geCip/Ov6+YteZf+RUVzuWO9sZyQM=;
        b=3e+SwDFP3vSXETlgCsALhOXnP9sktvp4xXMdVQojJixx4Jd2nRk4B3ntVZRCG1lcj/
         XL2UZZyDBcGvq27esWSBF0S6LJ0CtBinMRxvTKxA6I6iL99crNLx6jb0IIaN+uXP9Xxe
         BaDXnp32NyI4xJ3qFf0Y+IIb41i7zTDynMuycpDK3/HQfMGY5RBmslvneowwXN7OL17s
         BVdH/KO0z6OgJy6zgobnh9UIxXInCN6uP911nsw6dRP+KjjxZ90/qsCh/3KOj+sZT+cl
         x2ImGC8rJufB1aLlB8zpDATH8Zd+XzcngpjQD4JIsif8YjHxhLQDqdBTJW9MyWxo1E2g
         0faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466055; x=1715070855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Bw3WTLhwtlI5geCip/Ov6+YteZf+RUVzuWO9sZyQM=;
        b=C8YxPz2id38k75XfU4uyop4LgzAUY7mdMZpvnmzQ8SGqlZPlyc4NVzBTuoObrvlJQD
         JUJHELfoyrCiBsl6ypFBt2zRptXLLc7MWd4kOLcXPSvoRsqv49ibHO0kc6svfBZL0Eyq
         MJDWrpw8W62v6Aa7qttrRE1gTkFCuUX8Msou4cK/q5ouS/mxKDpSrMd/zxpg9uNwyduQ
         e6ak6hUNu1Kka0H6WreaXlAlgBArx+tFot2XuHaK+zrlAXgah6ztqfubCGTa8/n+EJEm
         LJ9ygFu4Ryr2eNL44ndHjhV6i9mbdy/4neX4qwcAWd/AeT4yumF9RgWHFfrFmw7X9Ez9
         tAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlpkSV0/Z/HY6vTPwVfVFE9FFIxqbTS+TsFc+Z/d1zS1vXccIyfNsYQi4gF67x4SpAQrIwysH6lJEPWaRGmYzAk9YGTbpPJaH1tnoG
X-Gm-Message-State: AOJu0YzwA2SKay/aV5do+NoatGZs1NMPuJbVfZAZmglHlbzn404sF8px
	d6L1VT+ENPf6CyoSvHyCyOHGnLTXr/FOA8RxrNXMC9V4BDs+IKDO6pVuuCPZ/fQkpa3YJShRsQy
	MbuBUYp0YfC8EgLTUQCdj5SnBEnFzqDEG1VoP
X-Google-Smtp-Source: AGHT+IGAxVVIvvhqlm9vE9iS3fPdPoQOYaPlzqepEmPc8+xUV7771I2xf8JSwUkJ3VO7dv85sBec9NEA4tsy96VB3BI=
X-Received: by 2002:a17:906:3e53:b0:a58:a721:3a61 with SMTP id
 t19-20020a1709063e5300b00a58a7213a61mr1393176eji.3.1714466054919; Tue, 30 Apr
 2024 01:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-2-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-2-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Apr 2024 01:33:38 -0700
Message-ID: <CAJD7tkYZZZ2raUyJKkLWVYvwb0G7Zi5Xz1t=BT7ih9wpyrThbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] memcg: reduce memory size of mem_cgroup_events_index
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> mem_cgroup_events_index is a translation table to get the right index of
> the memcg relevant entry for the general vm_event_item. At the moment,
> it is defined as integer array. However on a typical system the max
> entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
> use int as storage type of the array. For now just use int8_t as type
> and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
> touches 127.
>
> Another benefit of this change is that the translation table fits in 2
> cachelines while previously it would require 8 cachelines (assuming 64
> bytes cachesline).
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
> Changes since v2:
> - Used S8_MAX instead of 127
> - Update commit message based on Yosry's feedback.
>
>  mm/memcontrol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 602ad5faad4d..c146187cda9c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -607,11 +607,13 @@ static const unsigned int memcg_vm_event_stat[] =3D=
 {
>  };
>
>  #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
> -static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
> +static int8_t mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
>
>  static void init_memcg_events(void)
>  {
> -       int i;
> +       int8_t i;
> +
> +       BUILD_BUG_ON(NR_VM_EVENT_ITEMS >=3D S8_MAX);
>
>         for (i =3D 0; i < NR_MEMCG_EVENTS; ++i)
>                 mem_cgroup_events_index[memcg_vm_event_stat[i]] =3D i + 1=
;
> --
> 2.43.0
>

