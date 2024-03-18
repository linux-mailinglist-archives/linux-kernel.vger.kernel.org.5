Return-Path: <linux-kernel+bounces-105983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56C87E719
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344C81F22211
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF7364C0;
	Mon, 18 Mar 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qiplwgqS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38D328DB;
	Mon, 18 Mar 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757220; cv=none; b=p64HBLmU8PkOJKnuYRHggii2CZKDfWv2tAWCa09T3/bh9XoUCMNsnzsSermagbDLnR7tqOOPZih6eEJzdSL+pKeaDqNs6hxGURP9CuchahOueWSJ+QO/UZfMWp2too+PixmGkFN2/2tsjfFVxZ3YmYr6zAY/OA72S6I9avS5MC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757220; c=relaxed/simple;
	bh=vR7izpRoiDi/gPzIug7bV7g9yuDMhkNGfayv6OIoOKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZK0tbRGzd5pBv+AYLtZpASCP2HaDP45wJ5ZamiqzRvg89D4Fm2FfyetmVKE8jB2yyvey8Yo4JSKTD6R7WNwnyk4bQTH/ypwFxZjx9nyImPBxfidXHluyo3pCCyfSN24ooW5BdS/WHNXnNN1CesiUt6crASqrq0ObmPEtaq+44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qiplwgqS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757217;
	bh=vR7izpRoiDi/gPzIug7bV7g9yuDMhkNGfayv6OIoOKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qiplwgqSWKamgDurNozVDjVII5q1ncJP41gCnSAHfu68d4samcDpRd8gBOEKPF90m
	 XyfI/4gJu8pSYimwi7M7jhXwrSe/s3ROrOMGp/oxVUPffBR3qIn5iy1EyXNEtSSrSH
	 lGoJWOelM+WjxybIUScbxeZ6eatOuL/zCcowz6luNzWXqKVh174WUIr9yu8b/A3j2y
	 fg2VFRGn3SPSQulbeYyHb+XQEodJ1P+Opcws2Q8AWXLpjJTMmwg+kAQRYt3qlupz7J
	 chRVpqqeyT2yt2ok9P4d1v8/fLg/dQPq4QqKPjaRg3HYdw+16akm7bCNiEnLEW2pz+
	 91w4rJqvkjSuA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9586A3782082;
	Mon, 18 Mar 2024 10:20:16 +0000 (UTC)
Message-ID: <976c0107-c14a-4b78-8788-3238322a8ad3@collabora.com>
Date: Mon, 18 Mar 2024 11:20:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] mips: dts: ralink: mt7621: reorder gic node
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
 <20240316045442.31469-11-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-11-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes of the Global Interrupt Controller
> node to fit DTS style guidelines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



