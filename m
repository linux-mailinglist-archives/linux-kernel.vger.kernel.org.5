Return-Path: <linux-kernel+bounces-34155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACE837495
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B561C271A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0A47A73;
	Mon, 22 Jan 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPWsA64Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11937405CF;
	Mon, 22 Jan 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956703; cv=none; b=qbsJFev1DMAtC2gRdEERyZ6blmuk9UdHgDGf0L79IyOPO3nps78NS4VJ31cbcL0w7BXStw8TPjX6W+0jF/kxSXlXtpgLuePucW984qWgYMOsrCvzmoyqC6bZ+KNm+YzezkH9WFuJvtZOVxW2Z+hO4Bk0ivne+1gzq1Yw2WRFQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956703; c=relaxed/simple;
	bh=kBy1Gyk4KwbMYdlczXCSVyblnX5b1/z4nvmDyE4PLA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCnVj8IzJgYCDvlH5Pq4arTWNAKCgwCDG8II28dLqsAvxtzWYiDFxK6HSjXEptf9edJ+YK/DFGKavAt+dFGrVIyxoPVbgFq1rFfTqcOtQuiiISY+Y95PWeZuEQuxZyUkkBDBvqj+hDVmlMxjGIyFYPcroohuKEkATzrQRf4Jxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPWsA64Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6596EC433C7;
	Mon, 22 Jan 2024 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956702;
	bh=kBy1Gyk4KwbMYdlczXCSVyblnX5b1/z4nvmDyE4PLA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPWsA64QiIJiR5DEKExhPQM45t/lykkdoZuwLhoV9qa+hsveaxJx69OxBa/F/lttl
	 8mcarfEKPnDixdfMXPTmx8P8sNxYiNicA2r/9EbkMiGkN6JNadMqgArG0N+L7Dp4LI
	 ZMdOY8bk1HQDwQhlGiV/xjr6XXLZPsz4of0y+bEzh3Pzlr3e/mCmP1cXB7YLHD4hFX
	 1BLcFb2ODHKE5LBI2OX1zFMzprz3/sdPLD3t5cdDxdxEnbA8LDwoMygQjEOwCbIfdj
	 oLY98/Kr7+ilOZkPyfeLiK9MJEPNyMW1n7Bc1d10tubvdK6pz64h1LY9AnD9sNrkVi
	 G5SPSU89GeJcg==
Date: Mon, 22 Jan 2024 20:51:37 +0000
From: Simon Horman <horms@kernel.org>
To: Suresh Kumar <suresh2514@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl v2] i40e: print correct hw max rss count in kernel
 ring buffer
Message-ID: <20240122205137.GH126470@kernel.org>
References: <20240120072806.8554-1-suresh2514@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120072806.8554-1-suresh2514@gmail.com>

On Sat, Jan 20, 2024 at 12:58:06PM +0530, Suresh Kumar wrote:
> pf->rss_size_max is hardcoded and always prints max rss count as 64.
> 
> Eg:
>   kernel: i40e 0000:af:00.1: User requested queue count/HW max RSS count:  104/64
> 
> whereas  ethtool reports the correct value from "vsi->num_queue_pairs"
> 
> Channel parameters for eno33:
> Pre-set maximums:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   104
> Current hardware settings:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   104  <-------
> 
> and is misleading.
> 
> Change it to vsi->num_queue_pairs
> 
> Signed-off-by: Suresh Kumar <suresh2514@gmail.com>

Hi Suresh,

following-up on our earlier emails.

I do think that if this it is a fix it should have a fixes tag.
Which should be for the commit where the bug was first visible to users.

