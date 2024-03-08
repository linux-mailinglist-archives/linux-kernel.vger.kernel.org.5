Return-Path: <linux-kernel+bounces-96682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAF875FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352851F240BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82153E28;
	Fri,  8 Mar 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ycj46DCL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4D53800;
	Fri,  8 Mar 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887329; cv=none; b=FHZWHioLc5On8weXkff7S2BYOphUujmYjsSiKp68gcUzTD+XDAYScL96amfD58ps+pa2IU889Piv+Y4CSvrNMZqd6pCYlS2pidjGroquIlrQCvYrSFDAZonS+ul49iOFHwZxjX49rdXnV9G1K0PP16xbqQRU4MCGMJZWuxJ6iNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887329; c=relaxed/simple;
	bh=aSDQoDL8eQHMCL+EPyMT7iv12cCuougp3ULYiz+WB5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLCTWzvzUBdclzxBQQlnkL0E4uVwPFnHD9N+MNp2enDe1K/N652RHmsmBJ8JSwRYN1hXTRLFcYfycBm0eCV+uZYrYamugOHnLbwCGZ7iqqdR0EPmpC1iNkwOlcJ3fyOxYpzGAnVgs1xG3fPmfWGtNTnAif69c1BzlunYH4KUUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ycj46DCL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709887326;
	bh=aSDQoDL8eQHMCL+EPyMT7iv12cCuougp3ULYiz+WB5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ycj46DCLf3aJ8WPPc72qUc/RYJsoQMPIXudTGC3JsHzUWzONBYjCX1sD3gSjw6SXX
	 9aGOu3aktbdVjixjOTndyUIbXeGh3EROmWG/oM00efvH0sbZ32lKvaDkK5CyKCSAxw
	 7V3/7HqL4XYgNr7LSnEzCWdd2MsBPJOj6rAtBZAvz5ck9fOjk1F4zpOL3/xGYAYmQe
	 ZFsHuZdRMjQkamRhwYLFkTGEH6MRiSmUDAF54wQNme2vBBetNdXHFs++8pnUF3zqip
	 9NsCONNnzEtXQ/LJ2j9CYRW4R9MGD6dHEhclx/CLHW/DdpBbG2oePel5ZHjJ9sn5XD
	 oWn9ecemGdQew==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 16CC737813CA;
	Fri,  8 Mar 2024 08:42:06 +0000 (UTC)
Message-ID: <a011de50-3a67-49ae-a0eb-14dfb768efe7@collabora.com>
Date: Fri, 8 Mar 2024 09:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mips: dts: ralink: mt7621: reorder serial0
 properties
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
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
 <20240307190408.23443-2-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307190408.23443-2-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 20:04, Justin Swartz ha scritto:
> Reorder serial0 properties according to the guidelines laid
> out in Documentation/devicetree/bindings/dts-coding-style.rst
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



