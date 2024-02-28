Return-Path: <linux-kernel+bounces-85630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DE86B871
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6781F21BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B86FD05;
	Wed, 28 Feb 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwteKCrm"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFF6FCFC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149185; cv=none; b=SaDO+jQr/dtqkl/FQUK28FZoFhQCLtR04pYlF4e+ll1uM73OnRKefjCtpXKyqJiP0wvv/A82fSKMvdcZIWLJgvtVQXymvH12gZ9ksGkw2tg0+2tT5nabdfg1MdhLX2wpVJLLhgeDH1Mcpc8dIdhF/EFS9j5D1wkX3tVT6n6Tj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149185; c=relaxed/simple;
	bh=K6BFDpHPwpmKaTZ0wDrBzeFVCZ2JiaeGyq0H8B2Yl3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCrtAoSsqUTDHlLPJQF1jLX920ECwP9i0z/ptypRY7Q/PFig6jwzhQHFwTi2wpzxH1m/le/ec63zcNM+vNeuPfSEO70dlzO0aFJnZUT4Tguuz29wX75+BAND9yKM31ItNbQMS6dHkR9U6i8seh1p0glU2GCFad1n219Q5t9uVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwteKCrm; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 14:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709149181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxjyznzsUQpuSnVHC/hJK3IlSwcsWUORbF0nzzW2cZA=;
	b=CwteKCrmj5APkGH5f4E4W4Lqat6v4lYSpC15zG9mOOlbEEvVeXbTRKJmt7zESTRiDBcGEy
	nA8Rp6Gp/kkr8RQOODcjmspH6JAkhatBzHRXuiFEnkui5m3m/8hp3MgX5mTBcHoC4jmi4p
	syp+45pcMlmc8zCU0bZY//h/oA71N78=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Message-ID: <t6cc6gqgla2csyvrsv2znel5lg76vx7t2zna772qpw7zd6pnft@rxdakxza5cab>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-2-kent.overstreet@linux.dev>
 <Zd4Ef49kHX3g69VT@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4Ef49kHX3g69VT@bfoster>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 10:49:19AM -0500, Brian Foster wrote:
> On Sat, Feb 24, 2024 at 09:38:03PM -0500, Kent Overstreet wrote:
> > New key type for the disk space accounting rewrite.
> > 
> >  - Holds a variable sized array of u64s (may be more than one for
> >    accounting e.g. compressed and uncompressed size, or buckets and
> >    sectors for a given data type)
> > 
> >  - Updates are deltas, not new versions of the key: this means updates
> >    to accounting can happen via the btree write buffer, which we'll be
> >    teaching to accumulate deltas.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  fs/bcachefs/Makefile                 |   3 +-
> >  fs/bcachefs/bcachefs.h               |   1 +
> >  fs/bcachefs/bcachefs_format.h        |  80 +++------------
> >  fs/bcachefs/bkey_methods.c           |   1 +
> >  fs/bcachefs/disk_accounting.c        |  70 ++++++++++++++
> >  fs/bcachefs/disk_accounting.h        |  52 ++++++++++
> >  fs/bcachefs/disk_accounting_format.h | 139 +++++++++++++++++++++++++++
> >  fs/bcachefs/replicas_format.h        |  21 ++++
> >  fs/bcachefs/sb-downgrade.c           |  12 ++-
> >  fs/bcachefs/sb-errors_types.h        |   3 +-
> >  10 files changed, 311 insertions(+), 71 deletions(-)
> >  create mode 100644 fs/bcachefs/disk_accounting.c
> >  create mode 100644 fs/bcachefs/disk_accounting.h
> >  create mode 100644 fs/bcachefs/disk_accounting_format.h
> >  create mode 100644 fs/bcachefs/replicas_format.h
> > 
> ...
> > diff --git a/fs/bcachefs/disk_accounting_format.h b/fs/bcachefs/disk_accounting_format.h
> > new file mode 100644
> > index 000000000000..e06a42f0d578
> > --- /dev/null
> > +++ b/fs/bcachefs/disk_accounting_format.h
> > @@ -0,0 +1,139 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> > +#define _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
> > +
> > +#include "replicas_format.h"
> > +
> > +/*
> > + * Disk accounting - KEY_TYPE_accounting - on disk format:
> > + *
> > + * Here, the key has considerably more structure than a typical key (bpos); an
> > + * accounting key is 'struct disk_accounting_key', which is a union of bpos.
> > + *
> 
> First impression.. I'm a little confused why the key type is a union of
> bpos. I'm possibly missing something fundamental/obvious, but could you
> elaborate more on why that is here?

How's this?

 * More specifically: a key is just a muliword integer (where word endianness   
 * matches native byte order), so we're treating bpos as an opaque 20 byte                                                                                       
 * integer and mapping bch_accounting_key to that.

