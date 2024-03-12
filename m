Return-Path: <linux-kernel+bounces-100381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D17879696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81817B2360F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174D7BAF6;
	Tue, 12 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="foMmiKTU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAE7B3E9;
	Tue, 12 Mar 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254511; cv=none; b=LSqWY3ycG8o/SdaI1FNOZ4kc3v/FKMc3ZsIfPgzxzUsZkH8Fc1hFS3TQGzxm5qIhx4FIfe0tv2cOPaechFkiE+jWStMaHk4o1hsl0DDrgZTrUYfsSLTyiJ2rCHQuXZLTEWQgteCu1f/E0KGFQURdbghUCaLDH+9CDUx5vMWLJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254511; c=relaxed/simple;
	bh=pssySadyO3WsLSXVvrg+qLF0LevwN7Bf/tVt4wuz7w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmpCdlJQiRdKPeiYjB8TYxiGCtPcb1zUCF5jdnJ3eOpguC+Yd7BzQlWoAooi8VtpBGZF0HnFJ4tSCrfhOtiCzuAqb9p+1xIrk8tSxkrpyp/8KWMQAJqaVMs5E0sXofteHFnyRAuSis+dZNjGDJkgk9OYeFNyNxFHCG4/RxvmYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=foMmiKTU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710254507;
	bh=pssySadyO3WsLSXVvrg+qLF0LevwN7Bf/tVt4wuz7w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foMmiKTU8hq/wbrY693jOUcmZy2mKImlR2N3aYjOVMhGPspKUfLIDCIP6zdTI6VAw
	 oLisdD2XTMJzC9dEJBaqkdhXf30Odio1FfAEoFs9fU7SHsuq9GZ6ZI8JVvqUUUqXE0
	 nrwju0vt0fF0JyVggj55KoiwNKy/Ox3Rg0e6LyzRGU+9GGYqqbUOck8jwVOkIoY4Gz
	 LXbQCy40+2P7SO6scg4aDFnjnHrQAdIar5cUfVTnZwqYVdmQZGlt91nWHJ2qbhYHbX
	 cC6ZwaabYKDsh7B0P7Sv7C9vRwH3ODIl0tjARMnfc3jsoUQTUYSeZQcLKQY6yeq6zB
	 teTsUmm3lYdtA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E61637811D4;
	Tue, 12 Mar 2024 14:41:47 +0000 (UTC)
Message-ID: <3ec20339-b176-4d39-8cbe-4577a782aeec@collabora.com>
Date: Tue, 12 Mar 2024 15:41:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] clk: mediatek: Do a runtime PM get on controllers
 during probe
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Bosi Zhang <u201911157@hust.edu.cn>, Nicolas Boichat
 <drinkcat@chromium.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
References: <20240312115249.3341654-1-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240312115249.3341654-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/03/24 12:51, Pin-yen Lin ha scritto:
> mt8183-mfgcfg has a mutual dependency with genpd during the probing
> stage, which leads to a deadlock in the following call stack:
> 
> CPU0:  genpd_lock --> clk_prepare_lock
> genpd_power_off_work_fn()
>   genpd_lock()
>   generic_pm_domain::power_off()
>      clk_unprepare()
>        clk_prepare_lock()
> 
> CPU1: clk_prepare_lock --> genpd_lock
> clk_register()
>    __clk_core_init()
>      clk_prepare_lock()
>      clk_pm_runtime_get()
>        genpd_lock()
> 
> Do a runtime PM get at the probe function to make sure clk_register()
> won't acquire the genpd lock. Instead of only modifying mt8183-mfgcfg,
> do this on all mediatek clock controller probings because we don't
> believe this would cause any regression.
> 
> Verified on MT8183 and MT8192 Chromebooks.
> 
> Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

MT8195 Cherry Tomato - no issues as well.

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


