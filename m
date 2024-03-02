Return-Path: <linux-kernel+bounces-89439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D2C86F05E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BBA2852C0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935141756D;
	Sat,  2 Mar 2024 11:52:53 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6E10A21;
	Sat,  2 Mar 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709380373; cv=none; b=nVOkQkEa/VEKIkwMcX8vwLNgpb0U0E8CRKLYjHfrbw0XH+AjgqKJ4oFaiTcIlj7f49vzJjfCK9sZL5XdLuArjeLKcrCMzCpLh/VHa2nhhne/sni+vtyuSrErSBCosqXBgjTBmGEtBuoiBiI0Rs23KEEAoG5MK/Mo0GfZ8TnfqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709380373; c=relaxed/simple;
	bh=8xHNwMMQvUphpw7xYtBL3c+lR7+sHEAbXvlGd+ihcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIe/CkqD6etmlHc9ThNC/lhB9detF15EOOP/1nUbQuMaAei5ST8Ad9Mn1hU04jBqgNvSb0HSj6sqtPPICyj/Z+OBA87zK2/nh+XWP1e3zrIBjDjdWCMO+acOFbDHqoDPjt5Fd3gGu7Qvi4+pO3U4wPN3wFp/MqG6yPmEZK3pck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rgNuz-00027B-Jh; Sat, 02 Mar 2024 12:52:41 +0100
Date: Sat, 2 Mar 2024 12:52:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>,
	"fw@strlen.de" <fw@strlen.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v2] netfilter: Add protection for bmp length out of
 range
Message-ID: <20240302115241.GA7494@breakpoint.cc>
References: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
 <ZeL1_-Pdq6Kw0NIO@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeL1_-Pdq6Kw0NIO@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > +	if (f->sz > 32)
> > +		return H323_ERROR_RANGE;
> 
> Could you possibly place this in get_bitmap()? IIRC these are the only
> two calls to this function.

How would you signal the error?  I think this patch is fine as-is.

