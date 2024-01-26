Return-Path: <linux-kernel+bounces-39893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0E83D740
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC8929391E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A864AA9;
	Fri, 26 Jan 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iUr1imQ9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320E634ED;
	Fri, 26 Jan 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260215; cv=none; b=FsOLAjBdjr53zh/0c8t28BxyqUkHqS0g5LsKsFWf/QUNdcsWHeZpx6BhGqa9MZqqMHLfZLqQPDBX6tUrK5WnybwEFb7LvrZvItitOiHmSfzoPPXvG6tEobBBFA6TtrVFzX36nCgkoVrLlLg4tOTQQDUjbVKTovoJzFF+h8QhnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260215; c=relaxed/simple;
	bh=azLgXU4B5hvZ3lRSpkqmX1dSsInT4VOSlsC6BUhZkaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZIVEp0/qG80dz+3Ts7X+VCZUL9nn2jroB3WzFtx512x55hiy4LmhRhaiJ4lVHmwTrCsl8rk0qtOC+tS8ZgUz/at/XptKzdzPBbROxIgoxzaPxWKjXKUg7EfAV/3Q1x2nBUXLCnLvoH9N4Qa0XMkgi9XyMbmgnOS9mckc6bfEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iUr1imQ9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260211;
	bh=azLgXU4B5hvZ3lRSpkqmX1dSsInT4VOSlsC6BUhZkaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iUr1imQ9vVCgJdhGgthjtbxIGCi8O3zxDr4mW488Ieq3qJZL8gtRQTb/lF2TiDz6z
	 yGN3/eLl7GccqUcnUop5pPG8zLeLf3R8DwczDjBvhrAqIyyTq1WHs7/ByOWZ00v/1v
	 E5Z4x/Hy61hIXSlG3NBVe2Q4ohWL7rGL8PfbtF4IgyBlc+UpzHbjxdgfHe+CGNkm4t
	 sVBBUTIPshedtsJlTDedyALB+ZNM8MRq39Bi0XrR00jvqwJKp5g9qHirZAOsJaLMae
	 IywGRIZujw88biavP2Q6+fhTnAy5bc1CfbB5a+Jvv6IxR0aqEkah/XWv90VZy2ffS/
	 mVd3jgNEq3wOQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B4E03782072;
	Fri, 26 Jan 2024 09:10:11 +0000 (UTC)
Message-ID: <735f1b96-0470-440a-a72a-090c6f98b619@collabora.com>
Date: Fri, 26 Jan 2024 10:10:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] arm64: dts: mediatek: Introduce MT8186 Steelix
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240126083802.2728610-1-wenst@chromium.org>
 <20240126083802.2728610-8-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240126083802.2728610-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/01/24 09:37, Chen-Yu Tsai ha scritto:
> The MT8186 Steelix, also known as the Lenovo 300e Yoga Chromebook Gen 4,
> is a convertible device based on a common design of the same name. The
> device comes in different variants. Of them, whether a world facing
> camera is integrated is the only differentiating factor between the
> two device trees added. The different SKU IDs describe this alone.
> 
> The other device difference is the trackpad component used. This is
> simply handled by having both possible components described in the
> device tree, and letting the implementation figure out which one is
> actually available. The system bootloader / firmware does not
> differentiate this in that they share the same SKU IDs.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



