Return-Path: <linux-kernel+bounces-39894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7983D73E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386729CAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB764CCE;
	Fri, 26 Jan 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CsidsPSI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BB14263;
	Fri, 26 Jan 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260216; cv=none; b=gbkIDN7mTp7G308F2+MIR2+0jOx84tP0ipmNLZOAWbZNh2xw4fNTp1Z/2lHq9ArpFwJ7FB0uxJXC7h9q2WViHBGnRXBZaaHuNMRvIUGnZWtG+Svk7IcE2Ictajaa+RvBt1ck1OPgOfAyNPNMhCJVaOndYBkRxJqW3fFeb/LTjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260216; c=relaxed/simple;
	bh=SxA01WsGYaiPR9ygKYJLgo2WCbqnCyZLRDfMY+rV6Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmoblvM+ALBOAI4BDuzkvfJuEoAYrOKQlXVRpxKC2v1iDkCxguldvGzJiOkzsglh4tcaAK9YReNYNEeU9kb5Dp8UdVWHQUHFI+a0+nR+HTLzDTlkkdxMtcDkz3bJh80aHyenTwuZWVinxs//HPddJndkQLYBTUHWQ0JBIQQ+CR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CsidsPSI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260212;
	bh=SxA01WsGYaiPR9ygKYJLgo2WCbqnCyZLRDfMY+rV6Bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CsidsPSIcR6/+pQuEXLQ9vCn7YW8F3/zKlwAHE0vJHrGn2i/BPbqxIOpepjB9sAm/
	 Jow9+j7iW3P3bA5Tl8zbNkF5YP3rrLUrJL7ROX2xOAlJrKbhtH9No00Bj1oMDQvBOo
	 GwaPUkP1zUmcgI+TbHCAOFbvninsgIVC6bswXBOfAy4eT6t2jZRFT1cjhzXN7n0CER
	 92GretTOS43sE6H5tsSw6iTZze9FKn4MA71i6pkqZpSqFPoSjbK8Iv+tBsec01x8jJ
	 7TlrqglJdNwUFOuvz0mIrZVs90w7NilbiqKR8aXfhdbAg23xfSbMRPxm6SGCXwN20r
	 VdPHNW1d7Dd8A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1DBBC3782080;
	Fri, 26 Jan 2024 09:10:12 +0000 (UTC)
Message-ID: <051a0b5b-068d-43ce-a73a-f70f94888f8c@collabora.com>
Date: Fri, 26 Jan 2024 10:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240126083802.2728610-1-wenst@chromium.org>
 <20240126083802.2728610-7-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240126083802.2728610-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/01/24 09:37, Chen-Yu Tsai ha scritto:
> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> Krabby design.
> 
> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> convertible device with touchscreen and stylus.
> 
> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> device. It does not have a touchscreen or stylus.
> 
> The two devices both have two variants. The difference is a second
> source trackpad controller that shares the same address as the original,
> but is incompatible.
> 
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



