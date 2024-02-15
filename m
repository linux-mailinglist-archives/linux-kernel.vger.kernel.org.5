Return-Path: <linux-kernel+bounces-67143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0BF8566F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2771F244A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BB132C02;
	Thu, 15 Feb 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBU0mgeH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62E12C548;
	Thu, 15 Feb 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009839; cv=none; b=hl5BEF1n3L4+DR55fSp3Y5Conashjnhw5eYJWVP81ES1uHjOwbED6ozBxLBZqhx+JAC6qn93m43i5cscugPuOX2bq9csfYCCnPeaVzeJPLhRQqvUNojTgbJkwZofaOluOOA0ml+X0ftqi80sK1t+XT4wQRLkZKeaXFoT1JIcEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009839; c=relaxed/simple;
	bh=tHAmLV3OwB5Smivh2clFtWbsMSNhvOvXxI9/fJPyN+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewwuyXScOy8SmEPocVBV6l+1o5V9DBCi113T/hpZi96nKE/mFiKfPPCFJaGFZNpEpDIcrCbLJH3e7MhIxeTk5Ql9MFqclHhMTH2bbL/yiK1ClEMRbod0/OsUciY9G7lbumUZMr8eUZAsEnAaHn79Ej2D9PGS3nlwcebt0Ilj2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBU0mgeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3639C433C7;
	Thu, 15 Feb 2024 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009839;
	bh=tHAmLV3OwB5Smivh2clFtWbsMSNhvOvXxI9/fJPyN+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBU0mgeHs3k9Rbn10hP9UV4P1JpPA3Qtl76jNf2pHHA888qQdL9PUQe3w7tKdl62k
	 ZBN9CYWOnrGdCw7j5ylpK+gWerZZgpxWd1WFfYiUs8/u+UA5vJ6Vor5jirNAmnmP7Q
	 u3eLilW7nl5dEajF/scZRamRJqwwgqJnGCuc4BGMP4EVFMtXF0pS/hmS3EVg7+hu1D
	 fmyxUUzoBk0KZ7W52upUpkSWK3ZJ5e+6npNx2V+R8FzLsyNnJQe2E9Uz4jnmuaiwGW
	 MqinQUabg8HwovkCSMKJRkPKi1FKYi56M0VgzVMITlzeHN4tYAoQBEf0DGzfXeLgkl
	 JdhOWAk8hkhkg==
Date: Thu, 15 Feb 2024 09:10:35 -0600
From: Rob Herring <robh@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, Andy Yan <andyshrk@163.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-arm-kernel@lists.infradead.org, Jagan Teki <jagan@edgeble.ai>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Correct vendor for
 Banana Pi R2 Pro
Message-ID: <170800983525.88947.3003525865973395499.robh@kernel.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
 <20240214040731.3069111-3-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214040731.3069111-3-tim@feathertop.org>


On Wed, 14 Feb 2024 15:07:29 +1100, Tim Lunn wrote:
> The vendor for this board was incorrectly listed as Rockchip. Fix this
> now while they are not used anywhere, in the future they may be used by
> bootloader to select dts.
> 
> Update the vendor to Sinovoip.
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


