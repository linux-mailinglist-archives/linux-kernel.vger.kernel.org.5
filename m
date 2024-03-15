Return-Path: <linux-kernel+bounces-104298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232BF87CBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C6B283A05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65919BBA;
	Fri, 15 Mar 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO8sHujz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DBA18E02
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500605; cv=none; b=sKQSimoaxeV/t5awDVprjO2VDuOEWoOGUOjYIzBlzA9tihWCHDqOXwpdeoWMTyQq+sbpOVhoYLyrmOxV8sLnNWKLcPomzQPebUnVhUMhY2Q9ATmh7LuwSBAuZ0emL5Hkezq6xYwt4jcoUkGsmjkFXrpTh92z/QGAyuX33cQjcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500605; c=relaxed/simple;
	bh=HEdD5mQy1S8rbgfY9kpP0b3a/zUk/TZKPZgne1jO/bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2ETPqoO7YQGOnPxbP8Imxvw7xgsrLO/TSEYqvzDYuv3k83PpuFu+ualRWhcfo3boqYtzG/ihRw6RqEo1UbzQUcVfJIu7ONg36/UZI5fF8y6LNyu+zVrGVkW4yE0CEM83V44MNTl935n6fQ6QYR93JvhTAh3YPprGaLGFtT2/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO8sHujz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so2698165e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710500601; x=1711105401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWruk/k7WtclqkhSotMzYwMbwCi19ShEXbXynD4hB6E=;
        b=DO8sHujzsZk0tgejn72UKPn4DszGordAzWqN5xAiizMO9I7k/6XxIA8q6PomOxEVjo
         eoRxMkLe2+eZtxggDWEp9WbXTYGsT0DmPqxRL/jaTyPcNRTbnuz+Rp+c8pcY0/jBKYbU
         9BaqgGTeuc2MkDwjD/Fb95uls7BI3uDNF59Wf9jCNFyOd+E6TaugYmfQwMA9oNVZb0Id
         RRBPAfs61w6T81A0xE9AqRUCNZYqgdvfnNUpWVQHIZ1ADEgemfhze7bBgrmdsK73uOf4
         CVco1HGVyaUU0xe4VTnOqdC1bOyi6RZmw/taBy/R89OQ5MFQTBz/3rd/WjOfzIP0TOsD
         nqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710500601; x=1711105401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWruk/k7WtclqkhSotMzYwMbwCi19ShEXbXynD4hB6E=;
        b=lHniY9HmZB91QnxknUKRkcVG8uQKP6q3UN8lonosvGVC+AgtwjMufE65V1ZSwo4TrN
         nITIIA+gAuxoJPrjQf6BEnmDoSNhlhDyH/zijFCd6ETpcAh5OqvTI9ht+x0huVdFcfHV
         +zsZK0a4JgP+BiTNNe4HpUBhKf9ZMgMFlug/ysGO4K/PJIl1OQT1me2I5ZZvb8R/Liqp
         jPCLUDZmEiXdJf514pg5er9xVXLsCzuqo0cBjkEigtxIP8MvYMiZHQYG0NJYqseER3F4
         0ngsUXfHDWhKCtYZt6MBBAx/UKDKOzKbswCrIWQVY/TeHL9euzB1ZO58Xpm6k5EdPZmE
         EbHg==
X-Forwarded-Encrypted: i=1; AJvYcCVvGgAlLUvCAWK3JyKMWG3lv/molD49Oqkvmux7QpaqkrPVvRwjtkZwzNNMRhCZue2NYXlsJEwjuynbcpNEfh+Gor7ugjGKZUIxXz0Q
X-Gm-Message-State: AOJu0YyYIJ0qqM/G989jVrzgsCxDhlIni6tNZ8DLB2/6OvCVgXffroCv
	tQ9L+CapOjS7SzZFNQvnCOzQJYl54jw4ZCUQCDXxjfs773kPMVw2V++dy+yGIIRq7ZOzjll3YaP
	9w34L6AA3GtHiFNLSmzfO/SHReIR6Ay+lnvI=
X-Google-Smtp-Source: AGHT+IHnEmXKh/25GaGXOP390WghXc8EBxlur0/Likjim+XiC8g7iQwzJhZtpvdzi7LgEnJje8V5yegfJGJkexcDn/Q=
X-Received: by 2002:a19:3814:0:b0:513:c4b8:388e with SMTP id
 f20-20020a193814000000b00513c4b8388emr2151922lfa.56.1710500601039; Fri, 15
 Mar 2024 04:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 15 Mar 2024 19:03:09 +0800
