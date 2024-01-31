Return-Path: <linux-kernel+bounces-46118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD1843AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B90B1F26BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D5679ED;
	Wed, 31 Jan 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5BOpaePE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5960DCC;
	Wed, 31 Jan 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692459; cv=none; b=sVaid/6xudwgZVTmzPC/IDKih3RC95zVpLHBkITxREfIn3VhiHL8Y+hIomkFsuSDiAqkPizUWr7zE2IW+E/aLXrRrz53zQilEj5KElUTkYj/dmNSnh1e+25MDPNh7au2KDkw5fJK+8txWf6obrBwO3L6JwccKMBM8yfM4V4Y3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692459; c=relaxed/simple;
	bh=2PwMDPC8NQUUg2/errtkejxFs7bUsyCxqaGHwtreq5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0T942FZQqxVnLBfTh8JLuorPQ1F0wxL7Rkygm7mHtT+b78dm5eFq8BFYOdzHv8ZMW9PNMGHTvdD/gEgAob2MMk7pOH0M0niOF3HwqicdybVv/6/+6y8zIuMLVJMwOm0+b7kTkFOlDwDDwrhdqeIFLmgDPaUxT/bF/H5BkWZykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5BOpaePE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706692455;
	bh=2PwMDPC8NQUUg2/errtkejxFs7bUsyCxqaGHwtreq5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5BOpaePEXnLgEs0w1foP+e3f5pZOcnJ/DghUTUze1p1o71HWeTKA5x7Knkrkzhpl9
	 MTDjRqvSW7UD4oGEHttevqzOPREsJ6FTScbMIimoU3wBnG1UNuPG4Xix//3H+JQhpn
	 UcLadPJrzrpSzOpdEUNp68OdCwc5nyul6ZfVu3jdXPrmo4BHrDwgobfxXiFe7ojp3N
	 M1J+onqRju+S5rjQ/5qSHs+Eu/p9MLOwgPpFwzKPFqfWnZQkfmJWubwuoGiTW+7gVn
	 ua/aOanAG2AV5hBE4LE/mUxYg5sBrqVIGMeQFmrS9pK+uxqjJzcQwJuJ81hg6UvN+v
	 6b0e0QyDlh5xw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3942D37803EE;
	Wed, 31 Jan 2024 09:14:15 +0000 (UTC)
Message-ID: <6f2e1340-4fd8-48ce-91a1-f94486732abb@collabora.com>
Date: Wed, 31 Jan 2024 10:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-pico6: Fix wake-on-X event
 node names
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240131084043.3970576-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131084043.3970576-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/01/24 09:40, Chen-Yu Tsai ha scritto:
> The wake-on-bt and wake-on-wlan nodes don't have a button- or event-
> prefix that the gpio-keys binding requires.
> 
> Fix up the node names to satisfy the binding. While at it, also fix up
> the GPIO overriding structure for the wake-on-wlan node. Instead of
> referencing the gpio-keys node and then open coding the node, add a
> label for the event node, and use that to reference and override the
> GPIO settings.
> 
> Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



