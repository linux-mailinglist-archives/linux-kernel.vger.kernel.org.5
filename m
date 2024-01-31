Return-Path: <linux-kernel+bounces-46121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED64843ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1161F2AED7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F7A69E0A;
	Wed, 31 Jan 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dzzx9yYQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68169DF7;
	Wed, 31 Jan 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692510; cv=none; b=e7Mi38USAgdyHCX/iQ+isiOINoFtdEXxsMgh2TDhRaTxc4IIxZ2LfUj7smhqog8j9ZWiESQQfcahP1qMnsZ6yf0b1gnxVpmoFMl2jo6F6JF3gp2xHJDxHRY5cCPhUC70FMKG7nBkNofP0CUb4qkpIiGalKX96aN/Nxmg+gjCt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692510; c=relaxed/simple;
	bh=vw0BizcmVJNTech9k7+lv72FT42A03VfqewLKVt57OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nE43dBSZHxRhA9CDUfLosPJInW0C4nHTHKQZf5RbnW7fELcYVloZCc7yXjH6PEyAg+MelWaV3HbBbB/54fU+R7uGSZVDvejuJ6dkyTw64Pub7Nb86kfRpPKo7ff7PqfdMKqDGtM5lf6U/DIDkdQrVuriLoL6L2/Jo8hn95B/sYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dzzx9yYQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706692507;
	bh=vw0BizcmVJNTech9k7+lv72FT42A03VfqewLKVt57OA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dzzx9yYQ4NlDZtjv4Hu8j/wZzNHep086PNouK99Ho4cO1aS+eamCDsPhOocwVyKTe
	 1GIYcHymsvTIWw5VESooTY3CxJedPoIctFhMtFfStgJWx/25rQwUm1r1q+No1KdY18
	 qd6piQZKdOTjtyxb+ZlM0/U+NS1MSYY2Zr+DHpjE/zLUyW686CZ2XEbBc05qYyuEO+
	 MoBiF29I8GO54NHyyLrBBiKp/zQWxpnSJ3Df6qaMS4HcOVqgdLsmqlVZrp3jkRocWm
	 +sgQ4YkvDs6Cl6nirmdpPnpQUuNG+WRfOQUSFFajHyD2vKm1JELKt9UWW1AiKXX8pH
	 dDX5vJCKIKKwA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFF2E37803EE;
	Wed, 31 Jan 2024 09:15:06 +0000 (UTC)
Message-ID: <1a94706f-b814-4993-b495-40d3fc019abb@collabora.com>
Date: Wed, 31 Jan 2024 10:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports
 node for anx7625
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240131083931.3970388-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131083931.3970388-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/01/24 09:39, Chen-Yu Tsai ha scritto:
> The anx7625 binding requires a "ports" node as a container for the
> "port" nodes. The jacuzzi dtsi file is missing it.
> 
> Add a "ports" node under the anx7625 node, and move the port related
> nodes and properties under it.
> 
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



