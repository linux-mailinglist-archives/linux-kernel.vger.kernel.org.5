Return-Path: <linux-kernel+bounces-142227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737ED8A2932
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2843B1F22DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD945026B;
	Fri, 12 Apr 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HBJnRm4K"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552022606;
	Fri, 12 Apr 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910116; cv=none; b=B3VaGlKqnzpdzo1xulcMZECXjXcYWZMuG6gmovGvFrGLt1zdDJ7KJXnGRhhgMNP14uDzi6ysJicz4KeX21ACZeXdDCM/9HrOHp2DghLhMPivDHvQoQV5OmrE6t+hfEQFp2Dr+kt84LTO8dEPXn0j2fZIhDvYUMEwa1txr/w6+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910116; c=relaxed/simple;
	bh=dMvfufHeUkxZzXlJdk1qiATkZtsbN4RCI5YFOljiONA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u39i7nWURp5DeCu4ZvieWMT9XH9cHwX7Es6dtyS8U2Qj9iyOhNLtzuR9WmFtV3en5O/bCbAUxSa+NxPlnTPIcr+0SsfRt3UieoBkoXGX7P0rYrOwM/4XeGtrORDAh82PH7lprfk9gzdJyvENPoh8ba0BpGgQp7mqSMZS5NYCBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HBJnRm4K; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 398302000A;
	Fri, 12 Apr 2024 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712910107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nG1yXB1XEUMftHkpIGuydKh68O6oshqMzKBjchWUWDI=;
	b=HBJnRm4KJwgoJG/yw+/A62Pxo7TJ9fF307KWhyPxNW6XlyblM1LsFtqnIJVxKMW9pgFeKd
	Kyct1zJOUrAeuPp9jEG2vftsgxAfHY4hLp8fdpw0kGJrgK/AZjR0AJu6WsDT4bUlBIyNm8
	r4DB4j3ZWZ7q3V8wGji13KKrBdSQVS3IDqOnwbFG9I3mX02TVhSKRA0N7rIFdfuKilXL2r
	5whRGiSrTfRMO0zz4dgp+hITgM0yslOxNcdupC3yHfFSKcAD7WxXpEZwiO7idRhNg8h05e
	o7IsN5zlJQzuTBuBvp57Nr8M8b7z4IJx5fQfzGWhzmlkxxOaf5jr6kU41Ev7og==
Date: Fri, 12 Apr 2024 10:21:44 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: wefu@redhat.com
Cc: jszhang@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 5/5] riscv: dts: thead: Add XuanTie TH1520 RTC device node
Message-ID: <20240412082144c4a3d9b2@mail.local>
References: <20240412080238.134191-1-wefu@redhat.com>
 <20240412080238.134191-6-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412080238.134191-6-wefu@redhat.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/04/2024 16:01:47+0800, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Add nodes for the XuanTie TH1520 RTC device node on the XuanTie TH1520 Soc.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index cd6bc89a240c..62e588dbc942 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -463,6 +463,17 @@ timer7: timer@ffffc3303c {
>  			status = "disabled";
>  		};
>  
> +		rtc: rtc@fffff40000 {
> +			compatible = "snps,dw-apb-rtc";
> +			reg = <0xff 0xfff40000 0x0 0x1000>;
> +			interrupts = <74 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc_32k>;
> +			clock-names = "osc_32k";
> +			wakeup-source;

The wakeup-source and interrupts properties are mutually exclusive.

> +			prescaler = <0x8000>;
> +			status = "okay";
> +		};
> +
>  		gpio@fffff41000 {
>  			compatible = "snps,dw-apb-gpio";
>  			reg = <0xff 0xfff41000 0x0 0x1000>;
> -- 
> 2.44.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

