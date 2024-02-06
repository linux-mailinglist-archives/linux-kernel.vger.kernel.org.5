Return-Path: <linux-kernel+bounces-54600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897384B165
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2301C2204A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8699E12D164;
	Tue,  6 Feb 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JpKBrn/1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623D12D144;
	Tue,  6 Feb 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212174; cv=none; b=unF727G9+jNG4iG3D/5Q5PmmhCb98Gj3dfkqkHz4lEPJTCo/LW2Q5QtxeTu4KC9rFm3g/JsY6ycOJcI/Ojekj/UNWT8K/TzTBn8wacakW8FW2RO0iKTbngR3qx2el5bWllPfJLXql5+nsTxV8gXd2ztBcpH87Yvn9t8hfQJNkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212174; c=relaxed/simple;
	bh=NhbpdPDBmnVFx0EVPpJONGSyWZuJoDuIStBqdre5bZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJYkAEwDE9h/83n4NsQJgXT1bTrQtXh8+ReTSc03AqdcI6dGsiNR3S6Moq+H9nxjAa2vnBd0NnFz8ydIBVxnp1S+/dDb/W4MDHaRtMmBXeuWgDqeid94P7s0Ie2fyDYH2gMoMnm553ckMgT2UNlLxZIPo+2su2uWlR3E0CqBNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JpKBrn/1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707212171;
	bh=NhbpdPDBmnVFx0EVPpJONGSyWZuJoDuIStBqdre5bZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpKBrn/1t6RP4RVGRisa9V+YNBr00tokMKCMNHNE2yFCUdViyJY71ZjW/LbG8ZwS1
	 dSvr6OAlmkM3y54zH382SGdcS50P0Ka+KJkplyDKddVe4vLDXgUPtGTsPXPQR2qSsk
	 fgO9UeNEsDuULd91k49NQdzj65LJAnPKG030v8cAnBD3Jb9LELJfyqMNO4XqCho1wg
	 WjYHl+Ae50GJsHFkhP3OWb0WNskhJRe2X29tfsgA+24tCJyChAGOw0Xz2DXtgm/DV5
	 esWe0vFvn4/IIcfk5LbzwiHAPruQRW3+0JOkS/CBNAk1pAcRUp6wgvO+er8ktl6fFx
	 14UX3rsjxEyhQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 706E93782039;
	Tue,  6 Feb 2024 09:36:10 +0000 (UTC)
Message-ID: <736ee63e-a066-49e8-b1fd-62f0fc665389@collabora.com>
Date: Tue, 6 Feb 2024 10:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/19] power: reset: syscon-poweroff: Use
 devm_register_sys_off_handler(POWER_OFF)
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240205194437.180802-1-afd@ti.com>
 <20240205194437.180802-20-afd@ti.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240205194437.180802-20-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/02/24 20:44, Andrew Davis ha scritto:
> Use device life-cycle managed register function to simplify probe and
> exit paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


