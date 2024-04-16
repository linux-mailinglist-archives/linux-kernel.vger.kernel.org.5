Return-Path: <linux-kernel+bounces-146194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259498A61DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81251F20F75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FBA1BF3F;
	Tue, 16 Apr 2024 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8o6CZNf"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE061946F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239511; cv=none; b=YMZlyiTLDCj3OFnvRUvhTGeYD5I1eqYI5oVf3dXH77IhZr9gBgqiqBABkJJam7xK0BxKQaHhfxMzY+a77xl7yrvM+d1fL+4p7/Dj4yvbxuQRI7f4jcDFuPbJMKEMbLthJuIf+bFOb1laQfvLhwZSC3f13KnecoN1REJfZg3pojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239511; c=relaxed/simple;
	bh=FjeTOxQ0f/by6BCRieitR4Bb2ooz4HV9AMJxGMaIZkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb+hXc9RjNjGM5M8aRRtGKQCxR9TycMHHZYfAnsVoa1tQ9OmYoZK7hKy93y5MoFLiwQLM6sg5RS+s2UodtMzYUS81ENytmvKgqwSrTcg05Zo6azIwlHAC/URJS/+7StRuzQ8uxcN0BYzHx5l37T9hXc2iXPqJiXdB4YFh/CGjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8o6CZNf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da888330b2so33476981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713239508; x=1713844308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm7ZcmqODEDdlMVCkcEwyHPG5PSzL84rGETrzop4fyA=;
        b=L8o6CZNfGMMhNqJS/YtNVdYxFKY7viYNbyYR/E7uDAsRchWS+Mi4CDrbZtayyoI+pR
         KzdnyAaNJd78iyAkxURPZWTReFJAc+pr8stTgaI8YBoE5O5E6iRVBK5oC1kzW9lueNHT
         96snknPvv9iURVLths/xEubNJDmmaA12/cJgkI0zJp1l65AdHeOImkFRC7Y6eWo54qIN
         SZPxXfILOsOT/pbDAdeyJiNvAIirlME/9O5/15vP33doMqr8XUxdUP89SPyZgmX+uMaR
         liC1FtQW4jK3UqwWXrWi5LwaQVb/iiPB+eE6iQurb2p12T5HOaiWkFORcQKyXa/YQ6Vp
         fAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239508; x=1713844308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm7ZcmqODEDdlMVCkcEwyHPG5PSzL84rGETrzop4fyA=;
        b=wOMYwUDLpAEt7JjUSMPcfOzct/mZeiR9SSXaMib2Ma+VLdan0CUKDA1oaoajf9Ba7K
         f9dZtW/LgG9RaIUjqixTKuG48lBm7mRcaXfyG1ocbM5uMVBed2HYtxvy+8A5X38nTI1f
         9TF1B1H0VOIF0oUx3Fk1kZ7z2G679QjkQWcPX55ilLIduut8m65L+FUDZRLNwC5SiE9M
         O63dXiOlikitMg1IMOJZW53JMdbzFBJKoGAhoJoxofmTlMi8bdnr7Kii847CExp3oIgz
         0obO9qes+2g3/UvuUnmJDNluf5Yu5C2U8GPvtOe68ZpbuUE+1ptme92Ubj4Jw97+E77Y
         OO+g==
X-Forwarded-Encrypted: i=1; AJvYcCWl6+FjvaomKx24yQ2nuBmUFV+rRTybBE0FeAMOiR/QYmuFAho5QFNwJQhEVT/ma2SFCpSOY42W3WK/CQ1ZgOE8FUAfHS5OvPKLoGuX
X-Gm-Message-State: AOJu0Yxnb+Z3C1XqlUy8vtP3FvpzQHXtbhrrWvN8C/hJ03YEbb8AaYZb
	o415czIjgJLglT8fMEeOeCgABu3Om7hMGMbzg1QfyPW992QknjSf+n/7s9MzZGiiQgLH/GS2+yC
	jZhW50+O/xDNtvcSavuePK3E8sNJUbmUQ
X-Google-Smtp-Source: AGHT+IGrxY0SZpf+F3z5NMZMRCHcrZyRK9yVeUmI1wjwLiaa3T1CHXHwm8tCk5xg6bHIUZbpUltsqPjqiqLA2RgMf/8=
X-Received: by 2002:a2e:98d8:0:b0:2d7:121f:6b7 with SMTP id
 s24-20020a2e98d8000000b002d7121f06b7mr10287446ljj.38.1713239508017; Mon, 15
 Apr 2024 20:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415171857.19244-1-ryncsn@gmail.com> <20240415171857.19244-4-ryncsn@gmail.com>
 <Zh16ndI5aN8r4yOR@casper.infradead.org>
In-Reply-To: <Zh16ndI5aN8r4yOR@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 16 Apr 2024 11:51:31 +0800
Message-ID: <CAMgjq7Bg_p8ztuOy=25CR5u_=ZXRx64L5DxQm9mWEp-BJAq4sA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lib/xarray: introduce a new helper xas_get_order
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:06=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Apr 16, 2024 at 01:18:55AM +0800, Kairui Song wrote:
> >  /**
> > - * xa_get_order() - Get the order of an entry.
> > - * @xa: XArray.
> > - * @index: Index of the entry.
> > + * xas_get_order() - Get the order of an loaded entry after xas_load.
>
> I'd just leave that as "Get the order of an entry." as it doesn't have
> to be after calling xas_load(), it could be from any other operation
> that moves xas.  Also this is the short description!

Good suggestion!

>
> >               if (slot >=3D XA_CHUNK_SIZE)
> >                       break;
> > -             if (!xa_is_sibling(xas.xa_node->slots[slot]))
> > +             if (!xa_is_sibling(xas->xa_node->slots[slot]))
>
> Could you fold in this change I have locally?
>
> -               if (!xa_is_sibling(xas->xa_node->slots[slot]))
> +               if (!xa_is_sibling(xa_entry(xas.xa, xas.xa_node, slot)))
>
> That fixes a sparse warning which existed before your modifications.
>

OK.

