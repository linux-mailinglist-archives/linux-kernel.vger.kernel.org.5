Return-Path: <linux-kernel+bounces-165003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F758B8655
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184DF281FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECD4D9FB;
	Wed,  1 May 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1Xm9ELc7"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BBB4D9FC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549672; cv=none; b=oEYu6+j1B1pNTu81XNKSpqFTuSygEaptLlIncuYwJWB83jRRMI1PUziyA+DlZCkyCcX9J8tlBjUPYFlOQFZEFGMuv0HDBRko+r0izBa65fiOSLSMAMStFXc9x1C5xXqqrHnynNBm9SHQOOT5/npksU5gm0dqcodMBfKZPzdcQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549672; c=relaxed/simple;
	bh=LbOF6ESQyMI+cFhXNr1YLTujNXRcUHACJcCpS+EKEWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI+YncqTsMs6t1DHyLHSfiaoPLaAGoYdC/D0gew31bMaq08D69r8dF173zozqdL03Zbo/CUuiYXJHoIZkb1Ssgh4dR2/phJs9/lIxG436KTBEbrOjJKzHs2Am2cfYo3XgOboE/djdkEI1nP0uTz6cuT0dD9pxgEJ1y6H6qicA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1Xm9ELc7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4540809a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714549670; x=1715154470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxRd2H6e8mYNr1gSX+l0MwjfKp9IszVuWaKXuYO1IHo=;
        b=1Xm9ELc7U/34BHjCnH9pkh4iYjARpv5hmdXHFFyJ6E20fXLkXw6lftd+6p9gcz5lnU
         8r6ZwWbzjVkVfXjge1y7EEXA9FP6gpwE5EUNsxC0NU4EvzGMtQnZdYl/LD8kvE+bBSeR
         jaf4Ow5Pp2LQ6xK/sf8QQsBO83QDfEIe5hrCNIMzQOZehJ05YVhQzMM1GagrcV/qxjeQ
         1n7qhiBtWKOy8cpwPtATdjR3r7G7Ew5UIi0iz7+fomoWCzqdFGjuw/f3UhiY7nmlKGUV
         JaYvA7bP7Ky8BGb+YIU1MQug0yJDx8BfeogwdAG6wZR4qKNHfmUdv/ZmKzX/9elgIPxy
         nrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549670; x=1715154470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxRd2H6e8mYNr1gSX+l0MwjfKp9IszVuWaKXuYO1IHo=;
        b=QGpH2qSKqTXMBdHF6DnUiJecoaBtWLQ1lQbLK1uFSU+HEJ2jN5IgnIipMTBXix7a9K
         1wLuHFRu7MwnFcZm0eUDjtkTLLfEE6ur/NPNxWfva+r65iy06o2QQcN7T6HDyGsuPgrs
         bHjODRtzbddKF1/ZJWnWGuNNeseP7WEOz5sOBM4e8DR34iLx03DsYA86VoOgGNiPdOom
         mRITFw9rtW1rR+KVChFHtbumXKrB7KOa+OYF6Kzouy9U6fb6qa9RIVPLXoFpvzAX6LOh
         aT3tQe5tvgw7lc2BtnndIRnPjzEVBKGmNqrDFqqyEuU8AqUidhgDg4fpnqabYpfIazx2
         nj7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXezKDjILf9XbZKxtD1jBvjZuSiIH+2bwv1FQn7qgvQWlq7M2mPAvYtjgz/TFf5XYo1+ESMMiv9D3yAPeLRh9U0ITXDBwtZ4U3HQ/nA
X-Gm-Message-State: AOJu0YyzNaxrDdF3jH6ME6LVHKeil4acg+FquFQP+SJ12xvpxLp901M2
	qYbE7eUEnMv0ybmM629XsVh36kyoARMPXcC2cLuBcyXmmoR6BKXvlhIcIse1uxM=
