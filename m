Return-Path: <linux-kernel+bounces-105991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FB87E731
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EA2B216BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED33CF5E;
	Mon, 18 Mar 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fKoeEQaE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176D3BBDC;
	Mon, 18 Mar 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757230; cv=none; b=T88mJK7W3y1JoTUZJS6E9sIYGaxNyfwyda3XkDJ4sLHQHgwzP1tWjszb8TuSKHoDwIEiGxJlK80GaE9/UEb1syUVDQXk8SQZXTuWr9Fvmo8OzentUThXkUSvZQUoGcMkOzl+pZBn6wbfxogRFth0zXeXzki763FRiB6/Qi8AK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757230; c=relaxed/simple;
	bh=LR8yRNu1cX8M5FsRIEy0bPZmVjKgO3SpaqgcXr+/d/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2UUwUUTUSc8fiB6lrLu5sYrSfvMCYCtTJ6V1fYeIx8is9xbcZI+mtb+PWIvKS/+YPzFtVE6627NR8MELCzqq67nan6fDo5z4sQgI9BFMsM+9aUKVszl7Z64HdZ+vPAiMuev1wtlKntRES3LX3KVFnSac+Mejo2oXi/ZjQzJBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fKoeEQaE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757227;
	bh=LR8yRNu1cX8M5FsRIEy0bPZmVjKgO3SpaqgcXr+/d/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fKoeEQaEXlBdtmsPSeSHDWqTSMIV3b0Vw3VdhZJE2pyb8YgkYgI9cb4ve7NiEgicJ
	 0D25awGb4Av/R2tGs1OZeA36t8ZD/ek+eAx4VYXkZl56nlzm03OzaK1nONvKuPYu34
	 +VOeP8UVhC9/l3E1IF+QXhSRcZxuqpoqFhzgamD6G2cmrgemNPFtZTI3paxqte9AJu
	 aiCoV2oF1lO35ZCBP2KxJGtpk7R/lixRpV//wZvft9AGTm5VYaXJz7ws1g7agKDuGU
	 +vC9VK4nI5OnhlC0qWFv0uVHvV4Bpw56aSV90OU83h/ppph7K9EXxv0RBEjLCIsX+Y
	 YRYfeeKizvhRQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9CF4A378203E;
	Mon, 18 Mar 2024 10:20:26 +0000 (UTC)
Message-ID: <1b08cf60-8778-46f9-9f8c-b07c1df2ef7e@collabora.com>
Date: Mon, 18 Mar 2024 11:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] mips: dts: ralink: mt7621: reorder cpuintc node
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
 <20240316045442.31469-3-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-3-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the CPU Interrupt Controller node's attributes to follow
> what the DTS Coding Style dictates.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



