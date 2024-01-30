Return-Path: <linux-kernel+bounces-44490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248068422C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644D295F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032F6773F;
	Tue, 30 Jan 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NzQ1dUL2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2C67730
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613345; cv=none; b=q8pSPtaQTPOM2006oFfAiy8wet+yrdWFl9VZsUdUml3QpLYcIIqS21lwUBOMKIdflcLK2SzCkc2TPvSfGxBQGBZah7aggDPHwhBPIWB2bE5yl0gFTf4d6n77pn0EVJDJjya42TrdTfPDokCjTk602h7bKxFwzdte/IwFv1QNdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613345; c=relaxed/simple;
	bh=Ui52xWIkaVO5Fw8DIIJWouNt7gfaHvstMTUCljysJvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcCtA6MNNOn05Wvb2ZuCDi0mzhq0bDj1YKdIx2Z1fY1wlRCqrOdruEe+a3qIhbks1oTUf6wJK5tuunbCQREgsA3xYfVfJQMJ2Uh7C6FI1LhBgK/G9PDLSJzXqZAKWG4X0e1go7B2WEGmr4hb7+QyhdGF2tj41vCiaDCzCF1+/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NzQ1dUL2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613342;
	bh=Ui52xWIkaVO5Fw8DIIJWouNt7gfaHvstMTUCljysJvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NzQ1dUL2rQjqP+79snNYiqWVKdtyNEFWLMDGzz9G/EZUFJvOx7LrS9Kp7XPNJh4EE
	 O0MFSK2IJJ8LtV6g/iiXIweBWy4JJOat51ncsA5kZuWglBbPeobxMZqBZl+750NPSs
	 vT5l12neAtKQmmXZtx4MVyXaIlvFecZR3DC7aCQgrn+FUytn0n4Bhw44n7iHvZO3Us
	 7pBUeUgJcA+aA/qMcFb4S0BhUjfdN48/PRFdpTtAG/kJ/V14DXpr1q6FuS89x6wmy0
	 0yTYgJenvj3GoPaSK9CUttxehr9RXkCgWCv31JEZ3wES7qzQ4ocqjR0/T5UWZ018wX
	 UxHPj6SJAJwEQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB8393780FC7;
	Tue, 30 Jan 2024 11:15:41 +0000 (UTC)
Message-ID: <3eb512ec-1c50-48ab-93f1-6c783b5e6e48@collabora.com>
Date: Tue, 30 Jan 2024 12:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmem: mtk-efuse: Drop NVMEM device name
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 William-tw Lin <william-tw.lin@mediatek.com>
References: <20240130095656.3712469-1-wenst@chromium.org>
 <20240130095656.3712469-4-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240130095656.3712469-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/01/24 10:56, Chen-Yu Tsai ha scritto:
> The MT8183 has not one but two efuse devices. The static name and ID
> causes the second efuse device to fail to probe, due to duplicate sysfs
> entries.
> 
> With the rework of the mtk-socinfo driver, lookup by name is no longer
> necessary. The custom name can simply be dropped.
> 
> Fixes: 4e6102d60d88 ("nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



