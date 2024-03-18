Return-Path: <linux-kernel+bounces-106795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5EE87F3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94A1B215BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A295D483;
	Mon, 18 Mar 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvqVWd7f"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AB5CDF7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803546; cv=none; b=bIXkp2XbxKRrXo67Jdux33S5YtQFv/lmXmUrbsv8ItGXzkI5SBSQDlTrA5RLInef9+JTm6FDlD7t6nQ+NE6a43mfBHDTRDAqmIxxraPZz0hakDxPaWeRN0LZkMzIc1FwqKptNbO1wpFsgH8dkljDkLTAfSrKYlc4Jd8myLFlP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803546; c=relaxed/simple;
	bh=NG8z/DxOrpQGQkKs2gp5YXEcjaCTSb7v4M1rxRAteGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHsMjQ8b7CWdn25MUV8HSEoJuGdcvbTqNR/hbFWFZQrIvWttAMWvIHlB6CY6iRLQA89zptvf/d1z2XLr8pYcqsGEkF9pwF+JSl9Fftug1J57xZgS5zLbhguklVbCUWaUZ5ZSvjw7/jRMbRbFE8gChK1SM9pJLXJ8Lh+7TRp2KVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvqVWd7f; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7de17974a6fso2007973241.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710803544; x=1711408344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co75mbG3pWST74knvXilbjAm8wLeoltnx/M2lNlSSf8=;
        b=hvqVWd7f8lptmL3WuOi4ailbVzSukL8Gp1fetAYIFBBXYydefL2dz+2cvcHAcNValH
         FBFxcLA7YG8avdbFsFG9U4l5l7DeRXj17cLao3eX779sC18+deSxo3xOv96cAMbWpghS
         7MUqNn6+b5aOUThM+9Bw+Zm7jyc8wqVUqaKPNsk9HodsWylUZEPa1daM2dostVQnNnDH
         ueIuRdKc1SLz8A3YFZjlGvGN0Oi+Cc44pb6V/dyWBHAtgI1vpxjDEKKPOZfCNE6N3aNl
         0nQ+6E67Ubqw2lAnx2Ud06Q7IOtAHQXtAvCV5Zm6lK1qbLljKdDDHDjt+4ttuVZ779gt
         0IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803544; x=1711408344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=co75mbG3pWST74knvXilbjAm8wLeoltnx/M2lNlSSf8=;
        b=p/dfQZX5nKvuA6GwquQGhiSAyGCiq2EvNOhl/+HzZrpbHFCVWqsS93qGmMXkXlHRoy
         T+dYzfpRyOTgmq93vp1HPHuM1LGe9Yptqh/MlPXboRa7MbN657A264BJwtCDY7L7DUyM
         +h1JsqiNBgV6/ZH94r2hD6jA7UrIoledB0WxdI2rU4dBx6u11T5zH8igy7+ewh2LYy1v
         oGsi62HWLZqa+UeAQL/rev2aj1K4bp0Cxzsd/RILPV1R7ScIDXyNhSXAVTTBT0FNjWmO
         ev5oEr3KsTA7Ih7J58MefNTlYgBkAc8OWWETydUfppbvfx1TVOb3o1iloH2gpBfbjXLG
         5zlg==
X-Forwarded-Encrypted: i=1; AJvYcCWk/Tmo0NSrmZYiczByY/ku/RpgUBplfMSHVGvDTBpf2Z6ojljvH0kvhxTlSF8PuRHTH8UZ5NuOtDk/8ZgGBX9m+AgFrai5H7orkJ+s
X-Gm-Message-State: AOJu0YxGIPltCweWoyxeMz4uKKUc+5LeBTjHTUyKrdjs+Wa3LDmrPkhd
	22IKKbzbZAGtXbrmq+v9TmD3D/zlyB5DkqPjp7JmRme6tXqR+Yonmq0yXnvuG0SfjldbuIOvaaq
	AX03NPc/YWI6xb11xyd0wzrisC3Y=
X-Google-Smtp-Source: AGHT+IH9we0pIW9qQXR/OE/uny3WFqaQqRISrT5OAHOcUKmginDEs3dKSSY65MbfvwYIExrLFoT8L8FtRC49QFDh2ZQ=
X-Received: by 2002:a05:6122:20a2:b0:4d3:36b9:2c26 with SMTP id
 i34-20020a05612220a200b004d336b92c26mr12222400vkd.14.1710803543933; Mon, 18
 Mar 2024 16:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318230013.87543-1-21cnbao@gmail.com> <CAJD7tkYVJHsWoaEkTiTigJRzSNBrRSg3YVAL3Q5Q96cLSNJZrQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYVJHsWoaEkTiTigJRzSNBrRSg3YVAL3Q5Q96cLSNJZrQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 12:12:12 +1300
Message-ID: <CAGsJ_4wqPuZc47h=QRPForrxinhG3cvoh4VupLyDRo_uhneC-g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix kernel BUG in sg_init_one
To: Yosry Ahmed <yosryahmed@google.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	chrisl@kernel.org, v-songbaohua@oppo.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ira.weiny@intel.com, 
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 4:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > sg_init_one() relies on linearly mapped low memory for the safe
> > utilization of virt_to_page(). Consequently, we have two choices:
> > either employ kmap_to_page() alongside sg_set_page(), or resort to
> > copying high memory contents to a temporary buffer residing in low
> > memory. However, considering the introduction of the WARN_ON_ONCE
> > in commit ef6e06b2ef870 ("highmem: fix kmap_to_page() for
> > kmap_local_page() addresses"), which specifically addresses high
> > memory concerns, it appears that memcpy remains the sole viable
> > option.
> >
> > Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google=
com/
> > Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleep=
able")
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/zswap.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 9dec853647c8..17bf6d87b274 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1080,7 +1080,8 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct page *page)
> >         mutex_lock(&acomp_ctx->mutex);
> >
> >         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > -       if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) =
{
> > +       if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool))=
 ||
> > +           !virt_addr_valid(src)) {
>
>
> Would it be better to explicitly check is_kmap_addr() here? I am
> particularly worried about hiding a bug where the returned address
> from zpool_map_handle() is not a kmap address, but also not a valid
> linear mapping address.
>
> If we use is_kmap_addr() here, then the virt_addr_valid() check in
> sg_init_one() will catch any non-kmap non-linear mapping addresses.
> WDYT? Am I being paranoid? :)

we have a possibility that a userspace buffer or vmalloc address is given t=
o
sg_init_one, then it is non-kmap non-linear. but is it possible someday som=
e
people return a vmalloc/vmap address from zpool_map_handle() in the future?
then we still need !virt_addr_valid().

>
> Also, I think a comment would be nice to explain the cases where we
> need to use a temporary buffer since we have two different cases now.

that makes sense.

>
> >
> >                 memcpy(acomp_ctx->buffer, src, entry->length);
> >                 src =3D acomp_ctx->buffer;
> >                 zpool_unmap_handle(zpool, entry->handle);
> > @@ -1094,7 +1095,7 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct page *page)
> >         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> >         mutex_unlock(&acomp_ctx->mutex);
> >
> > -       if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
> > +       if (src !=3D acomp_ctx->buffer)
> >                 zpool_unmap_handle(zpool, entry->handle);
> >  }
> >
> > --
> > 2.34.1
> >

