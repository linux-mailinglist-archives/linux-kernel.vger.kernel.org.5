Return-Path: <linux-kernel+bounces-36664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FBD83A4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165E81F22055
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB517BB5;
	Wed, 24 Jan 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GJ/V/n9+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67D17C61;
	Wed, 24 Jan 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086682; cv=none; b=E187ZFl56TbykUfi793NZEtYlP91HvXlN9hniEVdEK9cvJqmlbTMf70ET2lRa5lxH2inqOaHh5iaOfdugnbo5p6B8wyMqc5essnmr/aA5T/Sc0laY94m9x9B4sp1bOhWsmeKUltZ/QPm2sqL/mqKM85CBFvgqVFcVseEiteB3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086682; c=relaxed/simple;
	bh=DxcDpKLmIS5x9C8j3sVwB34LceUIhcJpP8hPAp0icRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5EE+iw0J37HiXd27WImBX4PDaIhFidlzODsNRyeN6Hyvbu7whXMVAONF9ABZvNKhBpqprH4+JOKUCXdN+vWbO0ZAQYF85FtD6DqRmfk59evCObK7H1V0dI+yWd7S4Ut2eyZZ0g9s2eJTsCbLALefSumKIpRal/y3GhCyrqq/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GJ/V/n9+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706086678;
	bh=DxcDpKLmIS5x9C8j3sVwB34LceUIhcJpP8hPAp0icRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GJ/V/n9+L10m3msD+8IihP3z8WSWlWYz50CFsOgYZJIvVKAKvIlXIECU39pE7gwg3
	 F83hzM2GAUwGahvJMjty2HVLdiDpmYK7QVgcuBL4NSleoO4cZ1B7jYT2MO8OyBNPiV
	 C+MZbFRx6FuM/j+4Q9nIBf5RIJRr4a+U2FpXB1DzHL6LYQsNL1f9dO4WnwXh0Aa57D
	 CfnBmeDTM9ctBehYivow1KyaPGUThoMuSpujq+3srvAV8umH4reTztiPKW05i+A+40
	 EiUrthbSSiMjXajTDOIvl+LDnu7eiH1/LWWlTxt5Y3yJCuei1Y+MLuJJuxPpIQTLdJ
	 AzQy/hy6xyf2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8840537802F2;
	Wed, 24 Jan 2024 08:57:57 +0000 (UTC)
Message-ID: <0d11d506-24f6-4f1e-b0de-1d229988545e@collabora.com>
Date: Wed, 24 Jan 2024 09:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] dt-bindings: soc: mediatek: Change
 mediatek,gce-events to refernece
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
 <20240124011459.12204-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240124011459.12204-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/01/24 02:14, Jason-JH.Lin ha scritto:
> Change mediatek,gce-events property to reference mediatek,gce-props.yaml
> instead of defining itself.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



