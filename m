Return-Path: <linux-kernel+bounces-105985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CF87E71F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8000928262C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E19A37702;
	Mon, 18 Mar 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YihJS4Wt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880236AEE;
	Mon, 18 Mar 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757222; cv=none; b=Em7Pj6xY7aHaU+6Pc29ae3TuF/VhVExjJPllJ1DcCcmxVYlcHm4qPCbV0INUaog0cJek2TfGOs1aeVUp4qt5UypKjfmff1R3M7TXrSd3sRTuP6tXDo706A+UtJhsJ6q2mcA2MnbLnxH96NnBRxy8peii2XSBkoYYAYga9DFr/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757222; c=relaxed/simple;
	bh=8m2I0qNbHMrcATAanngbx08yTTqbz0dDFcQ2Aeb5DzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFZwPmMpuXY2BXJZF1y0yzv52OJ7AT3GVOoAjjE9MIKk15tjfu0z31qA8Jd2NkI1mEBlGfpzLkAPNpSNUjlcw6Ivwy9Jy8uXv3DhZNHOEfhnyI231FEGd1jSaSB+FXsggkD7JrdUuSGtMnKZBLwxGhvkYgBuUj9tP1lSB7pYLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YihJS4Wt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757219;
	bh=8m2I0qNbHMrcATAanngbx08yTTqbz0dDFcQ2Aeb5DzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YihJS4Wt5/45v2WATjRSkSpRyeASPm5XmnY+udTikrrZ7JiCbIQ483ucNsLiPtgZh
	 YgA1KPhpEQWmq5cSNx9vQ3FReq1a6KBX3BNSJxuWBPwk9wzLNcnFd7CnwnoebGcyeq
	 b1AiCKAAqNiCS9DjalEFQioV/cIREf6GLQ47M3PRN4WdOxBTD771jP4GNgYwEyZyb4
	 FpbD6TwfmM+6yXn7Me8oqCIF4q3EhGPTwI4wCenr+mgReQq2b/JV/S/aUYDUzA/vwS
	 aBhGs2raj0/ZiSJH/gXVY/ZFLcSyN4APHyLdM7fKNi4UdAU6pICJJ4VZeS04PSLRjZ
	 R6r23lUNTN6NQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0FD1F378107C;
	Mon, 18 Mar 2024 10:20:19 +0000 (UTC)
Message-ID: <c37a1b6b-0170-4a9f-95c3-2588f0f61585@collabora.com>
Date: Mon, 18 Mar 2024 11:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] mips: dts: ralink: mt7621: reorder sysc node
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
 <20240316045442.31469-5-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-5-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes of the sysc node so that the
> ralink prefixed attribute is placed after those which lack
> prefixes.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



