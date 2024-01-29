Return-Path: <linux-kernel+bounces-42536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F698402C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B061F22F67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E158956469;
	Mon, 29 Jan 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mD7T7xGP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE057864;
	Mon, 29 Jan 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524065; cv=none; b=aVg+oa47sSfu0yM+Aizp88HTplpoITLzK4+DBwbbMUskwq0z9zO7KR8Z8vIk4lxXFbG/aK75BU3wwXxTHrqAAzg/5hfcOS3tTs6H8nXSuBYh7/b4fRT3FkMjchCC2rHDDz9rPhK1Sensv2zham1/j6w44hNbKV+x05EubUHNWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524065; c=relaxed/simple;
	bh=Se2pMSyaA1uJqQKjYDSSGtdlRITL9xGPFkn0PUHl9v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eusl00MmCSWkjQa0A6h8dutF7X8keq8vie2WYYjxjAJoz+j8W11HwHTr9Rem6ERh+ao3GvgnsSJ/+YJCJvMJZ7zWvPLl9jnvINnrEu857DFQSqVTTWngNMKfjCWpgYbcnpR+zaCuK1O107YiSkJES/099LpOV2BOEwP/1txMi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mD7T7xGP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706524061;
	bh=Se2pMSyaA1uJqQKjYDSSGtdlRITL9xGPFkn0PUHl9v0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mD7T7xGPoHfuFfVwhvfyhBv8vOGj45UWbeiO4wWgmRRDnbY6U3j8J9YPPllTJ8f+F
	 zUl+gI2Xa7eH6kw2sbhoNQcJ9XbaCV/NbAqNjfgcdtm2dhs21vmxi5jfcEjr9wG/mM
	 2/Ke4p+45wPfDkjuG20D3wUpeDfZDq9xPeFsafNJoI5WJPkQT3cfmw110geOTzjyMI
	 AcZBpGB0khB3xQ6Zh9O6Ux55gRURMP2XwnokZmjMLrFyvv1/1MZd47zbWelC7J0Ajb
	 4+s6sS1R2to2/deYfEuys38AJ67aCVzt7lyY8z7nx9wIqhnOZvyLlmlVIGhEp7845g
	 Wdw8ZiCLwAfJw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 501BA3780C1F;
	Mon, 29 Jan 2024 10:27:41 +0000 (UTC)
Message-ID: <242fc593-6445-4580-95a8-b60150ff4b84@collabora.com>
Date: Mon, 29 Jan 2024 11:27:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: mediatek: Add socinfo efuses to
 MT8173/83/96/92/95 SoCs
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231222080739.21706-1-william-tw.lin@mediatek.com>
 <20231222080739.21706-2-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231222080739.21706-2-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/12/23 09:07, William-tw Lin ha scritto:
> Add efuse nodes for socinfo retrieval for MT8173, MT8183, MT8186,
> MT8192 and MT8195.
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>

Applied to v6.4-next/dts64

Thanks!
Angelo

