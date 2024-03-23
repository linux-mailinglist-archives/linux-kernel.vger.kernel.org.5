Return-Path: <linux-kernel+bounces-112437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BE8879D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080CB1F2177F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EE53E0E;
	Sat, 23 Mar 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSTeGG53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF41EEF8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711216274; cv=none; b=HYQiaYz088Eou8I/Q2m/jggzullbBE+eX6reEUrc85pyejqDCI6XkNo4twpluZllNvz1sPVx6OJ173dphp/DRnbjFbkJBVIEYtHNKbk5A3f/0fQveK8fFp6mQh4RJ77jAQgIxhp10NiHdIv1K1GeTEupXbvV2vWzkvpOoyGj84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711216274; c=relaxed/simple;
	bh=aFUWgJ6j3eMxB7F6CqY23CeEG1BKUpbBLEIqU1EnFrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkAdIbproBGHMgqZX+Xy9cImFulBg/rLsQhxE76PANwlecsTukTkTWY8T+8iXs8V55zJ7OYiPJ9OQPix/CdWSB3rrzrO+EYH/shSaqNnjF35/GBmGxYLfxJNdKbG9O+W4Rw/zKOULUsTDM+mXV5G3mrT40x0Yf09Vo11HBMLPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSTeGG53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799BC433C7;
	Sat, 23 Mar 2024 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711216274;
	bh=aFUWgJ6j3eMxB7F6CqY23CeEG1BKUpbBLEIqU1EnFrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSTeGG53eIkpnVxUoYlxTV46JKoq61UKbSL9IGS2H8K3EKnu/K/mAfY7VEu+/8At1
	 UDQRivswxnrXtpmVWL19v/1T7Kk6KeTy4CoUcK5s/BQYVFBthNGeCJ3Oyeve33b04g
	 XnOLQHE8eLc3si8axSxOymM27FDs7L8YgavIOdU3Xp5IhnrZaWWUcU6AGCTPY331YD
	 u2SHqrL0doHB06eLANtraxYzamJXa7pu10akyZCO4J98KqCSsfFPSW5/Mc2jpQC6iv
	 Uw5X5DCxfMRsWMFdCY2pDE0ajq9Dt9MSkZM6MSnsPYN7ioh4LeNMSOv3vUw3c5VNMy
	 gxAF3iOZUnWcw==
From: SeongJae Park <sj@kernel.org>
To: peterx@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 0/2] mm: small fixup series for mm-unstable
Date: Sat, 23 Mar 2024 10:51:11 -0700
Message-Id: <20240323175111.141475-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240323033310.971447-1-peterx@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 23:33:08 -0400 peterx@redhat.com wrote:

> From: Peter Xu <peterx@redhat.com>
> 
> Andrew,
> 
> This is the small series that should fixes the two reported issues on
> mm-unstable for this series:
> 
> https://lore.kernel.org/r/20240321220802.679544-1-peterx@redhat.com
> 
> This is build tested on (1) x86_64, allnoconfig+allmodconfig, (2) m68k,
> allnoconfig+allmodconfig.
> 
> Please consider dropping below quickfix:
> 
>   mm-gup-handle-hugepd-for-follow_page-fix
> 
> Then apply these two fixups.
> 
> Sorry this "small" fixup series is not that small.  Said that, I tested
> apply and the fixup should auto-squash all fine on current mm-unstable with
> a rebase.  If not, feel free to let me know if you want me to resend the
> whole series with a base commit, or whatever easy for you.
> 
> Thanks,

I confirmed this fixes the build issue I reported[1] yeterday.

Tested-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/r/20240322171456.118997-1-sj@kernel.org


Thanks,
SJ

> 
> Peter Xu (2):
>   fixup! mm: make HPAGE_PXD_* macros even if !THP
>   fixup! mm/gup: handle hugepd for follow_page()
> 
>  include/linux/huge_mm.h |  16 ++-
>  mm/gup.c                | 287 ++++++++++++++++++++--------------------
>  2 files changed, 154 insertions(+), 149 deletions(-)
> 
> -- 
> 2.44.0

