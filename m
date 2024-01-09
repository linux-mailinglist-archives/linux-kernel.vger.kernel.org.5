Return-Path: <linux-kernel+bounces-20319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD8827D45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A432851D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9128FD;
	Tue,  9 Jan 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VDXuyi00"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62C6D6CA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so3032812e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704770033; x=1705374833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaxHGV8oPAH0cXVpb6PujQFrg8LWhnuJG71qH//BYT8=;
        b=VDXuyi00FitORXJHbx1IooldKuUw1deuCnDnHJx0NlwzhGLwJrd1U14Be5grm1EfBh
         vmH0LL9j90S+kPm82XBvvqUY7joT3XDMVYDds8v2btD+0aqEDFI8vnMxo912CLVh/0Yc
         +fqNRK5rkFx8VkpCXqG4169vFTOoESASk249zzmSlHU6yoaCMpk7k5RDvhP5SV1ENP+a
         mexpWAqUI15xqe+ZUmlSzPl4/ZzpwVleMOWolovKFkLGWbM2RuDYdhD2TfVXhciBbTqp
         E49JP641kvMEEr1MwLLiD6S5ZkygBJsaooxpEhg+yeUwq+SD6afik7r2hpGMm7L/sOCG
         CuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704770033; x=1705374833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaxHGV8oPAH0cXVpb6PujQFrg8LWhnuJG71qH//BYT8=;
        b=FaB6NdiV55UWiyDghMfh6BXztuCAEWeNiurN8QtiY5MbPIJSJWNi5OYzBWsaLpq2mv
         NJS1R/dzT2zdjoGdBn0pd6kDO9nRvRHkJu9aS9N9wWb9wpumFRC6R0i/Os3otUlgMmm/
         nwx3dNLBAN9j5Tg9z7fgvZUz40Musb0u/qjkcjCcxasVE8TRfC046ZHFCfxJPd+Nnyo3
         F/T4jRdDQ0EzkpYJ4rW9j2gQMz/kq1cdUuJGIrpTavlk6wh95avppUFW2sWZ7wjBFMl3
         qxta6NRpnT1fG9eQCPPbNTvP4Xq44DipjvU4m2zh3FxRv/mVBBKuMRAoL6n8tG/7KxHC
         1DcQ==
X-Gm-Message-State: AOJu0YwzTaE8T4FDLEQd3Sr6q33CmCWxWotYhUL5vrYu/mjQBSqj1W1e
	xuqom8Mc/q49Q3bzl0MIDdk/L/LDeDaTYcL5/pmh2zvHk/Vh2w==
X-Google-Smtp-Source: AGHT+IE5xOFffq0BDtu3fPMSYTDgcpJAYIMsmG6qgY5nuh+v8UmE63lThALATxhAsro1qO7FkGODkyrfADcY7QxpVHw=
X-Received: by 2002:a05:6512:48c:b0:50e:699b:55f with SMTP id
 v12-20020a056512048c00b0050e699b055fmr1890054lfq.66.1704770033291; Mon, 08
 Jan 2024 19:13:53 -0800 (PST)
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
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com> <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
In-Reply-To: <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 9 Jan 2024 11:13:40 +0800
Message-ID: <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry, glad to hear from you and happy new year!

> Sorry for being late to the party. It seems to me that all of this
> hassle can be avoided if lru_add_fn() did the right thing in this case
> and added the folio to the tail of the lru directly. I am no expert in
> how the page flags work here, but it seems like we can do something
> like this in lru_add_fn():
>
> if (folio_test_reclaim(folio))
>     lruvec_add_folio_tail(lruvec, folio);
> else
>     lruvec_add_folio(lruvec, folio);
>
> I think the main problem with this is that PG_reclaim is an alias to
> PG_readahead, so readahead pages will also go to the tail of the lru,
> which is probably not good.

Agree with you=EF=BC=8C I will try it.

>
> A more intrusive alternative is to introduce a folio_lru_add_tail()
> variant that always adds pages to the tail, and optionally call that
> from __read_swap_cache_async() instead of folio_lru_add() based on a
> new boolean argument. The zswap code can set that boolean argument
> during writeback to make sure newly allocated folios are always added
> to the tail of the lru.

I have the same idea and also find it intrusive. I think the first solution
is very good and I will try it. If it works, I will send the next version.

 Thank you very much.

