Return-Path: <linux-kernel+bounces-31607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C28330C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377F31C21081
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30356456;
	Fri, 19 Jan 2024 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/ux92AC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063271DDD7;
	Fri, 19 Jan 2024 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703639; cv=none; b=ZibZr1hf2GxigEhj+OGPydyKIBGFzutxufzQHSV8vOyO59U5avio92U+LufHPcwl/f8ep4Dc/cywEeYGBaCjDQ8mMAxyL8X4//FdQIoGYe/6F61NnPF40A9J2O3Epi9A4+fSF0sRx6gPO8DdcAAyXSnKrehzaLNTi2SGNyPGdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703639; c=relaxed/simple;
	bh=ngixGCop/FGHGM4VzT1CdOop6LC5rXZwbYzCfDoGwts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go6s0vxAvfXTN7tX2yV8LZsKPgmYkqMOZs1Xo8nzRRoz4lI7vWipyyERQLD2Kn5eydAq8tnYniZO4WpIo8hkwBqsg9vrRUXVguuUnpIJ6Rb8wRHyp05jZL2baHylO1gvsDaGRofSsuHLB8IHOPxH1Fn7CuA97Fd32JH2y7d5wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/ux92AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C57C433C7;
	Fri, 19 Jan 2024 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705703638;
	bh=ngixGCop/FGHGM4VzT1CdOop6LC5rXZwbYzCfDoGwts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/ux92ACavMeQTuySYHzUdjzBdTshNCu8men0WVqNM8xU8CzmL8Haom99430LD/yO
	 jVeoVk+JB5RCGBz4asKTRhVO8A+lWq+kn9iVY5t+UUzwhpED/gZacqIcfDyTUhbz+P
	 4jWFKEhFOEhOIFIbzsObO6/AIZ2d06gJKeuIF7VALZQQPLwB4VYlVCvRS3gmnn4MEu
	 9do9ADGapuKlJfF83YmsujncFeCXK+tWLfSKM8iC0j7tPKWl1kIK0rOPS0wysyeegx
	 F4vnMaCTeympnvCFKjdCLeTZJCagf0NLgj/9AszYLWZlsXuuzSXjGuEoHYiloWsdtz
	 hareX2ZIrt4Fg==
Date: Fri, 19 Jan 2024 16:33:56 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ansuel Smith <ansuelsmth@gmail.com>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mtd: partitions: make partition an NVMEM
 provider
Message-ID: <20240119223356.GA1179470-robh@kernel.org>
References: <20240111121940.15628-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111121940.15628-1-zajec5@gmail.com>

On Thu, Jan 11, 2024 at 01:19:40PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MTD partition provides flash device data and can be used as NVMEM
> device.

I don't follow what is the relationship between this and your other 
series.

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/mtd/partitions/partition.yaml       | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 1ebe9e2347ea..7b1d84ce5ef5 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -57,13 +57,15 @@ properties:
>        user space from
>      type: boolean
>  
> -if:
> -  not:
> -    required: [ reg ]
> -then:
> -  properties:
> -    $nodename:
> -      pattern: '^partition-.*$'
> +allOf:
> +  - $ref: /schemas/nvmem/nvmem.yaml

Only some partitions are nvmem nodes, so we shouldn't always include it. 
Then we can't exclude nvmem properties from partition nodes which 
aren't. We should identify those nodes by compatible and their schema 
should reference partition.yaml and nvmem.yaml.

There's a general problem with the partition related schemas that 
undefined properties are not caught. This is partly because 
partition nodes can be nested and expressing that with the schema is 
hard.

Rob

