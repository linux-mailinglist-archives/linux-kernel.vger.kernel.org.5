Return-Path: <linux-kernel+bounces-47628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19CE845073
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07601C265E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECE3BB4F;
	Thu,  1 Feb 2024 04:46:42 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6E3A8C5;
	Thu,  1 Feb 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762802; cv=none; b=oMjyqXg58n13+DOPMIe0GepLKR1a2zvFWUanva+EpB7cj+YcXjSEO5M/2sPBnYJFMv3nfPhH5OJyz1OgE+B0UhGYE7tgauFlr580+AFoMkKzJhJxNU4psxnZNDnsfb6WLUmpzKO4pu3xvRMXxf/FzanZaKG3VPwBb0ERdc/I7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762802; c=relaxed/simple;
	bh=0OnbX1yCvm3sQP0M00aaws33W9O3jQOQMuSIPOlVDSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYMw+F3DY7QvIEgDY8nO/fsjE9kp+6ImVcucCuxFXDzvrdhhECP3sWpRUrofo7qLzVMy9KVfBhdNRmnhkXFMM5R6PKyUq6sTjueP55dDIyj/M3iDtn41ctCRvcOj3O3Bm48/g01XLyHWs5id+81FGG7aERGP3p48PgVQf4cbctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8562227A88; Thu,  1 Feb 2024 05:46:37 +0100 (CET)
Date: Thu, 1 Feb 2024 05:46:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <20240201044637.GC14176@lst.de>
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-2-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131191732.3247996-2-cleech@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

As the least horrible way out this looks ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Bt maybe you can add some commentary why this mem mode exists and
why no one should be using it in new code?


