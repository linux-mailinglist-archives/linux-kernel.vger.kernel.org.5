Return-Path: <linux-kernel+bounces-47389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BE844D38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3BA1F221C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910333BB3D;
	Wed, 31 Jan 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9c1ot3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5203A8CA;
	Wed, 31 Jan 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744514; cv=none; b=X25GZeF3EqT3AXn3sudSk9jBiT3cxZArntT3Val7skwAJ5YJEaWDhHfrcuI3ORhD1J0laurKhTVORTSeRJ1LPaIoO03KYY/DTAtFkc6jBTNu1LeDLKOFVQdpJUjuBXC514jYN6JoajD8T14zuxJM8FXQN+I9pv5Lgv+Jsn9wo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744514; c=relaxed/simple;
	bh=Cxry7gNqW2doRhJEQkZIqtEdzMs9aiFd0Dqs4XIolps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNo9pNiHNV6cFc1RyB5KjQVs/KL7xQB1PGse6Abk/rJ7D66C0s2Q9vZuVTSRW02xwsQsP8orKIe/jP03uNVxop692Bdhip0z+KRlP2jJPFGXeBL7jBTUPNBoqjAk6fnm9UEA+OAN6o8XZXja1fOkfn8v70zWVOmGln6gUSD++i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9c1ot3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97879C433C7;
	Wed, 31 Jan 2024 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706744514;
	bh=Cxry7gNqW2doRhJEQkZIqtEdzMs9aiFd0Dqs4XIolps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9c1ot3iIXBALfeUAu3wqIIJ7Ti8ktIInBfVbWNZhd1coiGlvHEg/G7EFO4mB2vR3
	 tCnJ5dWRDePTI5zb3mVZzlXawgGgnmwTJuV2A04LjKjcictcYm5SXybHee+VtGT/lg
	 dUax5FimBswXB5IlU2zZlSGiaznW3aCVYxH2mvEqd1CwTHIcVniV/3Cw0xGkP/3ZIH
	 SgUm/bpRtF6R0dgePswepsAgLm9BLA+S5pu/r82Zqdbms5RmuJXRRMJ61TfPmXqxLW
	 HgFNjRnXlbkc189WnNNSXT9HavAuiCpcrVvTMjBwdDyCqWDmQl7Qol3VyBhsBxcNyM
	 7DWjvyFUBV+YA==
Date: Wed, 31 Jan 2024 15:41:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Vinod Koul <vkoul@kernel.org>, bhupesh.linux@gmail.com, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Drop unreachable reviewer for Qualcomm
 ETHQOS ethernet driver
Message-ID: <20240131154148.00d9d318@kernel.org>
In-Reply-To: <ual3c4fuuz5trgn2ekklsfeslwvswfjg5nij5epbnuf5mihfay@pp32fs6btwxk>
References: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
	<ZbkWwn-oN5wqoPfJ@matsya>
	<ual3c4fuuz5trgn2ekklsfeslwvswfjg5nij5epbnuf5mihfay@pp32fs6btwxk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 09:53:22 -0600 Andrew Halaney wrote:
> > Looks like Bhupesh sent the patch changing but never followed up with a
> > v2 for this:
> > lore.kernel.org/r/20230915191600.3410862-1-bhupesh.linux@gmail.com
> > 
> > Would prefer if this is changed to his email (copied him as well)
> >   
> 
> Thanks for finding that! Bhupesh, do you plan on spinning a v2 soon? If
> so I will not send a v2, otherwise I can respin this with your email and
> no .mailmap change.

The lack of response is not inspiring confidence. We can add Bhupesh
back if he wants to be active again..

