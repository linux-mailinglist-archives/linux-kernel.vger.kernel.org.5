Return-Path: <linux-kernel+bounces-90983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A5870807
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF59EB27E36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864665FDD3;
	Mon,  4 Mar 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="advEshHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A6C39AF1;
	Mon,  4 Mar 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572081; cv=none; b=MuGOauwvym+p9DtNjk0UU7faf7CCoUMcZJFHEm3qDxyXWhfC3J9m98lZmHDFTct5nN3SIyYP2K1WsG1eFOt3WCby2z+hoGZm6uE12IN9P7OQPu/HTbmtwX5tQWBf8zbKynn1sAWt5/3yRAiyBBBgRP0dAc2XTaicvHdqySoSAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572081; c=relaxed/simple;
	bh=oo8N+RP2c/iFxHR/IdQJQEesKtVFD/spy8V9i7MIHuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvuzknVrJzxsIhAEQhcNT/N3Rn5WANcn+TPHtPp/vyi+N3NgQPJH2mS68e/PS/CIg//2fvi+O4Hoqng69666iFmyUTUp4CPzPr3vSnu1I8u9/XKDneCY3BYG0lF/ShH5s9erzayTmHfxNh/wET9NCbHm9YJHt+35rBgDf1e3rFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=advEshHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393A7C433F1;
	Mon,  4 Mar 2024 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572081;
	bh=oo8N+RP2c/iFxHR/IdQJQEesKtVFD/spy8V9i7MIHuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=advEshHsEmpUPOvyd59svVQwDfYQmy4ibHko62SjjRMD8AwzVJUw98yxTtzHe5oKw
	 ItafxNx26LOmTHQJ962f1O5H4yiv5FPq26qMzfd/L7tQXHiK7xtCTOnROMkcuNDZAh
	 Uyj631YdmxhqcyayqGanXu90ZduiMXCHTo0CLs3MMusmdUwFN2xbKVrEboQ/jRfpu0
	 dgGqFWYcGyE60wMZ4P3QSENIM601mysZDpZikbw0pKwfyl7O4EsnuTYcrD7ipCrHfl
	 Uq318gJ3Q8xfQleEn+cdZApVG4NFwd4tbIt4QerBSu6PwtxwK1MgwbNccd70rpNotB
	 c3kP1lZYSLeMg==
Date: Mon, 4 Mar 2024 11:07:59 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, mdf@kernel.org,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: altera-fpga2sdram-bridge: Convert to
 dtschema
Message-ID: <20240304170759.GA752387-robh@kernel.org>
References: <20240301161648.124859-1-animeshagarwal28@gmail.com>
 <20240301-uphold-numerous-305c3702805b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-uphold-numerous-305c3702805b@spud>

On Fri, Mar 01, 2024 at 04:23:30PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Fri, Mar 01, 2024 at 09:46:43PM +0530, Animesh Agarwal wrote:
> > Convert the altera-fpga2sdram-bridge bindings to DT schema.
> > 
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > ---
> >  .../fpga/altera-fpga2sdram-bridge.txt         | 13 -----------
> >  .../fpga/altera-fpga2sdram-bridge.yaml        | 23 +++++++++++++++++++
> >  2 files changed, 23 insertions(+), 13 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> >  create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> > deleted file mode 100644
> > index 5dd0ff0f7b4e..000000000000
> > --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> > +++ /dev/null
> > @@ -1,13 +0,0 @@
> > -Altera FPGA To SDRAM Bridge Driver
> > -
> > -Required properties:
> > -- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
> > -
> > -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> > -
> > -Example:
> > -	fpga_bridge3: fpga-bridge@ffc25080 {
> > -		compatible = "altr,socfpga-fpga2sdram-bridge";
> > -		reg = <0xffc25080 0x4>;
> > -		bridge-enable = <0>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > new file mode 100644
> > index 000000000000..88bf9e3151b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> > @@ -0,0 +1,23 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/altr-fpga2sdram-bridge.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera FPGA To SDRAM Bridge Driver

Bindings are for h/w blocks, not Drivers.

> > +
> 
> You're missing maintainers: (shouldn't dt_binding_check complain?)

Yes. Patchwork says this failed to apply which is odd because it is 
doubtful that altera-fpga2sdram-bridge.txt has been modified.

Rob

