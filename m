Return-Path: <linux-kernel+bounces-144915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B08A4C93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573A4B21600
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29E5BAE4;
	Mon, 15 Apr 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CkssawNC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5A4EB20;
	Mon, 15 Apr 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177219; cv=none; b=Lo+Y63KaaeQbfsG1mHezlemGK1b7wZGPIOM2TRDq8+fmU5mc/TtaIPwgNF7bl01zWqa9q23apUdppXQROVK2jDfHhBOiib44Q3ovPTp8j/NV/Sm8TxKpf7Oq8JMkOVjYGrt+I1fFIJ/iUAdzjryJUVoGmDJcQoY+rRZcpWckcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177219; c=relaxed/simple;
	bh=W2hn6oSy7NPPiYXX+nat04fULWlvxHEI0Yi3NxOxZXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtdpdMBaXC+D88ks6RDgn0i1kO096imtmkFrvVflmNn/5dofVzTV5Gv4kOpU7knSw5G3SfAHUC1/tPHoBSQoEF8Jps7xhf+hcFMyyyIj0KH+nvWGE+WmNaL263g9pl6qxtodk6ZAaciAp95aipuoFwHEfEqvBP1o97iGZeQLJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CkssawNC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713177210;
	bh=W2hn6oSy7NPPiYXX+nat04fULWlvxHEI0Yi3NxOxZXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CkssawNC3pd5GY1wqRRvzB7farQ11Z1gI760kXcNFTT0vUPS/I/GNSJq+9VwvlF8E
	 28DHDATLAMbc6qC0k77dWf4FbpwBQo5yKYf3Smi656iwZVau7HC9tEWA+KipV89O0S
	 vLg7cBgrAqrD6rk+BjmX2oLiyLoEnZSQeslAnfXxUOzR5YO1X7O8ZbGrbbXfSBPll6
	 TDmYkzZwEX18qxO845f0b3QfR05aCjGvVBMJvwKi5vt37TWcX2BOEukuRwG92DX+NV
	 Q2VyoNRuMZgsgjmjHSwcVhW3JNIKA/q++1prxp5nja/9i+nYdEyfHfU2QkNdbah6TK
	 kjBOY9Wr7/HCw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8D790378000E;
	Mon, 15 Apr 2024 10:33:29 +0000 (UTC)
Message-ID: <f3deadf1-8bb1-422d-a7b6-d0e0de98484f@collabora.com>
Date: Mon, 15 Apr 2024 12:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui: Drop bogus
 output-enable property
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240412075613.1200048-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240412075613.1200048-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/04/24 09:56, Chen-Yu Tsai ha scritto:
> The "output-enable" property is set on uart1's RTS pin. This is bogus
> because the hardware does not actually have a controllable output
> buffer. Secondly, the implementation incorrectly treats this property
> as a request to switch the pin to GPIO output. This does not fit the
> intended semantic of "output-enable" and it does not have any affect
> either because the pin is muxed to the UART function, not the GPIO
> function.
> 
> Drop the property.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



