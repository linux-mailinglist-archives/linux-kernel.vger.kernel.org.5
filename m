Return-Path: <linux-kernel+bounces-126792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FE893CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6291F21ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB3481BF;
	Mon,  1 Apr 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq+m+bbI"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6945BFF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984856; cv=none; b=nxwE9fz2BYfzYQhFuGWvLLzJHRqAl8H0rObmtmo/FNJPD3lRJgZYt2Szf+gg+KbM//xCOWt82+1eCTdR6LQx8oX49UTr5WlsKMn+Q201TVO2s11w4YvgfsyvhsK1FyP/Zd1d+O/WrWfiOZaFe7Y+X+/6FEoGhLXhoBrqtpSwcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984856; c=relaxed/simple;
	bh=92H7rkZJyMknyRgZiY7xK5YoqDGG2duQGF7Ozhgs2lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7b0bCdXKdArO9IFTQQL3m0gUJFKArSqrQxdkiA7nHKgXr4CHs1JsLAeclBWT6BWaf+kbTUpe+owGzH1vIybzC1+SvczJpvvxKjd3CiTsijIkPzP+5wA5FGbFzt/pPK37C399vRKU/lH0HJ/kRmPPSxVkmsur0Cjl/U/DKnJGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq+m+bbI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430a65e973bso26912401cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711984854; x=1712589654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92H7rkZJyMknyRgZiY7xK5YoqDGG2duQGF7Ozhgs2lY=;
        b=Wq+m+bbI9a/TwGWj7m/zqlp/VXO88bgR4J1qXqkFmt+qEy0663grt3SA1T41qi0cqJ
         kQeKPDphgzAW3hDxTokdf4L9K2FfLVZD3JH8cMV4Yxzl3Nj1YFzuUef9o+e3DOWjBTQ4
         4DvsrVBGeE/NM+bH98M0l9D209KQc1l8ZCQWXgInhgRvT1Ar74Vr/B65KnDdQ8aQ1uDy
         /E63GGuo/c1KyO6c0PJyCiYFrjySIeBofji42evT5LW7VDgz6nL7kJq9Z2mkFjLA+UG6
         oCnmyoan8jDl/36oNcYDNpw98S5idMFSwKX5jkfSlwsGykdTsZL0wd+LXR9fiDysiQrT
         O8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711984854; x=1712589654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92H7rkZJyMknyRgZiY7xK5YoqDGG2duQGF7Ozhgs2lY=;
        b=KsfbEuOUx3CIokWIbuLHZ2RkH/7ej2Ogav1BE/Zp/VqC0Wde5q0woVlZovBJn/rZ5X
         WyxOCJqlTuZEcYxg7pJFFo3aRwYyvozZRA242D97ObkVmPJ31mNXWOmvMm+NSQeiLQbF
         DpG09X7mWT4hVf8S+k5HrLFVPZJRJQivm9kFSj1Ek7dtoOgS2Xt752l+b16580zI/U7w
         IrrBDTGvsNksEtwX8+8IeDUQ6xz6/XCZoV3lJUHV3Xw2NHzBR1VZ8iRy2yxg+PWqRlLN
         6F05Z9q9gMD1rlgogUW+KInkXgm8kJn2zP7dmU1RsK6MGwU98H6dSbvf4QwgrSdglfUW
         ZQXA==
X-Forwarded-Encrypted: i=1; AJvYcCVNijpBUn3mWPlN0NmDanl/SBMfFOcsQ1WDicBqoKKal6UNqOq6aq2QL4SaffEaDxztC0FAMZWYNa3Xap6bQ7Pai3gu6+YWeqBti312
X-Gm-Message-State: AOJu0YwxiKy5yinW2Ow04aN8FQvHM+dDasrKaNa4Am75CypTRQ6qyOJf
	hw49Dn3zBvUcKAjQKEQ+OwRKerkKQXWpIC2mxDJJpgpQAGG2xZR1hoRL/Dsw4yaEZJini3l0/+Z
	N0QHv4WRarTjNYnQbhh6h+z5f9e4=
X-Google-Smtp-Source: AGHT+IELTjLD4UEXmf1PVs7+/v3eouHWyOZEr5yTffc43QG5dm7NkRnnhLv2pGTxHSnZdf/tKO0ulmTBu73MRbX7GXQ=
X-Received: by 2002:a05:6214:411a:b0:695:dd8d:572c with SMTP id
 kc26-20020a056214411a00b00695dd8d572cmr12030365qvb.12.1711984853732; Mon, 01
 Apr 2024 08:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACFO4hLEReDiPvaLmEj1c105xUnC3o_zXshpw1zF_+2n0CZpiQ@mail.gmail.com>
 <CAMgjq7C-4H5zcbs_-mvSNBBWiGhx__0_sTTG32Nfsz7TnP=i5Q@mail.gmail.com>
In-Reply-To: <CAMgjq7C-4H5zcbs_-mvSNBBWiGhx__0_sTTG32Nfsz7TnP=i5Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Apr 2024 08:20:40 -0700
Message-ID: <CAKEwX=O8_arvHJy7ZUZP+j4zY8Yj=Z4iGEgDh4B-GG0cnHphLw@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: prejudgement swap_has_cache to avoid page allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>, akpm@linux-foundation.org, 
	ying.huang@intel.com, songmuchun@bytedance.com, david@redhat.com, 
	willy@infradead.org, chrisl@kernel.org, yosryahmed@google.com, 
	guo.ziliang@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 8:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
> eg. If swap_has_cache returns true, then swap cache is freed, and
> skip_if_exists is set to true, __read_swap_cache_async will return
> NULL for an entry that it should be able to alloc and cache, could
> this be a problem (for example, causing zswap writeback to fail with
> ENOMEM due to readahead)?

Yeah the scenario you describe sounds plausible to me. This will make
zswap writeback less efficient - it seems more pages will be
(unnecessarily) skipped because of this check.

