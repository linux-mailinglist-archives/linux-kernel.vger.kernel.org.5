Return-Path: <linux-kernel+bounces-44146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB7841DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E7C1C27A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF985786C;
	Tue, 30 Jan 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QQ1m6SLd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D856745;
	Tue, 30 Jan 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603778; cv=none; b=ahF3XF43pVE4L9UQIOEvihgzAUtHuyRBZgBkUIUeV2Rhu+cn2U0vy96sEw2jtMdslRjiypJCzBBE/hw+Hd/xpbJZEU7fZ8gOpwKmBRBtF637kW/+FGMW8GbzqQSR/1IZ678ZRWAnSubqaViuYvWNHHcPrVGqKGqn8HP+DgylF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603778; c=relaxed/simple;
	bh=DPzX8bKF/2fviPf/M2liuaua/0lWQdiOsoNEF2zZ3Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyvR1QSRvLkFccH49Zowt5iFuJDUXQ37xT7KQj9soJZ7j8nrJ6fG95OVI4CftJ2cRsgYMhtXZ3U/c//U4LQJY9A5MN2pgtHybnTNRlWwMlHVjtTtmo+B1CdbIwQtensIjoxoVIiqNmGtEmC7Y040xWtM2gaMhACnlrdfn0VItUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QQ1m6SLd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706603775;
	bh=DPzX8bKF/2fviPf/M2liuaua/0lWQdiOsoNEF2zZ3Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQ1m6SLdXWukRY/jHpuZaif7HrnumJY0OTOjXsU4HwmzLA3WaO7HtRytzJIcqztxu
	 koxbBQ0E6kh7aVFy7PPw1ge3SKfXXR8VDKWego9QPPuQ2fKSDrCtjgPUUp1UcFG32C
	 oA2Tockeh2++BG9SmsF/1MwNOPDLObfrl/qx9/CNaYnWDA49kvFxSU60zEqI9syhcy
	 gGR2kQL0NT620VvFoARvoUNH0gZW87uTu1No8VUCAz5xcLq3uCFhAEMZpGZTxxqs5C
	 kAIm8VFh1p+boVdOMCuLXq0SPgXsToceRwMLTKSLFhtfBkJhq68lGKf4d8ViFpqvuT
	 JYnJaef/wSMug==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 885273782076;
	Tue, 30 Jan 2024 08:36:14 +0000 (UTC)
Message-ID: <46c05b42-dfc5-439e-9dd2-9c115199ff5f@collabora.com>
Date: Tue, 30 Jan 2024 09:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix a memory leak
 in an error handling path
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <481d345233862d58c3c305855a93d0dbc2bbae7e.1706431063.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <481d345233862d58c3c305855a93d0dbc2bbae7e.1706431063.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/01/24 09:38, Christophe JAILLET ha scritto:
> If devm_krealloc() fails, then 'efuse' is leaking.
> So free it to avoid a leak.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