X-Google-Smtp-Source: AGHT+IHRHk+cbO0Uc//LojouzmzN7miUZLtGzemQFCemIXFiIyRsCHU84FSFC0a0Vh8aVGvtLAQz+g==
X-Received: by 2002:a05:6a21:6d93:b0:1af:4c43:6ec9 with SMTP id wl19-20020a056a216d9300b001af4c436ec9mr2482794pzb.34.1714549670185;
        Wed, 01 May 2024 00:47:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b001eb30118300sm8446852pla.132.2024.05.01.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:47:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s24gt-00H82c-0F;
	Wed, 01 May 2024 17:47:47 +1000
Date: Wed, 1 May 2024 17:47:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org,
	djwong@kernel.org, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
Message-ID: <ZjHzo5y0Tz+oWMbF@dread.disaster.area>
References: <185a0d75-558e-a1ae-9415-c3eed4def60f@huaweicloud.com>
 <87cyqcyt6t.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyqcyt6t.fsf@gmail.com>

On Fri, Apr 26, 2024 at 10:09:22PM +0530, Ritesh Harjani wrote:
> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> 
> > On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
> >> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> >> 
> >>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> >>>
> >>>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>>
> >>>> Now we lookup extent status entry without holding the i_data_sem before
> >>>> inserting delalloc block, it works fine in buffered write path and
> >>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
> >>>> lock, so the found extent locklessly couldn't be modified concurrently.
> >>>> But it could be raced by fallocate since it allocate block whitout
> >>>> holding i_rwsem and folio lock.
> >>>>
> >>>> ext4_page_mkwrite()             ext4_fallocate()
> >>>>  block_page_mkwrite()
> >>>>   ext4_da_map_blocks()
> >>>>    //find hole in extent status tree
> >>>>                                  ext4_alloc_file_blocks()
> >>>>                                   ext4_map_blocks()
> >>>>                                    //allocate block and unwritten extent
> >>>>    ext4_insert_delayed_block()
> >>>>     ext4_da_reserve_space()
> >>>>      //reserve one more block
> >>>>     ext4_es_insert_delayed_block()
> >>>>      //drop unwritten extent and add delayed extent by mistake
> >>>>
> >>>> Then, the delalloc extent is wrong until writeback, the one more
> >>>> reserved block can't be release any more and trigger below warning:
> >>>>
> >>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
> >>>>
> >>>> Hold i_data_sem in write mode directly can fix the problem, but it's
> >>>> expansive, we should keep the lockless check and check the extent again
> >>>> once we need to add an new delalloc block.
> >>>
> >>> Hi Zhang, 
> >>>
> >>> It's a nice finding. I was wondering if this was caught in any of the
> >>> xfstests?
> >>>
> >
> > Hi, Ritesh
> >
> > I caught this issue when I tested my iomap series in generic/344 and
> > generic/346. It's easy to reproduce because the iomap's buffered write path
> > doesn't hold folio lock while inserting delalloc blocks, so it could be raced
> > by the mmap page fault path. But the buffer_head's buffered write path can't
> > trigger this problem,
> 
> ya right! That's the difference between how ->map_blocks() is called
> between buffer_head v/s iomap path. In iomap the ->map_blocks() call
> happens first to map a large extent and then it iterate over all the
> locked folios covering the mapped extent for doing writes.

Yes - a fundamental property of the iomap is that it is cached
filesystem state that isn't protected by locks in any way. It can
become stale if a concurrent operation modifies the extent map whilst
the write operation is progressing.

Have a look at iomap_begin_write(). Specifically:

	/*
	 * Now we have a locked folio, before we do anything with it we need to
	 * check that the iomap we have cached is not stale. The inode extent
	 * mapping can change due to concurrent IO in flight (e.g.
	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
	 * reclaimed a previously partially written page at this index after IO
	 * completion before this write reaches this file offset) and hence we
	 * could do the wrong thing here (zero a page range incorrectly or fail
	 * to zero) and corrupt data.
	 */
	if (folio_ops && folio_ops->iomap_valid) {
		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
							 &iter->iomap);
		if (!iomap_valid) {
			iter->iomap.flags |= IOMAP_F_STALE;
			status = 0;
			goto out_unlock;
		}
	}

