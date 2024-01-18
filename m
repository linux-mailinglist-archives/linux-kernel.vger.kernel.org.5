Return-Path: <linux-kernel+bounces-29746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EC8312D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8532838AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF829449;
	Thu, 18 Jan 2024 06:48:29 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417997481
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560508; cv=none; b=l9ypoLITViq1cfsUVBkXc7q/6d89xZ6NvjmeYm5YMkiFsPHUmNXgXkB497jket83Anz4UjA1+OB0fZhahhOAbPprVvIrkWvTa0eXkjxUjWMPhWhY4dqoaKZ7NB1PdUqNHtrNMLZMTrrK0XNvbvm7GSI9d9wcw/dg694eGeMtS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560508; c=relaxed/simple;
	bh=8jauxg95i132eOZCuJr/hrW8/+eD3j4e3f3VPpTT5U4=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=qisREiPzge3tgBPJFGFn3BjGZ3x+Y9G1oRkFh2OFSVdhjahsfUsMphfQHkjkN2rT42EgofLgf0CNSl7JiIyqG0bv1+rLf7HejShwfKVSubuYNketVEWefojX8J+/dbG9C6dE7QE7ZYfnXnY7GqVdMN5E2NY0RAr1Pj6yptPqvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e80d14404so354981e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705560504; x=1706165304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jauxg95i132eOZCuJr/hrW8/+eD3j4e3f3VPpTT5U4=;
        b=Fag5lDKIuZPbAGviynsCRgJ9H+6wpJt0SNWD1DvNn+g7w635DtZxBpdMSc2OAIVRZJ
         HGFNaTaiGYyhZxPH8yvUU7zTg2/ObnieO7AXEV5dPfqXYEqk8bKLWyX4XW24Sz7sTbK0
         WqG8Y+6myusxyOgeEgUNRy3/xnXckfKGPBGlspP8Cr2d+hWMzOyReX5qrnsIKlbWPsks
         NQw2q00tWGpNZAOGsMKrXPVhn1FhvS7yWSZqpUPpF9fhbuQr6E0h1bg5igiQAtpekHWt
         V6sTLA2PoMS2t3y6yhW1BZJu0RhgPpCNjfc7sG4V7A8frpweSKM7QwP8iIKwEu9Aw1cD
         CcOg==
X-Gm-Message-State: AOJu0YwHWz8avItETu06Wkaib/gZh/QCREUj8pepuX3778bS4xHrgsuC
	4N6CDpGNO07GUQwItuiBauYbpdi2uzGYjprgZ1g7ZYvYNIpol9FPv80isNQS36IQ+NDItxfRXbo
	FPMdS/fWODDDQcuYIwy/PjlOW6w==
X-Google-Smtp-Source: AGHT+IG/s7NbNdQFIeBlaCU1kPMbseGVc9UtT1SjMDdmYxpotmYqdS8MMRCcYq8pd1e50ALT7BqfOJgQD40bhxgY0rc=
X-Received: by 2002:ac2:4283:0:b0:50e:ed79:d94a with SMTP id
 m3-20020ac24283000000b0050eed79d94amr246958lfh.30.1705560503950; Wed, 17 Jan
 2024 22:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org> <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
In-Reply-To: <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
From: Christopher Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 22:48:11 -0800
Message-ID: <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> That's a long CC list for sure :)
>
> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > The RB tree shows some contribution to the swap fault
> > long tail latency due to two factors:
> > 1) RB tree requires re-balance from time to time.
> > 2) The zswap RB tree has a tree level spin lock protecting
> > the tree access.
> >
> > The swap cache is using xarray. The break down the swap
> > cache access does not have the similar long time as zswap
> > RB tree.
>
> I think the comparison to the swap cache may not be valid as the swap
> cache has many trees per swapfile, while zswap has a single tree.

Yes, good point. I think we can bench mark the xarray zswap vs the RB
tree zswap, that would be more of a direct comparison.

> > Moving the zswap entry to xarray enable read side
> > take read RCU lock only.
>
> Nice.
>
> >
> > The first patch adds the xarray alongside the RB tree.
> > There is some debug check asserting the xarray agrees with
> > the RB tree results.
> >
> > The second patch removes the zwap RB tree.
>
> The breakdown looks like something that would be a development step,
> but for patch submission I think it makes more sense to have a single
> patch replacing the rbtree with an xarray.

I think it makes the review easier. The code adding and removing does
not have much overlap. Combining it to a single patch does not save
patch size. Having the assert check would be useful for some bisecting
to narrow down which step causing the problem. I am fine with squash
it to one patch as well.
>
> >
> > I expect to merge the zswap rb tree spin lock with the xarray
> > lock in the follow up changes.
>
> Shouldn't this simply be changing uses of tree->lock to use
> xa_{lock/unlock}? We also need to make sure we don't try to lock the
> tree when operating on the xarray if the caller is already holding the
> lock, but this seems to be straightforward enough to be done as part
> of this patch or this series at least.
>
> Am I missing something?

Currently the zswap entry refcount is protected by the zswap tree spin
lock as well. Can't remove the tree spin lock without changing the
refcount code. I think the zswap search entry should just return the
entry with refcount atomic increase, inside the RCU read() or xarray
lock. The previous zswap code does the find_and_get entry() which is
closer to what I want.

Chris

