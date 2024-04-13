Return-Path: <linux-kernel+bounces-143780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BFF8A3D67
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AA31C20C05
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04846B91;
	Sat, 13 Apr 2024 15:25:07 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE545C1C;
	Sat, 13 Apr 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021907; cv=none; b=YRzmApCbiNCp7kAYMCDcSMBMNjis5mb5ut6LTq8hAw5R+9kK5zLar0nlf/DqtpXNssy2nmfmQZd3cdCGFxfPFul+xvG5G0Ywm1z5e2uZZFY5RjHCwUcfxCGWvVNae2j/uHx4M/UCJSH7RdrpwQx+SVOV3CdeqbO6OXq9oVT0R0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021907; c=relaxed/simple;
	bh=c7ntYBHFF2eWlWyEZXlqIrZDYsmFA2CHB5sWZvsVvAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLOSfDjRE7MPxpDK72fnJO78iK0E88w234KQUQzvf4ORVb611LKICx55J88Xfe4dTv7cHhtQwllshv7vFihQxs+fy+Dtttt+UoQlfMhLEHkt5abtt9aT9yaCu6JNzyze5prvNEKwj8Md5LItjgtLTwJz/mSfM+9XreH8+qzUMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 7E63920039F;
	Sat, 13 Apr 2024 17:24:44 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id DA82C40039; Sat, 13 Apr 2024 17:23:50 +0200 (CEST)
Date: Sat, 13 Apr 2024 17:23:50 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid error message on rk3328 use
Message-ID: <Zhqjhvq38oNH5-sR@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
 <f245966c-267f-4159-a9ca-2561693d24d9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f245966c-267f-4159-a9ca-2561693d24d9@linaro.org>

Hi Krzysztof,

On Sat, Apr 13, 2024 at 05:09:33PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2024 15:56, Etienne Buira wrote:
> > rockchip,rk3328-grf-gpio is handled as syscon, but syscon mandates
> 
> syscon does not need such property. I see it in gpio-syscon, but not in
> syscon.

gpio-syscon, indeed.

> > presence of gpio,syscon-dev node (or it will call dev_err() when probed).
> > Correct rk3328.dtsi and related documentation to follow syscon's
> > expectations.
> 
> No, look at gpio-syscon driver. Parent is used.

Parent is used, but the next lines are:
ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1, &priv->dreg_offset);
if (ret)
	dev_err(...)

So if gpio,syscon-dev does not have at least 2 items (or is missing),
dev_err will be called, 3 items for dev_dbg.
Current tree displays a spurious "can't read the data register offset"
message.

> > 
> > Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> > ---
> >  .../devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml      | 2 ++
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Will do, if we agree on the interest of patch.

> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi                        | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
> > index d8cce73ea0ae..2c878e7db900 100644
> > --- a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml
> > @@ -38,6 +38,7 @@ required:
> >    - compatible
> >    - gpio-controller
> >    - "#gpio-cells"
> > +  - gpio,syscon-dev
> 
> No, not needed. And also incomplete - where is the property defined?
> 
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

ditto

Regards