Message-ID: <CAGWkznHFMb_wv+g8rDGNHM93NSFCkzpn6XcAw2fJ3LjgYyMt-A@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:39=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Panic[1] reported which is caused by lruvec->list break. Fix the race
> between folio_isolate_lru and release_pages.
>
> race condition:
> release_pages could meet a non-refered folio which escaped from being
> deleted from LRU but add to another list_head
>   #0 folio_isolate_lru          #1 release_pages
>   if (folio_test_clear_lru())
>                                    if (folio_put_testzero())
>                                    if (!folio_test_lru())
>                                     <failed to delete folio from LRU>
>     folio_get(folio)
>                                        list_add(&folio->lru,)
>     list_del(&folio->lru,)
>
> fix action 1:
> have folio_get prior to folio_test_clear_lru is not enough as there
> could be concurrent folio_put(filemap_remove_folios) to make
> release_pages pass refcnt check and failed in delete from LRU
>
>   #0 folio_isolate_lru          #1 release_pages
>   folio_get(folio)
>   if (folio_test_clear_lru())
>                                    if (folio_put_testzero())
>                                    if (!folio_test_lru())
>                                     <failed to delete folio from LRU>
>                                        list_add(&folio->lru,)
>     list_del(&folio->lru,)

correct the timing description of fix action 1, that is moving
folio_get prior to folio_test_clear_lru, which can't guarantee it
happens before folio_put_testzero of release_pages
   #0 folio_isolate_lru          #1 release_pages
BUG_ON(!folio_refcnt)
                                         if (folio_put_testzero())
   folio_get(folio)
   if (folio_test_clear_lru())
                                         if (!folio_test_lru())
                                          <failed to delete folio from LRU>
                                            list_add(&folio->lru,)
     list_del(&folio->lru,)

