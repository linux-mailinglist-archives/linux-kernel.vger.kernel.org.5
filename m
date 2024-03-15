Return-Path: <linux-kernel+bounces-104401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5387CD53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065BE283984
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1D24A0E;
	Fri, 15 Mar 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="It9Y9O8i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761E1A27E;
	Fri, 15 Mar 2024 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506173; cv=none; b=kiOGL5juSQaCGJtXm8YA+h+6uaO++I1ffnwkpv11gcSI55cRCTzZlz1+2RepaYUGxsjt9s0QBZlziH/ngMKL96NJAVXjHMhemeD29jBRzOW8EcX9ZjtuKGuxvjmldPP6WNd3PhR+F4AYVBHpkSOpRLnIcPpGDMOwkBl3yDHS7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506173; c=relaxed/simple;
	bh=xrhjmaRRP7VwSVg5iaOTkc4zXHeCzBTS5s7lTKpzJW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUnPFFl8aC5kZud0w3c38fgzqTQHu66iuX3NU8dOncwkbDg8SKOWr5YbkLLXlVIB+Xr7kJu2K3v82O8+U+BiJe0tydu5c4diykHwfNwg5Eg4wTRmQtos0wgO8fgxmhUoAC8mKUGkZif8r50kqjceuZLdgzkhkLUfcpEz2vztqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=It9Y9O8i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710506170;
	bh=xrhjmaRRP7VwSVg5iaOTkc4zXHeCzBTS5s7lTKpzJW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=It9Y9O8i8MPGEaoM8mT3j5XEgKhF20RTurkqtQyECM8zjUoD1mYjs/3esg1SPGFUB
	 sPJ5h42z/CjPv/sW0Rbykgmt7fPxDqHq+jAk0lfaWWdMT3CpiOBREdLqF8Ou+tgquX
	 Ro9YK9+RTddXGqWW9kU+D3oy2k/pBz5ITBEY6nu5g4zzO3whDc08y0SIIVXWqb8pKU
	 iWQT++Irv3vKoDsFkjVu3WXGwKNA4NzKf3SVD3xRTVBL/IJmGKPmq2jsAJrR5+W+Ry
	 o+Xi1IDqH93uy7FLnYvPt4TRIX/l++yQnf9iokC9LqSTokhwDQaNtbN326ijMp/oor
	 C5dQ9In1fn+/A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5FEA037820CD;
	Fri, 15 Mar 2024 12:36:09 +0000 (UTC)
Message-ID: <8d18052f-ad0a-4396-bc66-10500dd6e41b@collabora.com>
Date: Fri, 15 Mar 2024 13:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8186-corsola: Update min
 voltage constraint for Vgpu
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20240315111621.2263159-1-treapking@chromium.org>
 <20240315111621.2263159-5-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240315111621.2263159-5-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/03/24 12:16, Pin-yen Lin ha scritto:
> The requested voltage could be lower than the minimum voltage on the
> GPU OPP table when the MTK Smart Voltage Scaling (SVS) driver is
> enabled, so update the minimum voltage constraint from 600000 uV to
> 500000 uV as listed on the mt6366 datasheet.
> 
> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



