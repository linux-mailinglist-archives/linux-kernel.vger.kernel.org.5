Return-Path: <linux-kernel+bounces-22257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07C829B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1909928490B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8048CCD;
	Wed, 10 Jan 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iLnHIaYU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632148CC7;
	Wed, 10 Jan 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704893921;
	bh=T7aLOm+cWROBT5elzjFsSPDIlFL6HfnPYUcBRZAqaVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iLnHIaYU+ycJoooY3e9ZNh68IUzl10yaH8AJ4Sqld77b4yDjZSgkVzZN22TvIjNP+
	 u/7K4905q4HRepGOd5nDLcWC/HnTsDVxn7o/iMAACKcpkxHQo8zOi57ISadTYBPZzk
	 sEy4PVk8ZXrXZKLRakNSulPNDYBtr/EImeG1iV/owNidxBdtcKHWftW1H7A3HvCo7N
	 9Hb4j3kHZmaZuJyGS0J3W8xBZTSgdIH/6GDj+lvXnYUgcotxnHd5km/n8djPbrfkr/
	 Ivi/hePrDME0BwdaloRTHf7HyCCyfH3bMjysK2YTbqF1ao3zI/+vEQ2iUl9xNYONrX
	 djD+7/ecvxu7A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4912837813E4;
	Wed, 10 Jan 2024 13:38:40 +0000 (UTC)
Message-ID: <7d8b39bf-5453-4e74-bfee-6f35a504eb37@collabora.com>
Date: Wed, 10 Jan 2024 14:38:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi
 AX3000T
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240110095118.25598-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240110095118.25598-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 10:51, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981B (AKA Filogic 820) is MediaTek's dual-core ARM Cortex-A53 SoC.
> One of market devices using this SoC is Xiaomi AX3000T.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



