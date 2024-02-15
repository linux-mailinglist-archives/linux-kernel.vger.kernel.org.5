Return-Path: <linux-kernel+bounces-67397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C3856AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E8287A53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2813699A;
	Thu, 15 Feb 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYQQeg/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54844136661;
	Thu, 15 Feb 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017790; cv=none; b=KmnKdk36DabrVDL2m0mp1xZXwoHWN3PBFO5vPf+0xpoXwnfP8Oitw6nvFhfIPsHQJlVqDFOT3TgXKviAYDPQCHmU/topG0CyxRnorsmhTVd//Zs6cfFScP+h+Z8slRRKinrF4fbZd39xDC6aZAiJIki8mk7u0IR5f3ZlZi0NULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017790; c=relaxed/simple;
	bh=BarItA9+PraAAFBMz/6LYeRm966GEzMFc4O7GBjYKFU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qndKuuYKpWf4WOvVMzS3bWEnXCZ2TiKJKOUW9pbwOyzkJTbAd09NirQgwLF666RI44c9EUWF/HzA9JQ/OudnAauBK6TlNe8Ar9Gh/3wbu1KFCrc97uhgm/zT+j1dmZVypzZbzEleEy9AxX3UDLlIT3ntnJbQxL8W0WIVsG7gLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYQQeg/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BE4C433C7;
	Thu, 15 Feb 2024 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708017790;
	bh=BarItA9+PraAAFBMz/6LYeRm966GEzMFc4O7GBjYKFU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cYQQeg/p0LjooSkWPQmGjFqujuj4uvfk0mzpyDNPc7yU8AQZLg7NnH9NMQVtwolOy
	 kBXqvyI5rgdQpkgerjAekcnN2IdNhcAn22t1Y+JA/RoGjlWg8vutWDDoyccKNSuaE6
	 9pi2vY93hYacakMGn5GxNoI5Qnqk25E2By0Fz0suzMr/xQagDjyGkmuyF2vjFwoVPy
	 QAeOd45JN6H1c2dH5UMaUwFZ+8c7B4dE28mOTCZT4vtLlhM00s867JgE2Rjl1dKEQ4
	 3SRANRVLFY9mo8sGb+3Z9gYoBst0uH2aCZOV8aJssvjxMD7mPtYv9lyq9MkgaT8NPq
	 ZYML/eKgTiftg==
From: Kalle Valo <kvalo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  Johannes Berg
 <johannes@sipsolutions.net>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wireless: Add KHZ_PER_GHZ to units.h
 and reuse
References: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>
Date: Thu, 15 Feb 2024 19:23:06 +0200
In-Reply-To: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com> (Andy
	Shevchenko's message of "Thu, 15 Feb 2024 17:41:36 +0200")
Message-ID: <87wmr5d4lh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The KHZ_PER_GHZ might be used by others (with the name aligned
> with similar constants). Define it in units.h and convert
> wireless to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/units.h | 5 ++++-
>  net/wireless/reg.c    | 7 +++----
>  2 files changed, 7 insertions(+), 5 deletions(-)

wireless patches go to wireless-next, not net-next. But no need resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

