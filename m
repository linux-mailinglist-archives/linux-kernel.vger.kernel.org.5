Return-Path: <linux-kernel+bounces-10914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9881DEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5358DB20D99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C515A8;
	Mon, 25 Dec 2023 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08sk9xF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D80110E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d41a32effso143385e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703487313; x=1704092113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyqJYcIcc+GjCQm5GmQ3IiA6wm6RwZv0sslOf4v+Z18=;
        b=08sk9xF9RaiaDgQ4qaT62CHgZzPXBgE6t12Qc+LAyPRdXSGQHjVVlP/1Y+wnSC3Hgd
         /jZ+IJDHtme8d26+ZJTpfsrxVqZCnrGTAgKpnBoXOhcwiIUanHH0LfPpoR3x7q7IkKu+
         x+9Qto67JonDREzZowl4IHoYLX3p+1R0UM4ZVG5JIBQaOBdzMrX2BtZgqlJGkHq0C/uk
         3P7McAboKco6xL40DyTQ4h45dc+BHfEolrsKpslFWRGTJCgHrN5tbpJmznbBMgF1S2gt
         +/0Ny4YX1ipmb7LBB29FvliWJAn+jUjPOkxFe2MT46ACu5LN4F4ALWxNQxQReXMbQ0vx
         fyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703487313; x=1704092113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyqJYcIcc+GjCQm5GmQ3IiA6wm6RwZv0sslOf4v+Z18=;
        b=sGnkEjb+JyFXOZ9bchPmxtYaFvD7e0mqlA6PDPtcsfOsGLathGyaT/ED5abesEZr3C
         anceu06yATlh+p9Mh0P4grEGqTBTpGDIKqnP449QvOqUrkZMUndNGw7NQLCoBeAw545D
         E2EBv2aT2imdKPJP7Qp5ajIp2CZueQ8x18PrfeF29mvH0l91YVtUpZSenhu83HeUltfj
         hSRNUsMHaL575yDIdQ+V5NOudVtq0xjdm5WhAHoDsQpWuXZm+lC5dhbSR6oFSP2/4yID
         GzlJZqySU1MaqYApAnyXmz8pBZ+ezb14N74QuWyyKGXDF3sqf6nf0kZpZ2d4v06a8krA
         JIEA==
X-Gm-Message-State: AOJu0Yw/x8ayyYrWjYnvUllmgkHi2HN15UvwYtQeKf37wDR0TQ36n90w
	C0yvdClMOzfqcGn0/WJ6m748WQ4pw0bPN6IAr5A27BFnz+wH
X-Google-Smtp-Source: AGHT+IFzTQmYyCFiTaXLaXaZbcsvot1nofMeqvQ8VYH0owZFOuqx80JhTGXp41erVHLtzV7kZVmPne5htCQI/FCyKjQ=
X-Received: by 2002:a05:600c:1c29:b0:40d:3bec:55a with SMTP id
 j41-20020a05600c1c2900b0040d3bec055amr333681wms.5.1703487313428; Sun, 24 Dec
 2023 22:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-4-ryncsn@gmail.com>
 <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com>
In-Reply-To: <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 24 Dec 2023 23:54:35 -0700
Message-ID: <CAOUHufZmwaos=6reZSbs53e5TM8nbK-u=1Q_god1fWPz-o_wLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, lru_gen: try to prefetch next page when canning LRU
To: Kairui Song <kasong@tencent.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 11:41=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Prefetch for inactive/active LRU have been long exiting, apply the same
> > optimization for MGLRU.
>
> I seriously doubt that prefetch helps in this case.
>
> Willy, any thoughts on this? Thanks.
>
> > Tested in a 4G memcg on a EPYC 7K62 with:
> >
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> >     -a 0766 -t 16 -B binary &
> >
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys \
> >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> >     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
> >
> > Average result of 18 test runs:
> >
> > Before:           44017.78 Ops/sec
> > After patch 1-3:  44890.50 Ops/sec (+1.8%)

This patch itself only brought a 0.17% "improvement", which I'm
99.999% sure is just noise.

