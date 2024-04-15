Return-Path: <linux-kernel+bounces-144459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF078A46A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D86C1F2203E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18511723;
	Mon, 15 Apr 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdXNZEF8"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A67FBF0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145834; cv=none; b=ArtuwxOAGhQrCEgqcrJO7ZC3cCZkVRxKotrgR1kc5P1nEoRiMwiEpG+Dg1rULDJk3bCDVv/2Givenmt5uM9k6IolvGr7Qghkl6ytsBHA3wF6936s7+LgZstlf8WsXE3X+ec3cdVm2Zav84kvGyFlAlx2xuzWMVKNhiT1+8Z+Eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145834; c=relaxed/simple;
	bh=7vMDYjSktelAHGlLsxho1rQJ4CkVojTekucaWrFiLYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suE9k4OdhFD6sqTUoCjVmHX/Uz5g4ENuO+tvCNxWSmLepZs1mwLcPvzEa85ISket4bFf1UsAJnto6Qp+zubHnn0BKb4zWrunSYkTSsRC1NZrufY8XFBWJ58u7PqSAXNkqk3o8e+KXQnfi8q0QOkINMAjLiNak2GTVGnJ4pn3KcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdXNZEF8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso32866631fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713145831; x=1713750631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSaUhARtlrBBbSU/eGQ+luiqgYoc7YzbWreKpdVDLF4=;
        b=NdXNZEF8CHo4KzD8PkqQGGlQDq2/ro058FKX42SueTlH9mNGQ/JBmiyzEdkbF8q0Uj
         WH78MNhpTGy4lteeSbcAPBHn0h1oNxBsKlMUsgsxi53+sHak35TjqH7/HqLxLwVWIsd9
         MzsknbxalCrjYmsK4wYWl4hU19QDHw09hq5bdlmi1s+cfVYRSncHlU9IlDA1WQfFvezS
         n1CPyRX6IKhgYmgsDNleh1jKReljSofhalrh1CPDRZVpDh4FjfCKLojB2jrtw84zokK9
         ygMgn5RLIjZw6LwJVtAtnYIXV3eGUYge48DTzViYEl/d+Ln3gJDBQH5Y/OJRHcap5YJt
         uY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713145831; x=1713750631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSaUhARtlrBBbSU/eGQ+luiqgYoc7YzbWreKpdVDLF4=;
        b=F7FTmATa1T9CiLxMRbSlJ5yKgrZ8z2j8e6n3xOsx9Xa0pfs5jmzuKpubKfebw6pQ1Y
         7UB6pN8fMfHYZI/lsY+T19BxnedAebAcSeKRUNpV+qmuyCkNy/t8BsBAUMnTh01cz1NE
         uc1XNawtsHn42J3IL/DAK6TVootEleFWd7WlqN3rnNXycAc9yKD2MiGpM+aPJ9Qy5XKT
         6LiXcziWbsCYNixGiWs7OZamWKmiX9zvT+/v+zAmCmYLGNpJwyNUM7Kx6u8dbFt+TUg/
         eAMGagPiSG5nvNAY37Zx6vLDN+L3XxgYs6PRlR7YvrLHaYUIyY/flTQv+vAEEWdNCqvl
         3M/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvnSmF9pjE64cAiN/fcMOJxuvzjCVNGdqv6gx1iFvuxO8gYczMcoZlmQuHzVsesqC4brn1AG0NXrEkuP0qokzvKqjt9uU8PTlr3YLM
X-Gm-Message-State: AOJu0YyfjQuex6qHQ7J+pARUeoq8D3lo42SqfA6hK5+PXqYD5VrzdFBB
	CstTJRb1OE7kIVKxkH28nrRe84KXQW+pxv+v2dXRHbWnilvukutlbNw0Ex9cuYEDyLfWfz27kWp
	D9qNkUNcsZXBv8gPN6UNUe+hSmHQ=
X-Google-Smtp-Source: AGHT+IExuoaxryisrWPTChHe0Sn6EqR5gqS1M6SxF727EbH7ugLFAQV1y5b81Tz5S+q3mIKnrkasHdGJAJjnNYsxFvA=
X-Received: by 2002:a2e:6e07:0:b0:2da:15cf:1e23 with SMTP id
 j7-20020a2e6e07000000b002da15cf1e23mr3949793ljc.17.1713145830395; Sun, 14 Apr
 2024 18:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com> <ZhxwIh2M8jr6IZaF@dread.disaster.area>
In-Reply-To: <ZhxwIh2M8jr6IZaF@dread.disaster.area>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 15 Apr 2024 09:50:19 +0800
Message-ID: <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Dave Chinner <david@fromorbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Alex Shi <alexs@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:09=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sat, Apr 13, 2024 at 10:01:27AM +0800, Zhaoyang Huang wrote:
> > loop Dave, since he has ever helped set up an reproducer in
> > https://lore.kernel.org/linux-mm/20221101071721.GV2703033@dread.disaste=
r.area/
> > @Dave Chinner , I would like to ask for your kindly help on if you can
> > verify this patch on your environment if convenient. Thanks a lot.
>
> I don't have the test environment from 18 months ago available any
> more. Also, I haven't seen this problem since that specific test
> environment tripped over the issue. Hence I don't have any way of
> confirming that the problem is fixed, either, because first I'd have
> to reproduce it...
Thanks for the information. I noticed that you reported another soft
lockup which is related to xas_load since NOV.2023. This patch is
supposed to be helpful for this. With regard to the version timing,
this commit is actually a revert of <mm/thp: narrow lru locking>
b6769834aac1d467fa1c71277d15688efcbb4d76 which is merged before v5.15.

For saving your time, a brief description below. IMO, b6769834aa
introduce a potential stall between freeze the folio's refcnt and
store it back to 2, which have the xas_load->folio_try_get_rcu loops
as livelock if it stalls the lru_lock's holder.

b6769834aa
    split_huge_page_to_list
-       spin_lock(lru_lock)
        xas_split(&xas, folio,order)
        folio_refcnt_freeze(folio, 1 + folio_nr_pages(folio0)
+      spin_lock(lru_lock)
        xas_store(&xas, offset++, head+i)
        page_ref_add(head, 2)
        spin_unlock(lru_lock)

Sorry in advance if the above doesn't make sense, I am just a
developer who is also suffering from this bug and trying to fix it
>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

