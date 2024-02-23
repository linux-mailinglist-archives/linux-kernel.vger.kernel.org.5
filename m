Return-Path: <linux-kernel+bounces-78444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C186139B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF0E1C21A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95C8002E;
	Fri, 23 Feb 2024 14:06:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE07E798;
	Fri, 23 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697188; cv=none; b=VniMxR1ZHzBqzfM5SZKT1gVVGMbPae1OoUWgRL8ggoZQa0OR35ElcSjEovpo4vnM1Z2vvTlM5zxYDxkymmitU5e06AB9rfMp/Y4vBWa7wg3GDCnvf2Hk15BrxxyrXp8nHf2i1+giRLfHxHlYebjTd9Mlof+Gwbiz/kB1kTdZ7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697188; c=relaxed/simple;
	bh=ScmL4w1XqacZnSkmwlBukyRTREwi2zf+jpOuAt0hDgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cymVkypTiqtbZfOxuea8/QhbX+cJnEAnMcdf0ogcEmUWgMVgoD1ImJBHiBWaO+BApcsE7dOWNfhbs44vSjpWbLGxeeM4v4Yd1ZoHQd7ML8JxHDV6iE1AQyE23mkP9B8+fTvXxtSVLG9GjnLt2PZ7ZkkNxoNX5AN4aorGomIXUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6410468B05; Fri, 23 Feb 2024 15:06:19 +0100 (CET)
Date: Fri, 23 Feb 2024 15:06:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	"Darrick J. Wong" <djwong@kernel.org>,
	David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: build warning after merge of the xfs tree
Message-ID: <20240223140619.GA30519@lst.de>
References: <20240223153636.41358be5@canb.auug.org.au> <20240223063554.GA10956@lst.de> <20240223095509.29024d9d@coco.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223095509.29024d9d@coco.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 23, 2024 at 09:55:09AM +0100, Mauro Carvalho Chehab wrote:
> but it is very weird for the ones reading the text file. So, what
> we do instead for pointers is to escape the entire declaration, like:
> 
> 	``*inode``
> 	``struct inode *inode``
> 
> I hope that helps.

In this case it says *foliop for an argument that is a double pointer
and the comment refers to what it point to.  I'll see what I can do
there, but the whole italic and bold thing seems entirely pointless
for kerneldoc..


