Return-Path: <linux-kernel+bounces-130252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D28975F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0751C21489
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02676152533;
	Wed,  3 Apr 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUEdu32y"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514F152519;
	Wed,  3 Apr 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164105; cv=none; b=l5JaDMXq7uKuqzd/Q5Wpuebpr592z5yTS0LcR0++YKFCsnT5zGk8Vv2WO7THmvGySrSrFOsWn5sp7n9dSzpkL9E5DOAg5ZbICEFyTVf2zWorsbZZuslhYKnO9AGIDRgnYtoJTwq6gB08zDQ639R9OIg8cqHHdjDygvVZVFZErU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164105; c=relaxed/simple;
	bh=OcC8tHba1b0xwNBnYF1Rz0FUebzDY8vUEmFY4cdpfrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBhZUxwz2jFGy4UZKgWmg9iySN12KlBfJTMqJ1WEkknNd2G8rn72sJ7KVtXzE3/OcU6ZnZZEVywax5PPPGgKxnChxpE02RvKKyINOn54WmrOG3jRI1eQmbKG5qukpr1GiG8CJPMyBlNwM1NsbABlNzllwylEcfeFcEdyHf+usQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUEdu32y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so47022a12.1;
        Wed, 03 Apr 2024 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712164102; x=1712768902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXkTMWhGJHnawvFfr99rf7hUQgPICISPDhu2Uum6b2c=;
        b=jUEdu32y8DiqqhR+jWnJAjGHE87mz16FZx6bULMkit0Hsh8JZpiYmZNgrgFlJQNHUR
         Y7EwKw5XlENVMskOL9U2KKvXJRNsZckBLPjzv6T5U8G0BLokV3tZ9AfxE/XxruT8gjFe
         8fSSabwycepfVmUW8S2EbgozxvJ0H8OJtNDnzgNeJ9ibHIkp8s4KIgeTyL1zZ3hlyFC5
         wzJfUuBfFCW9heJM62zriLuy0Qoj3io6lYmnvdgNoJmZd+h7utyv1ya9ot0pFetcF6vz
         exufm+SRNDssWtcVVnOoXCLoYkfQ0n02/L/0gfYDVbpBzV4e9T/4raoOgr8/6vgXOGo9
         H9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164102; x=1712768902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXkTMWhGJHnawvFfr99rf7hUQgPICISPDhu2Uum6b2c=;
        b=i8ArAPXj8ON3DzlkuSByWoUewM+2Oi3fRVlyd6dK2/Mc252pzqW53pBnu/YaU6Cjld
         DjgSo9ZmzBr6PzfF7s6vYiiLGd59yKWuqGzAkQk3x0xO1c8eTwIYyp3agE4bhKXYeVPh
         +nSe2lekP8f9eVeLjvxLfElVKZbtTlGFjaVeE1U3gXQpZ9lk2XmWfOiXShp2/GLTQsCp
         Ybzei9dlMz6pTOJLZ6UmN5jd4fgWrDe9KBWPx7ZJvKsZ3W9OmawvdJbEGuESyVKNG+9i
         mDA9EJNWMhI0ukUce3d27rjQVYFRZuoRVdqHmJb4mIIkzTAieGWbXmr8tG3grGMlPXRI
         9Sdw==
X-Forwarded-Encrypted: i=1; AJvYcCU2u1YJWG/zS00lYsc7XkBXi8Up3Rw7CHdXGDtNi31+sm9jG5abjiBWUXYl4owrqKyCFF8CqK3gf6jRkFQna866oIFf8xuK/0MD7xv2
X-Gm-Message-State: AOJu0Yw0+D57CHe5TWLCs64mimE8LbvCcutjOB9JjWyskkpDlRe1Z5cn
	FjT2JHlDpG9l2coOOTZV1kZLAg9hvIiG/W+IJFl6CXoSueR+nhOmp/ZzXqfT6l/k36EbGY1S9l7
	1wiFWXD7uE/c92H0rKUVX2VMmswwed2Tu3q88Gg==
X-Google-Smtp-Source: AGHT+IGNWuQf8Fdm6+GA67xbdAmuqg7ABWqeUX7DGm4IU3MXvh6Eh2E/ASCDWCDKiVHUSe9y/Ni1ugihT+RAdF2WBng=
X-Received: by 2002:a50:c31b:0:b0:56c:16c6:2098 with SMTP id
 a27-20020a50c31b000000b0056c16c62098mr2999250edb.11.1712164101549; Wed, 03
 Apr 2024 10:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402180026.2469459-1-snovitoll@gmail.com> <CAKFNMonDO_diEo+_JXKgHMTmOPv5T30TALb-ZvsOprcwSJCtFQ@mail.gmail.com>
In-Reply-To: <CAKFNMonDO_diEo+_JXKgHMTmOPv5T30TALb-ZvsOprcwSJCtFQ@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 3 Apr 2024 22:08:09 +0500
Message-ID: <CACzwLxhgq0rsrEi3Ye7ExrF6KMZEXeX6VeMehmZD5d3HR+eonQ@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: prevent int overflow in btree binary search
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryusuke,

> nilfs_btree_node_get_nchildren() returns a value read from a 16-bit
> wide field, so it will never exceed U16_MAX.

You're right, "high" indeed never exceeds INT_MAX as it's limited to 16-bit
in 32-bit integer. Sorry for the confusion, It landed via my grepping tool.

         Sabyrzhan Tasbolatov

On Wed, Apr 3, 2024 at 1:55=E2=80=AFAM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 3:00=E2=80=AFAM Sabyrzhan Tasbolatov wrote:
> >
> > Should prevent int overflow if low + high > INT_MAX in big btree with
> > nchildren in nilfs_btree_node_lookup() binary search.
> >
> > Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > ---
> >  fs/nilfs2/btree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> > index 65659fa03..39ee4fe11 100644
> > --- a/fs/nilfs2/btree.c
> > +++ b/fs/nilfs2/btree.c
> > @@ -300,7 +300,7 @@ static int nilfs_btree_node_lookup(const struct nil=
fs_btree_node *node,
> >         index =3D 0;
> >         s =3D 0;
> >         while (low <=3D high) {
> > -               index =3D (low + high) / 2;
> > +               index =3D low + (high - low) / 2;
> >                 nkey =3D nilfs_btree_node_get_key(node, index);
> >                 if (nkey =3D=3D key) {
> >                         s =3D 0;
> > --
> > 2.34.1
> >
>
> Hi Sabyrzhan,
>
> Thank you for your interesting patch.
>
> In this function, the value of the variable "high" is initialized with
> "nilfs_btree_node_get_nchildren() - 1", and "low" is initialized with
> 0.
>
> nilfs_btree_node_get_nchildren() returns a value read from a 16-bit
> wide field, so it will never exceed U16_MAX.
>
> These index calculations narrow the range between "low" and "high", so
> as long as INT_MAX is 32-bit or more, it seems that the calculation of
> this intermediate value will not overflow.
>
> So while it's a good overflow avoidance technique, it doesn't seem to
> happen in practice.
>
> Am I missing something?
>
> Regards,
> Ryusuke Konishi

