Return-Path: <linux-kernel+bounces-140224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00E8A0E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945DA1F21629
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EFC145FFA;
	Thu, 11 Apr 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX0H73a7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B9144D34
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830225; cv=none; b=po7O9/c2ev/8IZ8qUcgoCbPw+1FqUiAO5X5Y0bgpBxcBJ2WFqvWdhZIcSSzOyZGQlXYjGfnw9vVG6PD4wqiWMbHVao2HrSLpMI5mWdjNXmX8kpEHkSf6HCTtXQNN2SqhyygMNM2iRgSL9byQfcUB5s8YV0AKY4PhF/x/bwmZuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830225; c=relaxed/simple;
	bh=xwwRJ005fC7exc9ZgABH3FR6inUw8ZqVBxka1vwo6H4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y3f7Ig34AIT2g0j6A4X/nfMqa8JKUSOXmQmOCqjp+8duPJOGxkCkknrzrkO9HbeQo2S2YqARG5t5iUVosHq1HYBlEcpmp/4wqczjooqsqDklpr4C9U+R3fmwobD4XbCYokwnMzAl2W6UJuBcO9XpG+NcmFB5b1nRnl8Q3ZWWfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX0H73a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A7CC433F1;
	Thu, 11 Apr 2024 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712830225;
	bh=xwwRJ005fC7exc9ZgABH3FR6inUw8ZqVBxka1vwo6H4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TX0H73a73dvw3EGgbXtiTg/YYI5fVALHeMn6G+yUpQaNiftjPqVAK0wiGVXqbu1ly
	 H9Ooryj4iuwottr9Q0QVer/gVolO1kjnz4WUD3abQhKiI9v2VXs8sX0Sds3apg+IhU
	 I8q9rBQoXC/hhekXe6wQZWw6ttk8jBUUhYk1MjuuHxBfkyctMJpnNMBSoV2f789dES
	 LH7ou8/0vcMIVjiYW537M5DhKlxrv4CJff38qJg8P/6p27TOqHUhFl4kk7aTfi8JAg
	 2AhoBvHmkzcUqxCqsPD6nbnhI//CCaRcnDn5llCxe4l4xdNE6Aqj9xlH9/TzH6y1M0
	 wCyUvys3nBbHw==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>
In-Reply-To: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-Id: <171283022409.2001222.8782257923411409519.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 11:10:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 23 Feb 2024 21:49:49 +0200, Andy Shevchenko wrote:
> Just a set of ad-hoc cleanups. No functional change intended.
> 
> Andy Shevchenko (6):
>   mfd: kempld: Replace ACPI code with agnostic one
>   mfd: kempld: Use device core to create driver-specific device
>     attributes
>   mfd: kempld: Simplify device registration
>   mfd: kempld: Use PLATFORM_DEVID_NONE instead of -1
>   mfd: kempld: Drop duplicate NULL check in ->exit()
>   mfd: kempld: Remove dead code
> 
> [...]

Applied, thanks!

[1/6] mfd: kempld: Replace ACPI code with agnostic one
      commit: 2757d27d24b6c92b2476caaceca1e2666b0945be
[2/6] mfd: kempld: Use device core to create driver-specific device attributes
      commit: 28a8ad605b6b5819514467da6925b2e5b3f77c3e
[3/6] mfd: kempld: Simplify device registration
      commit: 3f3f569bea415066618f9680278f26d341ddf23d
[4/6] mfd: kempld: Use PLATFORM_DEVID_NONE instead of -1
      commit: c1a0b1194c5e0a5c2f027578439fdea009275bf9
[5/6] mfd: kempld: Drop duplicate NULL check in ->exit()
      commit: bb42768bd22196976acb217d1748b37ea55f8f3a
[6/6] mfd: kempld: Remove dead code
      commit: b89163d2e1235677f766895b596b3cd7447b69a3

--
Lee Jones [李琼斯]


