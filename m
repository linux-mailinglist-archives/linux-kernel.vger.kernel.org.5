Return-Path: <linux-kernel+bounces-48522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E07845D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8930BB33F62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EED7E11F;
	Thu,  1 Feb 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khzggZHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B817E0EC;
	Thu,  1 Feb 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804839; cv=none; b=Cm8yDX0ZKM8GoJO1qTxEw0qLLuenCGVvoihNeO5wFglbcHkRHEiuqmFKIlOgZY6b6+WrVNGmfNljITOqM2P/XuCbpDuzccGspkP5sqUOd+OT5huVzMPSfaA5Po5W0w0k6LM+e/Nk1e5iYUS3BleXQA/a38bS1dXEbsnuiR9JTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804839; c=relaxed/simple;
	bh=ahIUy8vso575myYmWIjBbi8GpodW9BmM9NcyKx4waB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkwbxPWhhLXnmAmsOSxhkxNCT2fuv/YRB1/qJnmPap0USkDbTNYBuZbi6HUE/OG8YqBZhsCtpaKoVU7DgFbsTKS5ruD/m5QSesWCioV4Hy3wo4whxEf35Wss7aihfJyH3VGgUeKZduiFpKNRHtua44iAsTdmpM/pO4/U3Xr7EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khzggZHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8F3C433F1;
	Thu,  1 Feb 2024 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804838;
	bh=ahIUy8vso575myYmWIjBbi8GpodW9BmM9NcyKx4waB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khzggZHUGjInwLC9G46R08OzHghP+fg9MO1hJo3J9j+H7T69ZTh+YuZwXTDjORA18
	 D/3n5tq9F/RI7HvaVzrCU9xwQVbvpmznIOJYxSJGLlFWChctQXq0+lsRWQKVhinoj6
	 oV5rWDXoU8yTSmF9Raa9/M40cELR4iVTtmb0ujPu5VQNYZOJ8wQ1YMbKEB0OrXLsUz
	 cNNEJmomfWzZO8gKka5/32H14whoMyyjchJQ0/ZwujMU998KJ/sdWOkJ4UeoinNr52
	 wbDbbWAHCSvimsiqeIzwbs5j6bodN9SKWFQGlIwBsakrTMiwPpbZGv0p56t8ueLskJ
	 fbWQpapUZH1sw==
Date: Thu, 1 Feb 2024 08:27:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "bcreeley@amd.com" <bcreeley@amd.com>, Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>, Geethasowjanya Akula
 <gakula@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, Suman Ghosh
 <sumang@marvell.com>
Subject: Re: [EXT] Re: [PATCH net v3] octeontx2-af: Initialize maps.
Message-ID: <20240201082717.7b946987@kernel.org>
In-Reply-To: <MWHPR1801MB1918CFDBEC70A298A3781945D3432@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240131024118.254758-1-rkannoth@marvell.com>
	<20240201093119.GB514352@kernel.org>
	<MWHPR1801MB1918CFDBEC70A298A3781945D3432@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 09:35:15 +0000 Ratheesh Kannoth wrote:
> > The use of bitmap_zalloc()/bitmap_free() looks good to me.
> > But for the kmalloc_array(..., GFP_KERNEL | __GFP_ZERO) cases I think
> > kcalloc() is the way to go.  
> Kcalloc() is a wrapper around kmalloc_array().  Why do you think kcalloc()
> Is better ?

AFAICT this is not the first time you're questioning Simon's obviously
correct feedback. Are you genuinely asking for an explanation why
kcalloc() is better than kmalloc_array()? It's an equivalent to 
the standard C function, calloc().

The reviewers are the most valuable part of this community, we will 
not take frustrating them lightly :|

