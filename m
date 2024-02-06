Return-Path: <linux-kernel+bounces-55632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E091F84BF48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97185289271
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6E1BC26;
	Tue,  6 Feb 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="m7ahRL1P"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662571B951
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255365; cv=none; b=VXSNdZVhUBNInvutSJBZh6Ubyj4N7NHh/v89gEoG4+2rpj3iiwoUL2y2kMPxYdglrdkLLQhZqXE7WwkrkyjB4TZI5xzSdrObLQ3AZRI+UP5jx3rVTVkmFqX/JpowV/xpY08YhFS1KoKwRQvThuWWvSONRp2kCI2TAtF+yWnatB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255365; c=relaxed/simple;
	bh=9foNO30lxIQVAOir/tTEY/aEn93LIXwsZ3ylGlnEScs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUYUd/DnNJpKPveqVspJUZpxgWzPDHyoMwg0nDC6mhnMhA41ww2bdIFrVgykRaQATcDJMtJ8ljsY5YKBjH96WRAWthhh/6QuJGUbZSZ23xglQHTZ2JZsoq5pumPmCwdJpUCEN6oNDRwdEvoBJnn/LiWp/D9HBLjpJ+C54P1VdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=m7ahRL1P; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc36e501e1so4256831a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707255362; x=1707860162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d1cAEA/en06DDamBuUyyFIq84mWg/nOkAan40QbBho=;
        b=m7ahRL1PZmtWmjnkHDZ6JXnr+LLr8VUoyoCwruPVv+OtQQMtNyq59Tk6SYktsgUgaO
         GMO0Stc/KJQGREHW3pwZZ8Zp63otdKHua8oxKNvb3FHg5B29eM5Y9KbFf4YyUePnkcq5
         txd/bktzXEAJfsAv40f9Dg7xewyvkozJfD9JbHiGWdhiujCfWxkoYaTzEEJw/udCiJ33
         giqnWWUHZWE6/aJttvMaY39NrEor+33QDYBS3gIvunwpYOaZQdNyZf3f3PrIQdn2lWyK
         YIl1k8x5xTfZFcPzO1CVqS3fH2Fh1Nl7iQfqE29tt/30/xPSFy0LsCOerE5E57yJMZ7Z
         9BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255362; x=1707860162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d1cAEA/en06DDamBuUyyFIq84mWg/nOkAan40QbBho=;
        b=Jc+xOVPBTLE79ObIbWfAKdnL/qEH/8AOh78Bzmv046asVE3/FWE9T7VrfbVa3efMSE
         GdAzyCs37K8P5uA81nYwRqiiZfZ8gZxzVEYzfKGYVJD/O0w6m3hYjgwUnB5emm4npOh2
         Qa4VolUWhGnalj2M7pg6lSIRe1OoX0RgSbgEtUvA6pJuHEwDonBPdgiveERL5a7baA5L
         HkmSYuRPBDKscH6V4yW8dDCq7pucZ44T25gXoiJ+BS+PW10uVmQKv3BE8gHVBr3VPeL+
         NeC7Jqg3DMzahm1b4SIvsHE0f5s/nSk8LK/tecntRhQmEi6zCeZlCgrBYIRBorYYbE3y
         X0CQ==
X-Gm-Message-State: AOJu0YxHqctnr67mvVxp4EIeOl5rx436DUjukz6X56jtWa33DKMLT+ut
	/wcl08B2dsUzjfyi0s/2JlBkOJcA5oSXpRt6VCkOjiXDAFiiHc3afug9iTwp+88=
X-Google-Smtp-Source: AGHT+IFwsBNz+g6T1MZLKpa+VqxDK828GdyrSsAoosVSfnms+toVCidvBvT29MWYbSG0wcnmvFn0zg==
X-Received: by 2002:a05:6358:290b:b0:178:8a06:68e2 with SMTP id y11-20020a056358290b00b001788a0668e2mr1015222rwb.29.1707255362196;
        Tue, 06 Feb 2024 13:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmUXmwHnwnbzNPnNXZb1YHfuTu3hdGBmd0iQj51Kcy6b7WfSAkwWFN05eZW66xLCBO1KGiN5gZH5phqkOY649nvKrAR5NTwe7m2VyLlufm9Hq2HMTG6Cp1Sv5rLVHAMX++f3KlLZsZ91DSrFxaNAxtXrKDTXWOHJJCa8/kVlf/0mDEd1Mv7i42RKbGNuHs4QONnbYv91Q4oINDbIGT4rs16z5xDLglin56tSqGlLydrLfwEbQQPtiJOyQ/f/ItNDKEk+Od90KdUkbGeSv9ry3k7nm+7ucRyAU8LsYKmOrF+aLzXw1iK7x0
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id 33-20020a630b21000000b005c662e103a1sm2748504pgl.41.2024.02.06.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:36:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXT6l-002zy6-0j;
	Wed, 07 Feb 2024 08:35:59 +1100
