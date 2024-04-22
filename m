Return-Path: <linux-kernel+bounces-153614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89D8AD064
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB41C21B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591715252F;
	Mon, 22 Apr 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbLfiK2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637A13E8B2;
	Mon, 22 Apr 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798867; cv=none; b=Czlg5O4GbVm9/rWAWxkwL0sSzU/IlLwrs61Lyc/5JOviXjHAsEHumheJfxdWKOnMujyywC+vPFAXODQAwzxkxCyQFrl/8uBjlX0tG/L6Z7lZxuuPim1GjgrretpMUPxG6hC616g5RL8PC5eWUaLtb+osiHo6loWh+izd4vrgs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798867; c=relaxed/simple;
	bh=jnc8O2OGDn/sskDkfr8kRfCzr/w39Wo4NtWiEW/JWM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHR3FRw/gQwQJw99t67/Yb+R7PLV49Njq8lavbvPHbCskggvUDxgwLaHrqOkxSX5A5x9+GbvFx0sk91G1DPzj6hduuoSidDFVj+4IS2ZLVivEj9HOYgoDlirT/b2YGjL02HcFzj8F9/fUHp485hcJcE6sE3DnDHQ8/Qk6lgcJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbLfiK2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6B3C113CC;
	Mon, 22 Apr 2024 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713798867;
	bh=jnc8O2OGDn/sskDkfr8kRfCzr/w39Wo4NtWiEW/JWM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbLfiK2ufzKxA6jCwnKjq433CsonhZ0Ilo5x0049M1HyXqulkL8q/0V93hQ9+B3o4
	 tL6PIoI/CHaQR6hcmn534Fc8yhmcXcIbyRrciLKyx+EFioKfkr5vnzgqFXe1RQytAe
	 K3Rlg3uw39b4QRM7FeyFSWAwT/+JW4/PAT6FHjHoKHhayBjUIC7OvhaGnIjM2MH9y/
	 GyfRUDB7IPeiWlyccDj98BIr8Es2A6hvdlSglgtOqeLGqyP0P6K5uWDVmna2lIrjge
	 n1FsoHDD/W4w5E8z/uBz7qoLRiwIVuavumTN9FYiLbx0+osUjZLuAvbJhHmQ8kcaI5
	 wW0UGuhsMDtiA==
Date: Mon, 22 Apr 2024 10:14:24 -0500
From: Rob Herring <robh@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	airlied@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v2 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
Message-ID: <20240422151424.GA1273350-robh@kernel.org>
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
 <20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com>

On Mon, Apr 22, 2024 at 05:03:04PM +0800, Cong Yang wrote:
> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. So add new documentation for
> "starry,himax83102-j02" panel.
> 
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=zBQJUC4CB2wj4s1h6n6aSAZQvdMV95r3zRUw@mail.gmail.com

Please summarize this in the commit message rather than referring to a 
link to understand "why" you doing this.

> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
>  .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 906ef62709b8..53fb35f5c9de 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -32,8 +32,6 @@ properties:
>        - innolux,hj110iz-01a
>          # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
>        - starry,2081101qfh032011-53g
> -        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
> -      - starry,himax83102-j02
>          # STARRY ili9882t 10.51" WUXGA TFT LCD panel
>        - starry,ili9882t
>  
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> new file mode 100644
> index 000000000000..2e0cd6998ba8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/himax,hx83102.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax HX83102 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
> +      - starry,himax83102-j02
> +
> +  reg:
> +    description: the virtual channel number of a DSI peripheral
> +
> +  enable-gpios:
> +    description: a GPIO spec for the enable pin
> +
> +  pp1800-supply:
> +    description: core voltage supply
> +
> +  avdd-supply:
> +    description: phandle of the regulator that provides positive voltage
> +
> +  avee-supply:
> +    description: phandle of the regulator that provides negative voltage
> +
> +  backlight:
> +    description: phandle of the backlight device attached to the panel
> +
> +  port: true
> +  rotation: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - pp1800-supply
> +  - avdd-supply
> +  - avee-supply
> +
> +additionalProperties: false

Perhaps 'unevaluatedProperties' instead. Don't you want to support 
standard properties such as width-mm/height-mm?

> +
> +examples:
> +  - |
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "starry,himax83102-j02";
> +            reg = <0>;
> +            enable-gpios = <&pio 45 0>;
> +            avdd-supply = <&ppvarn_lcd>;
> +            avee-supply = <&ppvarp_lcd>;
> +            pp1800-supply = <&pp1800_lcd>;
> +            backlight = <&backlight_lcd0>;
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 

