Return-Path: <linux-kernel+bounces-67771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BA85706C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404861F291EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468B145354;
	Thu, 15 Feb 2024 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xfQ9X2XK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25771419A1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035467; cv=none; b=pv3qcmhP5RctOrQLFqdgehgnVeDhm8QsgdIs/esX5zKObt7M/SXqhJEJym7Y/Td1HIziYcHgqNEpQpV25131LdC0MoS5clZZt7a1H0C2zH9KKmYTxgOCGsOiyTEg8pyW1rX50a76xTbibhdQmK77jUBBSj27MvkGmq2D2cHb2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035467; c=relaxed/simple;
	bh=BQqDidOkOg8KsFEst22N7rF6XggxOYOcJqHQu+R7DRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQTLD4/fVxutGbcFVDHNQZCUywjAl/a/ATQTqAD1UGfQbTY8dOFKsntEcTiJivbznJfl4Ihv5qSqMzepdFfxkyEYseRt7A1IY2/urisidHnSg/u7P1wD+wdOCnO2Xek+kiNmQPhana1QJ5U69e1x7HDapdSsPInyhKv6blApbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xfQ9X2XK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1182873b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708035465; x=1708640265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqLyuCsW475xlDjq9rWu9xXNC03QbYPQjapLSP5f0Io=;
        b=xfQ9X2XKs9MrO/SLlwLJ27onS3/+9RMeqVmviiSCcbXryhsWH9Hjte0MemFBKbakLK
         qwskVAKZn/SNqqPfCvG3Gb2SWrhAK5LHmWor7pnmpyrkm5k5rkr0+LU7Lao0XWYhJlqz
         OHvJRqOJpPwsruRRizGbnD5zRUqCqycAMPmRGrRV06jyDYDBd/fj46zpWOpvtp1Pg5UV
         r4vscWUqp0pnZAJ2G0mFoDbMXmBSxulUXO1OgQLUYTs+CKkysfRNlJAQo791E8eE/rxk
         lgXej9PZjxhhX+cScHHmUcJn/Fi2c5Am7ydf5KAhsEbgqsMP8vDIZ+uArbKoMhTSH80P
         1spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035465; x=1708640265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqLyuCsW475xlDjq9rWu9xXNC03QbYPQjapLSP5f0Io=;
        b=NdjkkRcqcF6IgEB7f5gEbB6JGK0eFnAaODwnF+CX0UQmVt9j89RjEvSvQ+qmbfIB09
         RcR5Y/jAWJNVlVntWMDFdDdyKKOjGGQj1HG/jwK5BSSI2eIhyEmGNYueoU8t6LjQH1l9
         QaDAKTTYlIordccNlVpITVVmbmxjoeDcIsaTGvJi0TK6U/0/mzLtc9SWCBcII6994rZ5
         MjVyWRqPZ9Yw1tTPLDiGTPXB++DlEuSY1uAc5AZ6te7rzXojbpSjXVBSjaxBqPirM7nI
         YFGfMSdc18Eg0M58KbLX1ND+33Gq/H5595KxTO9tNa8QIcVkDGAIo88CqCDkdODguTit
         edgA==
X-Forwarded-Encrypted: i=1; AJvYcCUbth5+P55O+Ma9FopBywAv7IUaLl2iLfhO0kj9rLBotyj3AC8xADfMcLeHnepbOQBBT35KZ2/0lFd/754hGyiJA/WeWm4ExfCANSZt
X-Gm-Message-State: AOJu0YwJ7zX2vUL2qHqgu6ofX64z2I5XPjglR6G8RUS+B64EWNtZE40X
	MhUu61R8S1yh4lzLKk13pxWWO8l8+MG4B7rzL+GBAhzc3b7o6spN5Qlw9fFZ+rk=
X-Google-Smtp-Source: AGHT+IF10IvncuJisp6y8CXRYam75Te24+bLDVMAcYz6fel6DiwBkZwF0/fv9w3QDOMhFdZye4KjRg==
X-Received: by 2002:a05:6a20:d043:b0:199:7628:286d with SMTP id hv3-20020a056a20d04300b001997628286dmr7498930pzb.30.1708035465181;
        Thu, 15 Feb 2024 14:17:45 -0800 (PST)
Received: from dread.disaster.area (pa49-195-8-86.pa.nsw.optusnet.com.au. [49.195.8.86])
        by smtp.gmail.com with ESMTPSA id m22-20020a637116000000b005dc4fc80b21sm1905442pgc.70.2024.02.15.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:17:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rak33-0071FQ-33;
	Fri, 16 Feb 2024 09:17:41 +1100
Date: Fri, 16 Feb 2024 09:17:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 14/14] xfs: enable block size larger than page size
 support
Message-ID: <Zc6NhXas68+5k84v@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-15-kernel@pankajraghav.com>
 <ZcvgSSbIqm4N6TVJ@dread.disaster.area>
 <n45xfink7g4fhdrnp4i7tp6tsebvncxicbe4hooswtwwydlakd@4zviowhp53rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n45xfink7g4fhdrnp4i7tp6tsebvncxicbe4hooswtwwydlakd@4zviowhp53rs>

On Wed, Feb 14, 2024 at 05:35:49PM +0100, Pankaj Raghav (Samsung) wrote:
> > >  	struct xfs_inode	*ip;
> > > +	int			min_order = 0;
> > >  
> > >  	/*
> > >  	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
> > > @@ -88,7 +89,8 @@ xfs_inode_alloc(
> > >  	/* VFS doesn't initialise i_mode or i_state! */
> > >  	VFS_I(ip)->i_mode = 0;
> > >  	VFS_I(ip)->i_state = 0;
> > > -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > > +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> > > +	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
> > 
> > That's pretty nasty. You're using max() to hide underflow in the
> > subtraction to clamp the value to zero. And you don't need ilog2()
> > because we have the log of the block size in the superblock already.
> > 
> > 	int			min_order = 0;
> > 	.....
> > 	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > 		min_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> how is it underflowing if I am comparing two values of type int?

Folio order is supposed to be unsigned. Negative orders are not
valid values.  So you're hacking around an unsigned underflow by
using signed ints, then hiding the fact that unsigned subtraction
would underflow check behind a max(0, underflowing calc) construct
that works only because you're using signed ints rather than
unsigned ints for the order.

It also implicitly relies on the max_order being zero at that point
in time, so if we change the value of max order in future before
this check, this check may not fuction correctly in future.

Please: use unsigned ints for order, and explicitly write the
code so it doesn't ever need negative values that could underflow.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

