Return-Path: <linux-kernel+bounces-55437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C395E84BCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5725A1F270B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047B134CE;
	Tue,  6 Feb 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+O0Rjbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDB134BA;
	Tue,  6 Feb 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242863; cv=none; b=hgxtRp336v5o/5LmERdHdy0cEmeATmnZqLu+xI87FkeFHGVbiIRtidupjbBYSN6cRnZPF78dPEB8qVHGWeHR9khjP64IF0MANxKAuB5fFelgnQ/pR8Rs59cBIIfvdYvEJ14bkImyrV4tenkoq3lAjQDK2q5M5VlAsEARVg+dI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242863; c=relaxed/simple;
	bh=vD0CmOu+sAgwUV0GLvAVUrtz3Jwk26LsOTDT0zBWy0c=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nQZ4hQ5v0fY2dotuqrPVWhDt9XPzSWj0d9BdnDdswFlf0xgO0Ly/QaUKHTVDXZBGaWN7xu28YKyeonxdeWB7Uh91fAmOF22p/tAXC6AagsoFi7CVCnKPGKMja3uHoSBBH9Tz2ixs08ENAAA/ZuWX+1UAUq2neH4fWAsPe5HmWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+O0Rjbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD2C433F1;
	Tue,  6 Feb 2024 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242863;
	bh=vD0CmOu+sAgwUV0GLvAVUrtz3Jwk26LsOTDT0zBWy0c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=u+O0Rjbw5SWfBdsCBJj5dlPAB9oX1PJreQJLDRIpKWUNfDJ6ZJMzIxmKc6z+Lh+qc
	 okwCFsNYJHyRlcKqfdsm76F4lg2fvLpzq/iY2rEfTvr08nOghVzYM8+RIrc/HYDfpX
	 2jVDh6isBFbKNIWKYRjGDQZVOmMPVKc9segMCqHYt5yxwMXCGbHu2r1PO8ugQeHl1d
	 u9zFcaLTbdhQui/p99aFuvoFysCaux9iv96xpZkApPM8GuxZSRP/FAriIowRXkUUql
	 zW5x3s0X5wUjodEBXKbNlJtrq6AdIftmy7B/kejeBMEv/FjRA3CiHd3na/XjMXfhsV
	 CZvbZJPdYDeiw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: make bcma_bus_type const
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>
References: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724286035.1979906.4352709916781759904.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:07:41 +0000 (UTC)

"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the bcma_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch applied to wireless-next.git, thanks.

06b5b2942cf2 bcma: make bcma_bus_type const

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