Date: Wed, 7 Feb 2024 08:35:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcKmP3zVdBwJVxGd@dread.disaster.area>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
 <Zb0EV8rTpfJVNAJA@casper.infradead.org>
 <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <ZcBUat4yjByQC7zg@dread.disaster.area>
 <ZcFvHfYGH7EwGBRK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcFvHfYGH7EwGBRK@casper.infradead.org>

On Mon, Feb 05, 2024 at 11:28:29PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 05, 2024 at 02:22:18PM +1100, Dave Chinner wrote:
> > Intuition tells me that what the OP is seeing is the opposite case
> > to above: there is significant contention on the lock. In that case,
> > optimal "contention performance" comes from separating the lock and
> > the objects it protects into different cachelines.
> > 
> > The reason for this is that if the lock and objects it protects are
> > on the same cacheline, lock contention affects both the lock and the
> > objects being manipulated inside the critical section. i.e. attempts
> > to grab the lock pull the cacheline away from the CPU that holds the
> > lock, and then accesses to the object that are protected by the lock
> > then have to pull the cacheline back.
> > 
> > i.e. the cost of the extra memory fetch from an uncontended
> > cacheline is less than the cost of having to repeatedly fetch the
> > memory inside a critical section on a contended cacheline.
> > 
> > I consider optimisation attempts like this the canary in the mine:
> > it won't be long before these or similar workloads report
> > catastrophic lock contention on the lock in question.  Moving items
> > in the structure is equivalent to re-arranging the deck chairs
> > whilst the ship sinks - we might keep our heads above water a
> > little longer, but the ship is still sinking and we're still going
> > to have to fix the leak sooner rather than later...
> 
> So the fundamental problem is our data structure.  It's actually two
> problems wrapped up in one bad idea.
> 
> i_mmap is a struct rb_root_cached:
> 
> struct rb_root_cached {
>         struct rb_root rb_root;
>         struct rb_node *rb_leftmost;
> };
> 
> struct rb_root {
>         struct rb_node *rb_node;
> };
> 
> so it's two pointers into the tree; one to the leftmost node, one
> to the topmost node.  That means we're modifying one or both of these
> pointers frequently.  I imagine it's the rb_root, which is being modified
> frequently because we're always ... appending to the right?  And so
> we're rotating frequently.  Worst case would be if we're appending to
> the left and modifying both pointers.
> 
> There are things we could do to address this by making rotations less
> frequent for the common case, which I suspect is mapping the entire file.
> And perhaps we should do these things as a stopgap.
> 
> The larger problem is that rbtrees suck.  They suck the same way that
> linked lists suck; the CPU can't prefetch very far ahead (or in this
> case down).  It can do a little more work in that it can prefetch both
> the left & right pointers, but it can't fetch the grandchildren until the
> children fetches have finished, so the dependent reads have us stumped.

Yes, pretty much all balanced binary search trees have this problem.
I pointed out this problem with rbtrees many years ago when someone
tried to implement range locks with an rbtree to track locked
ranges. On modern CPUs, trees with array based nodes (btrees, the
linux radix tree, etc) are far more efficient. But....

> The solution to this problem is to change the interval tree data structure
> from an Red-Black tree to a B-tree, or something similar where we use
> an array of pointers instead of a single pointer.

... B-trees are not immune to pointer chasing problems, either.
Most use binary searches within the nodes, and so we have the
problem of unpredictable cacheline misses within the nodes as well
as being unable to do depth based prefetch similar to rbtrees.

Perhaps we should be looking at something like this:

https://lore.kernel.org/linux-fsdevel/20240126220655.395093-2-kent.overstreet@linux.dev/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