Yup, there's the hook to detect stale cached iomaps.  The struct
iomap has a iomap->validity_cookie in it, which is an opaque cookie
set by the filesytem when it creates the iomap. Here we have locked
the folio so guaranteed exclusive access to this file range, and so
we pass the iomap with it's cookie back to the filesystem to
determine if the iomap is still valid.

XFS uses generation numbers in the extent tree to determine if the
cached iomap is still valid. ANy change to the extent tree bumps the
generation number, and the current generation number is placed in
iomap->validity_cookie when the iomap is created. If the generation
number on the inode extent tree is different to the number held in
the validity_cookie, then the extent tree has changed and the iomap
must be considered stale. The iomap iterator then sees IOMAP_F_STALE
and generates a new iomap for the remaining range of the write
operation.

Writeback has the same issue - the iomap_writepage_ctx caches the
iomap we obtained for the current writeback, and so if something
else changes the extent state while writeback is underway, then that
map is stale and needs to be refetched.

XFS does this by wrapping the iomap_writepage_ctx with a
xfs_writepage_ctx that holds generation numbers so that when
writeback calls iomap_writeback_ops->map_blocks(), it can check that
the cached iomap is still valid, same as we do in
iomap_begin_write().

> Whereas in buffer_head while iterating, we first instantiate/lock the
> folio and then call ->map_blocks() to map an extent for the given folio.
> 
> ... So this opens up this window for a race between iomap buffered write
> path v/s page mkwrite path for inserting delalloc blocks entries.

iomap allows them to to race - the filesystem extent tree needs it's
own internal locking to serialise lookups and modifications of the
extent tree, whilst the data modifications and page cache state
changes are serialised by the folio lock. That's why
iomap_begin_write() checks that the iomap is still valid only after
it has a locked folio it is ready to write data into.

Remeber that delalloc extents need to be inserted into the
filesystem internal tree when ->iomap_begin() creates them. Hence
anything that races to write over that same range range will only
create the delalloc extent once - the second operation will
simply find the existing delalloc extent the first operation
created...

> > the race between buffered write path and fallocate path
> > was discovered while I was analyzing the code, so I'm not sure if it could
> > be caught by xfstests now, at least I haven't noticed this problem so far.
> >
> 
> Did you mean the race between page fault path and fallocate path here?
> Because buffered write path and fallocate path should not have any race
> since both takes the inode_lock. I guess you meant page fault path and
> fallocate path for which you wrote this patch too :)
> 
> I am surprised, why we cannot see the this race between page mkwrite and
> fallocate in fstests for inserting da entries to extent status cache.

Finding workloads that hit these sorts of races reliably
is -real hard-. Read the commit message in commit d7b64041164c
("iomap: write iomap validity checks"), especially this link:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

And this comment I made in a followup email:

" [....] and it points out that every filesystem using iomap for
multi-page extent maps will need to implement iomap invalidation
detection in some way."

> Because the race you identified looks like a legitimate race and is
> mostly happening since ext4_da_map_blocks() was not doing the right
> thing.
> ... looking at the src/holetest, it doesn't really excercise this path.
> So maybe we can writing such fstest to trigger this race.

We have a regression test that exercises folio_ops->iomap_valid()
functionality: xfs/559.  It uses the XFS error injection
infrastructure to add a strategic delay which we placed in
xfs_iomap_valid() so that we can hold an iomap cached for an
arbitrary period of time to allow writeback and page cache reclaim
to do their stuff to cause the extent map held by the write to
become stale. It also uses ftrace to capture the tracepoint that
tells us that the invalid iomap state was seen and IOMAP_F_STALE
behaviour triggered.

This could be turned into a generic test, but there's a lot of
missing infrastructure bits to do it....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

