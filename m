Return-Path: <linux-kernel+bounces-29910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD1B831506
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A6EB212FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1A125A6;
	Thu, 18 Jan 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nCaG9dIC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E11BC51;
	Thu, 18 Jan 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567481; cv=none; b=bk926PwwYbCNDEC4geml81dTqUWp6ubg8AEAVCP1Ein6dB+l2zTNxYJI78t8+8YZOdaI0BiojhVzPe04E2oA0rtfK1f0uoFta5O+bcZfkgX3wnJj5ARsnzUS9PDdlDAVfBSH4O9mQRnYu+n3vlQjyafwbnBRM0mTPeJTjm3NBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567481; c=relaxed/simple;
	bh=SyeQsQ1ppgbuh7htdCHARcFwlcD8B29VimAs1TsMQxQ=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=VENSc2g1b/awOaFYOKz2PI1jzrmbw/Wt9oUiHSvjgUMjBKoSixSjBli8eMSoemswWvfkXVkWFSs1WrRmIgG4IdPI1bZf/reOtulzpFbXcMxyZBw/LUU42mstfLAb0RmNBDJyDuBtfxvHgg8iQC6fgV1hVygKURqMoolTdetSkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nCaG9dIC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705567478;
	bh=SyeQsQ1ppgbuh7htdCHARcFwlcD8B29VimAs1TsMQxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nCaG9dICCf0Ej9rjZuH6jcZl1z0dXLs376gr4N6MW1UjU9KSc+YU3vI/3lMfz3vKn
	 L812s79Q7xW7A8w4wzgeHoe5x/i3dJSrk5Irr0GTIQ3lk4skhmOIXuMrMzeYzcnBEM
	 f+ijc6Sz6UPR1Rhi3rQkJV2XwBKkNacVzZad7wRZPlWvNMvQisfwOUAaFUsHk7no8h
	 2NUgsXxbmDnlPHaMJOwHSIBVvMfs+0eFXjgYPgM6pwxhdmohRgbtqB8L3LnSWhkJj6
	 0gV7x576aRZ3HjtRz1fyrVPS73J9HKDfCH4HHOnNnVvIbCAmec+7ydQ4LCcLD5Sxu7
	 ybtezvrH5cMFA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 68E433780C6C;
	Thu, 18 Jan 2024 08:44:37 +0000 (UTC)
Message-ID: <97831a4c-f5d3-44d4-8a81-0bd2cc967421@collabora.com>
Date: Thu, 18 Jan 2024 09:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clk: mediatek: add infracfg reset controller for
 mt7988
Content-Language: en-US
To: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-3-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240117184111.62371-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/01/24 19:41, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Infracfg can also operate as reset controller, add support for it.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



