Return-Path: <linux-kernel+bounces-37572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F983B1CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F0128531A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99420132C30;
	Wed, 24 Jan 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="E9yOoh/X"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6912CDA0;
	Wed, 24 Jan 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123160; cv=none; b=r0tTfZ2xINqvUxf2eB7O6T0YPNnwtoRRsTf3NpgqzGArBY9LtZLr5odbECNdJvnETT5pIsYKXrb//Kbifh3RH/jDzfwngT/1VXq0tRrInfiV0oYNlMGWY90K/JUgp5jZz5G1F3dQpHwRUMczNTC5cPmRE7LemqIMjxprtlednRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123160; c=relaxed/simple;
	bh=j3ppBYKS2aBy3MCuBBzhzI0ZpLlu6832vbWamcxbxzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn4490W3y5GOpbWnshfJoaK0/DTUiPoXvy7EbkKihWDnHZcdWygurabH6v8YwJTFeOdDvknzlBb3vd8g+RHWHTVXSI7xWfQXg5+2w8iwBmGd9Qx6FkkLg/aAzrzVnHSAKFiWIjdguOMgl2xeQWnUbmYiLfn/vxoY22LNDsK12G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=E9yOoh/X; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C77C11C0050; Wed, 24 Jan 2024 20:05:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706123155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5DRll6lmXicAwr6wsX/zY977edd4j9dNj3nxzpjkUE=;
	b=E9yOoh/XdqoV6B0MScSmcAAvDVLfNkzCttT5SFGF6npMVkCcGoScic/s+VzYvc3wihSP0O
	50PIe5mnpL180Jnp8UZn6liv2d70E5acbkSi2jmfTpiCeiZ3zct9cAZ6611PuifubtNBxH
	THzZrwL4MNMiKMsZcadSa0PMyF5qJpM=
Date: Wed, 24 Jan 2024 20:05:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martijn Braam <martijn@brixit.nl>
Cc: fiona.klute@gmx.de, phone-devel@vger.kernel.org, icenowy@aosc.xyz,
	megous@megous.com, kernel list <linux-kernel@vger.kernel.org>,
	alain.volmat@foss.st.com, sakari.ailus@linux.intel.com,
	linux-media@vger.kernel.org
Subject: Re: Front camera on pinephone
Message-ID: <ZbFfk5yXTxNi-rob@ucw.cz>
References: <ZaY44AHISMIh8fHM@duo.ucw.cz>
 <2c720f2e-3c73-4a77-92e0-5da8fce86b3f@brixit.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c720f2e-3c73-4a77-92e0-5da8fce86b3f@brixit.nl>

Hi!

> Isn't this simply the case of picking the gc2145 bits from Megis tree?
> 
> https://megous.com/git/linux/tree/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi?h=orange-pi-5.10#n410

Well, that, adjusting dts bits to the new driver, testing and
submitting the patch. And it looks someone did the work and patches
are floating around. GOod :-).

I'm fighting with kexec crashing as soon as I pass dtb. Do I need to
modify the dtb somehow?

Best regards,
								Pavel

