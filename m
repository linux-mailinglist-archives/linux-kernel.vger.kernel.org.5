Return-Path: <linux-kernel+bounces-125816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B8892C91
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3562928345B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767C22093;
	Sat, 30 Mar 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KnWNOYYg"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A51DDF1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823778; cv=none; b=IQUCuiy1cgQnruHkF6th9ByMoh0Mc1KWEWTNrNcGs8u8OV1z9V7AcOtTTVQestArI5EA2q7djV7A2+CRZjD9iLWHsVHgPNyXcqpGKOVkYjBYrOM8hV+7MWx6zjLXavtgdkqSvvQeGvZFsmeb6OmSOvlXt02fqTLoP6yDcgH6vGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823778; c=relaxed/simple;
	bh=1dB4kBpqrBLoSXGxvdKY7oNYWzcWIPwsp+ktfILbU8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHzo3rCN/gqgNWEFLzvbl1LuLD/OuQrpaa7AjKrMkPaogpoEc4rt7uQ0iTY7yzTA86PfVJjtFbelW02VcFPmi0RCXocrEvHG6Cinx9J0aAFVxUTVRan8eadYpNZL7oONlCE1TJ/M68qF/RwFMUKpYGDFSOyBUC8y8vH3eMwgRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KnWNOYYg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ujY+2Fajyw/i8qIuOZQSTD217NXANw6Wgvcz9uBaBAs=; b=KnWNOYYg/5X275Y16WxV/bQOIg
	UXk+SD/WrPBzNWj/iByXWth5ghvY+B8EbPAx7oumvOuzuDpaV+TnegQ3sUAJkTnVzqCI00+nBmiL9
	k5NAQFWxw+MxIRYRGaRv2+BNRh7WZ3pm5cWyyZXr0cLjYJJv7QpSYV6IOzafGpHeS7F484kPlr2Bm
	UlmmnmXFQwafs/3sEFoKz5GHFlCSNEngJsaDgCBQW+2nbWnmsu1A6lDZFqylUkW+4Q23qYqbypS7W
	1AgjR8ZQtNqXOICdgR+FAnbvhxAz8g0U6SxsgApbMHAIsR0Aaps9SNK/NguUVF0h1O+zhD2czrXoU
	NaTZWMag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59452)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rqdYl-000387-35;
	Sat, 30 Mar 2024 18:36:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rqdYi-0003rl-38; Sat, 30 Mar 2024 18:36:04 +0000
Date: Sat, 30 Mar 2024 18:36:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
Message-ID: <Zghbkx67hKErqui2@shell.armlinux.org.uk>
References: <20231222022741.8223-1-boy.wu@mediatek.com>
 <6837adc26ed09b9acd6a2239a14014cd3f16c87c.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6837adc26ed09b9acd6a2239a14014cd3f16c87c.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 29, 2024 at 03:17:39AM +0000, Boy Wu (吳勃誼) wrote:
> Hi Russell:
> 
> Kingly ping

I'm afraid I know nowt about KASAN. It was added to ARM32 by others.
I've no idea whether this is correct or not. Can we get someone who
knows KASAN to review this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

