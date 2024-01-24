Return-Path: <linux-kernel+bounces-36665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893783A4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC581C22BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09E17C65;
	Wed, 24 Jan 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="apw6ogb+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CD17C62;
	Wed, 24 Jan 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086683; cv=none; b=T4vcS88lqfaLbPuEpNmFGT40pJ65HsbRBAFC4Xc6/VG3fqcJy/rFJZh+byHW15p9Qq11ws/e40LKEgi+zarD7dB61BzeUSi9Da/iPBUI08kSU1pVM73ultOkv4olJwcTs8pzLYPnTY1MMVE/TMNkz2kyHryMd2cJiKq1xSeKRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086683; c=relaxed/simple;
	bh=DxcDpKLmIS5x9C8j3sVwB34LceUIhcJpP8hPAp0icRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4nrGRNHXaqKcXsTUgUMfsawPqT12I9Sk73foPliNF0oQKvdOKcSOfFr+lKTsHv6S6Ll35HmCe/Bymnskfm7mXu/UrD+YWsY8AS1ioKGmgVadhNapYNs0N/qLY1tU79IpYWTVRF2/P74ywnPvm5QOHJodA39Bt8tEhmw0lV8On4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=apw6ogb+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706086680;
	bh=DxcDpKLmIS5x9C8j3sVwB34LceUIhcJpP8hPAp0icRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=apw6ogb+ighCkG56dE6a2Roe+FzIFSCZ3fTJDqFMHMLv7+kdKl5y9zwMcqSUV2Dta
	 FmNwl4nM5/3vZhBxHoi2ML3PBMPJvpG5lQDt6k6JxbXRE2nEapLL7uszXvlzyxoJQm
	 rkqE/iud/R3NZDSRel8+PjI68mLdidZhlaGdgMBT5r0pxYi1P9uwc9q1gQEc6AI42U
	 xSGGjsrm5cgO7z7Cm6S0WXP8NzzIrvbtwpxJ9Dpp0hzaU4AQXhAAa70vu6Ub/Z9S6w
	 vmNBLH7p13eYyP6WIDsQ3WPIhrRf8gYPAMDO5qanWQTfJTCfJzRXczD568YTS3YzsN
	 ca9vjfbYSJjZw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05EF43782074;
	Wed, 24 Jan 2024 08:57:58 +0000 (UTC)
Message-ID: <cadd67e7-55c1-432b-9377-1a8f8d70dc9b@collabora.com>
Date: Wed, 24 Jan 2024 09:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: media: mediatek: mdp: Change
 mediatek,gce-events to reference
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
 <20240124011459.12204-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240124011459.12204-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/01/24 02:14, Jason-JH.Lin ha scritto:
> Change mediatek,gce-events property to reference mediatek,gce-props.yaml
> instead of defining itself.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



