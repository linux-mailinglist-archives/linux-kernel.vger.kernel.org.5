Return-Path: <linux-kernel+bounces-54634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEB84B1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206C31F24C74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3412DD8B;
	Tue,  6 Feb 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLuKKcQv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF012DD91;
	Tue,  6 Feb 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213574; cv=none; b=Rd0ZMoBE9DvOrq6Sn2eIbCMd6zy7rrXt47N70UY9Y9T1WgSfExkRwZYSkhaaECFpJCsZvb6hKpkaNe4VQCUy4wUzV8jvuBM3+EI0Ac1QIdo/myvqx6TMtQ5jwNYRYCUl0UsaUIId+90p21F2v0Y+eDUcekLma8JZSwF8j3ALOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213574; c=relaxed/simple;
	bh=Ig8ijTw3hCT/GkZgw1zFTglUsDgaQwNI3+0+e16OyXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQq9VPzIoWcTYsN+XjrTbWxMZEVtE06iaG26hxxFl6T22CeWSS5dWdWi7V9FeZ8nSF3LNgz9ObuK3zCYacYovZ5J63r+Y5pQ0m3islxW298oo2xyQmpv8E+548NokIW/ie2zDZEU850ZvRmhHGuwwejdTxnGIupErJDOodYx2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLuKKcQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668A8C433F1;
	Tue,  6 Feb 2024 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707213573;
	bh=Ig8ijTw3hCT/GkZgw1zFTglUsDgaQwNI3+0+e16OyXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLuKKcQvVvD2zJsExDgivbWwcPaG3Ay56C06p/YQGyrgd6R+SMTceoDfjuQaomhFa
	 JSrzO44v+l/EsFYkQBTFlSHQNcstUtrtJOHSBEjGS7+TUjsXbJztzWxx8MmFEikoCb
	 Lfh+/kLSmF+xv+MuyRyGwSvu/yYEmgIdLXbyAOO82qSjY67PmMHIj+LzBnbbLnaidU
	 SegePhHwR9ot3na3p5hcKcWxOUt08XhSQUI7g9mIPj4IUj6vac65YfvNdJoP2Shi++
	 ENc0EKE5WI+AwPe3aMKUadmrCJll/bm7TDqxcc7SX3D6l3y43tsBvYAJxHfw30VQJe
	 jT3FsIBZ0oadw==
Date: Tue, 6 Feb 2024 10:59:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Cc: dlemoal@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: atmel: remove at91 compact flash
 documentation
Message-ID: <ZcIC/gP0WeI4BYU3@x1-carbon>
References: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205105201.81060-1-Hari.PrasathGE@microchip.com>

On Mon, Feb 05, 2024 at 04:22:01PM +0530, Hari Prasath Gujulan Elango wrote:
> The compatible "at91rm9200-cf" is not used by any driver,hence remove the
> corresponding documentation.
> 
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> ---
>  .../devicetree/bindings/ata/atmel-at91_cf.txt | 19 -------------------
>  1 file changed, 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt b/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> deleted file mode 100644
> index c1d22b3ae134..000000000000
> --- a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Atmel AT91RM9200 CompactFlash
> -
> -Required properties:
> -- compatible : "atmel,at91rm9200-cf".
> -- reg : should specify localbus address and size used.
> -- gpios : specifies the gpio pins to control the CF device. Detect
> -  and reset gpio's are mandatory while irq and vcc gpio's are
> -  optional and may be set to 0 if not present.
> -
> -Example:
> -compact-flash@50000000 {
> -	compatible = "atmel,at91rm9200-cf";
> -	reg = <0x50000000 0x30000000>;
> -	gpios = <&pioC 13 0	/* irq */
> -		 &pioC 15 0 	/* detect */
> -		 0		/* vcc */
> -		 &pioC  5 0	/* reset */
> -		>;
> -};
> -- 
> 2.34.1
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9

