Return-Path: <linux-kernel+bounces-77838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C9860AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA7CB22783
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206812E43;
	Fri, 23 Feb 2024 06:36:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED512B61;
	Fri, 23 Feb 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670168; cv=none; b=FSNtl1E1fRcd587a/3+mBtlv3/fyp2o42jqbQCUumqiJoXMTyIjB7ZuPnzOrOgUOdCmYKu9ZD7Rj5DhphGl5FiejOV5tPr0pp8X6nqhCwlmR1pDcl1jf5ECMA/Y3TqZk/fiC6MHYaJq1qSz0NrCoDcAuqSl/+u4iMX8ITEM+akY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670168; c=relaxed/simple;
	bh=EIFSZLA5E0TBYviwcyp0D9WXc5GW7/560fbNDjLAGg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrhBr646TsLEcEHQtcVaMPgNG2UwNLqXFuaQM3drLoRsrsUrifEjxnb/iquAWPntuunH755E1t1bmAP4DqlipkkI5gyOQ+cZ0omCVS0L33kHhKwCgBZyl6iFwK/BYtfxL5H05QKr5J/GwpxAXn3ZNJVUl7yD7nofvPFwqu5dXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7809D68C7B; Fri, 23 Feb 2024 07:35:54 +0100 (CET)
Date: Fri, 23 Feb 2024 07:35:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: build warning after merge of the xfs tree
Message-ID: <20240223063554.GA10956@lst.de>
References: <20240223153636.41358be5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223153636.41358be5@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 23, 2024 at 03:36:36PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the xfs tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/core-api/mm-api:130: mm/shmem.c:2155: WARNING: Inline emphasis start-string without end-string.
> Documentation/core-api/mm-api:130: mm/shmem.c:2156: WARNING: Inline emphasis start-string without end-string.

Thanks for the headsup.  Looks like kernel-doc doesn't like the
pointer dereferene * operator.  Any good idea how to write this instead?

> 
> Introduced by commit
> 
>   d7468609ee0f ("shmem: export shmem_get_folio")
> 
> -- 
> Cheers,
> Stephen Rothwell


---end quoted text---

