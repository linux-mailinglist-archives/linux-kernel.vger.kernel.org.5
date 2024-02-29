Return-Path: <linux-kernel+bounces-87578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627A86D61C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C7F1C2335C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68916FF58;
	Thu, 29 Feb 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dEe/F6Cp"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283216FF2B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241883; cv=none; b=fh16QwIst4nOVOXhFx74GgQS/P5MrZhSxmKO72RCAa/lqhaE0y1IMSyDXtN9F7J42i/AxAGATR4ur8Gghbvxni2aOAsfft2jp22trRnIrJqgw9xDsdHjiC4f02pPzUR7D1cZ5xIsDfO8ArWLrCbKj5ok6OtGq3sDe/mN0pABz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241883; c=relaxed/simple;
	bh=Jv57XkdEOb5lCcmwhvsrgcTRHKKlbAL+X8QUWiBeHm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYuJAtzEg4ki3TsVpn8omXffvkfPmapT542ScIU7ltcipjedUe42PxPOFyRsl0T86Fryc1E+h4hmZadH2ZKam1iq4E1npozjTilnc55DWYSxZ2q4u6XhkyO5urniQkzl8RwrtGfC26IILxqx5Y0gdIR7vJ/d8+mJo2EeXqM07Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dEe/F6Cp; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 16:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709241879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv57XkdEOb5lCcmwhvsrgcTRHKKlbAL+X8QUWiBeHm0=;
	b=dEe/F6Cpa/brZBrjcWn/DWZZekUEpH/qX6WBbE+JZND6SmPso1PcIBIYezVUQHo+OrQ4Gq
	sebiBHtZe5Yqj6NE+8c1QgumE18RpWc/el5cK0/UWnrIyn6BnEcz55686sgS0N7myIErKs
	Kjcz/Ieltatda8+p5hHhM8AXrTgVtt8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Message-ID: <r2ieuj2kvitrrg7sqhuossm3wn4zzlkhygfqx7bxorzbaylnw2@kpgfn4e42iuw>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-2-kent.overstreet@linux.dev>
 <Zd4Ef49kHX3g69VT@bfoster>
 <t6cc6gqgla2csyvrsv2znel5lg76vx7t2zna772qpw7zd6pnft@rxdakxza5cab>
 <ZeDQQ8cyMTgYaY6D@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDQQ8cyMTgYaY6D@bfoster>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 01:43:15PM -0500, Brian Foster wrote:
> Hmm.. I think the connection I missed on first look is basically
> disk_accounting_key_to_bpos(). I think what is confusing is that calling
> this a key makes me think of bkey, which I understand to contain a bpos,
> so then overlaying it with a bpos didn't really make a lot of sense to
> me conceptually.
>
> So when I look at disk_accounting_key_to_bpos(), I see we are actually
> using the bpos _pad field, and this structure basically _is_ the bpos
> for a disk accounting btree bkey. So that kind of makes me wonder why
> this isn't called something like disk_accounting_pos instead of _key,
> but maybe that is wrong for other reasons.

hmm, I didn't consider calling it disk_accounting_pos. I'll let that
roll around in my brain.

'key' is more standard terminology to me outside bcachefs, but 'pos'
does make more sense within bcachefs.

> Either way, what I'm trying to get at is that I think this documentation
> would be better if it explained conceptually how disk_accounting_key
> relates to bkey/bpos, and why it exists separately from bkey vs. other
> key types, rather than (or at least before) getting into the lower level
> side effects of a union with bpos.

Well, that gets into some fun territory - ideally bpos would not be a
fixed thing that every btree was forced to use, we'd be able to define
different types per btree.

And we're actually going to need to be able to do that in order to do
configurationless autotiering - i.e. tracking how hot/cold data is on an
inode:offset basis, because LRU btree backreferences need to go in the
key (bpos), not the value, in order to avoid collisions, and bpos isn't
big enough for that.

disk_accounting_(key|pos) is an even trickier situation, because of
endianness issues. The trick we do with bpos of defining the field order
differently based on endianness so that byte order matches word order -
that really wouldn't work here, so there is at present no practical way
that I know of to avoid the byte swabbing when going back and forth
between bpos and disk_accounting_pos on big endian.

But gcc does have an attribute now that lets you specify that an integer
struct member is big or little endian... I if we could get them to go
one step further and give us an attribute to control whether members are
laid out in ascending or descending order...

