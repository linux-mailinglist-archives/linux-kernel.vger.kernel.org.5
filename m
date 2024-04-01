Return-Path: <linux-kernel+bounces-126760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D75893C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C491F220D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD3F446B6;
	Mon,  1 Apr 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="APoNXS7i"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4D44367;
	Mon,  1 Apr 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983159; cv=none; b=i/mytGqFewTZGNYsAk3zggsUXVO3NHprqpql5C0/ukazOPFduCM8fuPVIyLMDCrmqpQuD3snqMP+37lVTA5xNWxY+X4CrZYThvyH/L3TCGlvI5dpfLpbv1o50SdNqaoA7X8eKXv6hV2qxBYu6DvE6x218WYB5PGIizQbFwgEihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983159; c=relaxed/simple;
	bh=hCCMDoVs9hwlaIgpLalvIN8iuYSg1bwiHL2O6nBWr4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ticQzVauDylcAM6TLzSdJAE7Euq8yw/v+8qfZlTFg33sm4+heyWIuG/MIGFUcMdTzaMur5SgLfjyUK4tvePTuzY2u/IUxwHObX2hkzx0DH5+PEeaP2g0CUyqnXAR4ESeKaO3ZzkWdOs9i60RtD8EFw7DzHMXr1gkH/lyjcvYxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=APoNXS7i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VO5BT6laMwQjJkCJwR4qE81BL69+Osp3rzopB62pODA=; b=APoNXS7iDJxM1bJsk/Gir/IDBm
	efwypmZVLv6q6MvWijb8/ed6zEBg5KKlV9biQf7IjOcownf1O1+l4jVh/3npRDZn2BRnTHCiZLHLG
	/mqW1pRtyTidM75tMiORlYtXERyz66yFxZeermwrQOQLrPrvcfj2MyCjz4AxO8yo9zKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrJ1U-00BrbM-K1; Mon, 01 Apr 2024 16:52:32 +0200
Date: Mon, 1 Apr 2024 16:52:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: marvell: cn9130-crb: drop wrong
 unit-addresses
Message-ID: <c5562704-6ebf-4bd3-b0dc-37068a9e472c@lunn.ch>
References: <20240401141051.98233-1-krzk@kernel.org>
 <20240401141051.98233-5-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141051.98233-5-krzk@kernel.org>

On Mon, Apr 01, 2024 at 04:10:50PM +0200, Krzysztof Kozlowski wrote:
> Top-level nodes, not being on MMIO bus, do not have "reg" properties and
> should not have unit addresses.  Correct their name as well to match
> "Generic node names" recommendation from Devicetree specification.
> This also fixes dtc W=1 warnings:
> 
>   cn9130-crb.dtsi:29.35-37.4: Warning (unit_address_vs_reg): /ap0_mmc_vccq@0: node has a unit name, but no reg or ranges property
>   cn9130-crb.dtsi:39.38-46.4: Warning (unit_address_vs_reg): /cp0_usb3_vbus@1: node has a unit name, but no reg or ranges property
>   cn9130-crb.dtsi:57.33-65.4: Warning (unit_address_vs_reg): /cp0_sd_vccq@0: node has a unit name, but no reg or ranges property
>   cn9130-crb.dtsi:67.31-75.4: Warning (unit_address_vs_reg): /cp0_sd_vcc@0: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

