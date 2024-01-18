Return-Path: <linux-kernel+bounces-29605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AB98310B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1341C23C86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42D186C;
	Thu, 18 Jan 2024 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpjSvDFe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273A17C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539820; cv=none; b=IdwvFG9avSKvTf0xNgJd+dyImtuWfP/LaYX+MOTjhZXzftIQsa/B35/JRHU3UB5PxHsp/Dwk4BdOq2cr1EXsAayY+AiL2Jei1W7zb7NKugQi++10cgheKHRGEVttXfIRUXpJe6zbOefGWgJV8ABgQp/To77vpwDHRJfeZvSt0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539820; c=relaxed/simple;
	bh=rsLIlFzFyvOPLK2orpePH7+oGpdZ/DAUbqI9LqJinoM=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=rEbc0yQWAy1EZcUOmGvLt8pNHLUVF8NTLQKh+PRY3BoDl6F3kX0oPnLWxctzxVs+dTcX8tpQ0oMXz0abAfxu9bX3NOGtCiGv9V5iNMG56zow/LHhbe+SuZfslqFTXMM55/lCl7zSum/5qYJXd+Iht0FWINj0qsVNRRgbZ3/qyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpjSvDFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F09FC433F1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705539820;
	bh=rsLIlFzFyvOPLK2orpePH7+oGpdZ/DAUbqI9LqJinoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GpjSvDFe5lRAIeqHWDIBBWyHf1OHRGBDQ7bhub0QFDebAOsFzh70FEIcx5RvZfH7r
	 0nrxZf5lxFOg12w35V9l8CAAcii65TiwqLsjHboIQIyL0A6ayNFnV8EmgM2mUCr0bQ
	 IXPM/FETVCxd9wW8cX437FFJJH8GPBRDyvb22PpHazj2UqBESet3Mw+uJuVJ0AS7Mu
	 EXA/95xy7qAdjndGXlHoVu3xoSJP/IRgyGjl1bgqktOILtJluml4UXHcZl93orsFRl
	 7WyM637xCdThonphUZVjwykyzRc5iK1/AVMc47bro3GvDjXnG39RyNzRDxLUQBs6MP
	 B4xWCc6EqRUmw==
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6daf694b439so6461164b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:03:40 -0800 (PST)
X-Gm-Message-State: AOJu0YyLuhi2h/qFj7PEu0AcwCOz4RkGopKZFsfok1FDCAhPNolVBnks
	LkXVKFJ7gMGM8CHVqNd61GbeFwJd0cdF3wUZfWN8/K4UuWMCTxk8KypU1oFwJCMG88ur7UuXOUs
	zbK3D3wmR4iaY2Dcy0Tok9XHaYOyW9kI1Rgny
X-Google-Smtp-Source: AGHT+IGYCnVV6anRJS7ULoEj04u53JNIxkLyo79VW/gE+B+TNHO8kMJb3wPwo2UTJAbocSh7zkRDIIDqoQySTI9kKv4=
X-Received: by 2002:a05:6a20:5530:b0:19a:4910:5716 with SMTP id
 ko48-20020a056a20553000b0019a49105716mr69166pzb.117.1705539819798; Wed, 17
 Jan 2024 17:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <CAF8kJuP4o3Ebg-aYKF9=ftbdu97RnkXnYL-8RuVjYAeXd+ng3A@mail.gmail.com>
 <CAJD7tkYfo6mNjHQJt4yfVuh55tMyVMRnbeq5ki42tYHBEgP_eA@mail.gmail.com>
 <CAF8kJuO=3-DMV-rXBZE-hVUXzQcV5B1HPFGzpzL99_5WggqF9Q@mail.gmail.com> <CAJD7tkadpOmERPzUyYUX=8=POan=Pm1zSae81zyRhYLXDHo_7g@mail.gmail.com>
In-Reply-To: <CAJD7tkadpOmERPzUyYUX=8=POan=Pm1zSae81zyRhYLXDHo_7g@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Jan 2024 17:03:27 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMRWDuY5hbAzbA9bQ5=4RztvD3tLB-W+6besGBk11+pPQ@mail.gmail.com>
Message-ID: <CAF8kJuMRWDuY5hbAzbA9bQ5=4RztvD3tLB-W+6besGBk11+pPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jan 17, 2024 at 4:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> Hmm I don't understand. What's the point of keeping the rbtree if we
> have the xarray? Doesn't it end up being more expensive and bug-prone
> to maintain both trees?

Patch 2/2 remove the rb tree code. Just keeping the tree spinlock.

>
> When you say "eventual goal", do you mean what the patch would morph
> into in later versions (as in v1 is just a proof of concept without
> removing the rbtree), or follow up patches?

V1 will remove the rb tree, but does not merge the rb tree lock with
the xarray lock.

Hi Nhat,

> Hmmm why? Is there a reason to keep the rb tree around?

No, not at all.


Chris

