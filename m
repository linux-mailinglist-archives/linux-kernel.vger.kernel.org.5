Return-Path: <linux-kernel+bounces-105988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1B87E728
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D090E1C219F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BA39AEF;
	Mon, 18 Mar 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SMt5Q6b6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104752C87A;
	Mon, 18 Mar 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757226; cv=none; b=XV9P0l8xhnHl6pY6Zr9nBN5GE02QjFZSqW2eGpkVOSzPC3s54w9FpCG8rZy54TYR4pbbiX2iv/6vWVfwsuzZZ+uq9HyvVTJpAM+8wBcX+wSFIV+j/b9Qf6p8iWRuisVbZZuyHPF9LOGcHYE3Jz4U8FSAb3SpyfAi7d7bs9ytPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757226; c=relaxed/simple;
	bh=L/WfCJ3Ym1EZIlVCoH5faw6c2cIYZNMg5UKCSUNlgxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0qAd5HOtQt42wleX0lPbQjTwItEXT3cKY01GHB7Q5ZQ2955lE/yTMeHkVwDy2EJ37WUAw+H28SgX741E55WnPFO6aP2DdV1IaH7PAgcVpGPyGO5uhFEOdW8kqN032eG01NgO3SHpT1ALp6Xsle5LqSstlTbRsmogvP/jrJgj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SMt5Q6b6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757223;
	bh=L/WfCJ3Ym1EZIlVCoH5faw6c2cIYZNMg5UKCSUNlgxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SMt5Q6b6BgxBqCcjVwEpEKsVWurV8xPDgI/UjkHzGIcRsZ5ZqhyYhUiX82XIaQ3gv
	 5Apec943xO3wQt7enmPwUxyNmNJJiI2qXvDKhXz15gZQPbEjEUcitn5L1h9dUF8P65
	 w1utNyoPa8jMZgGRLLUHXZ1EGv3l0qucWEFtx0hHHJGXQ2mTtWXmFMhYkPS6zx9N3b
	 GdzTGLD/yWQrHfEr4G+22ugkGC0GpsvEh37DHePzkIWjlvGMVNcIzu6e1IdrZbWA/I
	 GRvCubfznY9fW+c4x9pY1QXV2XYRTLjavts+OvNI0C4/PRZf2y9C99+4vo2d/u7CB4
	 D2W8QRuPpx9NQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AD41D378209D;
	Mon, 18 Mar 2024 10:20:22 +0000 (UTC)
Message-ID: <75c5ba56-57a7-482c-8d83-2cde08e30b94@collabora.com>
Date: Mon, 18 Mar 2024 11:20:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] mips: dts: ralink: mt7621: reorder mmc regulator
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
 <20240316045442.31469-4-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-4-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Reorder the attributes of MMC fixed voltage regulator nodes
> for the sake of compliance with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



