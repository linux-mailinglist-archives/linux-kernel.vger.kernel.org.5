Return-Path: <linux-kernel+bounces-7738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2281AC74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A704228784B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7363C4;
	Thu, 21 Dec 2023 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH5PmCz8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE25239
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e587fb62fso461843e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703123917; x=1703728717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErAEEiT3RhrIXvHzreTCpHV5zkBsSIfKV0fdWMIpUMQ=;
        b=eH5PmCz8iqAiwTjyf2qpv7I3y8ymORvdSoT3hKOReu/FFsgKhRxSzyln9UbEQZwb4n
         vy5c1GpG1RbeHUE8O2EbW4RzDhnHEcnVy09tmtHio8Tr8tCOSNiZtYY4jJP8oHUPSEBl
         kKgGeMglEqvIQM0GV/h/NLMMoqlb6Hpd55DXn4G3yCBB74GdyZDmxk8S4ifOO5p1pRcP
         NJMbAE0Pn/R9BF/vfZNYyyCFLsxx0KpYi/vbDcXpZ9yCq/iC8mz7l08eWQn7phfPlX30
         6UFPPAVc7nNoJcdFwQp2teTX9QA844HBApaH1Ux5Oxrf8qQmpK8TYLgGBUfmE/hAmh+t
         9flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703123917; x=1703728717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErAEEiT3RhrIXvHzreTCpHV5zkBsSIfKV0fdWMIpUMQ=;
        b=feaHLrbwhUCgSTO5jGYw5sf77jQVPfsgRm16m1RzAlI6rjxIn2sbozaB1HQksoQvU3
         6kjCpeyvh80TDeKqHRgm9A7CNwdZBUBbtrF2AR9c29cLwhkUXuv9AVqyG3ZMEpgXMYcR
         EC1SCMr1dpy0V7PSmVHfdXe93clQil1CCQgJHY0w3xCAgpaolhi/WurxFM33sFeCSQsS
         5/H+Z7Zt/jtqyo7eI8trB9oiVbBjJcTsoaw1bz19ESBjUN772xJcqNBBZ3wY65Yk8K8D
         7+Kmecbz1FMVpIUV2cIuYAWF03rC62oOmIVXhTW1RsXZEik4HYr8Nqx7RTEs9qULPxfc
         GO6A==
X-Gm-Message-State: AOJu0YyVMzC5d1ZWRZPoxjgw2dAY1JFZ3vq96chhtQlngQOF8hf0kPg0
	3aZchWsWn7B0a4eJJ6R5jSkkbat/Jdvt2P1WVicZNuTv
X-Google-Smtp-Source: AGHT+IHMqhXwYu59CmMuePryKXW2xxWXRW1jObGnLa7i6A5j56gEB0lfNOSdq+FGpJILArPhBxoPpVVe9iHlFXhibHU=
X-Received: by 2002:a05:6512:3687:b0:50e:384c:6982 with SMTP id
 d7-20020a056512368700b0050e384c6982mr2896047lfs.42.1703123917349; Wed, 20 Dec
 2023 17:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com> <ZYL2rbD5UTz3s8gg@casper.infradead.org>
In-Reply-To: <ZYL2rbD5UTz3s8gg@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 21 Dec 2023 09:58:25 +0800
Message-ID: <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Inactive mapped folio will be promoted to active only when it is
> > scanned in shrink_inactive_list, while the vfs folio will do this
> > immidiatly when it is accessed. These will introduce two affections:
> >
> > 1. NR_ACTIVE_FILE is not accurate as expected.
> > 2. Low reclaiming efficiency caused by dummy nactive folio which should
> >    be kept as earlier as shrink_active_list.
> >
> > I would like to suggest mark the folio be accessed in minor fault to
> > solve this situation.
>
> This isn't going to be as effective as you imagine.  Almost all file
> faults are handled through filemap_map_pages().  So I must ask, what
> testing have you done with this patch?
>
> And while you're gathering data, what effect would this patch have on you=
r
> workloads?
Thanks for heads-up, I am out of date for readahead mechanism. My goal
is to have mapped file pages behave like other pages which could be
promoted immediately when they are accessed. I will update the patch
and provide benchmark data in new patch set.

>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 2e6b1daac6cd..8cecf82dcc5a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3418,6 +3418,7 @@ static struct folio *next_uptodate_folio(struct xa_=
state *xas,
>                 max_idx =3D DIV_ROUND_UP(i_size_read(mapping->host), PAGE=
_SIZE);
>                 if (xas->xa_index >=3D max_idx)
>                         goto unlock;
> +               folio_mark_accessed(folio);
>                 return folio;
>  unlock:
>                 folio_unlock(folio);
>