>
> fix action 2:
> folio_test_clear_lru should be considered as part of critical section of
> lruvec which require be within lruvec->lock.
>
>   #0 folio_isolate_lru          #1 release_pages
>   spin_lock(lruvec->lock)
>   folio_get(folio)
>   if (folio_test_clear_lru())
>     list_del(&folio->lru,)
>     <delete folio from LRU>
>   spin_unlock(lruvec->lock)        spin_lock(lruvec->lock)
>                                    if (folio_put_testzero())
>                                    if (!folio_test_lru())
>                                        list_add(&folio->lru,)
>
> [1]
> [   37.562326] pc : __list_del_entry_valid_or_report+0xec/0xf0
> [   37.562344] lr : __list_del_entry_valid_or_report+0xec/0xf0
> [   37.562351] sp : ffffffc085953990
> [   37.562355] x29: ffffffc0859539d0 x28: ffffffc082144000 x27: 000000000=
000000f
> [   37.562367] x26: 000000000000000d x25: 000000000000000d x24: 00000000f=
fffffff
> [   37.562377] x23: ffffffc085953a08 x22: ffffff8080389000 x21: ffffff808=
0389000
> [   37.562388] x20: fffffffe05c54180 x19: ffffffc085953b30 x18: ffffffc08=
5989098
> [   37.562399] x17: 20747562202c3838 x16: ffffffffffffffff x15: 000000000=
0000004
> [   37.562409] x14: ffffff8176980000 x13: 0000000000007fff x12: 000000000=
0000003
> [   37.562420] x11: 00000000ffff7fff x10: ffffffc0820f51c4 x9 : 53b71233d=
5d50e00
> [   37.562431] x8 : 53b71233d5d50e00 x7 : ffffffc081161ff0 x6 : 000000000=
0000000
> [   37.562441] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 000000000=
0000000
> [   37.562451] x2 : ffffff817f2c4178 x1 : ffffff817f2b71c8 x0 : 000000000=
000006d
> [   37.562461] Call trace:
> [   37.562465]  __list_del_entry_valid_or_report+0xec/0xf0
> [   37.562472]  release_pages+0x410/0x4c0
> [   37.562482]  __folio_batch_release+0x34/0x4c
> [   37.562490]  truncate_inode_pages_range+0x368/0x63c
> [   37.562497]  truncate_inode_pages+0x14/0x24
> [   37.562504]  blkdev_flush_mapping+0x60/0x120
> [   37.562513]  blkdev_put+0x114/0x298
> [   37.562520]  blkdev_release+0x28/0x40
> [   37.562526]  __fput+0xf8/0x2a8
> [   37.562533]  ____fput+0x10/0x20
> [   37.562539]  task_work_run+0xc4/0xec
> [   37.562546]  do_exit+0x32c/0xa3c
> [   37.562554]  do_group_exit+0x98/0x9c
> [   37.562561]  __arm64_sys_exit_group+0x18/0x1c
> [   37.562568]  invoke_syscall+0x58/0x114
> [   37.562575]  el0_svc_common+0xac/0xe0
> [   37.562582]  do_el0_svc+0x1c/0x28
> [   37.562588]  el0_svc+0x50/0xe4
> [   37.562593]  el0t_64_sync_handler+0x68/0xbc
> [   37.562599]  el0t_64_sync+0x1a8/0x1ac
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/swap.c   | 25 +++++++++++++++++--------
>  mm/vmscan.c | 25 +++++++++++++++++++------
>  2 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index cd8f0150ba3a..287cf7379927 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -968,6 +968,7 @@ void release_pages(release_pages_arg arg, int nr)
>
>         for (i =3D 0; i < nr; i++) {
>                 struct folio *folio;
> +               struct lruvec *prev_lruvec;
>
>                 /* Turn any of the argument types into a folio */
>                 folio =3D page_folio(encoded_page_ptr(encoded[i]));
> @@ -996,9 +997,24 @@ void release_pages(release_pages_arg arg, int nr)
>                                 free_zone_device_page(&folio->page);
>                         continue;
>                 }
> +               /*
> +                * lruvec->lock need to be prior to folio_put_testzero to
> +                * prevent race with folio_isolate_lru
> +                */
> +               prev_lruvec =3D lruvec;
> +               lruvec =3D folio_lruvec_relock_irqsave(folio, lruvec,
> +                               &flags);
> +
> +               if (prev_lruvec !=3D lruvec)
> +                       lock_batch =3D 0;
>
> -               if (!folio_put_testzero(folio))
> +               if (!folio_put_testzero(folio)) {
> +                       if (lruvec) {
> +                               unlock_page_lruvec_irqrestore(lruvec, fla=
gs);
> +                               lruvec =3D NULL;
> +                       }
>                         continue;
> +               }
>
>                 if (folio_test_large(folio)) {
>                         if (lruvec) {
> @@ -1010,13 +1026,6 @@ void release_pages(release_pages_arg arg, int nr)
>                 }
>
>                 if (folio_test_lru(folio)) {
> -                       struct lruvec *prev_lruvec =3D lruvec;
> -
> -                       lruvec =3D folio_lruvec_relock_irqsave(folio, lru=
vec,
> -                                                                       &=
flags);
> -                       if (prev_lruvec !=3D lruvec)
> -                               lock_batch =3D 0;
> -
>                         lruvec_del_folio(lruvec, folio);
>                         __folio_clear_lru_flags(folio);
>                 }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..13a4a716c67a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1721,18 +1721,31 @@ static unsigned long isolate_lru_folios(unsigned =
long nr_to_scan,
>  bool folio_isolate_lru(struct folio *folio)
>  {
>         bool ret =3D false;
> +       struct lruvec *lruvec;
>
>         VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
>
> -       if (folio_test_clear_lru(folio)) {
> -               struct lruvec *lruvec;
> +       /*
> +        * The folio_get needs to be prior to clear lru for list integrit=
y.
> +        * Otherwise:
> +        *   #0  folio_isolate_lru            #1 release_pages
> +        *   if (folio_test_clear_lru())
> +        *                                    if (folio_put_testzero())
> +        *                                    if (!folio_test_lru())
> +        *                                     <failed to del folio from =
LRU>
> +        *     folio_get(folio)
> +        *                                        list_add(&folio->lru,)
> +        *     list_del(&folio->lru,)
> +        */
> +       lruvec =3D folio_lruvec_lock_irq(folio);
> +       folio_get(folio);
>
> -               folio_get(folio);
> -               lruvec =3D folio_lruvec_lock_irq(folio);
> +       if (folio_test_clear_lru(folio)) {
>                 lruvec_del_folio(lruvec, folio);
> -               unlock_page_lruvec_irq(lruvec);
>                 ret =3D true;
> -       }
> +       } else
> +               folio_put(folio);
> +       unlock_page_lruvec_irq(lruvec);
>
>         return ret;
>  }
> --
> 2.25.1
>

