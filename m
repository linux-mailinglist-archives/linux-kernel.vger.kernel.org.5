Return-Path: <linux-kernel+bounces-29583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF283106D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E817283A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2F395;
	Thu, 18 Jan 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACL1Qula"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73C191
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537084; cv=none; b=eqOT3GexVRUk0Xiok2ECBGM6ZhBcJd5RZ2d0EM0nY7iia8bmqNVaVix9xBLf3FKp9nR6wVQszqOov57GjfchRgWead43Dc3Eo2lI704G5tWwifFePGKs+wexGfhQQBMvyMAeQAOwTIVdQDWv7MYGmmlhwhrojyQAj6z91vx1Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537084; c=relaxed/simple;
	bh=X8SGrIjLKz3N+7j8PpTnE7zcRdqnMOLIDx28wL64vfM=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=e0oGIjScDB5VEDO6CE6hjBQJ7X8DagpqacM+QAM2SBJtzqvMffGSdVMJw52Jn0oL9F35eqfVCybEfaUFrHi79PaJwrp0PxFKhyQgrEJzjHO9Zjje826DTd5yJprluDX+da3IFSlCNNCpR1z2VzFPbCeVKKSRIFU2QBIhTCEvWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACL1Qula; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E629C43390
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705537084;
	bh=X8SGrIjLKz3N+7j8PpTnE7zcRdqnMOLIDx28wL64vfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ACL1QulaRs5RMSQPqifvediFinODMrrycsn1B0ps7dyoCt0DREDn4tCsH7dFoj8eW
	 Y74QuzpJQBkTS2ZBxS00QEUjvj87p+Gtga0BqTXCWOT5Ey9Lg5oajUYHsRpENsSud9
	 rzfvHcbH2Yk09ZEHk7Yxy6bN+B7OEqvEzGrFsPLXSHcIFMvddbp3tWrPcGCiBnB0lX
	 t/8u6K812JlHy3fq0JV7D77fPr6Tc2QWF52vfsDzQoUdg43f4yV8W0E0on6UXXm0BA
	 Ec0y14BqRukcJX/KnKwzW0Uuc3SI+6+e7DmVBhsuNyO1ivk3kPspZhJPMsXerofhyT
	 VwOlvu/iZgMsg==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d6fbaaec91so6429405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:18:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yye79tkAKsCFq5PPssRIY8iD1L+vsdeH6Vz6XqA28444uhVCFjN
	oYf5if278e2ZcC/0F3IWbYzfdRIGRR5bU9vJPnuqt6WW/c9LdVH1tpNm86sHZccM+rh6uMFRqpL
	h908elF98UbQHlvl3NVWPFiYivFJFpoBucHdM
X-Google-Smtp-Source: AGHT+IHG7BloajwkgvdQEfRmll3TT9JqCmQbQGfuCAVwO5fLYd194/hQE5j1S0L7XiZ96EoisN5GZbfQtySOzb7NSqs=
X-Received: by 2002:a17:902:bb01:b0:1d4:cd41:e44b with SMTP id
 im1-20020a170902bb0100b001d4cd41e44bmr84916plb.124.1705537083735; Wed, 17 Jan
 2024 16:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com> <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com>
In-Reply-To: <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 16:17:51 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
Message-ID: <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jan 17, 2024 at 3:48=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> > Currently the xarray patch should have everything it takes to use RCU
> > read lock. However taking out the tree spinlock is more work than
> > previously. If we are going to remove the tree spinlock, I think we
> > should revert back to doing a zswap tree lookup and return the zswap
> > entry with reference increased. The tree mapping can still decouple
> > from the zswap entry reference count drop to zero.  Anyway, my V1 of
> > the xarray patch will not include removing the tree spinlock.
>
> Interesting. What do you mean by removing the tree spinlock? My
> assumption was that the xarray reduces lock contention because we do
> not need a lock to do lookups, but we still need the lock otherwise.
> Did you have something in mind to completely remove the tree lock?

In my current xarray series, it adds the xarray alongside the rb tree.
Xarray has its own internal lock as well. Effectively zswap now has
two locks instead of just one previously.  The xarray lock will not
have any contention due to the xarray lock taken inside the zswap rb
tree lock. The eventual goal is reducing the two locks back to
one(xarray lock), which is not in my V1 patch. Your understanding is
correct, the xarray still needs to have one lock for protecting the
write path.

> > > The reason why I think we should wait for the xarray patch(es) is
> > > there is a chance we may see less improvements from splitting the tre=
e
> > > if it was an xarray. If we merge this series first, there is no way t=
o
> > > know.
> > >
> > > Chris, do you intend to send the xarray patch(es) anytime soon?
> >
> > Thanks for the heads up. Let me send it out now.
>
> Awesome, thanks! I assume Chengming can test whether this series
> provides the same benefits with the xarray.

That would be great. The xarray patch needs more testing for sure.

Chris

