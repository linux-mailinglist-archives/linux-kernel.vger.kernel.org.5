Return-Path: <linux-kernel+bounces-135375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546489BFA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97F1F22291
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E827442A;
	Mon,  8 Apr 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cJHGSwof"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C056F53D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581026; cv=none; b=cswn/7MeFKvTE6mDpCQmEBNUlIRsRbARds5iBuv+AOfKS9AKfABEG5/JGZb6+os9U6Y4ohQ7y114x/Wf8YCxY6bAbztkMjPkOak02swiLTgenA1NcM5QKZ0HRDIKciLTRI9gGk83aM7VtyGYCNakVmcx2Hi3R4g/kgvzFbFZcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581026; c=relaxed/simple;
	bh=NX8c/VEzlABel+cb+UVbVM0M8txNezi7QBogQFWuPcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2kOdtJJBuzDB4p4nmEBTHvbRycT1DhwDEHsuNRaV25wsQdMNAbKOxTHOQ8jRIMTkXDap/nd5jTkEu32a6Xcg8vcf23KsjvKPPN0ttdE7MS3RPy/+9qZeHXqPSBMofBQ5eZwJYiL7xm8jy0WQdQPp8TebwNKb0FYg2/b/ngZMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cJHGSwof; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712581022;
	bh=NX8c/VEzlABel+cb+UVbVM0M8txNezi7QBogQFWuPcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJHGSwof0rF7TySUFssqZe/IaEXByAiXZhM5qNHVmzo4lyYZD25Y+Ls+0RxmE/FEn
	 IvTnlX7Z4MBLQvE6if/WaZCoSmV1Lgy9RJ6AEnVh+yZ1xvtyC235eNPc1UQZ98E0nQ
	 2lotIsRMG6G0eIvvsL/wiiPEM8oDQeB2NwLw3P5f1OsHkFT8MQirKPX6txq9yAylDr
	 G7ch2ULxwrxfq40dL3Gx8wMtamM9Gyvqd/Az76luDxrgx/asI26usymfpyDQ35P2Ek
	 hgP1GN7pK2kgLRrZ/9v0IVqVaQHQj1M8TxSwatehHFsNKHwtsS6uc31jYbn3VWGT8F
	 S0sQt7NpLHK7Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D1E783780016;
	Mon,  8 Apr 2024 12:57:01 +0000 (UTC)
Message-ID: <1486bf40-a797-4651-816e-85bbfe22a809@collabora.com>
Date: Mon, 8 Apr 2024 14:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: select CONFIG_SOC_BUS
To: Arnd Bergmann <arnd@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, William-tw Lin <william-tw.lin@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240408125506.1594257-1-arnd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240408125506.1594257-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/04/24 14:55, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is needed to avoid a link failure:
> 
> ERROR: modpost: "soc_device_register" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
> ERROR: modpost: "soc_device_unregister" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
> 
> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



