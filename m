Return-Path: <linux-kernel+bounces-62104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CE851B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F8287843
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6053D994;
	Mon, 12 Feb 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AHwCVX/8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397A3F8C0;
	Mon, 12 Feb 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759181; cv=none; b=ReofhJuumeImQ7ozxRiBAFJkff/odX+PJxUeFf2J+idUQEALFYKSafNcNuOzgK0HxrIlw7CP3t/qyyWEGLxBWz65Qk/8nBEx+6/7fu1o0f1X4o/zCAQXeZ8B+mf4ZE7UoxGmzj9W5JSmMaHlJ7tbBe/Qga16NyWD4Pq6IvZN/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759181; c=relaxed/simple;
	bh=ycASeXV3KO9wMFNSd8aZBjKIIjNypcWPT1rqnJjtTMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es9BPw1TpKmBDdC8vMkcXNm5OXYrObuZd0NQky5xN93Gz0ZV5GUh9FsAyc6pUmNEtt759RXJxsAylrhZr3uU+BYKu8CeiA61syYUlWBeh0W7RZ0OzLM4/wopSNvREF3LMgtTtT23B41reAlE1WXFShNwgzKnfzHHuk9b4zyT1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AHwCVX/8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7C79620A72;
	Mon, 12 Feb 2024 18:32:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707759168;
	bh=zo/oDhSUJr68jp7VDpSrQdmexgxO3TUo2BA+NclIfvE=; h=From:To:Subject;
	b=AHwCVX/8mUNbJNOyDHvMXI9rT+6UtiDnhIcR4yoXe1wSRGBe7WB7HQlyOSMtEqEZx
	 4dUDpF2E+Y9WemvxE/0v7ZAnzuqgQtEAI1f9u58VZllNFAHeJIR2zRfIpqEtFFwftK
	 SN58IRVbeDHBYSKjj1KGdbeTiaBWACmaNIA9/dsg/N9Pj0oqn9+JSOSxhb+dkhHODB
	 DwzOU5tHFOD4twQ6TUCoqUVSaAg3kXUEniVyqqmvinFLZIRz2MCOgXAHaVcsRRO0DY
	 Qw0utWevoPrjzeA2gUZXQazIQayqg7d6qIS1FJsxwRO+4vMEG95QK5OxdV/ErFQj6g
	 RGjf9zkbNrFtQ==
Date: Mon, 12 Feb 2024 18:32:44 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add tuning algorithm for delay chain
Message-ID: <20240212173244.GA17182@francesco-nb>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240211160232.GB4443@francesco-nb>
 <7482f19f-b340-482f-bdf6-a5a68aeaf09e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7482f19f-b340-482f-bdf6-a5a68aeaf09e@ti.com>

Hi Judith,

On Mon, Feb 12, 2024 at 10:33:35AM -0600, Judith Mendez wrote:
> Hi Francesco,
> 
> On 2/11/24 10:02 AM, Francesco Dolcini wrote:
> > On Tue, Feb 06, 2024 at 07:15:13PM -0600, Judith Mendez wrote:
> > > This patch series introduces a new tuning algorithm for
> > > mmc. The new algorithm should be used when delay chain is
> > > enabled. The ITAPDLY is selected from the largest passing
> > > window and the buffer is not viewed as a circular buffer.
> > > The new tuning algorithm is implemented as per the paper
> > > published here [0] and has been tested on the following
> > 
> > Where is this `[0]`?
> 
> I must have missed linking the ref doc here, will add in next
> iteration, thanks.
> 
> > 
> > > platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
> > > EVM.
> > 
> > In the other patches you link some document, but I was not able to find
> > anything related to AM62, can you provide some reference on this
> > specific SOC?
> 
> This patch series fixes issues that affect all Sitara SoCs, not only
> AM62x. However, I could use AM62x for reference, no problem.

I am really looking for documentation here that is related to the AM62
because I was not able to find anything and this is a topic of interest
for me.

Can you share something?

Francesco


