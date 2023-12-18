Return-Path: <linux-kernel+bounces-3869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215B817467
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25351F23321
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F73787E;
	Mon, 18 Dec 2023 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Snbz/lT8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA294101DB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b5155e154so39565505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1702911501; x=1703516301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T2lzs4wznIp2xbwMuaXpnCrk161AzmSWNsE1VAdzIps=;
        b=Snbz/lT8TAYspcrvTfdUQqIZ/Jot3FdNmVC4AHRmZ8n+RolcvOmMJUjVXoL6ek8GFn
         tCk6vIpYuuDLotIOWlCZ08zSG1sb+CqdHU8ZFl7IUB4xHY08I3XD2CerRXN+uzixodJz
         bUekW1G4+tO4F/MyaA518U9BlXggTRy0LXO0dNLGdBY4jKNfUZcKCd0UIzVGvjaZEhCR
         6GGFJGE1CGXo5lNyjrpfb3wF65zOjRP6oYAQIsz6xTlAXb7CiPKSsvxKTVPGtj9l+zQs
         PajDOpUf6beg7cB/SV+mYmTZ/7GfKqAEr5AHUKFCK5cLW0yRemxNJGYcVN7Pk+iGyyPE
         qgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911501; x=1703516301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2lzs4wznIp2xbwMuaXpnCrk161AzmSWNsE1VAdzIps=;
        b=Des/7VQJNkhiWKvBZok4vWwlRB7omdKhOfKq5fj7gDmDjR/D6KQYqwguTQ1IS1X4oD
         faXjecGM1clqq8HbotryP27uv71JR4bD/fKBBo2VT3lIkVIWYk7v+YLYliYk1TqDsCD0
         nsYhTCR+Ygat0xwkoJQ7ZOn9SW58zs1FUQKp3gBSVcbJR4pHDYv2S339J6PbPJHGZ4wm
         aOzJNTqi2/kc3po/ywSGk8tePq3aBi8YZoSkvVpvbaaNFE3qTWaJW4zI1YofQI0P3ZN8
         fn2tJWlzek4/MvATws9aOyCCOrWkowzEGKxi6K0poZGaTtwlCIe6alQC2AqfrOH1i/aL
         DrBw==
X-Gm-Message-State: AOJu0Ywq6vmwFnB3sMeB0IL25kcFueQ0YvnOc3h03K2wDDtJiLQ9Ln8W
	gjVFHz44XCS7aNuJU6OqAgGCdw==
X-Google-Smtp-Source: AGHT+IHm5i4U4iCbK1WO2wBoHSz6xtDXsSSWbqr+KjfCPJ/PiFtLd2RWtKwkraO4kBXCUu/g7w6Hvg==
X-Received: by 2002:a1c:6a1a:0:b0:40c:6a3f:6bc2 with SMTP id f26-20020a1c6a1a000000b0040c6a3f6bc2mr2796111wmc.30.1702911500633;
        Mon, 18 Dec 2023 06:58:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:bfe6])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b0040d18ffbeeasm5305205wmq.31.2023.12.18.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:58:20 -0800 (PST)
Date: Mon, 18 Dec 2023 15:58:15 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
Message-ID: <20231218145815.GA21073@cmpxchg.org>
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
 <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
 <20231218140313.GA19167@cmpxchg.org>
 <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>

On Mon, Dec 18, 2023 at 06:39:13AM -0800, Yosry Ahmed wrote:
> On Mon, Dec 18, 2023 at 6:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 02:41:26PM -0800, Yosry Ahmed wrote:
> > > On Thu, Dec 14, 2023 at 2:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > > On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> > > > > <zhouchengming@bytedance.com> wrote:
> > > > > >
> > > > > > Also after the common decompress part goes to __zswap_load(), we can
> > > > > > cleanup the zswap_reclaim_entry() a little.
> > > > >
> > > > > I think you mean zswap_writeback_entry(), same for the commit title.
> > > >
> > > > I updated my copy of the changelog, thanks.
> > > >
> > > > > > -       /*
> > > > > > -        * If we get here because the page is already in swapcache, a
> > > > > > -        * load may be happening concurrently. It is safe and okay to
> > > > > > -        * not free the entry. It is also okay to return !0.
> > > > > > -        */
> > > > >
> > > > > This comment should be moved above the failure check of
> > > > > __read_swap_cache_async() above, not completely removed.
> > > >
> > > > This?
> > >
> > > Yes, thanks a lot. Although I think a new version is needed anyway to
> > > address other comments.
> > >
> > > >
> > > > --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
> > > > +++ a/mm/zswap.c
> > > > @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
> > > >         mpol = get_task_policy(current);
> > > >         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> > > >                                 NO_INTERLEAVE_INDEX, &page_was_allocated, true);
> > > > -       if (!page)
> > > > +       if (!page) {
> > > > +               /*
> > > > +                * If we get here because the page is already in swapcache, a
> > > > +                * load may be happening concurrently. It is safe and okay to
> > > > +                * not free the entry. It is also okay to return !0.
> > > > +                */
> > > >                 return -ENOMEM;
> > > > +       }
> > > >
> > > >         /* Found an existing page, we raced with load/swapin */
> > > >         if (!page_was_allocated) {
> >
> > That's the wrong branch, no?
> >
> > !page -> -ENOMEM
> >
> > page && !page_was_allocated -> already in swapcache
> 
> Ah yes, my bad.
> 
> >
> > Personally, I don't really get the comment. What does it mean that
> > it's "okay" not to free the entry? There is a put, which may or may
> > not free the entry if somebody else is using it. Is it explaining how
> > lifetime works for refcounted objects? I'm similarly confused by the
> > "it's okay" to return non-zero. What is that trying to convey?
> >
> > Deletion seemed like the right choice here, IMO ;)
> 
> It's not the clearest of comments for sure. I think it is just trying
> to say that it is okay not to write back the entry from zswap and to
> fail, because the caller will just try another page. I did not like
> silently deleting the comment during the refactoring. How about
> rewriting it to something like:
> 
> /*
>  * If we get here because the page is already in the swapcache, a
>  * load may be happening concurrently. Skip this page, the caller
>  * will move on to a different page.
>  */

Well there is this one already on the branch:

/* Found an existing page, we raced with load/swapin */

which covers the first half. The unspoken assumption there is that
writeback is an operation for an aged out page, while swapin means the
age just got reset to 0. Maybe it makes sense to elaborate on that?

