Return-Path: <linux-kernel+bounces-12306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541F981F2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06D91F22F32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FED498B0;
	Wed, 27 Dec 2023 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykmhsx0P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A225495CA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ba84a3cc96so289139239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703719316; x=1704324116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swUUhVhGR84IN8e7Uhazo2gmUEhU/6ZIWjlBrcgxqH4=;
        b=Ykmhsx0PHF6394u+d6HBh7KmJsKsigOUFokSHMto8rBelL1y+ccQgLfiSpm+cXl0lZ
         W5bJbxZoYZ1/6lUzJA/TM21/ad8hrY1tTddqPFoZy0/vl0fp6W+By6ccES+HNS5St27U
         N9KCzGmSHyvkVKBU7KfbvkSPTpqfmTXXOaFOoQtVrLlwZNA5+Org/sR+sYwQHVIcstwB
         2HjqVqoZEvreTjQapS6On6k1hzeL5dgMQjFkYzwwRpJRDYqWw3retHcJD5t0Ds14XTQw
         YgSrP++dttZnmA9areLMQyTZoq5wSTgcDEhn5eDr71D6eX/YR6YOpdiaFS63GRLAiahW
         QSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703719316; x=1704324116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swUUhVhGR84IN8e7Uhazo2gmUEhU/6ZIWjlBrcgxqH4=;
        b=mo5UIdyU0rONfBs15krK2imzyOweAvvMYEjVzYUc0HW/0vGlmICQrI+KiDp6TgoTqJ
         3EP0C5Fonx8vfO17Ke2mjWpKMKfUWcl1r8VAW2Pzq/H6SUSFYAMYz10dF77J76oP9XIR
         +8Tf1l7mxpVzZf2a00RjBfJ8yD+ccqPJJiPIydaEC7pe7ucT2HBmDPzKvm4zE1eEHjH/
         8HyyC366cuFIWdLc+Ap2jClf8RdFFtl7hPtt7Kd8jhzA35JDO/yjY0I8KVhKe1r6QC35
         mrYn45wB7YqKHfB6YqlEgmp+hYPywqD61g4Mv4lEpBCnT/N150g3r9jq+JjiyybYn8bX
         FzPg==
X-Gm-Message-State: AOJu0YwCsYgyQnahJNFiZB+eRRAVIx1AweR2XdhQ/xqKvLloET2KzDlZ
	Nl7DG/a438eWGtnMluM4qJIf0+pbZOUcM9NX97Y=
X-Google-Smtp-Source: AGHT+IHVYxypehbwk3MNttN5Sm11IW2Tbt1AEIEuT66pXQpHxhPI6Juwt18rpONw4KzLliPKQperlMc4LM53mS4RSbI=
X-Received: by 2002:a6b:4f04:0:b0:7b7:ae3:442 with SMTP id d4-20020a6b4f04000000b007b70ae30442mr13877651iob.10.1703719316273;
 Wed, 27 Dec 2023 15:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com> <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
 <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com> <20231227125853.2dd07cd61f8a8df95042677c@linux-foundation.org>
In-Reply-To: <20231227125853.2dd07cd61f8a8df95042677c@linux-foundation.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 27 Dec 2023 15:21:45 -0800
Message-ID: <CAKEwX=PDeez9D8t4WSe2qd753h=06ZSJwQ8TQDv1xLXB0cpn-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <21cnbao@gmail.com>, 
	Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Chris Li <chriscli@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:58=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 27 Dec 2023 14:11:06 +0800 Chengming Zhou <zhouchengming@bytedanc=
e.com> wrote:
>
> > > i remember there was an over-compression case,  that means the compre=
ssed
> > > data can be bigger than the source data. the similar thing is also do=
ne in zram
> > > drivers/block/zram/zcomp.c
> >
> > Right, there is a buffer overflow report[1] that I just +to you.
>
> What does "[1]" refer to?  Is there a bug report about this series?

I think Chengming was referring to this:

https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/

Syzkaller/syzbot found an edge case where the page's "compressed" form
was larger than one page, which tripped up the compression code (since
we reduced the compression buffer size to 1 page here).

