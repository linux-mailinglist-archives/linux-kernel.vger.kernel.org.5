Return-Path: <linux-kernel+bounces-9012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDCE81BF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E4D1F2454F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC81A6E2A1;
	Thu, 21 Dec 2023 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVzHV+3U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712C651B7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46688d253b2so323771137.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703188159; x=1703792959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTilOv/OhJpxxj4x2c0lRPzP1/GCN30rU7OA1s4EK10=;
        b=dVzHV+3UlqNfXnY4b3u1r4kAAJlQDKGNqe/uaEDeZ+VXFMpgzJTYQEj8HvjjBfNLWN
         OjNuQImNJAzOSZXsBzWPib4hfKqEr9N1r83iewu6IKfKjJCkGp2RFGTw+ZL/GWI9uDtp
         ZaIiaOBZ05x98hf6/k9QPdAsaqCpWjh1mOWtPNTZzrfvmztNyicGXN0tQw17j8bBRE6l
         YVS4uJGCK3cUVWm0GT1FFkYsiIHlfjZlY7K8AW6x8zlSzSwqv8ISu49uLhHfso7L5uI6
         k30ZXFzQqa/PSmbVPlNFqCvLZlhts2PI+7JwCkNp3yshLQ6onjy1C+NxirVMR0enLa/i
         bD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703188159; x=1703792959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTilOv/OhJpxxj4x2c0lRPzP1/GCN30rU7OA1s4EK10=;
        b=oBryfP6RVf45VTs4k5Ci7U14XV4+jYIxDnMRtakMHT3xZsfl2TQWfWZnuBsa7KBdO/
         DdB0yacFSCDWigixeSSTPLhB4hNijPv8YAn0iNJkbBsN5YiXU6M/fRTtk8c3Gg8Ri5Cd
         5TodG1yWUj1ZH3qY6QvHmtefyjxdvi4eyzwpYwiCLdNhzKXfEZO+WyzPrzgzbbd2hfbR
         13WxpnbjuTtTbp2i40snkIUfM2rPA4/eg7OQn1RnHyE3UqNgzyMJfTRe8/IVv8ltU27U
         uRdO/r5bFmdiAunxjfDoA9nZdRwoTjk2AdlnM9w43LQMD7VSw2aL0HEx0YyiGC/F/g8F
         ZdPg==
X-Gm-Message-State: AOJu0YxTqXl844vK9fKX1Ug851ZxOBaH7YZ8HviuWivt+zITOdodYBD2
	J8hlR+65YOF0HmeHgPGioYEP8eFhMGWUXFyFwB/OUPNl1yXQ
X-Google-Smtp-Source: AGHT+IHUqR7HXHvIZLCaYk/k6TOus8rCR1v+guqujioc7xktg11FsaS3D5+szN0zbXqpNTMxRRA8AxLRUdHgvjos2C8=
X-Received: by 2002:a05:6102:2b87:b0:466:9d4b:8778 with SMTP id
 ib7-20020a0561022b8700b004669d4b8778mr110845vsb.65.1703188159581; Thu, 21 Dec
 2023 11:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220220843.73586-1-mike.kravetz@oracle.com>
 <9c7cc2ed-6f9d-4305-8efa-6381eb9e39d3@redhat.com> <ab373102-9192-e3bd-e829-63048365b3ca@google.com>
In-Reply-To: <ab373102-9192-e3bd-e829-63048365b3ca@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 21 Dec 2023 11:49:02 -0800
Message-ID: <CAHS8izOoWCQr5cD0Dyw_sMd3Jp2MnDH8spAqLn7F_Afh_kEQPg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
To: David Rientjes <rientjes@google.com>
Cc: David Hildenbrand <david@redhat.com>, James Houghton <jthoughton@google.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:45=E2=80=AFAM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Wed, 20 Dec 2023, David Hildenbrand wrote:
>
> > On 20.12.23 23:08, Mike Kravetz wrote:
> > > I am stepping away from my role as hugetlb maintainer.  There should =
be
> > > no gap in coverage as Muchun Song is also a hugetlb maintainer.
> > >
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >
> > Mike, thank you so much for all your hard work over all these years!
> >
> > It's been a real pleasure working with you every time our upstream path=
s
> > crossed! :)
> >
>
> +100.
>
> Mike, your ownership, expertise, and collaboration have been deeply neede=
d
> but also very motivating and inspiring.
>
> You know how I feel about it.  It's been a pleasure.

Indeed, it was a pleasure collaborating with you on the hugetlb_cgroup
stuff. Thank you very much Mike.

--=20
Thanks,
Mina

