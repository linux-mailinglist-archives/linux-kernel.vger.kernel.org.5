Return-Path: <linux-kernel+bounces-99311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA9487865D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93CBB21FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C94D9E8;
	Mon, 11 Mar 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP5wdNZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049729A9;
	Mon, 11 Mar 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178481; cv=none; b=LMtZ7wLxaGD9uThgp6255xALHp+naFIfGu0vdZqrVWFXMBKvrpLZck8FUO8YcobM2HCapvHIxo6U6dFLDuPtfssYGUBMIodfAQ/p0CBzGYnZv2XqAqaUzjok1ScIcWmJ4DachAtl3jgcIO7trsjM0FpyqDSrE0tlhUvCoReBVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178481; c=relaxed/simple;
	bh=Ej9iokf53c+lmdcFKb97Bh3rX/K4nJN37K+iO8QuNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORbXUe+96nF8y/1k1a+2wOuxFaZb3ZuL3AoQT4IWiSyELr/YDVRbENgYKN3lBFAxFos5O2Na46S8E6VwPxyFcXQiJy770kX9vUaZOaMHd01VtdQLEQo7cGvCySTzoANg57tPSdOYjS5x0OYWxalosUuvjdBiNGC7bZEpMI+XWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP5wdNZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41292C433C7;
	Mon, 11 Mar 2024 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710178480;
	bh=Ej9iokf53c+lmdcFKb97Bh3rX/K4nJN37K+iO8QuNG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iP5wdNZRWbyLGV7n0/bjFdODYl8MNg1fI9i4ew9aeafT9munvawc3OOZNIJgUtrXN
	 vJL2ikiWAjyE+xybzKAU+ntk/jAhBvoYfkheLnE38hquKHmVwTLMezI+syNFcbS/pD
	 ZxadFE+//WtrTX8+JmxuVOWIAJ2Faxu34Vn1aKqU05OVZP5DI6Fr6d+aScXF8j7Ouq
	 8np2tczT7U1CeqTRApaWLSLhMg5hI4jJxotuu0bHmF7aSE9cOvR2sNfNDwtUy4OHt+
	 g6HxkyYHB/w4NL4PZiu92p42rhVG3aERV4M7IZX5iIxhRgA97eOeTloUpxk3VINiJJ
	 FF5elrXLxbJgg==
Date: Mon, 11 Mar 2024 11:34:38 -0600
From: Rob Herring <robh@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH 3/3] dt-bindings: hwmon: max31790: Add
 pwmout-pin-as-tach-input property
Message-ID: <20240311173438.GA1451467-robh@kernel.org>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-4-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311111347.23067-4-chanh@os.amperecomputing.com>

On Mon, Mar 11, 2024 at 06:13:47PM +0700, Chanh Nguyen wrote:
> Add pwmout-pin-as-tach-input property.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  Documentation/devicetree/bindings/hwmon/max31790.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
> index 5a93e6bdebda..447cac17053a 100644
> --- a/Documentation/devicetree/bindings/hwmon/max31790.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
> @@ -25,6 +25,16 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  pwmout-pin-as-tach-input:
> +    description: |
> +      An array of six integers responds to six PWM channels for
> +      configuring the pwm to tach mode.
> +      When set to 0, the associated PWMOUT produces a PWM waveform for
> +      control of fan speed. When set to 1, PWMOUT becomes a TACH input
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    maxItems: 6
> +    minItems: 6

Seems incomplete. For example, fan tachs have different number of 
pulses per revolution, don't you need to know that too? 

There's a common fan binding now (or pending). You should use that and 
this property won't be needed.

Rob

