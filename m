Return-Path: <linux-kernel+bounces-71321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4A85A37D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6EE1C23904
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9033CE0;
	Mon, 19 Feb 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lsfUKLy1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4831A61;
	Mon, 19 Feb 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346011; cv=none; b=mLN2/b64Kax3n3zvF73ZLF1kpFWgSOxAr/grd72je0tX8YKTff3Ixoa70bVp78B5qdJgpTWcvzCHqN/XfF+e/Ia5VM8yeh03y7OxAwoaAkSY9GsWKPGdmQVxbPLEp4S3R2TwkU+ovXW63bjZttmDeMVnLwphYoHtkJWydpVNodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346011; c=relaxed/simple;
	bh=xwUbvQQzwKR0HkhBjmcu7L7bevII6H8fbUCpXghrq20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrdpgN8sUws1SEEaGmMYtbOvVSJMLoXx9wY03FYUG4u+FT89qRzYXgkmuQSt5RNeg0k0KqTvSvzX7Xs0dPS4m3++nZDU+TcJAVlI2mchV7YFeKGBfh1OqOACE+iSvR1bqbvrAtau57mLDCDNw9KSk+YyASa/ahhLWM6p4/l0qZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lsfUKLy1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708346008;
	bh=xwUbvQQzwKR0HkhBjmcu7L7bevII6H8fbUCpXghrq20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lsfUKLy1VGDwkUu+GyF5x2nSG0Jc+HBUbCHlks/+DsxcUhns942nF/Sbz/O47/ZfY
	 iisdTnRTZJNDcr7mTgNe92U9iAXbEESSDlGkYKUjtgHet2QpVPpuTlz9pqJvJN+8Kl
	 D/ZxJ+/OWxEnF5fgk9kxLBXtOV0uS5bO8/MM4OEdC94s6ysKsIsuqPFSKBKJS81VEo
	 cS0zIh+UE3NheXoPyk/iZQgUJeUh3eKv9rdmnqhSJAG5Tm4Vw27wqDRq+eFvJm+hiP
	 6SjqO9O1hb2AZWeWOeAYSjDZqxrLncAQKbU15Mil2QCDWnFu604t1L99JgDNUEFLpB
	 NB0UKtLm7BFqA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64D723780BFE;
	Mon, 19 Feb 2024 12:33:27 +0000 (UTC)
Message-ID: <94919703-18b5-477c-8dc4-9a359129284d@collabora.com>
Date: Mon, 19 Feb 2024 13:33:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as
 critical
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Jianhui Zhao <zhaojh329@gmail.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: John Crispin <john@phrozen.org>, Steven Liu <steven.liu@mediatek.com>
References: <fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/02/24 04:11, Daniel Golle ha scritto:
> Without the SGM_REG_SEL clock enabled the cpu freezes if trying to
> access registers used by MT7981 clock drivers itself.
> Mark SGM_REG_SEL as critical to make sure it is always enabled to
> prevent freezes on boot even if the Ethernet driver which prepares
> and enables the clock is not loaded or probed at a later point.
> 
> Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



