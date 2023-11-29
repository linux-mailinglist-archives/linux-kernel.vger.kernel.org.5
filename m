Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631797FD165
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjK2Iu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjK2Ius (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:50:48 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C505D19BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:50:53 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58ceab7daddso3112997eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701247853; x=1701852653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYXSXkaMtC15qsDcPr/TTfVheSuOP1FzJ66FIQNOxts=;
        b=U7tJR3QQmhRzC0U1jTzz+rCEt8e/QkKgxdNZ5mmbtLzJchlyR/OebRKUIkUoIfO7b2
         d8yAeWKQsxxkAJu3zJZqTy05D+9XLvdl0h3GMfPzj6iHXUAMDiBF8HhWjXGiOT2Nuz8Z
         lLuzBCesb62JLBYYH0gsk1GQVqJi/l8TMa/8bb1LK+noadPqcfmNQV2X68xPTdWfDWdJ
         X3OhjY9LQaLF7rxMLNnFl7BPlrN0OilTiaHtK2hb13Gtq3MBjhDkwUUBWObnL7kHECUA
         ED5fA14d/LFdkpKt7a89nl16+E6foiAr5bbweTqorxhVJ/cPrhoPUAG+1IpG305/+Lup
         CX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247853; x=1701852653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYXSXkaMtC15qsDcPr/TTfVheSuOP1FzJ66FIQNOxts=;
        b=Hv+ILAdw/9Hg5c19lyHVPzdFuML3zPYxJO8ysXOOlsLVhquEgSb612A7T+pN0St0Jt
         NHb0kq0oUX09E9/a4RuwF1NTXriGJuPw3mmO836fHKPl2C2u4bPyNEX8wS//Tq/3BjRV
         E3Gbckvvr57NvQkb81q3nUlSCsuB8foLvzbZpIkoj5EZLFdR8X3cDCctele0T32fXDsz
         bWWVT1Qr2H9/JiJ5QB6NpK1ums1wIF6hcQEnMS/cypgPR/7AHfF/uFLg+GlGFBFdutVO
         faHilXhlB5kvmzwelWWlVa/a+sAADCXjpLc23QrK5Z0sPQ4jJLmVPd+SYafP5gX0y4Pd
         A0KQ==
X-Gm-Message-State: AOJu0YwuNLV1yW5ZlLxI/qUQK1ShCdzzc9o60SSgtN+z/O3zxS/29fZb
        YbY4oVnMwLJPjjppb+MY9X6afw==
X-Google-Smtp-Source: AGHT+IFlAixmOkdEDtxGfEJ9lx0Lw0rR4W/R4CexjDMnl8uFGG693OejX8yVG2qZwlv9TCQdJRYbOw==
X-Received: by 2002:a05:6870:9d8d:b0:1f9:5699:e53c with SMTP id pv13-20020a0568709d8d00b001f95699e53cmr23027716oab.36.1701247853109;
        Wed, 29 Nov 2023 00:50:53 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id hy13-20020a056a006a0d00b006cbb71186f7sm10357652pfb.29.2023.11.29.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:50:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r8GHS-001RGM-0j;
        Wed, 29 Nov 2023 19:50:50 +1100
Date:   Wed, 29 Nov 2023 19:50:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZWb7aiXDIC/BNl3L@dread.disaster.area>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
 <ZWZ0qGWpBTW6Iynt@dread.disaster.area>
 <20231129063433.GD361584@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129063433.GD361584@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:34:33PM -0800, Darrick J. Wong wrote:
> On Wed, Nov 29, 2023 at 10:15:52AM +1100, Dave Chinner wrote:
> > On Tue, Nov 28, 2023 at 01:32:02PM +0800, Jiachen Zhang wrote:
> > > From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > 
> > > xfs_da3_swap_lastblock() copy the last block content to the dead block,
> > > but do not update the metadata in it. We need update some metadata
> > > for some kinds of type block, such as dir3 leafn block records its
> > > blkno, we shall update it to the dead block blkno. Otherwise,
> > > before write the xfs_buf to disk, the verify_write() will fail in
> > > blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.
> > > 
> > > We will get this warning:
> > > 
> > >   XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
> > >   XFS (dm-0): Unmount and run xfs_repair
> > >   XFS (dm-0): First 128 bytes of corrupted metadata buffer:
> > >   00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
> > >   000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
> > >   000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
> > >   00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
> > >   00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
> > >   000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
> > >   00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
> > >   0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
> > >   XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
> > >   XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
> > >   XFS (dm-0): Please umount the filesystem and rectify the problem(s)
> > > 
> > > From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
> > > its blkno is 0x1a0.
> > > 
> > > Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> > > index e576560b46e9..35f70e4c6447 100644
> > > --- a/fs/xfs/libxfs/xfs_da_btree.c
> > > +++ b/fs/xfs/libxfs/xfs_da_btree.c
> > > @@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
> > >  	 * Copy the last block into the dead buffer and log it.
> > >  	 */
> > >  	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> > > -	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
> > >  	dead_info = dead_buf->b_addr;
> > > +	/*
> > > +	 * Update the moved block's blkno if it's a dir3 leaf block
> > > +	 */
> > > +	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> > > +	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> > > +	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
> 
> On second thought, does this code have to handle XFS_DA3_NODE_MAGIC as
> well?

Yes, it does. The code to decode the block as a danode instead of
leaf1/leafn block is a few lines further down.

This code does not support ATTR_LEAF blocks, however.
xfs_da_shrink_inode() will only try to swap blocks on the data fork,
never on the attribute fork. That's largely a moot issue, though.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
