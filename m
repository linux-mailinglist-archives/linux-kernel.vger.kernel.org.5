Return-Path: <linux-kernel+bounces-99648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36296878B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76112821A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17858AB9;
	Mon, 11 Mar 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8JmCkra"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A94AECF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198878; cv=none; b=dxiY0OouhLNkZu6eZYVEPELxjSeXdpb+jnxQWnF+WfJyHg2DIxmD3Wv6VjH3p2NuGlsJDusqq/Sn4DijdsF+nEEjKZRb1ct76eW0e6tEI0Df4yh2oylwVm5zUmu3lnF2djTElbF6DGxTnxIDBv2dt0qbjus1TX8br1Gj25gGcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198878; c=relaxed/simple;
	bh=LpUR8UCpmEUadNSsxiGuGv54IvSXkHIHWl31gFvuH68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omeqa+RZujuNTZsGfm/NYojYsbxJxTpFSU+ra6Nyic3SXNkWFXpqIwl2nfzKrvXOv/H+aHc1T/AoLa0bRfu28sM8ai9cgKcBGXeBCrRUeuzmVx3BFEMTsbZH2X5V6eoKM1VHCPMrS8PO/dNf2qy1yijClEnXbI8Nu7gtdw1qlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8JmCkra; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7dba73cab13so1889993241.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710198875; x=1710803675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ2pa4nj7oXlSTKQD8kE+gXKIpchRZ+8dqQudfY0JWE=;
        b=K8JmCkraxw8nD6k6AbOndSMnXQkym2N5R+KnGhAs63mh5Id/66hZTOUc6nf11gd+ye
         QFyQXYOHIGKp1RfBy8GUd/Vyp7gh8kv7aduH9rHSRaqmrSkv51hJGIdnEJpa2KnJ96Wh
         tsD1NTYKeAdKvQkKEfTf80Se3up+KPiezH3Dxri7OTNPJTMqhyxWyh/QwSMkdVITtgLr
         bAITg4mYqDcsqynGbhdO3EmsCEMfHUInWhviqMHMG0nt7HZAsvRRe0z0FKl3d7G4PsgH
         kqgOk/kl3h0pAp6Fwr5i8iFmD759YNFutC9MA6EUqYBIVN85RWcPV1aeXz+3rCwPPq7R
         nYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198875; x=1710803675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ2pa4nj7oXlSTKQD8kE+gXKIpchRZ+8dqQudfY0JWE=;
        b=wDPprsqE9Sd6gKgfSqFBp+FRXayOEMHgZy7SB8P10UrVVeCRfDjWQKMwo+fMIND1pQ
         biezBPTudYuj8s6B2aU2uORKSkOFiHWqK1JuqSvVsYEGl13f5hR/AeKqTqRz/BsVzasS
         c0/2+BShIaAMnn072EhN6Ci6jpLestYOtvttIY3Tgaa8xP+a3HSnPdrNdM+Ysv8jnqDr
         zDbxKFaJnO8rr7qXxgDlY+Lsnc4svYi+8UEVtRzEj8Q/cknlh8TFxQl9lmUtZi8Uo82f
         wjoS5TyleW6p0r6y6DZhnVV63RIr0WUMY2qas/56RQeOWB+c7zDOlfJmErqFt7GvaR4q
         8E3A==
X-Forwarded-Encrypted: i=1; AJvYcCUNPFRY46qHDpwUBQqSGcezfJtCZAwZAej+aBSRbcbCkir670+DlsBG7/ppWntnqkrWZOMRb+ZateQz2FOEOqTc77d9iizzjDzJ9eqK
X-Gm-Message-State: AOJu0Yxx6DV0RU6eXGR9hd7uc1j5ndSIb9xDwjgtETULKQpd16PLu9xj
	5GsXuQWRfwSKMPWWlpidA5GIVdVjfu4IrL5HP1Noi/gwMLI19aiPxbOrvvEKSEioh4JVmrrnP/R
	hmdjJg0fd4DufYa/GYrzjCXk1NPftugt+eR8=
X-Google-Smtp-Source: AGHT+IEP9QfJ/15+LGEwgLxR55JR1HY6yYb3v6kYkzjs959wuPjQW0amRAEzg1bx7UNX2oZCCPJJ2x0tUUqnX2Ddm5Q=
X-Received: by 2002:a05:6122:16a5:b0:4c8:ee1:5a0b with SMTP id
 37-20020a05612216a500b004c80ee15a0bmr4811063vkl.15.1710198875414; Mon, 11 Mar
 2024 16:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210845.13488-1-21cnbao@gmail.com> <3439a693-753e-4293-a0fe-eefd7b3cdf53@redhat.com>
In-Reply-To: <3439a693-753e-4293-a0fe-eefd7b3cdf53@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Mar 2024 07:14:24 +0800
Message-ID: <CAGsJ_4wtCu6TO9LiAvPZi+h6C5MbDiF+WxdrYo9=XXbJS8B6Xw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swapfile:__swap_duplicate: drop redundant
 WRITE_ONCE on swap_map for err cases
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:37=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 21.02.24 22:08, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The code is quite hard to read, we are still writing swap_map after
> > errors happen. Though the written value is as before,
> >
> >   has_cache =3D count & SWAP_HAS_CACHE;
> >   count &=3D ~SWAP_HAS_CACHE;
> >   [snipped]
> >   WRITE_ONCE(p->swap_map[offset], count | has_cache);
> >
> > It would be better to entirely drop the WRITE_ONCE for both
> > performance and readability.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   -v2: drop goto according to Andrew, Thanks!
> >
> >   mm/swapfile.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 556ff7347d5f..7cb6d9a2d51d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3320,7 +3320,8 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage)
> >       } else
> >               err =3D -ENOENT;                  /* unused swap entry */
> >
> > -     WRITE_ONCE(p->swap_map[offset], count | has_cache);
> > +     if (!err)
> > +             WRITE_ONCE(p->swap_map[offset], count | has_cache);
> >
> >   unlock_out:
> >       unlock_cluster_or_swap_info(p, ci);
>
> Maybe too late, but LGTM
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

David, thanks!  Though it is probably too late as this one has been in
mm-stable for a long time.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

