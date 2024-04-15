Return-Path: <linux-kernel+bounces-144916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80B8A4C92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06ED1C210A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CB5BAFA;
	Mon, 15 Apr 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rnyFditB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADE5B20F;
	Mon, 15 Apr 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177219; cv=none; b=MbybCJORQ8GRczDMgDG9S33WlAT+I5qDZcR2c36o6I73IjzudB2nGMGCGMS8krNxYepVV+J65Leqx0egG898ncaSfgATZomVIZu2AtWkFhM1jYhGM4XpvWGPqgiZpPfqG83NRDEV5FoXQogaz/9JgVHNwQ4ErvPQc4iBKYpJx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177219; c=relaxed/simple;
	bh=hx5s8YmotvAhrLtLSctDiJ/fC4X9KfCW0JvNJiLtpmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sP+JW4ITJl4AoG46JhltDIwRsY0E86zS2BTjarKnwSg1KZJjX8bIXuEOEgJ/OJtQfcB/wIwJEfyx4iUYCo9fryzvpZH43vEF4n/15pn3h1DjW4hT9x3TgAK38Fyb9+UKrPmarnmGMFEZgsXyg6WmeMoyiJsOVl1UE2wg23l620s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rnyFditB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713177211;
	bh=hx5s8YmotvAhrLtLSctDiJ/fC4X9KfCW0JvNJiLtpmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rnyFditB0BzFnFzj7LFXWWjVfcWdO2ownQtAnHtW/RJuScVy0ut63cuuSBiiz7uVV
	 eta1WWQGEXVAKq8TCju4WG4UwC8Qd5YkRHV5goSGmRrl9guqozlZCNb7h979b0HqrI
	 RtgNugSCXoO3MZf+7JcCUOPtwCqoMesh9pb8QePmCMgH0ekuBWzsY3PvP7MhYOW5B/
	 7y8likFp4trGknm1qAS7rd1HemBVb333JejXJRbJojkLYcmFXSSt/Ec1x8HTJsN9PO
	 ESrIPmGwUrAuiccmLQXZnmWjQj9Q4dVnmoCEkBtOVfyOXQJb7ebFo1FZKW9e60iiT7
	 o0uHgCje/szhw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64001378042B;
	Mon, 15 Apr 2024 10:33:30 +0000 (UTC)
Message-ID: <799428ae-83ca-4c91-89d3-8cd1b489bbf3@collabora.com>
Date: Mon, 15 Apr 2024 12:33:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: Drop mediatek,drive-strength-adv
 usage
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240412075516.1199846-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240412075516.1199846-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/04/24 09:55, Chen-Yu Tsai ha scritto:
> The "mediatek,drive-strength-adv" pin config property has been
> deprecated in favor of the generic "drive-strength-microamp" property.
> 
> Drop or convert all instances. A value of 0 disables the advanced
> mode, which is the hardware default.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



