Return-Path: <linux-kernel+bounces-105129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A187D975
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0311C2102C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA01134B6;
	Sat, 16 Mar 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="A5SYvb9/"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E5101D5;
	Sat, 16 Mar 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580917; cv=none; b=KE9GG9ja9u/CyfFGorBewD9sNjJu5/6MGExkmhxmwgCTsuUCAtZ8IG0buIR4GRT1euWnpyHAID1h3kDncqdJQYHhz9HfhRJWw0pBYDhByT7p8v7NJZLrm29ZCYD1H7xE1v0gQMKbEFgpQZM35DCP9Q47qfr4fFIUtCwQaHwWEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580917; c=relaxed/simple;
	bh=eFvCpcNuMM9rsx6kb6ny11fu28RM1GGpZq697OkqjwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGeV6Gn89Sd6gHOC6qdztqmQZRtPL/tYSKs5cHros4+Vhfk89olll1gDg/VlxWf20MMC1xTNIrRomxD5s08pW7nSj8kuII69GrmFQ59bVMrfHhzJGf60XLCeDcSU8Ou0bo18w6AdCiFRqwQnD0Ep1nVU0LUoHFo5AacAAryIrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=A5SYvb9/; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3879920003;
	Sat, 16 Mar 2024 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/R89qJGYnbeg9WVgcaQ8Cba+D/WxrvX+F1zgBiCfzWc=;
	b=A5SYvb9/N7NN+b2Ch960ECv6QpDXu7CMYPuwjq5pqY1NoidhgH14sYCDwS6IgCQsjlqwhm
	E7HvuE9gh/2ZuyRB/Z62wMBAKxtJxB25yECBpZrOINZw5dtANDM7ZMOri5cttsEeJFa0rW
	VqMF5r2I+Ve4qd7aN5+IibF9+eGBBohdk22OD+66gbenj2odO9rnMtEgeC8re/Nph0kl2H
	tgGloYUgdYhCukQmarHCcfzaiwtG8S0iHvZ/+LedS5cQAJpa0pkRXKgZmp9pyP0QdHsKEJ
	Rh94gFlD5zN+YBSaLzJ2ECluPxN02Dj+0nQMGA5+ukzIO9NVL5QcG/CggKKkUw==
Message-ID: <659f18e3-ed71-49ac-a019-956a7fbdc215@arinc9.com>
Date: Sat, 16 Mar 2024 12:21:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] mips: dts: ralink: mt7621: reorder gpio node
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-6-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-6-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Shuffle the attributes of the gpio node to appease the DTS
> style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

