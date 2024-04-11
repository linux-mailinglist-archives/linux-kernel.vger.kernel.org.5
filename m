Return-Path: <linux-kernel+bounces-140072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66A8A0B18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F715284E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2F140361;
	Thu, 11 Apr 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9M8nzaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B613BC35;
	Thu, 11 Apr 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823863; cv=none; b=jA6xZL17sqzWBthlihVQEToeoDyEfUcD8bY0VmM8wKlMHAyMo2Igd40+4pPYNsBKjEwLYao/bebCWzft8bhus9ClAdHwPxiXuI6JkyHf1XWGSPqb4jCmXgWV6f8hkbZkI8fs+Q7L7BPpoqI4oVw6vO3n0m8GiIHkLU0yQZNSSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823863; c=relaxed/simple;
	bh=OTteXj13ozPvpXMPgkaG4Vll1Z9QS6hJCoj/YemDNOY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dgNmpZJbRka1ctFTLdgOiLsX994G58r20cfns69oxPeGi7ylcxiujeUYhF+FQAcFxC5/hmAgewieibIzdwx/DXrzE9J+3OhCKv/CqupHUxNIUyiLzcUA/O98qcS+iNkpjRqgyHqKYzeUJ5gKIzkf78NoTcml8BpDK1w7yPQl4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9M8nzaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD2EC433F1;
	Thu, 11 Apr 2024 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712823862;
	bh=OTteXj13ozPvpXMPgkaG4Vll1Z9QS6hJCoj/YemDNOY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=i9M8nzaUhMf5WeIHnKp+719OymyObxb/WOq0n/Uejh0zLigQNSujvF590a6jf5ocb
	 6rD4BqU2Vd9Zn2KopqCZGcj++AyIlq4vSstQHrUHQhcWX0B0WN4Jcscyl6T721Vk5E
	 FN0g8ALqsawJJEgntx60mavbPcXbYNLOmbxnmHHvvTEONUXf7u22NkmV2oz4GGmOOl
	 XQ3bkZr/VMI7zVk6HTgYeWkpyOd2YtYRQeK7AZjM+83fjfR+5gZc0I85v5any7KmbQ
	 XBgjOhupJjyO8yNNntKIe793EIThNwELEvY5BpTpAygokftYi19UpVllUZRuiRyu+7
	 +pzxuRjX1OiKg==
From: Kalle Valo <kvalo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Felix Fietkau <nbd@nbd.name>,  Alexander Couzens <lynxis@fe80.eu>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Ryder Lee <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH wireless-next v1 1/1] wifi: mt76: mt7915: Remove unused
 of_gpio.h
References: <20240228200321.3607764-1-andriy.shevchenko@linux.intel.com>
	<ZhbOEqO4BIE4q7Vv@smile.fi.intel.com>
Date: Thu, 11 Apr 2024 11:24:18 +0300
In-Reply-To: <ZhbOEqO4BIE4q7Vv@smile.fi.intel.com> (Andy Shevchenko's message
	of "Wed, 10 Apr 2024 20:36:18 +0300")
Message-ID: <87o7agz4r1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Feb 28, 2024 at 10:03:21PM +0200, Andy Shevchenko wrote:
>> of_gpio.h is deprecated and subject to remove.
>> The driver doesn't use it, simply remove the unused header.
>
> What should be done to move this forward?

It's applied to the mt76 tree:

https://github.com/nbd168/wireless/commit/b648ed2b4645e9cd0285aba576cb6f800c218b30

It will come to wireless-next in the next pull request, usually there's
one per release.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

