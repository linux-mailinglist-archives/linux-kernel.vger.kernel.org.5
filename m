Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F947A4096
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjIRFtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjIRFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:48:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B8121
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:48:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fc1bbc94eso3602206b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695016122; x=1695620922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1DRqcBgmxswHX4pyVMaZ8qtBDRiLU8WPLBXlzgYD2k=;
        b=Ax2fIs/7bsV/onMa7xt3ZnPIsVJ6+DYyEMRV4m4a6jAQ6+ZRfRtZzfrh+Bei1DfOZj
         kEQA6Fw/TtxvRgqCqGq0eMQuazKA/4vSfraF0D9A+nOdCgj89/IhMMfpYuP2NeFvn3Wd
         GqHyZZyvAwaDuTq6FKm9CmhRB+PRH27CFY7cLV1wTWn+7RCID+TAaM+4ZsywLgmta5IR
         MH7qa6nbjsAG+ujEWfmLo6OSzV4CSvVvaFEDhWrIo8RjGTUDurTThYqSfpqchXP2P74J
         gTWPDLpIlpOQF67TCW27qi/zux9C2JSzhirbvKjs1i1CI4sxe8v1cn8M2v5zFeVnhWBA
         aY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016122; x=1695620922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1DRqcBgmxswHX4pyVMaZ8qtBDRiLU8WPLBXlzgYD2k=;
        b=e58xroIf83trPc4u8WvtKJTEdbD0lFT9Yk0U425bgiR/+jv+bysTSUW2eazpPeliLo
         UFemuw/pBbrPpk8pB8l7nb76uFuieHWl01ZVIMuQ3sH2KtD6jpYm8vUF5alu4MO+42BH
         +HxOPUNS+jrt51l0Iyhs4BMX1uiT2AfieKzdXxgQURBNfYj66UjALW9BeeRcN8M/mNl+
         x0m/vagC9nqn6RDYTeDKqaD7/QYMtScECDkCFeiaRDpJliTvBnQenqCWJl2UfXk0RgHy
         Ie47+GPXyDFx6Yx8gZVpjQzKjRsaKOX0FisVcMYnzIQ0tysMxcdZe5PWmxz6aW2zC029
         XdVA==
X-Gm-Message-State: AOJu0Yw3Le/Ny5VBBvxOGdM6drIyHXqQ1aNJe2QTvjZFMjt+zY59k1tR
        vsV3FVgf3ilwhyKI4W4MO6xzAw==
X-Google-Smtp-Source: AGHT+IGWSjgPJY0rz+mhy5X0wouSG5p/8Gn/5BnR3iDeiNiZQcEPTgbz0a+Wja+GB/mgOJTRCfB+dg==
X-Received: by 2002:a05:6a00:cc2:b0:690:15c7:60bf with SMTP id b2-20020a056a000cc200b0069015c760bfmr11315941pfv.20.1695016121692;
        Sun, 17 Sep 2023 22:48:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7938c000000b0068e12e6954csm6453271pfe.36.2023.09.17.22.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:48:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qi77e-002E25-0S;
        Mon, 18 Sep 2023 15:48:38 +1000
Date:   Mon, 18 Sep 2023 15:48:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cheng.lin130@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v3] xfs: introduce protection for drop nlink
Message-ID: <ZQfktqPJ5Qzs7unT@dread.disaster.area>
References: <ZQeBY3kmww8qAjfP@dread.disaster.area>
 <202309181144537682244@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309181144537682244@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:44:53AM +0800, cheng.lin130@zte.com.cn wrote:
> > On Fri, Sep 15, 2023 at 05:50:56PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > On Wed, Sep 13, 2023 at 05:44:45PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > >
> > > > > When abnormal drop_nlink are detected on the inode,
> > > > > shutdown filesystem, to avoid corruption propagation.
> > > > >
> > > > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > > ---
> > > > >  fs/xfs/xfs_inode.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > index 9e62cc500..40cc106ae 100644
> > > > > --- a/fs/xfs/xfs_inode.c
> > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > @@ -919,6 +919,15 @@ xfs_droplink(
> > > > >      xfs_trans_t *tp,
> > > > >      xfs_inode_t *ip)
> > > > >  {
> > > > > +
> > > > > +    if (VFS_I(ip)->i_nlink == 0) {
> > > > > +        xfs_alert(ip->i_mount,
> > > > > +              "%s: Deleting inode %llu with no links.",
> > > > > +              __func__, ip->i_ino);
> > > > > +        tp->t_flags |= XFS_TRANS_DIRTY;
> > > > Marking the transaction dirty is not necessary.
> > > > Otherwise this seems fine.
> > > Another strategy:
> > > Set nlink to an invalid value(like XFS_NLINK_PINNED), and
> > > Complete this transaction before shutdown fs. To make sure
> > > nlink not be zero. If the nlink of a directory are zero, it may
> > > be cleaned up.
> > > Is that appropriate?
> > No, all I'm asking you to do is drop dirtying of the transaction
> > from this patch because it is a) unnecessary and b) a layering
> > violation.
> > It is unnecessary because the transaction will almost always be
> > dirty before we get to xfs_droplink(). In the cases where it isn't
> > dirty (e.g. xfs_remove() on a directory) we explicitly check that
> > nlink == 2 before proceeding to call xfs_droplink(). Hence we can't
> > actually get to xfs_droplink() with a clean transaction, and so
> If the corrupted inode is a parent directory, when remove its
> subdirectory, the parent's nlink will be decreased to 0.  But the
> transaction of subdirectory removing is not dirty (There are not
> check about the parent directory). In this situation, the transaction
> will be failed and the filesystem will be alive.

Yes, and that's perfectly fine. The transaction cancelling code has
worked this way for the past 20 years or so...

Indeed, you said your customer wants the system to stay alive if possible,
right? Well, so do we.

If the parent directory has a bogus nlink count, and that prevents
us from removing items from the directory, then as long as we
haven't dirtied anything and we can return a -EFSCORRUPTED error to
userspace to say the unlink failed and we don't have to shut the
filesystem down. All we now have is a directory that has objects in
it that can't be removed....

For a higher level perspective, we only need to shut the filesystem
down if we cannot safely back out of the modification operation that
was requested. Whilst the transaction is clean, we can safely return
errors to userspace and continue operation because everything in
memory and on disk is still consistent, even if we have found a
corruption in non-crtical the metadata. Just returning an error to
userspace can't make the problem any worse.

This also is how we treat corruption that is found during read
operations - we return -EFSCORRUPTED to userspace because something in
the directory or inode we were trying to read from was corrupted. We
do not need to shut down the filesystem because there is
no risk of making things worse or the in-memory filesystem state
getting out of sync with the on-disk state.

It is only when we are trying to modify something that corruption
becomes a problem with fatal consequences. Once we've made a
modification, the in-memory state is different to the on-disk state
and whilst we are in that state any corruption we discover becomes
fatal. That is because there is no way to reconcile the changes
we've already made in memory with what is on-disk - we don't know
that the in-memory changes are good because we tripped over
corruption, and so we must not propagate bad in-memory state and
metadata to disk over the top of what may be still be uncorrupted
metadata on disk.

This "in memory matches on disk" state is effectively what the dirty
flag in the transaction tracks, and it's done as part of the normal
running of a transaction as items are tagged for logging. Marking a
transaction dirty that has nothign tagged for logging is actually an
incorrect state; we may handle it correctly, but it should never
actually occur and we should definitely not be open coding dirtying
of transactions to create this state.

IOWs, the transaction modification error handling paths already do
the right thing according to the state carried by the transaction at
the time the error was encountered.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
