Return-Path: <linux-kernel+bounces-36663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5059B83A4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C6A1C2241F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7DF17BB7;
	Wed, 24 Jan 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l29n1LNa"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A517BA1;
	Wed, 24 Jan 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086648; cv=none; b=YavYB9vrAqOU+BD0rkjzxqd4BatbcRgm32eSyqw+/V0WF0SJtrB88pPaIWCjDiWnLbgg+apRB6TpgMYO8xgm2CiMF777IozSQ4LlnmHGDGd4p/SNG1s3txWgfL85y/7olbb2Uw/TR70L3hMybIB2vqQA49fElKUqobBaeymCl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086648; c=relaxed/simple;
	bh=mv/7ewEA4l7pAVBAP8biUVLUr2QSV9pQKC7zQv+hEQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVdFl4q9k52ymHBvgsXNdK2ip/Mykh/ihT2tNREeHXnT7elAM8iGLgzNCVt+a1CieWY4GGbDVDR8blZBHr+JOLKhFNZKtn5K4IO2Nv1tTQ2EtaMncJQWxZCKTB/8el2+dKSOgUkX/NrStM8LF3OVop/sg1M7sKyN3GO7m5uMXY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l29n1LNa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706086645;
	bh=mv/7ewEA4l7pAVBAP8biUVLUr2QSV9pQKC7zQv+hEQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l29n1LNa4UC1tyoaI2ZVW6ekOax3ozxHbprpCoveeOUHpLNpPcK1uDNawsVKXqpOG
	 FKzntSiTGRWcBsWdfGNjbo4doYTt4uFd9GNFeGDcp5IDGryVZBycZYzGFYr3brvMRx
	 tW1j0yuv2fP0wgXojS/WkxRNhAL7u9D2OcY1NZUfGkDgkTh5g8MUxXRD+zhavi471c
	 GTpoWaCp90tz5/5nD/6wsX9jiwwuxRXUD8jUfteBWaJOTwC8pq5h7AO4xWEfOK3bsh
	 PJIuxAKVQX3bRFPA89SwaCTjKj7/XnFA3eSG3ty2zFn62Gv19nQaS3ncPxk7cam7XK
	 inOcYNx/epBlQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C692C37802F2;
	Wed, 24 Jan 2024 08:57:23 +0000 (UTC)
Message-ID: <f91d3ac1-0a7d-4ca2-bf0f-c5e471c2f6bb@collabora.com>
Date: Wed, 24 Jan 2024 09:57:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20240124011459.12204-1-jason-jh.lin@mediatek.com>
 <20240124011459.12204-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240124011459.12204-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/01/24 02:14, Jason-JH.Lin ha scritto:
> Add mediatek,gce-props.yaml for common GCE properties that is used for
> both mailbox providers and consumers. We place the common property
> "mediatek,gce-events" in this binding currently.
> 
> The property "mediatek,gce-events" is used for GCE event ID corresponding
> to a hardware event signal sent by the hardware or a software driver.
> If the mailbox providers or consumers want to manipulate the value of
> the event ID, they need to know the specific event ID.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



