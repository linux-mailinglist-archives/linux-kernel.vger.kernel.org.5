Return-Path: <linux-kernel+bounces-3255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 742308169FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028531F23288
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F4125AF;
	Mon, 18 Dec 2023 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjNdV0BN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FB9125A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso2856998a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702892321; x=1703497121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ8Fi2dLzLbYy4lYxo2rawHPEVgmeyvbO/CcjHbsVvQ=;
        b=xjNdV0BNsJIACFqS39qr4panlvmQmAzWP/fpNwkWAZ4KDhSybnzj6CGKvkfAzNRLer
         TBy+v1vBEx2FMFjcpmwE2tzs7IbFhWz5PbY+HTuTC/q9cHVmAlolfIGOtDrGiJxT+oCB
         dtFppE7nOZmuINYaL7UVDkuXqZhMkkRv7LemqsOT46+BND6vVzLEltnOTXK8E1ojTji2
         Mlz1lU+sKKjv70Pkw8VKxS4CS/7xrvj9e0HhK19wW/U4AyPVNfnYD+SmF+Qe/ASJV5oL
         oDh5l5ZXf6xAcSajrdJjVa/PfuaM4fQKHCJQAoH5AIiapYu81cC4UJgdjcbSs2TN48az
         5blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892321; x=1703497121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ8Fi2dLzLbYy4lYxo2rawHPEVgmeyvbO/CcjHbsVvQ=;
        b=KOtZqbR+KQyqw3FtiZet5o8Q5n4l+BEqFYA+EGiss5vKcTU8mmsL6Nu5ZM5OfMOTX3
         2DHfAvRhNk1TMph++017o5f/Wm5yxSkCgZOBfvVE7D/3+ZwU5WOK6LA6HVNsjtD6/zrU
         Ifty8QoiELlHBra4YP9mA50vvwJXwG4IT+eC5Ld4d3K1HJTjT4oavecph4OmkzzO/cIT
         IzL5IOkTwdWg6wkNZbFgzLKW+1yrcqoCvEaVi2IiQ54cn/pP3AIsgy3CUGXk5GKurjyV
         EVzlsvVwI76PULVrm/TzX+66MswB7bre3I3ll1BGzTdSijDMY1s4DZmCk4Y65IPgyMt1
         D7Ag==
X-Gm-Message-State: AOJu0YxXgG5O9CA6vp7M45Jld3BZPe0rvW8xuq7588e7HaJWx0ACMfQz
	1kgB08wgJFdAblFeZESf/pxRX3DZh0bfGzSxc07c5Q==
X-Google-Smtp-Source: AGHT+IHwOwRufeKXUD8IHua/HZtfaweMW/rW+eUzxVzu70/xq/9byuzl+DXAq8hUFt2pOMb2wrlRHAjCRLShgMWEFhs=
X-Received: by 2002:a17:906:7388:b0:a1d:b6b5:3416 with SMTP id
 f8-20020a170906738800b00a1db6b53416mr5657636ejl.84.1702892320732; Mon, 18 Dec
 2023 01:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com> <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
 <b3736d08-fccc-4499-8801-4e9b8a7394d6@bytedance.com>
In-Reply-To: <b3736d08-fccc-4499-8801-4e9b8a7394d6@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 01:38:04 -0800
Message-ID: <CAJD7tkYdvhhn6KG1cNnGAHp6XxeSG7zpC9JqxSJd5yBxQVHoAA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/zswap: refactor out __zswap_load()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chriscli@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:15=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/14 08:52, Yosry Ahmed wrote:
> > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> The zswap_load() and zswap_writeback_entry() have the same part that
> >> decompress the data from zswap_entry to page, so refactor out the
> >> common part as __zswap_load(entry, page).
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >
> > On a second look, there a few nits here.
> >
> > First I think it makes more sense to move this refactoring ahead of
> > reusing destmem. Right now, we add the destmem reuse to zswap_load()
> > only, then we do the refactor and zswap_writeback_entry() gets it
> > automatically, so there is a slight change coming to
> > zswap_writeback_entry() hidden in the refactoring patch.
> >
> > Let's refactor out __zswap_load() first, then reuse destmem in it.
>
> I tried but found that putting the __zswap_load() first would introduce
> another failure case in zswap_writeback_entry(), since the temporary
> memory allocation may fail.
>
> So instead, I also move the dstmem reusing in zswap_writeback_entry() to
> the dstmem reusing patch. Then this patch becomes having only refactoring=
.

We could have still refactored __zswap_load() first by making it
return an int initially when split, then void later. Anyway, it's not
a big deal. The new series looks fine.

