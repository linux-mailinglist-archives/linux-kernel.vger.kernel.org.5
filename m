Return-Path: <linux-kernel+bounces-20294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A452A827CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064F61F23478
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464F28FE;
	Tue,  9 Jan 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WEKrAot/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30B2573
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e835800adso2329664e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704768205; x=1705373005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwBZsH8BcPmrXBFsDiVkOfnprXScu6S5zpCjH/rm0pM=;
        b=WEKrAot/firiKLBXu7vEfmZM2aYjHF80nQReVoDU2Jp+rw8+2H2vSXG0rQAUQ6hbqu
         0CPVQ6G257nLx80wtM5dWe/Lqsfi+3M8Wy8D05lVDh0ALEcNMg58YAPsJNamx5ZtF6Yw
         gfVwQ/aya5XWsmW946gV39AMOcIniU6O8iSZnwnw7cS4OEj+Q2gw5O4G0itHiwTNuixj
         LRLwYxDQlw4g35acoTllI5eEcZ4rcziXD1x8x6PnTBiQQGZcucYqxivH9XepHglFhuIP
         q9+A5141SclMIor4JXKDo1bbzTYJXsCvPUUE3X2VmPvl+unTYoPE2tdPrlvL06p1XXFU
         9v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704768205; x=1705373005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwBZsH8BcPmrXBFsDiVkOfnprXScu6S5zpCjH/rm0pM=;
        b=R1d2xtCxqsXK8e5x19u3JUeON219yo8eYBlIquE+czDYCKxJABCb3qs+6UM87m8+vz
         SD54BiwAV0PCi0tNzjZxDGzZQQI9spxnEuAyqQF68M4jleNTa9tE78jC4S3MWhXBoyQ5
         QWa7BBu2Pz2yHVnwbudymWthZTVgyA/Gpe+FwLAoaFDwor043EtoBXN2s6yGu+VW9PjX
         jm/658gZzDBc/bH5rCpNtBMQdz6E0z1dsjdu2HOWa8RFVMO6evB2r9pA3zqq8d3VHrRS
         tAV1mwoekDiI48fk6gt1rlMSsQsTvCHGFqqWbFQuinyFv24Hs4EviOTmaZWNd6jOi4nu
         7xpg==
X-Gm-Message-State: AOJu0Yzq8GaYk6kksBy4ArZRbzyzeCls0z2gzrseQVzFr5sKlrrhXFWn
	vRPWInvwbudzxpQx3mRTUcIv4NiyQ9mWvbFE39islLN/KcYdVw==
X-Google-Smtp-Source: AGHT+IG4fOGnqM8Qe4o+balfTJDtscCuFqdajZ1EGzXvWvcho5ajCu5tNvih36fOvsTH/Hd48o8m3d1CvBA84Hy+Re8=
X-Received: by 2002:a05:6512:1086:b0:50e:811c:65b9 with SMTP id
 j6-20020a056512108600b0050e811c65b9mr1848810lfg.118.1704768205232; Mon, 08
 Jan 2024 18:43:25 -0800 (PST)
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
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com> <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
In-Reply-To: <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 9 Jan 2024 10:43:14 +0800
Message-ID: <CACSyD1NCa4HYmZuXy+8FE9ihoKo1kDfF4O5dMTH+iZeCugNLTA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Sun, Jan 7, 2024 at 1:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Fri, Jan 5, 2024 at 6:10=E2=80=AFAM Zhongkun He <hezhongkun.hzk@byte=
dance.com> wrote:
> > >
> > > > > There is another option here, which is not to move the page to th=
e
> > > > > tail of the inactive
> > > > > list after end_writeback and delete the following code in
> > > > > zswap_writeback_entry(),
> > > > > which did not work properly. But the pages will not be released f=
irst.
> > > > >
> > > > > /* move it to the tail of the inactive list after end_writeback *=
/
> > > > > SetPageReclaim(page);
> >
> >
> > Ok, so I took a look at the patch that originally introduced this
> > piece of logic:
> >
> > https://github.com/torvalds/linux/commit/b349acc76b7f65400b85abd09a5379=
ddd6fa5a97
> >
> > Looks like it's not for the sake of correctness, but only as a
> > best-effort optimization (reducing page scanning). If it doesn't bring
> > any benefit (i.e due to the newly allocated page still on the cpu
> > batch), then we can consider removing it. After all, if you're right
> > and it's not really doing anything here - why bother. Perhaps we can
> > replace this with some other mechanism to avoid it being scanned for
> > reclaim.
>
> For instance, we can grab the local lock, look for the folio in the
> add batch and take the folio off it, then add it to the rotate batch
> instead? Not sure if this is doable within folio_rotate_reclaimable(),
> or you'll have to manually perform this yourself (and remove the
> PG_reclaim flag set here so that folio_end_writeback() doesn't try to
> handle it).
>
> There is still some overhead with this, but at least we don't have to
> *drain everything* (which looks like what's lru_add_drain() ->
> lru_add_drain_cpu() is doing). The latter sounds expensive and
> unnecessary, whereas this is just one element addition and one element
> removal - and if IIUC the size of the per-cpu add batch is capped at
> 15, so lookup + removal (if possible) shouldn't be too expensive?
>
> Just throwing ideas out there :)

Thanks  for your  time=EF=BC=8CNhat.
I will try other ways to solve this problem.

>
> >
> > I would cc Weijie as well, as he is the original author of this.

