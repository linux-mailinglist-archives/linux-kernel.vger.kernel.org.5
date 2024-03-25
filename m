Return-Path: <linux-kernel+bounces-117268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF788A96F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E2D322E54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FF128823;
	Mon, 25 Mar 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBu3GFHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB958135;
	Mon, 25 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377409; cv=none; b=b0kObiX+gqydCXN2jPxbA62x4n0s/7bn54hbhRYbUWAOXEAWopejF7TPPcM9Kwgdcw/Z2PLKhHRelwIm+H1cf9JDWV4pwYOyx6ZNk/zEEfr5ahbilk3JqrTjsp086cBlAH4lXhWxTym2CTeAwQh31NOqy1QjFhtFTksp22p7WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377409; c=relaxed/simple;
	bh=9Qe/3gikq2clmRBfjTNKgor6Y6DhAn8an5PiAqL/lqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfxUTOFw+B/U1rTvSym+JGV0IJpilqxOMs+tWxFKgviBbCFxpVL/I0N6FhxAvJIiXkdzSOCywHPiIE2OpqiKSyMeBYHnHljnxIZTC2o2GGDEIYuYKqzjOZyB2ClxGAN9ryv0IZQgLAFq/nud/CHgZtACCmGz5osRYviecM01GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBu3GFHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D1C433F1;
	Mon, 25 Mar 2024 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377408;
	bh=9Qe/3gikq2clmRBfjTNKgor6Y6DhAn8an5PiAqL/lqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBu3GFHgd64EEQ6NHJ6CqPTLWLLzUk1XuaHt9Ll03UYJR+IqIMELoRgvmKxNiw0xO
	 Cba4oOz+nYXiGyZoJtbVOPY8qJ5JFSMGY5gMFUmwpAhqWNYZH8iZkQIoHYoywnBjlV
	 BAxfA1HE1NWYaSv0WbE2RtLX8LbnglngBbBgYkqQlUydIBKvF3v+nMn5xna2ahYU2k
	 AfpNyiBPzEdH1tRV/RniYF9F74eokbYmjZRzk1IcT+s7GJH8PYAsjQ8PQGnuo4t+0i
	 A7ODhZOGKH+bKdebrMBNXMstZZYr7IwDpoUwQPt20sykp37tvqjoleOGhGGT8jUXRo
	 GTOVpjgQwT71w==
Date: Mon, 25 Mar 2024 09:36:46 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: samsung,exynos5-dp: convert to
 DT Schema
Message-ID: <171137740493.3330504.1269871894633902325.robh@kernel.org>
References: <20240313182855.14140-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313182855.14140-1-krzysztof.kozlowski@linaro.org>


On Wed, 13 Mar 2024 19:28:55 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5250/5420 SoC Display Port Controller bindings to
> DT schema with a change: add power-domains, already used in DTS.
> 
> This Display Port controller is actually variant of Analogix Display
> Port bridge, however new DT Schema does not reference analogix,dp.yaml,
> because of incompatibilities in the driver.  The analogix,dp.yaml
> expects two ports, input and output, but Linux Exynos DP DRM driver and
> DTS use only one port: output.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Document deprecated samsung,hpd-gpios
> ---
>  .../bindings/display/exynos/exynos_dp.txt     | 112 ------------
>  .../display/samsung/samsung,exynos5-dp.yaml   | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 112 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml
> 

Applied, thanks!


