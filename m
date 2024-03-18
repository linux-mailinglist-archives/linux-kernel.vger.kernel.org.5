Return-Path: <linux-kernel+bounces-105997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEC87E747
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F5B1C21C04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6B374C4;
	Mon, 18 Mar 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AptskvFZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A52E419;
	Mon, 18 Mar 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757441; cv=none; b=qg0Qf3pBpdhaVUIjLDYAniQuC7at34rORbc3eyNfmxx+pEKcex9bRwOOcbuHGqavRatr9aSREicOBNOxfNzpDCbSMDZE5BXfSRRam1nK43rHozuBBu84EjDY2I9ydB0F++f3sUxXoJtcIHEOywbLEVQAoehHThaeN7WVPQPmOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757441; c=relaxed/simple;
	bh=oYi/GEei9YTrArQdXX13oG7NfqzSc8H9fu6XZlt8hC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y14XVbRcFHIOgJuOY0tJ/XreLLAlrnuCmOGAT2LI7wSoYc2EAUbC4TdfgpYvX9JE0yNA8ycDvbiM7zItOfpmXmHjfNJ70vheJCa0Az2hIbnqsznnN88FZxupIBac9mhOrsLmHS9HqcoZO/DGTXusXVAnXMcgO2v3uw4qbpURxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AptskvFZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757438;
	bh=oYi/GEei9YTrArQdXX13oG7NfqzSc8H9fu6XZlt8hC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AptskvFZNxoFnqnGQe+cCxluGI4hkrkPGqYFFbkS/qlNCllF8+dbs4Xt/8CayKQB9
	 vmAytJ+fOjAEMT29dEURE5YtqtLe214UhhCZtsMYASZtbHLQXNJ5kskjUuBLmorAmN
	 xnHIW8lFwjbwIk5xx3d+EjEv+904ZazSAWdg5TSO9YHlP5EQFLGowCvwMbfwYAwosT
	 QCOlGHP9GnfDUsj00KUKiK68bA6IAAFbpU3dxh7nY6U7bXkWRYgtR6XA7/99J5pR+/
	 BWdORVK6tQ/Pbs5nUt2SZwDdE5LZ4CKkJNqqBQ+DVHQE/HDoVYBT+cdsVsnh5buo72
	 01w8ZBAdg6aAQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0D503782033;
	Mon, 18 Mar 2024 10:23:57 +0000 (UTC)
Message-ID: <37c65bf7-591a-49d9-a360-b52110be1b20@collabora.com>
Date: Mon, 18 Mar 2024 11:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] arm64: dts: mediatek: mt7622: fix ethernet
 controller "compatible"
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 "David S . Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240317221050.18595-1-zajec5@gmail.com>
 <20240317221050.18595-4-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240317221050.18595-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/03/24 23:10, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
>          from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
> (and other complains about wrong clocks).
> 
> Fixes: 5f599b3a0bb8 ("arm64: dts: mt7622: add ethernet device nodes")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



