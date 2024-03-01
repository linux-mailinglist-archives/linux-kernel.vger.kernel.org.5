Return-Path: <linux-kernel+bounces-88044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF286DC9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50832B20DF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634669D13;
	Fri,  1 Mar 2024 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbzCC1GB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBB69943;
	Fri,  1 Mar 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279981; cv=none; b=LmoDwE7F7NRctIF317SrFViRPLSkpUJSrKR5tJ/ezTOoLL6JUQyVk1r3C7s3/NJvl3xhGWdkUzG03PeWmB2Sh+Mh7pyW6a1mpaIDm4iOPyQp2xqwtMkCEU8Rgxet6Y9XdsdMc/enHtFWanARYM3NTITsK71x7jSbjfdlFBpfoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279981; c=relaxed/simple;
	bh=onhMwfZHRvjdKu0c6UrVflIw+f+gEw3QbIuux2iitqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooXge5sYe6+cAh39M/uqO3pLJtTs7p0yiGaAlaspWA0CaM0fPSRlGrxdE2T7Dt+w9nfW7mMh3i16lWg+Wm5CGYMAnwNzbuN/SpncEFXjw9f6kHLfp5p2QCaWtrEVvZQ/z3KPtVjt//blvYa/dJHYQV6w+7wI9QUsX99FQziNg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbzCC1GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4FAC433F1;
	Fri,  1 Mar 2024 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709279981;
	bh=onhMwfZHRvjdKu0c6UrVflIw+f+gEw3QbIuux2iitqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbzCC1GBYi9leoX1nhtVp36bYagTlNOwxnVIfgRnttcQVhkkUIIxCXnAvOp4vBfmJ
	 qpUAEi2oIB35VMOzv+Xuq3Xvwrk5UMoyNC8RA07NeKvv8gnasMgBKmx8om3YYA8RiD
	 7HE80TZahJVTAF2PWbL/NSe4+0m+RQVYt7o5w/zP8xi9m/6UR0Ovo17Y4iCvrtX5wI
	 7HGNJzZT13KCgJYTQimVGNDVC6sDsTVpHTWm4c76oZpo62GwsZEPdQeqmpYufkISPt
	 8AE6ouORoLczdGX4oSDaeCYrl9x2bFZhEJXBBv1z0aG6DkcEYY0wufI6IFdfREWrsK
	 DubPyYcNVcGtg==
Date: Fri, 1 Mar 2024 07:59:35 +0000
From: Lee Jones <lee@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RESEND] dt-bindings: leds: pwm-multicolour: re-allow active-low
Message-ID: <20240301075935.GD1209090@google.com>
References: <20240229-excluding-bonelike-d8f01dcc0623@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229-excluding-bonelike-d8f01dcc0623@spud>

On Thu, 29 Feb 2024, Conor Dooley wrote:

> From: Conor Dooley <conor.dooley@microchip.com>
> 
> active-low was lifted to the common schema for leds, but it went
> unnoticed that the leds-multicolour binding had "additionalProperties:
> false" where the other users had "unevaluatedProperties: false", thereby
> disallowing active-low for multicolour leds. Explicitly permit it again.
> 
> Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low property common")
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> This needs to go via netdev as the commit it fixes (and is based on)
> is there
> 
> CC: Pavel Machek <pavel@ucw.cz>
> CC: Lee Jones <lee@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> CC: Christian Marangi <ansuelsmth@gmail.com>
> CC: linux-leds@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: netdev@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Please take this via netdev.

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> index 5edfbe347341..a31a202afe5c 100644
> --- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> @@ -41,6 +41,8 @@ properties:
>  
>            pwm-names: true
>  
> +          active-low: true
> +
>            color: true
>  
>          required:
> -- 
> 2.43.0
> 
> 

-- 
Lee Jones [李琼斯]

