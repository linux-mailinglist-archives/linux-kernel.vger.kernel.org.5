Return-Path: <linux-kernel+bounces-130595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC7897A43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EF1F204E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65315625A;
	Wed,  3 Apr 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Leo/VnRM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7B1B946;
	Wed,  3 Apr 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177527; cv=none; b=hoQnPHiewjVyhqjWjyuhizgp6+DgU2D5P3/0xhtPLMip3s4HVgkuiTQUgTH2ui6E5fXjoTXnyT2c7cwEhYOcUMrd8uavvvFUfxR65phjEVS0+5Lv1Xy8c+JbxRPBk8eh5voL/u3/dV157kJvtxFMwPFDD1Qk98ho6nlNbE3JzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177527; c=relaxed/simple;
	bh=ihz+JoABNGCOvGpZDNd6tZFP5zaTOJBdl5OkGmbe20c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/zeX7++jePqDWopoOt17of6erjJZf4U6GJH8kd/zou9628lQ6nnapaKVIIS0GzxMzC589DnH+ZiqPP5+KXompF1dT74Qvi2QN/eAe9K750uT4TxeKF7vW2Ssr2EIj0LXkMhEKUuKGA1Moki/M3edQ2OgwT84ChaXr/OZmccIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Leo/VnRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF95C433C7;
	Wed,  3 Apr 2024 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712177526;
	bh=ihz+JoABNGCOvGpZDNd6tZFP5zaTOJBdl5OkGmbe20c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Leo/VnRM4JQ/VaKX6w6WYgkkFyWlUMVGKxlWkUjDa6QnuNCqBlUZi6AGAnk/f0jy9
	 0P1IW81CpKHRL+JIKW3wGp6qKa90PcmQFrOpKXyV7JOf1jU37kz8zXh8R2RpjwlYN0
	 p8dDeLXagyUZchPwsMW1y0flu/isCuDKDErp2DMI=
Date: Wed, 3 Apr 2024 13:52:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, linux-parisc
 <linux-parisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Mel Gorman
 <mgorman@techsingularity.net>, Rik van Riel <riel@surriel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Arnd Bergmann
 <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: sh4: parisc: asm/cmpxchg.h:60:24: error: implicit declaration
 of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
Message-Id: <20240403135205.7673001add2216e63db02d1e@linux-foundation.org>
In-Reply-To: <CA+G9fYvUwyf-5yB=xZVAPXrF3C9z==7bbhDYBnX9jdJ1PxzPnQ@mail.gmail.com>
References: <CA+G9fYvUwyf-5yB=xZVAPXrF3C9z==7bbhDYBnX9jdJ1PxzPnQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 13:23:23 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> The parisc and sh defconfig builds failed due to following build warnings
> and errors on Linux next-20240402.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> parisc:
>   build:
>     * gcc-11-tinyconfig - Failed
>     * gcc-11-allnoconfig - Failed
>     * gcc-11-defconfig - Failed
> 
> sh:
>   build:
>     * gcc-11-defconfig - Failed
>     * gcc-11-dreamcast_defconfig - Failed
>     * gcc-11-tinyconfig - Failed
>     * gcc-11-shx3_defconfig - Failed
>     * gcc-11-allnoconfig - Failed

Is this a new failure?  If so, can we please identify a suitable Fixes: target?

