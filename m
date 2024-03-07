Return-Path: <linux-kernel+bounces-95957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C5875557
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61F21F23B77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519E130E2B;
	Thu,  7 Mar 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIzF/9Wo"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844A12FF6C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833208; cv=none; b=UePGZkiM0HRCLwjLFSYuzw/3UVpv3oE30W0RdCM8fivEMsFYTP0ECMDbi76yK8kFvSgmZOWF7fwcaG/X+GLoa8Iebrn6KCHz61V1P08K/XqdQ2nfPi8oTNQfMjW3k/RCpHM8JZvAmRK+btO0Og3WN91uuBugo9PsQNyUp1Ueyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833208; c=relaxed/simple;
	bh=hRSl+XEmM4fPNM12v3nNoTx7PNw2TGseWo3VuRaIdko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gylSw+gbT+yt39esvrU9+K2IF0pXNEwDTFBL1irK00oecXQyVLTXi1sIBfprqGtBpdhI1GQWaa83ay20YYs4Nqyjez8Zg8l0cv+4UtbePJBcBz6xFgsPns85Jo+BLX9Hg9C+ZQT7bDvpJRyZfRYH8rwcQ+4tZkSBY0Ut0k7hLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIzF/9Wo; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Mar 2024 12:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709833205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Saf0V459wjVI/LACMclGTIzYyUNjj1FKOP0tushsb8k=;
	b=fIzF/9WoqVVDQVfK5OIIQsnwrnp4nKQCLhLc6Ex7PZuRVHUpvG+MG7OAWnrNk/UQ226T2I
	zMuqiO3Nt8FDHMBvH/C/1QnWTAu1Xumqk4ZVMdbHnVPyQSXF73y+BeESa5PW552epgKYZ7
	RDsqlCmxXcJsO45vFsxhg3hJMgfZ7NI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <xqazmch5ybt7fatipwkuk7lnouwwdn55cirvaiuypjmy3y4fte@6vwyvv3uurl5>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
 <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 04, 2024 at 10:18:22AM +0100, Christian Brauner wrote:
> On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> > Add a new statx field for (sub)volume identifiers.
> > 
> > This includes bcachefs support; we'll definitely want btrfs support as
> > well.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > ---
> 
> As I've said many times before I'm supportive of this and would pick up
> a patch like this. There's definitely a lot of userspace that would make
> use of this that I'm aware of. If the btrfs people could provide an Ack
> on this to express their support here that would be great.
> 
> And it would be lovely if we could expand the commit message a bit and
> do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
> then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
> subvol_id for the field in struct kstat.

_id is too redundant for me, can we just do STATX_SUBVOL/statx.subvol?

