Return-Path: <linux-kernel+bounces-128566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26677895C86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BD6282576
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8415B575;
	Tue,  2 Apr 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IAMIajiP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108D15B963;
	Tue,  2 Apr 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086030; cv=none; b=gRZWAIGoGNxcLa9n6PO6uDSdnhiqRXE+ImM3r5ASA0ogBwXJbPP+D/P+NumJXPGweM7PRxaATXF7SKJ1/SfmLn1aT7UA3cF/M8+L3QpUa2Gl/eVcd7hM19liZsp7kONnaVKVSz8wOu7WT03WBLnVmNNEvUP2s6c3MXSF7FIIWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086030; c=relaxed/simple;
	bh=hg49FgYaH4GuMBzIb8C7D7yRNHB16wAyclAyJ4VU55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abqXDlh0QuHxJOH62DSfWLY2xS5GmIR+3nxdVAZeGp74ECZgiSNJ7S7ZsaOY2J5sU/KfHav8xUzT0BRPsu6zZOfZNIVCWcd/7v6Ic65K+U1CVEygJsaFuGuFauY89sKP2Bak7to+rhxLF51WTm5KgLduiVsxdDb8KaSPbJA9B/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IAMIajiP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2IvxhZTeRGMzJtd2ZyOSnbmig+nTZ2hJJ3tE10xMgUk=; b=IAMIajiPWl4V8UpSiU0IzV5Cer
	M197q8FTSCL5rAG9aEpZq39W0vV0WjuTvyg4kESmQ+V14cuO2Ckt65/r/5HL55E1WuY6fgnZCKUO9
	G7zEMAMR4TSeaRPDynLkn6mEiCnEgIOoYvIRLXPQj7CpCHwdGVbr9vTm0B1+fMcVpm+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrjme-00Byla-Io; Tue, 02 Apr 2024 21:27:00 +0200
Date: Tue, 2 Apr 2024 21:27:00 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: marvell: espressobin-ultra: fix Ethernet
 Switch unit address
Message-ID: <09201a97-7e7b-4d72-8ada-f58f85887349@lunn.ch>
References: <20240402183240.49193-1-krzk@kernel.org>
 <20240402183240.49193-3-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402183240.49193-3-krzk@kernel.org>

On Tue, Apr 02, 2024 at 08:32:40PM +0200, Krzysztof Kozlowski wrote:
> The Espressobin Ultra DTS includes Espressobin DTSI which defines
> ethernet-switch@1 node.  The Ultra DTS overrides "reg" to 3, but that
> leaves still old unit address which conflicts with the new phy@1 node
> (W=1 dtc warning):
> 
>   armada-3720-espressobin.dtsi:148.29-203.4: Warning (unique_unit_address_if_enabled): /soc/internal-regs@d0000000/mdio@32004/ethernet-switch@1: duplicate unit-address (also used in node /soc/internal-regs@d0000000/mdio@32004/ethernet-phy@1)
> 
> Fix this by deleting ethernet-switch@1 node and merging original node
> with code from Ultra DTS into new ethernet-switch@3.

That is a bit ugly, having the exact same code twice.

Could the bulk of the switch node be put into a .dtsi file, and then
included as needed

&mdio {
        switch0: ethernet-switch@1 {
		reg = <1>;        
		include "armada-3720-espressobin-switch.dtsi"

        }
}

&mdio {
        switch0: ethernet-switch@3 {
		reg = <3>;        
		include "armada-3720-espressobin-switch.dtsi"

        }
}

	Andrew

