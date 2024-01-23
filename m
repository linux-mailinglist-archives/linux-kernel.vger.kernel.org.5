Return-Path: <linux-kernel+bounces-35415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F148390A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DD61F2172C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED445F84C;
	Tue, 23 Jan 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JU7vykwa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C625F565;
	Tue, 23 Jan 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018273; cv=none; b=lRvNI49TqSUC+zaP4scXxrcMN4FfkL+p9BvUM5g0//wVFEBprGGKgthXrqxpOCPO6vGJMa2QI0vNSJ8KyQGGHCHnzE/1kCMG0+BSvvFbQM1/3hL13B8I1KHoGH4RB4zBgFaWwPCPNZcbtpWahkigBFudYz2Z3GhQyQxbJUbkUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018273; c=relaxed/simple;
	bh=Lr743DzRNBCOnIZotz3AEaz8XjiK7d4JarUHiopO4OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIg+i/P+FqDR4ZmTwiOfP0FdKNIoUB0IJvRWIKHgRspr3B/xC5t/b0JYJslYwhjfsubQIxUOzIlVSrpZfNGQEjNNUCMR+UWs26PXLuspjVqesLdAY3CHABtSU30lDh2qPlxeSfgoQmT23f72KMLSrwBo/jWB7NDL3zgjqdhhafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JU7vykwa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E3A340E01BB;
	Tue, 23 Jan 2024 13:57:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jUJ43itIBKnQ; Tue, 23 Jan 2024 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706018258; bh=Gq9fhd5LizCMfcgUfno0hm3hs9DAa8aKTa1odpHlDJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU7vykwaoGxztRqZ6gofU73miwd+PR+/TOelEPKWuKd433UOJNr+m4I5bIJrWqmIJ
	 B7RZuHvO+zZQd1oFWJLs0hhBpa4MrfoXL02ANAkRbw+iEcpec9/ltM1Qb3T9Bp/KjF
	 OIchcno2pskeKFXKXs4yWt5vjputIBcfo/3DlB8CbtxiPhjT+0RQHKmN+6IPIfyJh2
	 bJ6PV1XeB9vJ989M6C+87cwx8yoO1WZuHfXT/JD6kPvmOjE01fYivGhjgiGulmkf/d
	 ojG69FBQc4aPeJ1+udgDPgCTq5PxgwfNCUZDel4Xm2yosqGi6F2tzIgsXwAy5wqS37
	 m5H0bcZ4ngyLrMM0k+fpeZ80ziRsBeUzkyHs9WUofefZAQSkOPbB4BylvlzbYs1GQT
	 jI85pJ7ABUq+sbpjerG/08Khok/L0CUsqIigryqenRSsf8KNueFi7vBtmrQACVKGY7
	 FnqnU95WWRlkWiztzyxuhu3hczQN4voubzBSb/qj1+UEqoaq9/jd5Ps+M1o6rNOuW4
	 A3ApfB/g1eLrlNjq7mgjqITigUk9aCoLFXfa1CABBorl2qXuuaaWd+3lL/YScAHmKw
	 sVzdBBBeZOQv4rOF3fMpDGYcDeoGrq43ttP2owDwV2nlnowUnD7+j8u15f8ExyAMVz
	 lnfzT2fhtQbFx+aig8nlW9DA=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60AF440E00C5;
	Tue, 23 Jan 2024 13:57:29 +0000 (UTC)
Date: Tue, 23 Jan 2024 14:57:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michal Simek <michal.simek@amd.com>, Yangtao Li <frank.li@vivo.com>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] EDAC/synopsys: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20240123135720.GTZa_FwNLkUmxqKInU@fat_crate.local>
References: <20230704101811.49637-1-frank.li@vivo.com>
 <20230704101811.49637-3-frank.li@vivo.com>
 <7765c981-7ea1-60a8-a297-7f739ca9a458@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7765c981-7ea1-60a8-a297-7f739ca9a458@amd.com>

On Tue, Jul 04, 2023 at 02:17:09PM +0200, Michal Simek wrote:
> On 7/4/23 12:18, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   drivers/edac/synopsys_edac.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> > index f7d37c282819..620861fb5231 100644
> > --- a/drivers/edac/synopsys_edac.c
> > +++ b/drivers/edac/synopsys_edac.c
> > @@ -1325,11 +1325,9 @@ static int mc_probe(struct platform_device *pdev)
> >   	struct synps_edac_priv *priv;
> >   	struct mem_ctl_info *mci;
> >   	void __iomem *baseaddr;
> > -	struct resource *res;
> >   	int rc;
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> > +	baseaddr = devm_platform_ioremap_resource(pdev, 0);
> >   	if (IS_ERR(baseaddr))
> >   		return PTR_ERR(baseaddr);
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

