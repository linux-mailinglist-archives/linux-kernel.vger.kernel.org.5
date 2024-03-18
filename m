Return-Path: <linux-kernel+bounces-105987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89287E725
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0751B1C2198A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE712DF9D;
	Mon, 18 Mar 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NAfZixBZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E8381A1;
	Mon, 18 Mar 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757225; cv=none; b=NGtdo+GEhR5mUrGAgccDzHgkAlqXqPz5p9A6Gq+tx6fK19g4INgjvw3GcAPR8c3SsvxtfmwgTe+jEzRvnHB7Na1meJfbqpCFZrMJfBkdK5pKdhm4TMhujUs5AiJsaOu0qhXplRgyEoBb4gup/czOPYNdl0I2maDysb7Pa/MQe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757225; c=relaxed/simple;
	bh=M++vTJkQ759R9Mkwui1J3cBXY015Nmf4LfDb5qGiOEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA/SfeptUvq9TcE+B6jyMKaDH29dg18KVwqMAqDOjtmE8o1AILOJ9kf0HUltSMPT8e4+21Dorgyaao674M1JC+TOsd/TSxV3TJxaYEi8gGYtUUsUTdZEoUox4t/7g6F71YTJBP6kRP3E8XPU468gRm4vuotF5TnQYTwzYq8blmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NAfZixBZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757222;
	bh=M++vTJkQ759R9Mkwui1J3cBXY015Nmf4LfDb5qGiOEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NAfZixBZJGbT+COCy8sgZlNk1eZM4R0hVqDxf6FepWL07MyI1pL6zWmskVm+agb8B
	 HJ0ZYuwRDs7eU3fR1hdXul+C6XeOlikz2JJXznYKMVI7SSHWAimjm69iBeS/dxDLoe
	 DFCVnfoYLBV5tzCAGebKocQ13LJehhmQ/yaLc/CQSGL1CxU04BwKfTWg4zSWruSrfZ
	 C2ornlIbt8UYdiVqUX4l1yCpeedC3QN6/hHrgM6NIDd3FMHHLFMWJp4/X/tKFDvzZs
	 TDF5EfHvEfdYz5OYRjNscGuwMHzhlAkooSygOdm1Cjnl3MlN6eBj9xWYAJ7YLS4EgC
	 rts9Y3vn01WXA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C2ACC3782033;
	Mon, 18 Mar 2024 10:20:21 +0000 (UTC)
Message-ID: <b9ba05e9-888d-4af4-8b64-d06cc8e6553d@collabora.com>
Date: Mon, 18 Mar 2024 11:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] mips: dts: ralink: mt7621: reorder spi0 node
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
 <20240316045442.31469-8-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-8-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes of the SPI controller node so that
> they're aligned with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



