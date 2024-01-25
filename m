Return-Path: <linux-kernel+bounces-38524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F5983C103
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF4028C4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81164481A8;
	Thu, 25 Jan 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTrlUi5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802446447;
	Thu, 25 Jan 2024 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182436; cv=none; b=KM3wWN9v7Gzu6pPpgzMkQy9w4TLoy4lpeUtTZnxUvOFAHNqQLmdbz6H4fVX7K+feg9zLfHO/EnFAjJ0JaHWLzr89tk4s9b+n+rzA3oYlEjIc4QnInSK1tpor7pfSZMcjY3S3q5YrE/9T9zyEA9XvGySgY6gLJmdMKUvqgqczcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182436; c=relaxed/simple;
	bh=sJBazGEgZqoeVApoEuk0AF0P4v6I9SX7AQhh97D4vH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD/FcfVm9mMs05/M0gs6FNJPI1NJa5wKzCuN8cOd3kC5jBJ+Ro3fyuegVHZeuFaPX5E7OTX0EuUQKXVzBJgMAZgvDJ6YSSalYQdL3sdBxnI61MdIqKpTPiceYZFCGtViu3cOuD2hVgMAzAb159l6GowrO4fAlPlyIGFK0amFGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTrlUi5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2FEC433B2;
	Thu, 25 Jan 2024 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706182436;
	bh=sJBazGEgZqoeVApoEuk0AF0P4v6I9SX7AQhh97D4vH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTrlUi5hnMtlWHfQ+5vNeKY5jnz3O0d4erR2K73kUPveu2kCYNUAKbOxk2NjbQJSr
	 9cp9QkQ7f+n/tvptNbAamOQ1fuG1Bdgj3U0LpjKPn7bMSSzWS0CtRyHkpp8Nsid8lE
	 AoCYAOp/FjPFZGN3arvM3CrRWXi/sHXMYrZM+5vDL5V3USG1tdcix7pshKhvQgf8yB
	 hEJta9HkACkzZ4zrb+KQkqrK3tjVoUg+KOyYt9lETprqeD5OoM9bmiYZDsbuZwxV+B
	 AAFrR3WCTMIQWRLuX4U3wUArOIgmRBSg0E+GCJL9XvQKTBeIzZFOlyox6fgiRHg/oQ
	 pml++HTga/qig==
Date: Thu, 25 Jan 2024 11:33:51 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 2/3] octeontx2-af: Add mbox to alloc/free BPIDs
Message-ID: <20240125113351.GG217708@kernel.org>
References: <20240124055014.32694-1-gakula@marvell.com>
 <20240124055014.32694-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124055014.32694-3-gakula@marvell.com>

On Wed, Jan 24, 2024 at 11:20:13AM +0530, Geetha sowjanya wrote:
> Adds mbox handlers to allocate/free BPIDs from the free BPIDs pool.
> This can be used by the PF/VF to request up to 8 BPIds.
> Also adds a mbox handler to configure NIXX_AF_RX_CHANX with multiple
> Bpids.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


