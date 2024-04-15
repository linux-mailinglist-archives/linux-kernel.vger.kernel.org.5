Return-Path: <linux-kernel+bounces-144716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2708A49A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53742B25612
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2652E652;
	Mon, 15 Apr 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0LPjgSf1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0702C6B6;
	Mon, 15 Apr 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168045; cv=none; b=iJZEQS7I5WR09Ujxx9G1DkpD3l0XjUHNeJkN14dnOz2aEA07YhRXa3sna9oTZ7gthkOqSER/IMoxO+qKt+KdI1B8azqcqSDjG+6hf+Ipkz/T7V9IZzvY18EDRc+S0HuVBE7eMRWnuetwyi5dL5miG50ddHjfivCArBUTdKR4AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168045; c=relaxed/simple;
	bh=HSR6PBtfxo7EXtU/d2SXM83lh+wVbddu5sGZ+OvYtDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kz2Z/1lFnNoro9+cFuHwPQKFRcOWKcIfB1ZzbUFkQeQcgAb7AEJm99gINL+xxP+Mz/6eA6SxVyeqbLUjZPd3yyoKFglN94ZN8mjkijzJYvj6k6XdxyvcKJn/odtYsdsQ/UB+ftS1hTsXEZm3v2JEeQ/kmYcLNV1LUmdhQVQyCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0LPjgSf1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713168038;
	bh=HSR6PBtfxo7EXtU/d2SXM83lh+wVbddu5sGZ+OvYtDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0LPjgSf19fzsF4BViUPiF21dBSiq7NMYVukcWBXgO2drb9VJRWQeY+7dvpeCoykAi
	 BFkN6IOUOlb03rW4a84O07xhRfWOi2ZMyTsiHI1oCz/hhGMYoW/9cdwpGl8iZw03Jp
	 GRTPb3oi/8vBg4Ve2qJQRbNkLFWpMeZgRMZ4fdyBj+65RpGCvPrjZyBlRCCFODXQEa
	 o+L3YgJfGPFhYmV7XXJdNi78vY14qnLCfLQ2GobzA2naA5CGH4NEVDlv6GF2Qn7B0B
	 Kt2DKqWRXfS6kp2ka8XEBV0W5dkXPnQ2iuDMccd+IA4K2LpUcJnMBCt/Rg7MkLVpr1
	 y7ZCjIvekOkyQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 938653780894;
	Mon, 15 Apr 2024 08:00:37 +0000 (UTC)
Message-ID: <1e62f1eb-f4cb-450f-9345-0a6f1a65468f@collabora.com>
Date: Mon, 15 Apr 2024 10:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Chen-Yu Tsai <wenst@chromium.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240412073046.1192744-1-wenst@chromium.org>
 <20240412073046.1192744-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240412073046.1192744-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/04/24 09:30, Chen-Yu Tsai ha scritto:
> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> While the Bluetooth SDIO function is fully discoverable, the chip has
> a pin that can reset just the Bluetooth core, as opposed to the full
> chip. This should be described in the device tree.
> 
> Add a device tree binding for the Bluetooth SDIO function of the MT7921S
> specifically to document the reset line. This binding is based on the MMC
> controller binding, which specifies one device node per SDIO function.
> 
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



