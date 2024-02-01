Return-Path: <linux-kernel+bounces-48656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AE845F69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F012B1F29DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51208527D;
	Thu,  1 Feb 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ihG4H+Cx"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9D85275;
	Thu,  1 Feb 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810709; cv=none; b=f8M8hCcYOcBTgYVO6IyWT7NpGqaOK9TbXvFkDroCNGwSPenYEc4SwXFapn4Kk4/+tj5mhifTfMdv14HF0j0XKesv4wOkccqXXyQfY6sFS5KuTyoJDFbjWUH4QRz/74vv3p+g7x/ePAV7lJC8MBB4He9jcIcknkPk9YBsv9MXxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810709; c=relaxed/simple;
	bh=I0wLRr/Sl79b2Xe1FyfzbVWzIscJuiBxBqIBkYPKXcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRPq/lM0PHPPW/bbraGXFBYbBttoxldUaCYp/J9eN1zzpwkz2ecc+req7oIWtiuMI60mkkF1fovdDD4V4BmJFet+B2+7N1PA1cU/U+1aT7XpyRM8wFjj13cFFzUxvuSz/fh2fVSjqwUnJUCIIl8q62AFK0DkeyXItzPPFdFveIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ihG4H+Cx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wlDdr8NPiv5K6d89Bs5uSKYd3ZJ761NBPkhp6QHmjxU=; b=ihG4H+CxyyBjdudwZR3dMEQ0TK
	7sxcRhO62L8ketQE7IZBEniIleIcd43plriDe1Ay652flED+oXwgx4ygMQippFmFk4TwuNnNu4Vn3
	fWRF4K7TxQmjK3efqvMR0HNuxNTDQpdLGotizhkiN/BKzkQVUZ9wl95sX7jXC6ze36MJgivnWn4TU
	i0XwhS/rLkqRBgE7Lmgyyca2aXPuxN7DRsINUh6PZbeqwgi2y0eSFRzBEwoWVSTyGXMR6S/jvyEx6
	1p7oHGDGtrEi4gZwENv7VFRpe7tI6Oe2ukCgRWhu2d/7mL17ieBYs9dYwb1/kA6682OA2ocuvrXP8
	5iuYf9nQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40810)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVbQm-0004yf-0q;
	Thu, 01 Feb 2024 18:04:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVbQj-0007YI-BP; Thu, 01 Feb 2024 18:04:53 +0000
Date: Thu, 1 Feb 2024 18:04:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] arm: topology: Fix missing clock-frequency
 property warning
Message-ID: <ZbvdRXsvY2qBXApS@shell.armlinux.org.uk>
References: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
 <dfccb849-67b6-489b-8e83-3df1f9b29877@linaro.org>
 <9da01fb1-9bab-436b-af49-783e44821b26@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da01fb1-9bab-436b-af49-783e44821b26@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 01, 2024 at 04:03:59PM +0100, Stefan Wiehler wrote:
> > Does this mean the /cpus property is like a default for when a CPU node
> > doesn't specify the clock frequency, or does it mean that the /cpus
> > property should only exist when all the values for each CPU are
> > identical and thus the individual CPU node clock frequency should
> > not be specified.
> 
> Good question, the device tree specification in Section 3.7 [1] says:
> 
> > The /cpus node may contain properties that are common across cpu
> nodes. See Section 3.8 for details.
> 
> And in Section 3.8 [2]:
> 
> > Properties that have identical values across cpu nodes may be placed
> > in the /cpus node instead. A client program must first examine a
> > specific cpu node, but if an expected property is not found then it
> > should look at the parent /cpus node. This results in a less verbose
> > representation of properties which are identical across all CPUs.
> 
> So I think it is pretty clear that it should only be used for
> common/identical values.

Thanks for the clarification.

As this is DT specified behaviour, I question whether it should be
implemented in arch/arm/kernel/topology.c - what I'm meaning is
a helper such as:

const void *of_get_cpu_property(const struct device_node *node,
				const char *name, int *lenp)
{
	const void *res;

	res = of_get_property(node, name, lenp);
	if (!res) {
		node = of_find_node_by_path("/cpus");
		if (node)
			res = of_get_property(node, name, lenp);
		of_node_put(node);
	}

	return res;
}

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

