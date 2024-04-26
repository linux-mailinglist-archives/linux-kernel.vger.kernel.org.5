Return-Path: <linux-kernel+bounces-159730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C68B3358
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570891F22E55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99013D26B;
	Fri, 26 Apr 2024 08:52:11 +0000 (UTC)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07A2AF02;
	Fri, 26 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121530; cv=none; b=bJLaOpJ0sTvIOzWDa6xzc6XIHUF4GkjksTl+6fSsap1bOCZPgOa3kKZRVPPsiWLZ34OelT43nt+bss1mUltgaXujmcEkZJJOvXLQyL3K/kjrDaqh0N4atYG+FSN3hXXJ3FNuhjZBQ8lhpCzh0eYmzYYyPVRLg7W59z/LYyzeGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121530; c=relaxed/simple;
	bh=QWjcz7DXkXVKIZtE3S2+Scj+DK59MRahn1IPxQpGUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBd0lW4ztaXsJKR4hv1q3rVKQHYzEWhabcvZZUPGxTpqu3quiCm6Y2TeRDYQT+dYcCvZ261rwOeppyXEbH+S17fKE5TrQSvUqW3o7L7ztPg8L8W+qOgFB6YuM8bgVYL47Iar0pNIjTLmL1kzid5jpGh7bn1jHV4CuP9XRocUXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C29A47219;
	Fri, 26 Apr 2024 10:45:27 +0200 (CEST)
Date: Fri, 26 Apr 2024 10:45:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dietmar Maurer <dietmar@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	Alexandre Derumier <aderumier@odiso.com>
Subject: Re: [PATCH net] netfilter: conntrack: fix ct-state for ICMPv6
 Multicast Router Discovery
Message-ID: <Zitppppzfbbdym78@sellars>
References: <20240306141805.17679-1-linus.luessing@c0d3.blue>
 <ZfyeC8mjLnGkqnVT@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfyeC8mjLnGkqnVT@calendula>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, Mar 21, 2024 at 09:52:27PM +0100, Pablo Neira Ayuso wrote:
> [...]
> I am going to include your Fixes: tag and pass up this patch upstream.
> 
> Thanks.

Thanks, sounds good to me! (in case my final OK was still expected/needed)

