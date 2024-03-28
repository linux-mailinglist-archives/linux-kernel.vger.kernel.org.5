Return-Path: <linux-kernel+bounces-123590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B4890B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD501F25993
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D9139D05;
	Thu, 28 Mar 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M91K4TnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AD46BF;
	Thu, 28 Mar 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658236; cv=none; b=dP/74f2EhktnedUdM/4RcEl2cP/lZU4bmcnB2BcGf87VGsAavWMvMnkqaqjID+eGLZEviZ9k9QV4DVqKn6QZOHPNqMOmlDvSvLSkI/MAPjc4hYjwm4JzDdFEIOY2oGGpAr22z9aTxC3h1WWC0+xZnXMKLa11NRNXqvbnttifQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658236; c=relaxed/simple;
	bh=o3TMU6J+1La8rLs2zcigdVj1AgPp6xVFZzSdMIJZ+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9mKGUfXFSraGg6AeccuWVKq6fOAaHd6ks+9Rj1699/mOiOnGKjHWVf0dHIRxbullG3WuUs9ZKqKVlC7IHIJyh0UD/YiB1/MiF4rCN6htH+6T2J7AR0VibzMMkg2qP67mpz/nRAQzOY/ynrR78hmJRWwwpQU9X1QYapz6rBUZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M91K4TnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B2C433C7;
	Thu, 28 Mar 2024 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658235;
	bh=o3TMU6J+1La8rLs2zcigdVj1AgPp6xVFZzSdMIJZ+dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M91K4TnGiHgnYf7fli2rIaNCPFSkgB6FKdjUAO5LIu+nLxhre2FmA5y0q+G5YL4e6
	 MiTAjHYTr1oxozM2m47RyyTZJ/LT5eG4uPj2MAyGRBedG6rcsR5Tax0POrIqgAoMyU
	 LKosAXuzI2Uy4snnO31W2VpbtqGm1tCav8w8LVxJNoRhfxmAtOS1HfewJiBVSdspFY
	 EC3ZzPqtPr9KcLWvpsmo5rzrdvQonI72X/tvdCOqtD8Sh92lPUEqy+SU2V6MiK52AD
	 +eMkSrIuaBew8BqY8qbXt9b8o7KxmCl99ESbA45vXyLDpOJr9RApK8z2FR4V2aPbqu
	 GVrhTPC293Q1A==
Date: Thu, 28 Mar 2024 15:37:13 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Michael Walle <mwalle@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v10 2/2] dt-bindings: mtd: fixed-partition: Add binman
 compatibles
Message-ID: <171165823084.305347.5584935515178377776.robh@kernel.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
 <20240326200645.1182803-2-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326200645.1182803-2-sjg@chromium.org>


On Tue, 26 Mar 2024 14:06:45 -0600, Simon Glass wrote:
> Add two compatibles for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Note also that, after discussion on v6, we decided to use the same
> 'fixed-partition' schema for the binman features, so this version
> adds a new 'binman.yaml' file providing the new compatibles to the
> existing partition.yaml binding.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v10:
> - Drop binman,entry since it is likely not necessary
> - Put the description back
> 
> Changes in v8:
> - Switch the patch ordering so the partition change comes first
> 
> Changes in v7:
> - Adjust MAINTAINERS entry
> - Put compatible strings into the 'fixed-partition' binding
> 
> Changes in v5:
> - Add mention of why 'binman' is the vendor
> - Drop  'select: false'
> - Tidy up the compatible setings
> - Use 'tfa-bl31' instead of 'atf-bl31'
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../bindings/mtd/partitions/binman.yaml       | 53 +++++++++++++++++++
>  .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


