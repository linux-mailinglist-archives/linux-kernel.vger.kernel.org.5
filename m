Return-Path: <linux-kernel+bounces-84774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45D86AB64
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26980B2570B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C70383A2;
	Wed, 28 Feb 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYTrXii3"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26521381D9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112860; cv=none; b=FjE2i+0HnQOzgSNucHi6t5U+gBgLAoTUF37gJk0rXIhaXhWNzK6Pdc3iNYXr42kI9x/tbWYSQQr4iO/ehrxg4VJuVy2Yv+tfEbda4h3PWuQoL6/xVHNcIGR8mc+XLtr3infkbTku6gJWF+RlktsgReos+01tETrvSIJGfR71S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112860; c=relaxed/simple;
	bh=GFVNR/zlWJslKz1dioQtSnYIsd3zA6B9GH6xfvmWywE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pex670m8kLn3+S4Ks/FDL28uhPzU8+bzgktcWj3Fgy7rSlPZF3jegZqN2q+/4ANDfX/jEWJ/vImWfGZlG3ltdK0NJQsUOTtOVWdWk366PO1ZWjJ6jFY+0rQtr5YXGysuuVfhK/6GSPps7+h9+fcFvCOKoSqhL36ptCNCrRjWgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYTrXii3; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7dad2d1c9edso527345241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709112858; x=1709717658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrofktxwInA3vcID9wwrk0HbtLWVMB1feXE92jqNChU=;
        b=BYTrXii3O+7No5bFL1pM+uqSoWav+cSJ7XsD0w1uHWISAjAhylO5L8sKI11aA4CbF3
         Gpjj6WfvAvPQ5aI+h2YpFzAV0/Ece6qo4rOyTroldtQNza3W6vErhSevlV7Ej1TTLX0M
         svZ/BAL7aCkn3ThYiZuBDPIFBk/ads67JM0j7Z1DWEL2g7Zh8JbAWkXd+8/5AvdeX5qk
         +WhCMYutC8To9WAHEZQS7Z1Y1+/YPPiQnNJDJWZky0CsRjXVdPpTAytLxuhJgXSKVHWZ
         FyQNgvyxrZeO5goMBtpjmChSvcyTclSdZr3s8ClE2K0MXYi6j6k5xWzBf3x5k5ibraPC
         DZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112858; x=1709717658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrofktxwInA3vcID9wwrk0HbtLWVMB1feXE92jqNChU=;
        b=e0eTh0vQ1NK2+YRl89pmod9JEc/qPxXCg4jHixYhfg+yXMe+PKfFXgQ1PdEQkJetn4
         Y/uFfa8wSwAx2jk0L52Jy3fLsO11ivo/rR2c3C88GXmjpGPfikz11qwFdr5prsQ73BPa
         k0uz/gJEzHl7kyYGl8ZAHjQyc8vdmjEeUh9pFgfPAjzXcXw4ym3XhnR6JaTyFVpl1cOc
         n2XBdJ/3VS7Uo7tRzfnTiTHLI7s2TOAsfw6ln86qfpQrAcDN34hYZD4Zmp08AmdKIIf7
         WsHCEQj9mc+UolLd+R4NbDho28EKSjDmuSgiCWRUdLOuMETaN74TbVlAgV6FsyhR+W6e
         8E/w==
X-Forwarded-Encrypted: i=1; AJvYcCUMoH6MFiqmgT3jeH/B89IlcN3BKRaDBzvdL0IpBSQEhP3/bTUwBRNdasPzVM6e+gc7puTX63zV2izcxFInO9k9+8+Aki9dW9cQNwrP
X-Gm-Message-State: AOJu0YwOccmVChymtzpBeoYdOPo5ATbO+mI034mCNodCVKK+6ekddvtE
	9o660L5DNozkwPEtT5wDoPHgA4qEkogxw7eGiv47MhyudisUVxObZ35Kq8jtTWLEAab9DPuFH8Z
	komi6txhllrX+jjD0jUDAHCXcrZ0=
X-Google-Smtp-Source: AGHT+IF0+UYaaN6m0QRKJndax7JXEHR+fygNk1XN64sj9tDZQvEktqzoxCNdUl67Oa9NtNbY9GdEofhoM8AuRFGfE3s=
X-Received: by 2002:a1f:cdc3:0:b0:4b8:383e:8266 with SMTP id
 d186-20020a1fcdc3000000b004b8383e8266mr8069276vkg.11.1709112858035; Wed, 28
 Feb 2024 01:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com>
In-Reply-To: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 22:34:06 +1300
Message-ID: <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
To: =?UTF-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>, 
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:51=E2=80=AFPM =E5=88=98=E6=B5=B7=E9=BE=99(LaoLiu)=
 <liuhailong@oppo.com> wrote:
>
> If vm_map_ram(page, 0, 0) would cause panic by vmap_pages_range_noflush, =
so
> change IS_ERR to IS_ERR_OR_NULL to fix this.
>
> Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..109732006cf7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2387,7 +2387,7 @@ void *vm_map_ram(struct page **pages, unsigned int
> count, int node)
>
>         if (likely(count <=3D VMAP_MAX_ALLOC)) {
>                 mem =3D vb_alloc(size, GFP_KERNEL);
> -               if (IS_ERR(mem))
> +               if (IS_ERR_OR_NULL(mem))

it seems the only case for vb_alloc to return NULL is size =3D 0, isn't
it a bug of
caller?

>                         return NULL;
>                 addr =3D (unsigned long)mem;
>         } else {
> --
> 2.34.1

Thanks
Barry

