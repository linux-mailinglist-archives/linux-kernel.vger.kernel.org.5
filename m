Return-Path: <linux-kernel+bounces-29913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CF83150E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764D02817B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0198125B0;
	Thu, 18 Jan 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NE282zo4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014A1D533;
	Thu, 18 Jan 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567594; cv=none; b=b4FXEvE12tBqBx8jBpTYRg87XJ8gGvwoeZTM37XZX2WQQIO0ppBoBAXd3mXzxY8Krp8hSWERu3KIFHvXOjo4P24NrzSMeCi18bEb9y3KLC5ieH/CSfA5cg1MhUOiiXgVgeibZyBuKCUZMhBFrgc9O3goZJ5FshKbL2AYhN8jZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567594; c=relaxed/simple;
	bh=Xlc2Yg/2t4ZtVXLim5SeRE+/1WgtJ76896r0f87mGwY=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=YGMp7YiXaCzEAxxdQRgUFH5ZQ2zUDM+yNPxZaxGAvRhZvKgTYzzs/yFewH81Rj68yiGlrDNhom5CLW/ZHk8ktwTsCe3ZoL177PqaELS0DkgmEZW5D77KvIPdO/lV4VW42eSkbYpOAnIEqr21WDSzAhPj094wjJHytmyjrGMUSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NE282zo4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705567591;
	bh=Xlc2Yg/2t4ZtVXLim5SeRE+/1WgtJ76896r0f87mGwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NE282zo4E3JFhSe7KhhmvOaXZFUluByXB546POuZGZRQ5rY0dSFMwkUj2a4+T7bgV
	 HBvJs9yxGTtyaARQZgIDSL8+cPqnME8HVUb8KR/ttRZTH4fLvQ+2z3WRXEdl+EsemN
	 RzbHjBAZJPj4vF5lc84qyzkkrDFGWUfbCHimbadgyMdgYKRCut/iIej+jj4HafgfKm
	 2O73zTuvphCrxL+7VlRc0m7qCqMQpskLOmp2sQ2dXwxRBtwDyA/SQJ541am9TW9m6z
	 UVpAh/Md3F9VfUEiW8if1w4d0V6UAYl3/xU9qCRO3/uhEEBNqlyBoI2hyfB9uwmfys
	 9MyzPvSarjUhw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E39B3780C6C;
	Thu, 18 Jan 2024 08:46:30 +0000 (UTC)
Message-ID: <adf2db77-3d8e-4a59-bbcc-d7e1253bf162@collabora.com>
Date: Thu, 18 Jan 2024 09:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] firmware: coreboot: Replace tag with id table in
 driver struct
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel@collabora.com,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
 <20240117-coreboot-mod-defconfig-v3-3-049565a27bba@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240117-coreboot-mod-defconfig-v3-3-049565a27bba@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/01/24 20:03, Nícolas F. R. A. Prado ha scritto:
> Switch the plain 'tag' field in struct coreboot_driver for the newly
> created coreboot_device_id struct, which also contains a tag field and
> has the benefit of allowing modalias generation, and update all coreboot
> drivers accordingly.
> 
> While at it, also add the id table for each driver to the module device
> table to allow automatically loading the module.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



