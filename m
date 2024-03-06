Return-Path: <linux-kernel+bounces-94350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0B873DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E9A282470
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AD13C9C6;
	Wed,  6 Mar 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNgkFwNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CD5CDE2;
	Wed,  6 Mar 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747526; cv=none; b=Tf9kC5jc4jXIt23wi1KQe3+Q7x6kqpN+tMDrLOKsl1Hb2pD2w1YHCPADZLo1GfQxV2I9CHNvKM4XcAaICMVZn51U+yBSJ1WGus7sfsighr1URcu2goblcmO2kQDuCWwF7i2TsjDY4ibDkBvEGse/Xw30glxHXTN8aBjtB+1AxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747526; c=relaxed/simple;
	bh=jgEqnyMEYTp0IrTDwRr0KVr2VswUj1JqQ0+266jhtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjU9BbH0gbw66ay92JD9Z6MRV5dBZk+BBHs5CJ2TUBZTC4pSSzvY1VIYoXED1/+dal7BXORDRxr5bkJ6h8tQjGtw0zIzQMhb4gGxsWNEiHgjME4PhvBtV5aioRnvh0/KVNYwD3vI7Bm6GCP4aCQ71+h4j3iOKkypa3U5WLULLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNgkFwNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9EAC433F1;
	Wed,  6 Mar 2024 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709747526;
	bh=jgEqnyMEYTp0IrTDwRr0KVr2VswUj1JqQ0+266jhtlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNgkFwNjM9f6hkLDbZFwtoLQAcqD7MooHi0DYcg9Q1zc0riXtyrd84D9NCPSY11Va
	 awkyccB/VTiowgOSLD2Nbn2zkpdPCtVPhRRAd5Hpy7kKAIwIPpkrA0PITYNm3e6/78
	 kLgHlyJrdXcfAwDdG51qSaN20KgCVH2Wc8UJVuXGv4xgPQmgWDhyMJwv2cxW+XpKMk
	 DDHR42nKbVSF/r3/YT7OYuDqiEcq5y3xAeHprU9uTS1N8vIfTLCyEBpdwqNzxVAd2r
	 UdYkhPY1zyDFYSZIoQ0IWVlQ4DfySJav08uy+jsvPXc3sYuxOCi8gBVJve62/rKkOO
	 Pnq+iQwXPIHBA==
Date: Wed, 6 Mar 2024 09:52:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] net: wan: Add support for QMC
 HDLC
Message-ID: <20240306095205.5875d8ae@kernel.org>
In-Reply-To: <20240306184611.0cea20af@bootlin.com>
References: <20240306080726.167338-2-herve.codina@bootlin.com>
	<20240306105651.1210286-1-rkannoth@marvell.com>
	<20240306143743.5732b298@bootlin.com>
	<MWHPR1801MB191837C8907B39F67893F0BBD3212@MWHPR1801MB1918.namprd18.prod.outlook.com>
	<20240306082230.7ecf207b@kernel.org>
	<20240306184611.0cea20af@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 18:46:11 +0100 Herve Codina wrote:
> > > ACK. Usually I get comments to split declaration and assignment for
> > > my patches in upstream.     
> > 
> > Yup, that's our general preference, to split the init out of 
> > the definition.  
> 
> Does it mean that I need to update in a next iteration ?

If you'd be so kind.

