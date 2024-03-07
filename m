Return-Path: <linux-kernel+bounces-96173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C0875811
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D54EB23DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D5E1384A6;
	Thu,  7 Mar 2024 20:16:38 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103412F593;
	Thu,  7 Mar 2024 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842597; cv=none; b=sdvcQWX4L+g/NFqetYIdgDC4XoSPDpuxbo8WczDSOykOcUOtJE72JYoCNbaWTuG1/CJqJGCa6tzTVjEfaCJ+ZVsvu2W1SN8Jl0sHAYR7jUAwvAPU3nMcQD0TYz31iAs05oFzxc0BM4t+P67Oek1AuwPV3HN/Kjh2IVVi7jZ55rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842597; c=relaxed/simple;
	bh=8gmRJm83mDNGqmsZS6yqSG0sCWwT7f8vYOopRnfrElA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d6q8uC2z7XghedQodU2j2qKnDQmCJBt7CvEzB8nIWSmU8HB4qaQJi92PybTyNPKWX8BjptNXJ3QE/y2kW1jHleHOJhjnadGVpgeHspdn3ztFieZbA45qZ2C1mg9jHgcDCC8DhA2Y1G61DzMlJ9adRyYCgskTdkWUJ62cff3A/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C618992009C; Thu,  7 Mar 2024 21:16:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id BF00892009B;
	Thu,  7 Mar 2024 20:16:26 +0000 (GMT)
Date: Thu, 7 Mar 2024 20:16:26 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Larsson <andreas@gaisler.com>
cc: sam@ravnborg.org, sparclinux@vger.kernel.org, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
    Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
In-Reply-To: <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
Message-ID: <alpine.DEB.2.21.2403072015010.29359@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org> <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com> <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Mar 2024, Andreas Larsson wrote:

> I'll pick up the whole series apart for the ZONE_DMA removal, so there
> is no other need for a v3. I can add the Fixes lines to this one, if it
> is ok with you Sam, or take it as is.

 Can I have the spelling of my name fixed though (which was supposed to be 
included with v3)?

  Maciej

