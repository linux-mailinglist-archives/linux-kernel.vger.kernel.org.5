Return-Path: <linux-kernel+bounces-45281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC5D842E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002421F25802
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5110E6E2AA;
	Tue, 30 Jan 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoX5hB+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740E69E1A;
	Tue, 30 Jan 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647164; cv=none; b=eH9pQ1aNKcWE5Rbdw52Gg7DsKHS3bdlGToxiVi/9Sbm1PNVXhMi6LiEh5XecJaEqNUKBw3fYTzE1VZLaQWaom2MvyVzssJ6EVmoLTMOMQj7KtbfwZGz+C9vlOMS4YPmdXfcT+t/qDE+pT1Ofqz87tDMvZgnb+ZO8V3YwHD+W9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647164; c=relaxed/simple;
	bh=K5vOyDAZH33Lnu4vDYurahA8ZLJkazz+ZavXy0qdlzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNNcBFTWKU+J7YxaKjIhWIMb0GaDggV5S8HBD/2LGzYtbiTjPZZB7ecKZ7y/YIRPBKAEe7LE2SMJPlrVVyhDJ+hPd3e8xGHlF6BKwwDs2DYNcjrF9uu6SpR1QAvWMc+jZEjLqVQM8v1eBuJ5rJZIpcBOX7mezP3pgDI38lmxecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoX5hB+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83E2C433C7;
	Tue, 30 Jan 2024 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647164;
	bh=K5vOyDAZH33Lnu4vDYurahA8ZLJkazz+ZavXy0qdlzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoX5hB+p4SSfKQGPNSa0c86H8hkuAvHqMuN1ovtOhzbNn19U3HQrINYCfHeBGxl57
	 lJYh+tXBR2EULslL/VGNQ6o9oM+loW/HYDKC3r1t5IV+MGXXhefzuzGOurJ1tI9hMT
	 axJxHKVLIpllO8Cu3DHv4TLQ31tdd+BkcCBswm099isd+OdthJfRJtUcjZZnITmNyA
	 HTz5w17vnEldTbnOZDc01BvmzZRCkAh3xqV+LWsfhlBG/9bQikPzxssVrqMtSQHlIA
	 qqqoTjm1DXpYwjeqZCwYbdeiSF6xBIdmXvLe7Bdwf4DGfLqwOQZA6qkxaFiP1U3Ap/
	 Yg0uAga/DcCjQ==
Date: Tue, 30 Jan 2024 14:39:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: narrow regex for unit address to hex
 numbers
Message-ID: <20240130203921.GA2300248-robh@kernel.org>
References: <20240123083312.20808-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123083312.20808-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 23, 2024 at 09:33:12AM +0100, Krzysztof Kozlowski wrote:
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index 7a4a6ab85970..5b9fda2a81e0 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -60,7 +60,7 @@ properties:
>        be implemented in an always-on power domain."
>  
>  patternProperties:
> -  '^frame@[0-9a-z]*$':
> +  '^frame@[0-9a-f]*$':

Technically, it should be '+' rather than '*'. But I'm pretty sure 
generically we check that node name can't end with '@'.

