Return-Path: <linux-kernel+bounces-71307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D385A337
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31921B24B45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776432DF9C;
	Mon, 19 Feb 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2QX/h5dE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505F2E832;
	Mon, 19 Feb 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345734; cv=none; b=DL9LN1UhO8gd+iFnB/YbXYLnLM9hn4ypB01NT4kZV70rHGe+5xxNpNK+JHdIsrFrauZKqSkqvk6ByPSXVs31NSpz7sTKiFa/D28abO2ewDh15wOMQE0lli9PcZc5wW/Qdb7s+5HZFChed1m4PjeHC1M7ny15swbdin14g5iZtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345734; c=relaxed/simple;
	bh=ldtcDeRxUwJgADZNUFjdHdosag5VORxjVngR/8kNA9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9vIp4HZG7HDHjVarC0OyxrkGDb7PWlcTMp7bE1xB40ZCZO4UqoSk7tHUuecJZNScj8R3ALKhIz2A+q8Q9UEwLA8fgxrrki1TC7W3C6SrQJjK1p7fMD7sxl6eWFNH06rMVouT1y8lKHIYAovg/eveVWKtYh8ZKVNSFG0YIQzv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2QX/h5dE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708345731;
	bh=ldtcDeRxUwJgADZNUFjdHdosag5VORxjVngR/8kNA9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2QX/h5dEf+sZCPTssHqe4dMsez1TlRUdreDjiL3PuaWPku2qKDhgQiv6Pwnea66Tz
	 zlV8hy+QUnQKLwTOMpVz3Oopr/+x+hnCUEAoBJs8C7jQ0KJBXGfSKUa5lzGMEWiBrM
	 5Z0XZLYbS9nw5r8oo3ktPzlQbOI+OFqZgQiOC7yYi1b4ebBs76c4CpXJMo2SC7ZsrO
	 4cvj5Hfuu63NY2ulHS2EN3DJgEXdBjEHauDSvJ055yavjB/d9HEWgK9KqGb9HhaBun
	 V71hk03C/hdk1SeNTor0NWPmCWrj3ei6zEe0ZOV0FXtiCPgtEIa+RrwykipBUeY6zF
	 HKd3Pq8rZJ8fA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 84BA43780BFE;
	Mon, 19 Feb 2024 12:28:50 +0000 (UTC)
Message-ID: <adf70c16-f1dc-4f01-a331-b0cd975a4c42@collabora.com>
Date: Mon, 19 Feb 2024 13:28:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8183: Correct parent of
 CLK_INFRA_SSPM_32K_SELF
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240219105125.956278-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240219105125.956278-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/24 11:51, Chen-Yu Tsai ha scritto:
> CLK_INFRA_SSPM_32K_SELF has the "f_f26m_ck" clock assigned as its parent.
> This is inconsistent as the clock is part of a group that are all gates
> without dividers, and this makes the kernel think it runs at 26 MHz.
> 
> After clarification from MediaTek engineers, the correct parent is
> actually the system 32 KHz clock.
> 
> Fixes: 1eb8d61ac5c9 ("clk: mediatek: mt8183: Add back SSPM related clocks")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



