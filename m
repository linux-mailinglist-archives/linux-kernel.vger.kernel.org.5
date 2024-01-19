Return-Path: <linux-kernel+bounces-30823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BA8324B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F4B217B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B2C13B;
	Fri, 19 Jan 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGAzh/4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9B8F4E;
	Fri, 19 Jan 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646079; cv=none; b=kX5pPMRU+rCm2iXBBZRH5Rk6tb4Jf9jr6N0fDerBgyRV9eek6DFL8vyJ/9nM8dLP9LQvsZjJaHi5Y6uvf8aJ8Fy/rzpgcZDwvvrdCNA6uHcE7oE8cvXTBg/27IxvHyVYHkRyo4vk1CXmyXF4JFtqATvz06vJToBZHKR0yWu51Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646079; c=relaxed/simple;
	bh=ybA7Oc8IdtrO7eV7Gbv0lepTuXv8HmJ31IowmvsVq8w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m63WZ2ZSNyJ1Wd9vmeXrMbVBvwe9zLkWPTVNQkdtGBI2A/dofbxUb7/VRluV9m4lQUMnKo2bwjj48FGyPR3W5G/fNTBlr+8zWLK/t3OrvxmHBLthMUKZuhF1RPVNqFaITEwcUz3M6UDOVXw7fo6C8h9pNfgJH3WwYqHOqD2pKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGAzh/4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE6C433F1;
	Fri, 19 Jan 2024 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705646078;
	bh=ybA7Oc8IdtrO7eV7Gbv0lepTuXv8HmJ31IowmvsVq8w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PGAzh/4YmVT5S4OS9eQk1mS4lN+09SjCWQE/JyAgmagMRQz0wNuhoSlnMlF/0FY5x
	 /Ij/Gt1u0ioX1CjhSasQTC5mSgkYcKOtyMJgptXWkUM/RpVpgYHku/cyC2m9Q6mVJ5
	 RkE2DP+0ODENZESZATD8M6uMMXYhuSEQVGtc9LP1soaBY8Oh7HE5YY9qoy2aaRk/am
	 UgyZgUKGC4Uwg2QFHNsL7QVId0nBxXu3O2TJhHkiBsMYTEyHPLTlq45GgLNr/9mb4i
	 u743CyBKjfqm+It734T8hi4T7yWXmPlI8rolnK2IksV6rBscxQ+B1wNrYR8vblXK7S
	 AyqlpJGW1p8vw==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,  regressions@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org>
Date: Fri, 19 Jan 2024 08:34:35 +0200
In-Reply-To: <874jfjiolh.fsf@kernel.org> (Kalle Valo's message of "Thu, 11 Jan
	2024 22:47:54 +0200")
Message-ID: <87frytg7b8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Just trying to make everyone aware because I suspect this will affect
> quite a few people: ath11k is crashing during suspend on v6.7 due to a
> mac80211 patch, more info:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=218364
>
> Proposed fix:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/

The fix is now applied:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc

I'll try to use regzbot for the first time, let's see how it goes:

#regzbot introduced: 0a3d898ee9a8 ^

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

