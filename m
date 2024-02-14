Return-Path: <linux-kernel+bounces-64908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76146854487
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32811285354
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3210A35;
	Wed, 14 Feb 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r3X8VTjj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184D79DF;
	Wed, 14 Feb 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901419; cv=none; b=WqMjEdmuMPcq1PpjAw8k75yavCIUOFfNkvk2fEf9I4vGcEQxnrJD9Gx5ndILIytuPbkur0197t/GVSzs2TqgwdA1OAD8Phbqki9Yz27a75K2cT3bV2icYDDg50nZ2sK38lTNkZEJR7d2yH+PmJPaCy1W9r1oP/YQDO+7hXR8MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901419; c=relaxed/simple;
	bh=E4Fif1h9LAA837algbblMC/VbtR1NPcDBXt52yRm3WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCo0RwT3Bi80h5ycmX2BwrcJhJxe1c/DBTtgw6mI+xniqpKBbCumHcXrnQR9OjRTFr+0wIv3P4YTrSy9UqNhYrL4PTid/NLvYUBKMXSqw7jw4KsDBV+C4d/VErhoPgWIxm1eG0U9DU9HLnlTRAB9hxTlTvw6byXs1V/qfDXET3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r3X8VTjj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707901410;
	bh=E4Fif1h9LAA837algbblMC/VbtR1NPcDBXt52yRm3WQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r3X8VTjjoFJUcBdiXZ0v6uttY6TAs5Xt4/Ya0lWRAaqEmQ3u9e1RmD2eNiZ4I4h6m
	 yB3BhPiRh3G1sOWARcawu3l8fQp/URU71ShBah7Bw44g7bT6W9rgYQmEW+X/i9RhHS
	 r/q2AJYbvhP21Zx4Ci8vc9labXo96H8JIiFcCezw5zrf02EaN1ChS+dcHaG+g6RM2z
	 EWWpUuWsxYPGZ9lFUKo4aGZWS2evYlR+WjcZ6a8kCeiyyRYlBkUtm8RDtpzuQCTor8
	 7I3sd/byrRT5b/y98KLu0h5sjsofgI8wbGTcfMq33I6tzy8hPGGu4isOHSqkeydP6x
	 axSIHwXWLwr8A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E01DA3782075;
	Wed, 14 Feb 2024 09:03:28 +0000 (UTC)
Message-ID: <c8878258-9f3b-4e2f-a022-3bd43bcfd02e@collabora.com>
Date: Wed, 14 Feb 2024 10:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt8186: Add missing clocks
 to ssusb power domains
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240213-mt8186-ssusb-domain-clk-fix-v2-0-1f981d35f3fd@collabora.com>
 <20240213-mt8186-ssusb-domain-clk-fix-v2-1-1f981d35f3fd@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240213-mt8186-ssusb-domain-clk-fix-v2-1-1f981d35f3fd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 16:02, Nícolas F. R. A. Prado ha scritto:
> The ssusb power domains currently don't list any clocks, despite
> depending on some, and thus rely on the bootloader leaving the required
> clocks on in order to work.
> 
> When booting with the upstream arm64 defconfig, the power domain
> controller will defer probe until modules have loaded since it has an
> indirect dependency on CONFIG_MTK_CMDQ, which is configured as a module.
> However at the point where modules are loaded, unused clocks are also
> disabled, causing the ssusb domains to fail to be enabled and
> consequently the controller to fail probe:
> 
> mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@4: failed to power on domain: -110
> mtk-power-controller: probe of 10006000.syscon:power-controller failed with error -110
> 
> Add the missing clocks for the ssusb power domains so that they can
> successfully probe without relying on the bootloader state.
> 
> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


