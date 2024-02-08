Return-Path: <linux-kernel+bounces-57691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB284DC60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095AA1F22238
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859056BB2C;
	Thu,  8 Feb 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DTZbgUlb"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152E6A8C3;
	Thu,  8 Feb 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383237; cv=none; b=HfdXJV9lLMreRO/wI34tWaDxKnknfyjPRFUgfMl9kKwVrsHH1DPvLK5RzWfDGfg+czUp3R7TdtiRZsmvjIh+4TWgluz8BfCNihKBXq2H8eQAY2E+JkMQogdTsOHNwA+nUBzlC3MZSU6u8TUYSF5Ow2H6Ubm1tebzf8jTEN5h1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383237; c=relaxed/simple;
	bh=ybaYy52DBFs6X4uyopQviqgZxtlT5woLcGtycIi9UcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGnkyiBUM664H8LaVWC+wllkqS3BneMB5wjP9UoE9jaG1rjVbu64Nb2+3OoAyzfJ9c/T3d3CAZuHrJ6HIakv5leUS7NgVcXuu6fAaDdDUe9nB1W8Qxixjp6QFp+y8cTfPjgs2ixxOtFiyWUTIw0k8674iALrKi44KWL49eaudHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DTZbgUlb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nUIRQu+c/DqWfn5l2BGlZEHY5+hbaKGg5sK7i1tE35U=; b=DTZbgUlbN1pkgDRLcxhQQ8YDof
	SO6YNoDGjdfyYb2z+3rjB+/bmXnFfPqw05jWPPwabAAiXFoouJSoPbJlopJSfgnpThM6im/wmNQrk
	I22FlZMy0cuZoU4efTKSaFczOOEdBOxX6v7QfoLMmBu7KxtVh+qimHUFqrxkBUTn7xQw4lQDFzkVm
	b/Pn4dRIBWDdsiL4OQ1zXVq0je8hLkng7bci6YaYlxSixK9dB8F1irjli8z4Fs+laVdECzzGH5xiZ
	d/ZdSIX0nJCg2XpO7ludk+rKd+zrSguLmgjOpvS/lRxdxFx/n+2LZv325M6z+5g/Q0jsADwanVXyl
	fDhgXP8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34478)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rY0N5-000483-2e;
	Thu, 08 Feb 2024 09:07:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rY0N2-0005P6-TG; Thu, 08 Feb 2024 09:07:00 +0000
Date: Thu, 8 Feb 2024 09:07:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 08, 2024 at 09:30:48AM +0100, Sergio Palumbo wrote:
> Hello Russell,
> I did the requested test

I asked for it with a kernel that has #define DEBUG in phylink.c, but I
see no debug messages from phylink in your quoted output. There's no
mention of what's going on behind the scenes, so this gives me
absolutely no new information.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

