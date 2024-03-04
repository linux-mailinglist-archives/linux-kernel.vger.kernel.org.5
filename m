Return-Path: <linux-kernel+bounces-91004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09634870854
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C12E1F21159
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B6612ED;
	Mon,  4 Mar 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzmC7j0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8D1E484;
	Mon,  4 Mar 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573575; cv=none; b=dPBv6i4A3Y1stKzgRP4UbbnEpgfjhvatpdWFqTDLK3w/fF8eiVzU8aeStm5uL/KhnZdDFpB3GPPLIsmlXsH/m8QRaU+sQwQ4LrnU4LDBImD/lrr5bUovS5XJCLT44ibVd9CZU13i3BJWZ53FgOZpPuTHidGaAQBnYgugFn0Rwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573575; c=relaxed/simple;
	bh=+IW+YDKGh9GrcXOaSorNCKmwiir+EFYzEfc4h4VwKU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsB13FCO401X6JojnNOuJe4E9AGaRuNYd8tPnwYVl2FXwWjUrePAqAJwNbea9v/Iv2Ib5x6J4DRi6zq1Ou8ckT1Z3OfPUJ6dXcUj13jirfqhQFvb01L7a5Dg76sjpMHYn0w12vytNosf4AGlrfp66PA5Vfb28Oe8pUWt0oh+6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzmC7j0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA6C433F1;
	Mon,  4 Mar 2024 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709573575;
	bh=+IW+YDKGh9GrcXOaSorNCKmwiir+EFYzEfc4h4VwKU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzmC7j0+OJokakRY0jBxaQHkfCNNC65RFSyEJTJnz5/szAaOC21Cfw/CJp65qLTmi
	 shXiKBDp+ay2AJqKT1LyauhbqfzlEuE/XAOHZbrtVz1rdme8IYsugGEiiT0qpT4X6h
	 GRXDqcWoWXfmXg/FCH85xDW0d3wF3wL4lNs2c8xRPsJLIS2BhK9kf4XTMC5hTSk+fO
	 UPaGhKWMg5tP7A8XEMXO7/Ew3N5kPMgJfELEfmuoAbevrtl2mi8mHbyUE9GburgCOh
	 CiWVvTyth3ziO4h3xQJvuqjmL3D/gZsHhU1+vAuupZQbLBzW4C42/XzyMKs3JOP64Y
	 nitu/+xXlHdvA==
Date: Mon, 4 Mar 2024 17:32:50 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: R SUNDAR <prosunofficial@gmail.com>, jmaloy@redhat.com,
	ying.xue@windriver.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed inputq,namedq field description to prevent
 kernel doc warnings.
Message-ID: <20240304173250.GM403078@kernel.org>
References: <20240303143919.6903-1-prosunofficial@gmail.com>
 <120c265e-dde5-454e-8e0b-72a1361912b6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120c265e-dde5-454e-8e0b-72a1361912b6@infradead.org>

On Sun, Mar 03, 2024 at 08:41:56AM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 3/3/24 06:39, R SUNDAR wrote:
> > /net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
> > /net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'
> > 
> > Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> 
> This is already fixed in linux-next and net-next, as was another one of your
> patches.
> I suggest that you focus more on the -next trees for such patch targets.

Yes, agreed. A similar patch was accepted in January.

Link: https://git.kernel.org/netdev/net-next/c/5ca1a5153a28

-- 
pw-bot: not-applicable

