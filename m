Return-Path: <linux-kernel+bounces-36183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C396F839D28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B9E1F2912B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03454BE3;
	Tue, 23 Jan 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RvX4HvfC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFF53E17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052113; cv=none; b=CDediXp+Hx5qt4qJYVHjt6km3S0t/opfHFdV6vB/ieej8ohiIWl8Y3Aqk1NWCAWXdKHLIxzdvlhsVVEUjw6DoZfLOXHBPaF6JXWQKpf3MmS1k0VOFwD3tEMbtr9Z+CHRuRcLT1HVvSUphhkdcJ+g3JJyjuuKiX7tKnzNGC179vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052113; c=relaxed/simple;
	bh=ZR7sfWUwnT5BjG/tPD79vE4fth31migQSpuAcSwowUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+9pVnhHCyzFGPavGYi0d6GVcjrbhWCiCkYoXr6/XbbhTxt0+GWyuiX4dHJ6ZHYHntGPUwbOlYyb9toOGsTgyqmjy3aZ16M3DfhkTAlBAEgwwTu/M2P+dS0ynUHgie65lS3Pate3XJiW1fmK0SBnBnfJKaQnOdi86fJjS4ilWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RvX4HvfC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71e184695so19441265ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706052111; x=1706656911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyNE0YBQ61XvxQg0qzcUw/mj3pyKM5V+H7U9PFr3Dnc=;
        b=RvX4HvfCp9MumJ6K8hIZzKFqBmgWHy/Y6u1vIUhjUQtIO4WFvjpCcqE70cg9PTfjRU
         +gDCUwKH4q0tfBIS0xfLoBJ1oaO5rJFYohmjq2yfeAKb8gQSJqyHKp44xaQeRPdQS5XI
         fDZcdggS8uPRwLROIRGfDdxD/56XoKevdcwY6M3M3FLudZgNoy6HsBhV4f2FMDeblEsL
         azKvCt06cZXAxAVsFCC6vJWC9/AvSgwn6Dzx+NkAbMyg9LsjT2K4Uf6JwkuG00v2geI8
         Yt9qz2qHhvckMjKyDxEIBSZ3kbhkOb9M5H0N+UYQG6SHzoYr+4GlCEbngYI/xIUF0JRZ
         Da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052111; x=1706656911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyNE0YBQ61XvxQg0qzcUw/mj3pyKM5V+H7U9PFr3Dnc=;
        b=kDtbTiQpwCv4+oDty8/nT4baFEzBiUNJlc8ZfPs6qX9tveIrT9Nz27RtTTD9fOp56H
         r9NbBDicamRNdqweoG7q2hjrPjUQK68Jyn7FGRPt/OG1mdL0TnZENT1bIbFdB75sRmEz
         qJ6pWzZhgINqM6V/XMot9Kw0Mh1jK/+yMT0R6mM1aBVOrs34lyonDHFCl5iAs4QBL62y
         ktPVANzhnlJUFXBEoBQARENrwwulD4BfD8m/AwvpJDYb2hCZKruaxeNG9yaWHAYsSxyA
         V9TKLeTFxnXI3wlJcoTKTrpCBi0UiwdN/juFH1vOZy5mgo1MPGDeY/+YOy3zAcLj5GF/
         wxzg==
X-Gm-Message-State: AOJu0YyEavUF/IK3Zsng1KX0ArPHDrfQXc6S42cXylx5H+QVPKNeqSKJ
	LZw+29LQzSPkzPi791CESQY7W7g6x+j4DAuNG3dc/W3tuYoA/IiG0MHjWQsYjLg=
X-Google-Smtp-Source: AGHT+IGeQm//kQ1jNNCFdA/q04f/cj+3wXvZbTLBGBCW2U08K7o/GP2/AW3XgLOokmhWoQbjbV2FZg==
X-Received: by 2002:a17:902:d202:b0:1d7:1e5d:ab39 with SMTP id t2-20020a170902d20200b001d71e5dab39mr3908243ply.80.1706052110812;
        Tue, 23 Jan 2024 15:21:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8165932plz.176.2024.01.23.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:21:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rSQ5T-00EPce-2c;
	Wed, 24 Jan 2024 10:21:47 +1100
Date: Wed, 24 Jan 2024 10:21:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Message-ID: <ZbBKC3U3/1yPvWDR@dread.disaster.area>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
 <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>

On Tue, Jan 23, 2024 at 09:39:02PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 23 Jan 2024, Johannes Thumshirn wrote:
> 
> > Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> > zonefs_zone_mgmt().
> > 
> > As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> > from a place that can recurse back into the filesystem on memory reclaim,
> > it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  fs/zonefs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> > index 93971742613a..63fbac018c04 100644
> > --- a/fs/zonefs/super.c
> > +++ b/fs/zonefs/super.c
> > @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
> >  
> >  	trace_zonefs_zone_mgmt(sb, z, op);
> >  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> > -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> > +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
> >  	if (ret) {
> >  		zonefs_err(sb,
> >  			   "Zone management operation %s at %llu failed %d\n",
> > 
> > -- 
> > 2.43.0
> 
> zonefs_inode_zone_mgmt calls 
> lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
> function is called with the mutex held - could it happen that the 
> GFP_KERNEL allocation recurses into the filesystem and attempts to take 
> i_truncate_mutex as well?
> 
> i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
> zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)

zonefs doesn't have a ->writepage method, so writeback can't be
called from memory reclaim like this.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

