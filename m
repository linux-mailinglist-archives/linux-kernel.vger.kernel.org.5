Return-Path: <linux-kernel+bounces-58349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C284E508
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44726281E90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D747E789;
	Thu,  8 Feb 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DJcRibhC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960617D416;
	Thu,  8 Feb 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409739; cv=none; b=DbB7ZVuFkdS9ljavumoIWrHEytf5hf2kU7i2copehy2UkQDBqw6x9yEC0JFaxPxKDr8vo9cP+LA5y0uGoIrhz+BzXRSuRL9u61P+QR2RHujT8LzTJI59E2wwQDBfyul/NtYJ/Yr1AxoIopDJCo0W5uAjTlJtjMeYJN/8Rs73NO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409739; c=relaxed/simple;
	bh=pG3hD7BNqQBz51nLa5LhJvaNVAFxuXxojG2yZf3XVxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQccSj41gAOhG2lQ+oW89hqiHuolKfTSJjkcbLaSAeq9SQJNkNCMyGzoBbKWWMCSlik1J6NcwXp2CiqAMoKgBsuxCvf3cyIU6G9XYy0nT68ls/LMah8YQOkrUTRJBUgekBkbd2vYDuEfUNMOOuT49IfUKf+/Ei6jsQv7XU8wwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DJcRibhC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h216siugj8ahtN6cphm3ZoqpCGaHT/mNmdUJWUfGAwQ=; b=DJcRibhCc+zxmCGRMgGLdNdhwb
	NhneNQ67Yj0Uj/SDaxKWs2Qo7SezhwM/fPX76yWwtIDRjSnMywM1gy8Nk0fAy8a3uZVvAYHxy6os2
	+G1YaNbxoMBUkxAk6C5QBJ+wAnn+sijMfuGABaFmjrVigEFUW+2bEHf27dcg0skVJVcLVRsP/uZZG
	wvqEv6WqWfHPeMzBvHnT57OaX3e0HlAsnERwmwHwU8peH0bm8ydnlW0gu37W6lP6hFbhaeR1lh32+
	VaOAc1MbBGhneWPDEjuuGn57uAbr7ZTla6iQzggmWg/aR6a1BTnh4yXZaU8YLi9421dACz4dZpkvY
	0ARSFxcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57080)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rY7Gc-0004fQ-0P;
	Thu, 08 Feb 2024 16:28:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rY7GZ-0005eG-5L; Thu, 08 Feb 2024 16:28:47 +0000
Date: Thu, 8 Feb 2024 16:28:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
References: <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 08, 2024 at 05:19:24PM +0100, Sergio Palumbo wrote:
> Dear Russell,
> I understand your point, but I think ODI DFP-34X-2C2 situation is quite
> similar to:
> FS GPON-INU-34-20BI
> HUAWEI MA5671A

MA5671A is configured by the OLT. The user can't configure it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

