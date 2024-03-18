Return-Path: <linux-kernel+bounces-105980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D287E70F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1AB1F22453
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327112E644;
	Mon, 18 Mar 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O/m7BrDS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE962D05E;
	Mon, 18 Mar 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757214; cv=none; b=SQL/5/4noTfLJaWIYkkZdgU1KTxjvDSqrz0w3mYQOZvKp9jdbr+SedP3DA5uCuEQ+iuTSoZHAT7Y3tEBgD/OMqc6adGHlSjfMr5oh2COfOhjBPyCGdwSrWgRCDt6EjMNTITgIGgW1FWTY8CPhx5OetLaOuVr59wIbb7RfU7InAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757214; c=relaxed/simple;
	bh=WoikhZZr0gaoJ3V1DHAFR2wjFu+N/hvofiJZCIAiWio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kury/do6vMjfQp81CCDGfGtr5lI6uAX89hLEW+ymlq3Xf0cykCUzR56fHvXtBa1aXOCej97sWf0lRcwULhX5KB2kXUmavfkLWfgMQl+uVv6m4wqPiJnzjK19VWeOfrOiZrJb/++tA2cxXpj0/THQMzttNqZ0OdUbQhcmfTXr/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O/m7BrDS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757211;
	bh=WoikhZZr0gaoJ3V1DHAFR2wjFu+N/hvofiJZCIAiWio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/m7BrDSVJJnY7SaJ8BsVhxcMlmPjQ3ajK53VNg2mkQ9DH+HdhKKcN0QtawaxnAd/
	 FN4l7hcvFjFiyWZqrxhp8on45p/KNfuAzljCe8tUWanTUHT0uSe8Ccw8NnFIDot3XT
	 KMJZ4MDKM/Go8SYzBiJ8JEzzUcMWqMgXK/ZZrs9oEvvxhDwwusIcCQ01zwzOiingi6
	 WAxoyTscMNtaveUMvrHlXdyA1kLJRAckrInGCWaKQI9uYQKWn2VgNj/7DJl5Y4TCby
	 +C8E1qhST4Ua9i6L+utpqagLPpoCnN1oH/UHctcpQxOZW7iZTXrmRQx/SwOIUc9N7b
	 Kb+0K5VV2xrPA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C8E43782033;
	Mon, 18 Mar 2024 10:20:10 +0000 (UTC)
Message-ID: <6f8a0600-b838-43be-9544-4bea54eed445@collabora.com>
Date: Mon, 18 Mar 2024 11:20:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] mips: dts: ralink: mt7621: reorder pci?_phy
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-14-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-14-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes of the PCIe PHY nodes node to match
> what the DTS style guide recommends.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



