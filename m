Return-Path: <linux-kernel+bounces-46684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C584429F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D503628BA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15ED84A52;
	Wed, 31 Jan 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTXNxpIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00F69D00;
	Wed, 31 Jan 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713657; cv=none; b=IwLoF0vn1SlJkfrxdTdtycxZv1SPShaxUwNCqfHxB1q621nXxYmJZkusYg2ZdCB5+ddJFR9ejy5ZOEtl24msbphK3dcoYWxpxADN6uWXEAwV0+1+8ciQnfed4S0Q98VlXIfI0UjXbGWg8AnH/sGtoaKZ+fVcQqgNt8KcB9/sofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713657; c=relaxed/simple;
	bh=3aiCCA7CxoRzULPh9IwHf5NFobEP7nFqJa6RSSR5YKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Autg2wiW0/a1lRSpDzEIFdKO3ZJL5MOQ96eSRBfD/Av8Zog4uwhYt8VhSGpW9rVJvGSB+LQfMD8GxEquVfvnzLZWylO3PbDFBubqoQw5zqFkln6opJ0Q9Jk9Gr3EbDp4U+xUVdv1gIkHXjlpYwRyDXbAAd8B3IWqnfkzeVYTPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTXNxpIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600FEC43394;
	Wed, 31 Jan 2024 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706713656;
	bh=3aiCCA7CxoRzULPh9IwHf5NFobEP7nFqJa6RSSR5YKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uTXNxpIRBUUC/CUHs3JtFSRg+n+3BvDfZVl1RrjZZXQvlDOxAOmbrhSQjSrTOOVhE
	 9QwSX9FDbGNCTXYAGJ+G5ilToXA/H1Qu+4NSpZKMb9g9aUxJkI+fxAQa+7IHu1bIAN
	 /w+DzhEuV/wg8BDXmC2frAZ+wrU9CBVs0NmD1qbwY8eQ1ChEkJoLeaRr5XHPQ1XENu
	 qwFGUJNqgiaNRioT4lIHOyjeoedcrR8q7h2Ow1vDsR7Yg7XFF6j6RMBN1GJtxL8sBP
	 TXLbf8JiLUSVXlwf0NZ07WGe6M7NTkF4I8yja798jwaUzWQky8LtwnTQoYVGc/G5hr
	 Or2bHLC3KC1Bg==
Date: Wed, 31 Jan 2024 09:07:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pci-current tree
Message-ID: <20240131150734.GA585821@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbn58XcoOXauLUjN@hovoldconsulting.com>

On Wed, Jan 31, 2024 at 08:42:41AM +0100, Johan Hovold wrote:
> On Wed, Jan 31, 2024 at 12:58:43PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the pci-current tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > drivers/pci/bus.c:440: warning: Function parameter or struct member 'top' not described in 'pci_walk_bus'
> > drivers/pci/bus.c:440: warning: Function parameter or struct member 'cb' not described in 'pci_walk_bus'
> > drivers/pci/bus.c:440: warning: Function parameter or struct member 'userdata' not described in 'pci_walk_bus'
> > 
> > Introduced by commit
> > 
> >   69fb843fdbd9 ("PCI/ASPM: Fix deadlock when enabling ASPM")
> 
> Bah, I added a newline after the opening /** when moving a comment
> without noticing that the kernel doc comment was malformed.
> 
> Bjorn, you could either remove that newline or squash the below patch
> address this.

Squashed in, thanks!

> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 116415f91195..826b5016a101 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -425,9 +425,9 @@ static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void
>  
>  /**
>   *  pci_walk_bus - walk devices on/under bus, calling callback.
> - *  @top      bus whose devices should be walked
> - *  @cb       callback to be called for each device found
> - *  @userdata arbitrary pointer to be passed to callback.
> + *  @top: bus whose devices should be walked
> + *  @cb: callback to be called for each device found
> + *  @userdata: arbitrary pointer to be passed to callback
>   *
>   *  Walk the given bus, including any bridged devices
>   *  on buses under this bus.  Call the provided callback



