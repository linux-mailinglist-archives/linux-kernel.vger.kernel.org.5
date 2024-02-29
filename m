Return-Path: <linux-kernel+bounces-86340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB7A86C41F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A368C1C22276
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC055784;
	Thu, 29 Feb 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="380yPiqQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98853E23;
	Thu, 29 Feb 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196481; cv=none; b=ZFo7Gg0s7zowcVFzQayhN50gc9fgGwgPpQ2dbnz6oflYNO0FXhWUgGe9A/MqeAFg+ddou3G/luGmBWQlJB2kCrZSGbJgBV4ygELzNcY21NdLam7x+jWcKlrc9kXQ7enB7a0ZSU5NELGngmkEi6Bxk2h25m5Vwhd6uVHVVFBJohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196481; c=relaxed/simple;
	bh=mmWBDdhK273ffFAgPs7rWmE/50GwPeyqlWRJZXegMnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZT0TPG0GmbVAWKFrku6lRUbFJE5hX2HvDBwbDk9dmq3ck02zqh785dagGiRijAiAnkm/bXXPnRs6qzGKdzMq7A/jdb3MZ/i88MRIRhMdUbTz5/TZNAr8ShVZX4sLececeUU7PEh3vrMwx2OW18aNeIPSUAHoOFzX6ZJCUAi49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=380yPiqQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709196478;
	bh=mmWBDdhK273ffFAgPs7rWmE/50GwPeyqlWRJZXegMnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=380yPiqQqqJKDZt0x+KbL2NbQ+iLD/BrHgNvaRrn5G2TozHwO2ZAvEyjIBOajnT4I
	 cdrMf8rpIL0zKbkoCWzQm8y1uSl0nSfN9NxGhirZ4IuaJoUGAGj+UmNM5is3kEF/dW
	 PFFTiv4J9LmmhsM7mfSz6pJzTW328bLnxgAYNzgdjln59757yKiInEKRi7FWQW7Nwm
	 PVKddXN9BVtcvAoMhpQXKg+JJb1z8DH7TIQvzYk+/90yVfHliWZNjoTaUPM0lrXyzZ
	 nFjDSmsSRgYM/6S/zPAlIBM712C6pfRaBBPjpHJRNE3jJC59l0djzSXoEmW5kYntXG
	 CP6Pgjopfnhtw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA78437820DD;
	Thu, 29 Feb 2024 08:47:56 +0000 (UTC)
Message-ID: <96fafea3-d5ff-4568-a026-03d870b9f109@collabora.com>
Date: Thu, 29 Feb 2024 09:47:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: display: mediatek: gamma: Add support
 for MT8188
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
References: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
 <20240229023522.15870-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229023522.15870-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 03:35, Jason-JH.Lin ha scritto:
> The gamma LUT setting of MT8188 and MT8195 are the same, so we create
> a one of items for MT8188 to reuse the driver data settings of MT8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



