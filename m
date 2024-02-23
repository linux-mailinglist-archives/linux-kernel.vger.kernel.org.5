Return-Path: <linux-kernel+bounces-78583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65FB861556
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A4286B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BABC7175E;
	Fri, 23 Feb 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfzzO8cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B0224D8;
	Fri, 23 Feb 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701384; cv=none; b=L1HOD8DqQh+NLYuwr0lci9Mb2Ltvf2yIzNOOGSniCuHi6sfovXxl+SP1NI2aR1r66mPsaGRvRyY59SziI6syrchdNhq1OdUpFA6j2cQm9H6LF4uq6ayYhXvnoTKcy8PPS7bvLVJh5qlRTF9MuacQ1oo7WhyCSfDoZ4r8Is2UOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701384; c=relaxed/simple;
	bh=hiDT6YHGmh3oE5cDRrYXYKlwqhuhJpnLRLGqGi7XlCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADsLh63bJ6oXFDWT+ImlYMoSVa/KXP+/ixjJHYkGTGNqaQfO0EUzQco6ZtQMbkXyZeWObCE/B50/n6/IRhOhjM/FEMAUX//Xmt1xE0T6zlpZoUfQEuGYzuJsUtuZhMZdPG4seh9Roxq1Usb4tqHkvJP000CIIp2NA7P37HXM6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfzzO8cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D520EC433C7;
	Fri, 23 Feb 2024 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701384;
	bh=hiDT6YHGmh3oE5cDRrYXYKlwqhuhJpnLRLGqGi7XlCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfzzO8cvde7hjjv8g1iSG/QnSuIFHCsqD1L0NTWkpjzI9oAOkQN4uDg25wcfC9mxN
	 PIpRjrZIFCCMOItPf+wTo9S4Kec2wyQt4zQ5VxEfLPb7g9tpOW6nSRywDajDg/fRE2
	 rWy0Bj0W7XnowgpCF2Qws8uwBJoN6TT8z9dSY7R52Os3vpGUSSSqu8K+NGIUmbB3EQ
	 2vbWPe3yPz2fP8uDXbNMg3/O4xzG8zW1aN0OSpOF/6kI8EEavn3/DrZlHXfebYfVZQ
	 iTkz1c4VbymC9ksIFVzUssOJ4XO/98hfggvCz8ElZ53qV8/ih6a3eEg7jzC7k9dZ/X
	 816GjZgRU9X1Q==
Date: Fri, 23 Feb 2024 15:16:19 +0000
From: Lee Jones <lee@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: dlg,da9063: Make #interrupt-cells
 required
Message-ID: <20240223151619.GD1666215@google.com>
References: <2212567f4c17251011e5e0bfa4ea0126d9815d39.1707922672.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2212567f4c17251011e5e0bfa4ea0126d9815d39.1707922672.git.geert+renesas@glider.be>

On Wed, 14 Feb 2024, Geert Uytterhoeven wrote:

> '#interrupt-cells' is a required property for interrupt providers, hence
> make it required.
> 
> While at it, move '#interrupt-cells' in the example to match common sort
> order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> index c5a7e10d7d80e8d7..e5ccc2708f0bb0f8 100644
> --- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> +++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> @@ -87,6 +87,7 @@ required:
>    - reg
>    - interrupts
>    - interrupt-controller
> +  - '#interrupt-cells'

This doesn't seem to apply.

>  additionalProperties: false
>  
> @@ -99,10 +100,10 @@ examples:
>        pmic@58 {
>          compatible = "dlg,da9063";
>          reg = <0x58>;
> -        #interrupt-cells = <2>;
>          interrupt-parent = <&gpio6>;
>          interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>          interrupt-controller;
> +        #interrupt-cells = <2>;
>  
>          rtc {
>            compatible = "dlg,da9063-rtc";
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]

