Return-Path: <linux-kernel+bounces-148690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF28A863C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9DA1C21344
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5121428F2;
	Wed, 17 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzRBw2TK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF61419A2;
	Wed, 17 Apr 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364858; cv=none; b=Pke4Tt5HnBrGOUnCTstWxRPpsh3/Si2SiHaR0xdEQ2zxx0Zpph5RubjORReHy5CcHCQ+Chsy1qV1/J0EuFsflIp1M9lZcnpxzzgg2tQku4b8OQt1ug4/cJEyv1q7GQZMbQBtkgn47wWL0GptEusHYh9lgTEzc6tR3tYolpQY/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364858; c=relaxed/simple;
	bh=cA9scemWzsFPzGRaNP28UzTwSugriMk3blVS/UdZG5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmjI0fnVlplqc8ZmTAePsXjtvwaJ3DxxHpdd+xGyvIwYJSmYXa9PyAw0pAk+zpUjdt8Up3lHoJOi5PPsxGv1YkZsFjvMOQxIWhfn6qc1o91aaJJfK0GpkkvYCzf5gSgKFpwflenQl2SHFTP4/IdpEDN8R8iJ7eTOxF7VcW8xKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzRBw2TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5F6C072AA;
	Wed, 17 Apr 2024 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364858;
	bh=cA9scemWzsFPzGRaNP28UzTwSugriMk3blVS/UdZG5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzRBw2TKlNf290/RbUJs5YW4I8FKBGmlxBfHu94FlQsrTRnCtbIQBYX6daCmCUTYF
	 yp688MjUGxUF4Si6PNGxbw80Z28XuRCrG9hxHjicTVTui70H8X5pVofBDvmnetTGY8
	 2GCc4NlMw+cG+CKNkcJkoDJQbuayL8jjIJsaNsBnsbZjezXGAMjVLKQrGBDHYaAVXW
	 dN6Z1rv9GyNx0kCqgyyU+iideLd9fm9xzpoi+9IynigDdBjQvynIRhueNUnYU0lGns
	 cdwAMIHvk0vhDjuwIQ2wuPy/c22Vz+T6UfPMNuqDQdtOQdCUOcIIqdOddeyBsjJE0O
	 i9rAFiploTiQw==
Date: Wed, 17 Apr 2024 09:40:55 -0500
From: Rob Herring <robh@kernel.org>
To: David Wronek <david@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Raydium RM69380
Message-ID: <20240417144055.GA2335446-robh@kernel.org>
References: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
 <20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org>

On Tue, Apr 16, 2024 at 08:30:48PM +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
> Note:
> Depends on commit 48a516363e29 ("dt-bindings: display: panel: add common dual-link schema")
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
> new file mode 100644
> index 000000000000..0ac7d033cbe0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raydium RM6380-based DSI display panels

RM69380-based

> +
> +maintainers:
> +  - David Wronek <david@mainlining.org>
> +
> +description:
> +  The Raydium RM69380 is a generic DSI panel IC used to control
> +  OLED panels.
> +
> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - lenovo,j716f-edo-rm69380
> +      - const: raydium,rm69380
> +    description: This indicates the panel manufacturer of the panel
> +      that is in turn using the RM69380 panel driver. The compatible
> +      string determines how the RM69380 panel driver shall be configured
> +      to work with the indicated panel. The raydium,rm69380 compatible shall
> +      always be provided as a fallback.
> +
> +  avdd-supply:
> +    description: Analog voltage rail
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: phandle of gpio for reset line - This should be active low
> +
> +  ports: true
> +  reg: true

Drop these and change 'addtionalProperties' to 'unevaluatedProperties'. 
Other properties in panel-common.yaml should be allowed. width-mm and 
height-mm for example.

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vddio-supply
> +  - reset-gpios

> +  - ports

Already required in panel-common-dual.yaml.

Rob

