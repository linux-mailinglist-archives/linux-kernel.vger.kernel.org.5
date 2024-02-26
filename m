Return-Path: <linux-kernel+bounces-80985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8406A866EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AF41F2602E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14B64CF7;
	Mon, 26 Feb 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hQcQo6ua"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629B64CCE;
	Mon, 26 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937778; cv=none; b=ftzZ+va1EO8rkZUupAdaBamtq2BhGY5ZSiMsIu7VOmudi2De0HISogVgZacaDCEH/38W/ytHoieUOxG1yoW8TMYXCc+uZNHYateCNecyzdgCcP/OQ5dgX/KkmcsXM0PGocxpNoaK4/ka7WU+7xZMBQyubj3p+hl723pATanthdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937778; c=relaxed/simple;
	bh=22mIqwheuC6Rn5p1Eu5S1/Bl6YMtGWLbnEVTK4n7+gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0e0tKbSzk5V0JfpB3iotkcakf6aJUcc8rDZSM+k8kjdt6Fhu/RJVqglawEFyHERgArbo+3uAmnrpFAHZVALIsmLndt2e5GnfGwPpzps6T/xS39dgUNjL7neIwpQ7QQHYIW/OyBkVlX1PFIR2PEUn/YjZVJDI4I8+6IUt8nk/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hQcQo6ua; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708937775;
	bh=22mIqwheuC6Rn5p1Eu5S1/Bl6YMtGWLbnEVTK4n7+gc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hQcQo6ua6hBX65ziMOVXmhxYZeUzXhC6tVf1nnhfV459MFCnw9caTTUatBS2relKw
	 pVOHkZngubhf3ma8nVCckAkPKECa7ujGkRUmXpeYbNoFlxop+LkGhHayDAL2wNMGJ3
	 A/n37eJWXzPa92hQuJcEFig2Db1/P7hUbxDlakLM8fp+n9y7vzm7ceaStFszOtPb66
	 AUW1xtauYgLiHoWMLSWQFSMTH36Igz8SGgsgWoA7f3v7e8VKfMn1Z0tMX9f5mwbvGe
	 JMzNMuy7drEdZXKVa8nVigbB/aRPLPCM62X+CcwSI+dF2RG7/aJhtIIow3thpfzf9d
	 YjNzlQOAbl2iw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C23F9378207B;
	Mon, 26 Feb 2024 08:56:13 +0000 (UTC)
Message-ID: <7e0a003c-7016-4de7-a193-2db28995e6ea@collabora.com>
Date: Mon, 26 Feb 2024 09:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] dt-bindings: vendor-prefixes: add Cudy
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240223101709.30072-1-zajec5@gmail.com>
 <20240223101709.30072-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240223101709.30072-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 11:17, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy is a Chinese company providing networking products.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



