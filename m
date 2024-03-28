Return-Path: <linux-kernel+bounces-122576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543888F9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF050B24E31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407654775;
	Thu, 28 Mar 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5L+Qlh3"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DC2CCA0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613935; cv=none; b=fgXWZwsNa/YpUq5uE5hJKabc0FdsyWGl3RbSvrwTZaCEQ7u25RuzkZ5PbvqQAwXoJxdcuDYEwmdYb4hHLJWMiZQHws/CxaJ60yXGCVuWlisD3INkKYJ2iIGg0bki4AFCn2nW+8Qi3CkscQQZx7X1y2vXK2SWwkwLpp0jaUi7lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613935; c=relaxed/simple;
	bh=OaQMeQj7Glr/vG8OGAseA/3R5XZVpdnkIWZqYmlMC9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUm6y0Ae748eNZeo7aYQBWaETxrRr2jXenOrnc/kx4ZdZ2DwIsrY0WeGnqVvOfalijSq+w0jLiQ4rhKaMDW8Niav6CNNARs6vRKi56IV7NEwpOK0XRmcSF+NUD6xKeayhYEsCX55Dd12lGBji5IWzi8CwV0+zXhzB8auTq16K6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5L+Qlh3; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4765a8015bbso223657137.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711613932; x=1712218732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faWC1DJFvByP4iBBdzTYQkGTB8nR36Q4Xhop1j6+ZC8=;
        b=H5L+Qlh3LxQ4vF6YYHa6PkO130R4tyPw6u8/I7qU7VOfF4JQ1WFIGcp6lb1ndxt5YJ
         veyitOhJ+t+xiMp4MzBWAgIrob3jU9d4EVYqQrG3xzEwBwvErh+MpAMchsZHP9M1gZ85
         ofX0Wtdm0BzV82Ny0tAfEcIMzeelOd5r5bmYDB79GyrpQ7EUa2Pkz0Avo7Fcgo4Izy2+
         pLHENeJ/SyPfkHkRxEcNp/nbNZTLPuRa8Yg107z7Q5ZIGwksvMl4tRlqvWWJ0BKB9NGd
         vBhlapikCZSWQ2mIoFXeo1wCVzWczg45Tt4ckKJm5eYY8pYUCZaWqlc0YcP/JdiB8AKq
         LMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613932; x=1712218732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faWC1DJFvByP4iBBdzTYQkGTB8nR36Q4Xhop1j6+ZC8=;
        b=XTUfpUrhh3v/0Ejue0zs0NAFugKai/E/X+vy4XycaFoMyqm3Z78x4axpSV6KsgNRwY
         yp9Zcik1RtO/OYo1ZNWWmjpf6dfKrVDmqSCs+LSOzXNmfZbtoGA55noAJaIPzzuLb+To
         LO2Gjbe465us0iBaOohD9EchgBXPsc/mbeBBzOKtSukc59JGxd5BWdlguyIDJ2iZ8cVB
         7a3qkyZfa9pw1+aX0M0zLRDkziMevb20GonGBIBOA9usaeMJ7/k+Aa4f6Fmu7aLT1qy3
         3qg27Yo9DBWBqgJAFR6PF1pPGu/ARA7FT5HVLf/hGJ2EC1JDWkOMKILZf5Bm2pin0Dip
         xX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf5P1vAvl3dUKiz0EDZaL6eO3xYkJNxu1G2x6ObLP6p4nfWzwLKSsaBx867YyDYWpwJXkvNuv/PXn3C6r9PvlZsYlrYXp3bJORZHxl
X-Gm-Message-State: AOJu0Ywfx1YiFULgSp3HGmI83dLnt3otU0K6XckfU/rlDLXQCS4vJX/5
	MxHO4WDW1NgnHBbXH3Am4SWZ+OAQikYDYDStY51OKQ03SukIEka2jFWlRMylm15ffRWtXK7OSXD
	/xMgtElVQOYP0pZhyhNAH5sHacFY=
X-Google-Smtp-Source: AGHT+IEQ5qLrsDD4Z5wQ65B15tC3VvOxRqaGvahmHxAaehvbkeJzWNbDl1ZBeEPlkBEMgljJeH1nNVSbuxwzv0RFBRw=
X-Received: by 2002:a67:bd18:0:b0:474:d253:e22a with SMTP id
 y24-20020a67bd18000000b00474d253e22amr2453112vsq.17.1711613932351; Thu, 28
 Mar 2024 01:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com> <20240327144537.4165578-6-ryan.roberts@arm.com>
In-Reply-To: <20240327144537.4165578-6-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Mar 2024 21:18:41 +1300
Message-ID: <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Now that swap supports storing all mTHP sizes, avoid splitting large
> folios before swap-out. This benefits performance of the swap-out path
> by eliding split_folio_to_list(), which is expensive, and also sets us
> up for swapping in large folios in a future series.
>
> If the folio is partially mapped, we continue to split it since we want
> to avoid the extra IO overhead and storage of writing out pages
> uneccessarily.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/vmscan.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 00adaf1cb2c3..293120fe54f3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
>                                         if (!can_split_folio(folio, NULL)=
)
>                                                 goto activate_locked;
>                                         /*
> -                                        * Split folios without a PMD map=
 right
> -                                        * away. Chances are some or all =
of the
> -                                        * tail pages can be freed withou=
t IO.
> +                                        * Split partially mapped folios =
right
> +                                        * away. We can free the unmapped=
 pages
> +                                        * without IO.
>                                          */
> -                                       if (!folio_entire_mapcount(folio)=
 &&
> +                                       if (data_race(!list_empty(
> +                                               &folio->_deferred_list)) =
&&
>                                             split_folio_to_list(folio,
>                                                                 folio_lis=
t))
>                                                 goto activate_locked;

Hi Ryan,

Sorry for bringing up another minor issue at this late stage.

During the debugging of thp counter patch v2, I noticed the discrepancy bet=
ween
THP_SWPOUT_FALLBACK and THP_SWPOUT.

Should we make adjustments to the counter?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 293120fe54f3..d7856603f689 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1241,8 +1241,10 @@ static unsigned int shrink_folio_list(struct
list_head *folio_list,
                                                                folio_list)=
)
                                                goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-
count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
-                                       count_vm_event(THP_SWPOUT_FALLBACK)=
;
+                                       if (folio_test_pmd_mappable(folio))=
 {
+
count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
+
count_vm_event(THP_SWPOUT_FALLBACK);
+                                       }
 #endif
                                        if (!add_to_swap(folio))
                                                goto activate_locked_split;


Because THP_SWPOUT is only for pmd:

static inline void count_swpout_vm_event(struct folio *folio)
{
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
        if (unlikely(folio_test_pmd_mappable(folio))) {
                count_memcg_folio_events(folio, THP_SWPOUT, 1);
                count_vm_event(THP_SWPOUT);
        }
#endif
        count_vm_events(PSWPOUT, folio_nr_pages(folio));
}

I can provide per-order counters for this in my THP counter patch.

> --
> 2.25.1
>

Thanks
Barry

