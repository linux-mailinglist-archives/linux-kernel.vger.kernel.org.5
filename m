Return-Path: <linux-kernel+bounces-128544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE9895C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF1B1F21E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2E15B56D;
	Tue,  2 Apr 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r4PCKzAQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E765382;
	Tue,  2 Apr 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085030; cv=none; b=uYM0AEglKiHvoY2clRh9PndJi0z5un2YYjOXfOroP/SD8axDn46xUHukRiQwjSG1FH3NLbZBpw4T1DMZf0typSThX0xCBczatzHr9JpL0Xpeo1n8NB+qCuNrUI0u4yKkg8YiGaozhXbczTfRnemVXAywTPa4jrygi5lifdbXkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085030; c=relaxed/simple;
	bh=nSoQBSOjOlCiCd4Wd4mHRJURksOoI1cF0UUNTCeJtRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GghlbRePeao10lrEw9vHeRevu52kCxYZqXW3oVUUxagMeCaSx+qS9uk7TO8jhKsr5SZGofAu4Zs1NgK9ejKweqn+Ra/HzX/ogDmfJRnaE594vDDvPRIp7QNooEQw0tNBui/SFjDbaRPJB/ekE/iQGAX8nVSXgT92iyMOY9t2K0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r4PCKzAQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T2qm4NgaI6U8f9fs2Fd901UBkX4Ox6SqlD3BR0LhFO0=; b=r4PCKzAQGOineGigWaTtkmnVJd
	V7sSCVsSJYwuyzRogAPsFbRuJdjN/JWBoO3q+7h5ZhGvnkJJKdFjr8fwxTaBFiz6Hstk9eT0x+ncp
	Rqqm93s+yn2C1t4N130zxF7gTWpMUDNWA4KVP0WtR60Lh+QOtHlVJl99V88UFBlqL9AY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrjWQ-00ByfE-Nq; Tue, 02 Apr 2024 21:10:14 +0200
Date: Tue, 2 Apr 2024 21:10:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: marvell: eDPU: drop redundant
 address/size-cells
Message-ID: <4149c90f-969f-4f4f-b0b4-5c015813044b@lunn.ch>
References: <20240402183240.49193-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402183240.49193-1-krzk@kernel.org>

On Tue, Apr 02, 2024 at 08:32:38PM +0200, Krzysztof Kozlowski wrote:
> The ethernet-switch node does not have children with unit addresses, so
> address/size-cells are not really correct, as reported by dtc W=1
> warning:
> 
>   armada-3720-eDPU.dts:26.19-60.4: Warning (avoid_unnecessary_addr_size): /soc/internal-regs@d0000000/mdio@32004/switch@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> This probably also fixes dtbs_check warning, but I could not find it, so
> not sure about that.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

