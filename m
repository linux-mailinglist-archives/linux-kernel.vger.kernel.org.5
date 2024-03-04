Return-Path: <linux-kernel+bounces-90638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E135287029C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6781C23418
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD03DB97;
	Mon,  4 Mar 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3a0c/lQC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2E3D548;
	Mon,  4 Mar 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558691; cv=none; b=HN9YHphlYjD5NJw+NHoSfHsSEmpCcbDy4ujM8zPtESusMk2KALKCdBKGES/HrZFZdJuyHupiqDFiZ3W4CC7jejFAZ0TNuaso6aSl08FCFeqjwSmVfM/Yu95/DDigqkkJJzIrXb7zuQMxw/bUpbHHS4xclEP4ITnEdiR1VqizLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558691; c=relaxed/simple;
	bh=JO+nK4/XoBa6mHXTNvGm1aZLOHYucf1zl9UOsaMS2bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItsesahASWK5ZdXFVdT5spu4fAbKqK0vLnp8WTG/FQyRvgWyXSL94EKiZn2xPqIX0kNdCXhPPL+3NQVNlvncLNcDVxAqbS4m74LFJXawfjxgLPdVN1iCKL/OpUHgOtistYlPlnznsKaXGi8VyMXgdTwmVmOiav4vFpSX5tVqFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3a0c/lQC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nZ20AYDFfavj9F06Wv4gsheOGrFxLruQsYcgyQGjmGo=; b=3a0c/lQCv2CWyKUKbHldWrleLv
	7GSKNiaoIZ3B8wMItAcxUWdwHl8A9ZurFDP9vfeMi09onMOlULl8pEOi9I2OQk2wpaSdiB2RmQlkt
	mgfaml8QKSrHNuep0mdlMtWZyeGMeYhJBAE+LnqcG0Al4RNd4XunaxxuSDxdtRmP2hJc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rh8JX-009KEd-Pj; Mon, 04 Mar 2024 14:25:07 +0100
Date: Mon, 4 Mar 2024 14:25:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wojciech.drewek@intel.com, arun.ramadoss@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Message-ID: <2bbc2980-ce44-49ab-81b3-dbbaa0829bb7@lunn.ch>
References: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
 <20240304091548.1386022-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304091548.1386022-3-horatiu.vultur@microchip.com>

On Mon, Mar 04, 2024 at 10:15:48AM +0100, Horatiu Vultur wrote:
> When the length of the cable is more than 100m and the lan8814 is
> configured to run in 1000Base-T Slave then the register of the device
> needs to be optimized.
> 
> Workaround this by setting the measure time to a value of 0xb. This
> value can be set regardless of the configuration.
> 
> This issue is described in 'LAN8814 Silicon Errata and Data Sheet
> Clarification' and according to that, this will not be corrected in a
> future silicon revision.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

