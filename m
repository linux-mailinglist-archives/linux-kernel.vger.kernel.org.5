Return-Path: <linux-kernel+bounces-137223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BCA89DF18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BB71C20D05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8C13DB88;
	Tue,  9 Apr 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmuY8Bcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3D135405;
	Tue,  9 Apr 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676398; cv=none; b=oV1nuh7PYqUy/P6dOEFm+QWFH0I36Q8rtb2jVfOX1wEarGWW3UZ1ihj0Ooqygp635a+oad019jpFb9MVH75CHkrAQuc/jSwewRRTbM52QrBPCJJOTc6q7lHkKq+QM13u9DiTc1K2KWff5Y05uvh8vrfObsr3pp6rllbgh35Cn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676398; c=relaxed/simple;
	bh=oCGXVyPyR9B3gNUVZorJo7CahECeQomuVMDkB/ArHes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egCOovDGCPjja5BjaRCpA28/nR0xE7JzBvj3irnaPQI+Sw/lkSMrP6smPTQMwrJccn+mVD3uiSxLiWIJv6cPbx1z6nVTGU1nFWEICaMj0eWstSk7JPV5fn8QX47OKjmhsexsUb69KiV+koNkTCR01utXOnngqLLMHDyw17wmPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmuY8Bcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4A7C43390;
	Tue,  9 Apr 2024 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676397;
	bh=oCGXVyPyR9B3gNUVZorJo7CahECeQomuVMDkB/ArHes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmuY8Bcjk7RIfLkVWu5lRVYTeo0dohNfwjfmvJ9X+LABWVwUCJHFLc1AwmqR++tW1
	 2NziFaHSE4+XLtT5of3JVlEaG1p1neewig3CNaBhOwODe9s5hJnwTYT+n9K7M+hdkl
	 c4PJgD9/W03RtH+/WOrWe5pghLTFWucpQc0qrrjB5I6U01EmWKOp44TWRkySbY2xgC
	 H1NWK15e8yIk6olNHLX0B4GWN8f0pM7l7bZjjmvRgG7ljmA3MgVcHfrozeNR31L+en
	 LxWzIijG1kPkFcUEZL0GE41EjRTrpSsk75EdMMnRv4Kes4TsbaQdN7xPLoRQsmO/Tj
	 PpAtlfUrhu0kw==
Date: Tue, 9 Apr 2024 10:26:35 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add compatible for MT7988
Message-ID: <20240409152635.GA1289655-robh@kernel.org>
References: <20240213130044.1976-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213130044.1976-1-zajec5@gmail.com>

On Tue, Feb 13, 2024 at 02:00:43PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 SoC contains two on-SoC XHCI controllers. Add proper binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)

Seems like this got missed. Applied now.

Rob


