Return-Path: <linux-kernel+bounces-105981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641D87E713
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBB91F21EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D332C6C;
	Mon, 18 Mar 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="audS9/ET"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825B2E859;
	Mon, 18 Mar 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757218; cv=none; b=nHQBu4uo9NbWtw0hGTNL8ymad+GLBKX5qd29Zd/hO9SF+ybKCgcpjlcWZ+Kd896Z/KRrhGksjOMnri+jtJDrqipwwOA2MJb7o8nnXs/C23SFNEh6Try0M+p68XgWxpopITrjUUX5oVFvOObg6uloMQX4EAJ5c86U+kX4jacYBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757218; c=relaxed/simple;
	bh=xFqKkyAmJVTNmLBFSihApou28cptANiceTSB76zEC5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHUtlEKI1Tp9UXEwbjGyOMcay3iNNzam+OKE0oW1OhUgW2gZ9SWQjV5qh6+fc3xad/rtgTx/yqgK7f8XezNhTZRfvkIpd8OU9N3E7lO7mx2vRZyOputti+IjPq6r0fsOD8FCZRbX1yGZr0WBIUzKmaPYK2HgK13++m1BP+IjAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=audS9/ET; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757215;
	bh=xFqKkyAmJVTNmLBFSihApou28cptANiceTSB76zEC5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=audS9/ETDK7z/jTMXazQhkgR0iuRi2oPlSZehNai4j9E3HDhtdId9a1oe4xrWqzwZ
	 rXiOBzlz6JJzJDzFTbu54Fire4ahBBVGiv7xQvTaKfA9K2V9qC5WyiTG52r0BOy/Ro
	 ae6uIFDnPLec74tdDgYCqMxdjtdMljCSsgWgJ5CRUw08MdGk9CSE7fmdUYLD09Q+mm
	 +Ad/2tQ0uYKqhaenIg2Mzh0gYk316Gow8lSAGgZx5ConTm1kUma86/I/ovJ8vjFxmk
	 cumzIyptkRS1/poSnt8cirUUxHAzc/54sppV0xwyFLs07iPrKIdU1R5E+zb75dMaxo
	 qncc04mMMCH/w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F3C9378203E;
	Mon, 18 Mar 2024 10:20:14 +0000 (UTC)
Message-ID: <5557e38b-add0-45a0-8b66-e3af2c33ea24@collabora.com>
Date: Mon, 18 Mar 2024 11:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] mips: dts: ralink: mt7621: reorder pcie node
 attributes and children
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
 <20240316045442.31469-13-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-13-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes and child nodes of the PCIe Controller
> node to meet the DTS style guidelines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



