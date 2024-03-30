Return-Path: <linux-kernel+bounces-125776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B075D892BFA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D2A1C213D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAAB3B19C;
	Sat, 30 Mar 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNh16Tgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B013B797;
	Sat, 30 Mar 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815305; cv=none; b=e14k0Xt2iNXVIBPqvWhDiThXLs5V18eCBgaMuxHhs7cBsAquw0F2YJr9J/YQ+Xf7pZE8LziKi/kWaa6ZJYalpPQs/TMFZypSVgCAvwoQQc3Z4SHwI4AhgTnpMRWMpCbHePoBm2nAwQNmjSXLfsAiNM3zyr+S0Ts/m7p+GjpjGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815305; c=relaxed/simple;
	bh=R6e1rgzG7LLbsqpqTULDF0Q5Ol6Unlo2PfLYVNjOD54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnkJKSM1cGRMypXomX1ROl/AR5xh6QsNCYBq644BBxTSqS1ODJo7Wofrr0AiNO4En/3821PCYo8copxKAhBZUlcWO7PXPU4kL1JQTRXWtIv0w9XdgYJmBb/kMlet6ypTfFQWaWEBK4tTp1N7lqRp6W8RmpUoacZAH3kDRXKezng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNh16Tgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7176AC433F1;
	Sat, 30 Mar 2024 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711815305;
	bh=R6e1rgzG7LLbsqpqTULDF0Q5Ol6Unlo2PfLYVNjOD54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BNh16Tgxho5L7S5bQv5qAVnwoKQna8KWMINLgiBnkEflse+XfkwMhoq0SpLr7AXWD
	 8vNzzTsEx2xrhLjbOdJ3dj0zrEEfh2ILIEug7EEk4e5cysqBg1dAhaZN4yZbK+uuof
	 k0fcl583FLP4jVn6AQ9Lq/qOee88IImIh4gPvnmz49IcSl44Wfo+V2UqkT4LbC0JYw
	 0XjeYZZvnLVyXLFkTE5LW9dlqgtwSLuJ0ig161xdlAq3aG2C9jPdJvhDUv3KGGojIv
	 apeLJFVYToDcG1NcrdJeATB0WA79CKsc+1dy0HBWmlhN7jpdHE3OUF8MD87NWjnitc
	 piONJ1ckhJ8sQ==
Date: Sat, 30 Mar 2024 16:14:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: wefu@redhat.com
Cc: jszhang@kernel.org, guoren@kernel.org, conor@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 lars@metafoo.de, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
 marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 marius.cristea@microchip.com, fr0st61te@gmail.com, okan.sahin@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, lee@kernel.org,
 mike.looijmans@topic.nl, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC
Message-ID: <20240330161446.21ff631b@jic23-huawei>
In-Reply-To: <20240329200241.4122000-4-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
	<20240329200241.4122000-4-wefu@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 04:01:26 +0800
wefu@redhat.com wrote:

> From: Wei Fu <wefu@redhat.com>
> 
> Document devicetree bindings for the XuanTie TH1520 AP sub-system ADC.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>

Hi.

Few comments inline.

Given Fugang Duan is listed as a maintainer I'd also like an ack ideally
from them.  BTW your +CC list seems a bit random.


Thanks,

Jonathan


> ---
>  .../bindings/iio/adc/thead,th1520.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
> new file mode 100644
> index 000000000000..80890ce62810
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/thead,th1520.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: XuanTie TH1520 Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Fugang Duan <duanfugang.dfg@linux.alibaba.com>
> +  - Wei Fu <wefu@redhat.com>
> +
> +description: |
> +  12-Bit Analog to Digital Converter (ADC) on XuanTie TH1520
> +
> +properties:
> +  compatible:
> +    const: thead,th1520

See the example - doesn't match.  Should be -adc here as well
as this is just part of the SoC.


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: adc

No objection to having names, but if there is only 1 why is
it required?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - status

Status doesn't need to be here

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc: adc@0xfffff51000 {
> +	compatible = "thead,th1520-adc";

As the bot pointed out, spaces not tabs for these - Please run the suggested
tests in that email before sending a v2.

> +	reg = <0xff 0xfff51000 0x0 0x1000>;
> +	interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&aonsys_clk>;
> +	clock-names = "adc";
> +	/* ADC pin is proprietary,no need to config pinctrl */
> +	status = "disabled";
No need for a status entry in the example.


> +    };


