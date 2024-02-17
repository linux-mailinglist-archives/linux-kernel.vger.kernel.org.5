Return-Path: <linux-kernel+bounces-69898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B8858FFB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B340B210A1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B097B3C9;
	Sat, 17 Feb 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkwBQsUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA306A025;
	Sat, 17 Feb 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178996; cv=none; b=KNgBpUYN1T7fPTIVLJLUe8qeKJueMu/GtvH7pZaCUgUJJxYjoaaGZMkV9dOLDYJd9OrwLqctfeQcaL1EubBD9SB76cCWFI3BpDNrS0wZdQ6J0zXgwy55P/DfpuB6rbNRsrnC+6LGJ2jvhac6Yh5ZT14VA/OWzlyUc0K57rO4rFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178996; c=relaxed/simple;
	bh=XWQCs6PGhIvYz7XOGx/U7vWKMp1Df65xKPuZVEikzJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCDCxmokoNxapOpzPrW9fJ3AIP5Ev0CnNf42h5HZ+TrcstqEfoOtNUdAYHudD1EsMNDNPNmR3VoDFh+Zo9g4ZnHcANI6w/mO41oVNz1hcm03ILq3FoafhIHaxRl75EMMwI/q1dzBgn240NbJjluDauKTqgMXPzevNnjA9kuKyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkwBQsUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281FC433F1;
	Sat, 17 Feb 2024 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708178995;
	bh=XWQCs6PGhIvYz7XOGx/U7vWKMp1Df65xKPuZVEikzJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkwBQsUq9N5YCk6VRvVLPeMnkI2LhwDQ93/E4w32dYebddGCeu4mCrksJV0riWFYT
	 5PZBd1rZ9XqeHxjzYz5Nx3nZkucqm3ucjZh11p3yuv3kWa3oNJN0eR3+1/umbrEtvh
	 +y9sLIn0BtwYvL6e+UQ2t1jlTqb7Cpud8ofy46e4By3Uf5ViAa2JhiYk20BC18drGb
	 82e83J/W8trX/+ZBO1BDGDzDrfU+nZX1UM0Cn2fr4OlqLmnvDwLHOCfNjydE6LHzgg
	 S6F+Y4l2I4AXW4dNkUVnIqwQ2SN+rUSXY7Oo0UCC5Jln2UM3lAdZCWgWErLURQubfD
	 cJ9srWOSFDiXQ==
Date: Sat, 17 Feb 2024 21:56:55 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] riscv: dts: sophgo: cv18xx: add top misc system
 controller
Message-ID: <ZdC7J-5zUQFHHiNK@xhacker>
References: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49533397F35C450DB92B00C7BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49533397F35C450DB92B00C7BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Wed, Feb 14, 2024 at 09:35:55AM +0800, Inochi Amaoto wrote:
> Add top misc system controller dt node for CV18XX/SG200x.

it's better to delay this patch until users is seen.

> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 2d6f4a4b1e58..dbf018e99c48 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -53,6 +53,14 @@ soc {
>  		dma-noncoherent;
>  		ranges;
> 
> +		topctrl: syscon@3000000 {

"sysctrl" is better, the TRM name this as system controller.

> +			compatible = "sophgo,cv1800-top-syscon",
> +				     "syscon", "simple-mfd";
> +			reg = <0x03000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>  		gpio0: gpio@3020000 {
>  			compatible = "snps,dw-apb-gpio";
>  			reg = <0x3020000 0x1000>;
> --
> 2.43.1
> 

