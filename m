Return-Path: <linux-kernel+bounces-69795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA6858EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7219F1F22229
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D117A1EB4A;
	Sat, 17 Feb 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji+BHswJ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A71EB3A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165156; cv=none; b=D+/EyOE4zu9cCKNylmruKeStgsdEOx+VlccOPRS/0Okb8jM+AXgaB+cscfwy/LZ8BuSGlKorOAgDGyuHpwfezRerYrb8IE8axCftGqeeN8a3mRcJVLYfqmKJLIrZJZZyvJfCMrQx3SyfPqpmfzCswMw61j3IK0PmJLk8qFPs3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165156; c=relaxed/simple;
	bh=rr9GfZ98kNf1r9adRYgyXB17Nc+N7JFYTnjcnjoO+MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJKObgHl+JIi1McU1uuw8fUF/ffpBXn+Ho0M8klYxiugWMpxRuDfatPYQzzuHmx6XAQ4exS9pS3Reuf3zOT7bTGnYr/9xivARIuqJZw/vTG17SSZOPSk1wUa6i3Yn+ZRB6dM3H3KfY0iatjvEhI3XNQBilwTKFQ5H8FeG2gMCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji+BHswJ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso1752784241.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708165153; x=1708769953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uClJ3fAlScaq3NqQwR+2Ic2/qYD/92ld+NgmLu3RlS8=;
        b=Ji+BHswJM8bkRJkx1jlDY7lrKwLUwdSLVmKH0+nCgeMI1r6scoh6oH2k3Y0O17rFM6
         bAcIbirR4E//COXo/6i2zvWLUzSqggBC34DDrX+JodDbRRvepKl6RakjON/73Ur4Ydnm
         c4AvMzqKbm0lLFQQExbAAQJbDCM005J/iUqpqdi7MaHPyR2Ss9jzgSj+ff3YH5vS4HsN
         TvzunSLP3KEoMCbIB3nZxlSQizbsqNiVJmJb9RjkO8DLMThSVnqbzU7MnzhmJgeWaHx0
         hAHETtViMdFyaO9x3z5r9vNNCYVGlFqD90uuX7mCHiTg3ObHquY+p7q2Xkdkj6qpmMM4
         660g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165153; x=1708769953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uClJ3fAlScaq3NqQwR+2Ic2/qYD/92ld+NgmLu3RlS8=;
        b=KGruqAMm1Td7oXHYX3JuJRGev7f5H0IhzOOS1rIUjM43yJc+ER1jhNLTs09kysZ0ci
         IeQHDBmgClrQP9yiBqH0Kvn3SMo0PYIveAvwa1YVGBOXfBI1xHQNTPhz6fnzkF4vGtci
         ibS2JJoVcY3ZG6P9sKTqLYhM2aR0A6hLKgeiupALuTOIT6irwqp1ft4gyyM6c70+tfSD
         btaZv7WhqCBZcXlQInmR+Dq9BP8mCH1YhYhgEHWeM7d2X9zTn69D5gXMKT/IVCmKhIwx
         aNd1IfWaXq+WJrPuoaaH7eD4zXwU93XZc7zD0UyNjmA8z0HLAEcKtpGPSgV9oGZad+nS
         rGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8IZM8UG4iWiKb0JHVRm7qkZxX5D66SiqYLMxn8rWNfCE74CQl2K4EFI/1yv20J7oygA802rjXEdAcgLOgO/66YpdGlgKnjzowMrAG
X-Gm-Message-State: AOJu0YyhDiKPd2cQqzePCoxQA54uZTbxVATdAAR//17ZALA8b41tEusN
	XRwp+L2CgyHi9Es0qtDlfYWHhycoH7vl7RAy7OGOGq4NSt4Q9iGGXyhje+pOfb0fco+daoxRoMo
	6fXVLbn41kLpTLfNls0fszm9gSAM=
X-Google-Smtp-Source: AGHT+IGLXWxnqiQBes97u+3wAzXqStcg0VIXKROlbLqfeL9vuKpwnhs7OrRiTrQQsn+n0pVtkM2GUR4tZoATGUhs308=
X-Received: by 2002:a05:6102:2385:b0:470:4514:506b with SMTP id
 v5-20020a056102238500b004704514506bmr284887vsr.3.1708165153533; Sat, 17 Feb
 2024 02:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217053642.79558-1-21cnbao@gmail.com> <ZdB0-fnlSyGgH2cQ@google.com>
In-Reply-To: <ZdB0-fnlSyGgH2cQ@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 17 Feb 2024 18:19:00 +0800
Message-ID: <CAGsJ_4xo9Z4zxgDUZAzbCZ83Y1QYXZxRKbTNU_4xDP0+eP0V=w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, senozhatsky@chromium.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 4:57=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Sat, Feb 17, 2024 at 06:36:42PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > We used to rely on the returned -ENOSPC of zpool_malloc() to increase
> > reject_compress_poor. But the code wouldn't get to there after commit
> > 744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
> > new code will goto out immediately after the special compression case
> > happens. So there might be no longer a chance to execute zpool_malloc
> > now. We are incorrectly increasing zswap_reject_compress_fail instead.
> > Thus, we need to fix the counters handling right after compressions
> > return ENOSPC. This patch also centralizes the counters handling for
> > all of compress_poor, compress_fail and alloc_fail.
> >
> > Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
> > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  -v2:
> >  * correct the fixes target according to Yosry, Chengming, Nhat's
> >    comments;
> >  * centralize the counters handling according to Yosry's comment
>
> Yet Yosry is not CC'd :P

terribly sorry. I thought you were in my git send-email list ... but you
were not...

>
> The patch LGTM, but it won't apply on top of mm-unstable given the
> amount of zswap refactoring there. I would rebase on top of mm-unstable
> if I were you (and if you did, add mm-unstable in the subject prefix).

This patch has a "fixes" tag, so I assume it should be also in 6.8?

>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

thanks!

>
> Thanks!

