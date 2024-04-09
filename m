Return-Path: <linux-kernel+bounces-137192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91D89DE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542E51F2B964
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD4135411;
	Tue,  9 Apr 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN5yBGbZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314921350D2;
	Tue,  9 Apr 2024 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675556; cv=none; b=L9wSi3UwCZCy0bG0YyZ8uSWSCXr7AW6PQY/9ukybeeNes1uSUnLbYkd9pGbN08gtgnIDV0mfuX+Fi6ULyzNnjDI7fMD+uHHePa7B+UJn1/xiph+qLXR81G353JuyMga3dVCOPfd88T0Pj6OXELqfW4mDkbDLft8ktrDH1BhFLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675556; c=relaxed/simple;
	bh=yABctAo805xjpg7U8FgXkQBd8qT9ep2vZCs5aKbSz0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScwxCDjSufLNsnj3bv/gWu6mrNR+zAHcsIhYMFEIN4b1OyP538w2/XuiyQw3D0BEEd3pMzAx9iFkcW2GjhFXz1kdnSEZ/aWjcnfsuLatGFCEdcdwQwqyVQS2SovRKgCeF6sB4MtWVpoNSZfbrNGptguGgkc0UsQK6tRgtAG+rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN5yBGbZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415523d9824so58876895e9.3;
        Tue, 09 Apr 2024 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675552; x=1713280352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yABctAo805xjpg7U8FgXkQBd8qT9ep2vZCs5aKbSz0A=;
        b=RN5yBGbZJOenNRR1ddXLF/8zYVj4f2KlhTutDKBdalynlYMEnCloMeVyui/elU8jTF
         ZlPjZv5BYQwUC27mTOUS2i5zDUS3d1FWXl52rAYKT1D8u9SRqdnEl1R5PVjyLWrzyclt
         o7aoxINsLThoC4tZGQCjnv2rBZdDiTS/vo4NimGbKLZlGTQsmorwxOcsGvN6/6cefinu
         fENHbpbJ2wgOfHz/UHD9q6Ccvu98+la3+oBRQsweBn0gKpvj5+dUin6Txt1/gsYR2ztM
         BOViF4edg6XQp03ste5rozHbcMbsOmR3Qne07QaAesFEMAp+Oqf9VFCiOcqxBzVbJa20
         HvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675552; x=1713280352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yABctAo805xjpg7U8FgXkQBd8qT9ep2vZCs5aKbSz0A=;
        b=Ik9xPPKxZjw0+TsmiJOIXodRi7E5KTIeyduK+kOIsawk5IR3JQsarVeLpWq0Bz8MGk
         Sv5kczMIKuKkCz250IOLobwdKqiy7zQFufl9I8+VbOpfYV2s2IIEjFFJ0qbBNDYsXOHB
         hpASe38BTJLAoDNOGZWdfWUkYQLOwsLc4ikEydiPoClBTyE0UVQe1L/b+rQaG+1KmxEG
         oSBQFaWJiStMwn1Xn4PVhts0cvCEUXqS+kID3j7HoIxcl9JX6M8T57YJQRbt54PzSTZS
         k3nobbBW+lUd+6INubTAd3IdHx589d26APhkso1z8NDcmi3euP+oWL2rBTTjA8LXPrzp
         OGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUfSsvkqeBMOy+M6dwdgUUsZg6/8snVdCsA1mFW9N13LROIjNemfGwCsKMfmFthxKykkSC7vjC+zezOgWcJdD/LQ64CX/rc15SoUxWp4Odqtlg8himf3T2/GBD/QVcv/5u8W9R+lr9xULBkh1N9WV0I+XVR75+W89S0s1atItAu
X-Gm-Message-State: AOJu0Ywz7+BVwv99MaD0mbN/rtjoXjC/Y5bLwoZtSjEsnz2V0avRe3ss
	7jV06+CKjoqwP6tQIOMxuf5kI1aqAFTmyJMlX8X7PzZi6F82RRTR0eVVn08SoN9oFj3aoGfiSLf
	rax/CzDMdWhmR6pAB1yPKk+SX7Hw=
X-Google-Smtp-Source: AGHT+IEnfA8z4HxYt7Ye3dMfz4SZ+PR7TbjhtSSH2Ys+ESDSFz5zhjFVZ7rjXvdBpUczd5ZIVbVyLWd2UUTSuPnWJfA=
X-Received: by 2002:a05:600c:1906:b0:416:3217:15be with SMTP id
 j6-20020a05600c190600b00416321715bemr12441128wmq.35.1712675552276; Tue, 09
 Apr 2024 08:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com> <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com> <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
 <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com> <20240409062504.26cfcdde@kernel.org>
In-Reply-To: <20240409062504.26cfcdde@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Apr 2024 08:11:55 -0700
Message-ID: <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
> > > Just to be clear this isn't an Ack, but if you are going to list
> > > maintainers for this my name should be on the list so this is the
> > > preferred format. There are still some things to be cleaned up in thi=
s
> > > patch.
> >
> > Sure, I was talking about "Alexander seems to be the orginal author for
> > page_frag, we can add him to the MAINTAINERS later if we have an ack fr=
om
> > him." in the commit log.
>
> Do we have to have a MAINTAINERS entry for every 1000 lines of code?
> It really feels forced :/

I don't disagree. However, if nothing else I think it gets used as a
part of get_maintainers.pl that tells you who to email about changes
doesn't it? It might make sense in my case since I am still
maintaining it using my gmail account, but I think the commits for
that were mostly from my Intel account weren't they? So if nothing
else it might be a way to provide a trail of breadcrumbs on how to
find a maintainer who changed employers..

