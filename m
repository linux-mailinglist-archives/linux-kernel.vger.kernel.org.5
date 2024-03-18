Return-Path: <linux-kernel+bounces-106749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4987F313
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA92281E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D7C5A4D8;
	Mon, 18 Mar 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hhfOO/cn"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716859B6A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800582; cv=none; b=jH9qdKKqqGqkkgV6zDeDxVtGEP6n/LKLZ+pqToMlVe9lKKw44juAHov0uQyJX7fOy/exHIkRwT9hqMukuHtcjyR1L6MMkPVxjfy7IFQnon2fzHJqZszuccetKRaOK+VdZA47Q+KBrItv8kwrksG9Dtf69EpT8BBxkiyE9cdETM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800582; c=relaxed/simple;
	bh=NqI0VTZW80xtuCGyeObiIog7FSq9YX7JYVoRKPWyAsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP2tuidu64u1cFKlUTFVr/kZ90gpuFKExmFzNPYwh5CPyZEuIrxFpg8MgSSvtA0k1HdPoOI0HzYUb+EWoELTg0EpkkRDA0Hh18VA+ppfc0EpXo6pbE57BAW2QBNzFAMCSHjuwj9i81edcCC2+5r9wrzmwn+1F1uueHBDzw3BU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hhfOO/cn; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4a2d99598so1012335eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710800578; x=1711405378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCCQCvkYtGuuihvS9ju13jWtjvlJYDKT9jyxnBBJm5s=;
        b=hhfOO/cnoOU3wnrH1TbsSuGUEZTtNBJPUDUIbIAw5mre3kMg5Q2CKR2Kyj5ZdgPqYj
         L59Hc5IG1vEkH6kMNEMU+NGk4dmZokTStw+YOyuNaRBD9KaavjAG3GAo+VWrvcIt0ezv
         J6zCf3W+rPjJKZhIdewcStElPotBuTlh+jd+U0/2gHu52tCxBqzm9o6s7Kr1FX/KMnCh
         pcTWN+t2vHrFJq0yxrqcgf/6RWQ5L5Y1y54x+MjP24en8VttiVvw1Iy7Ges0vbru+9o9
         qAZM6/TgKk30AlXLTRsze7+vMESCdieBkoMP5z88IMY3EmGxscSo2HXrqy8HTEfuhyvQ
         dDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710800578; x=1711405378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCCQCvkYtGuuihvS9ju13jWtjvlJYDKT9jyxnBBJm5s=;
        b=ooqj7JskyZLr4Q/P5Eto0xo0OORO8uiTzmnYsSqPFqj4sdJ4EpU1qWe3qqc963hfO2
         wUm+fpr6eYK6zb1IPIe3Fq7e6581meeNY34FV4/n55No/D0ZJePOY6N3OY00KMMXl1mz
         CcgbkInc3QXnvrEVmlyxbbh9ie/mWB5ooPFSWPZbaNr/CEmWYgl5zy+61dKi7U/sTIjJ
         2l3KC3my+ihII9Qx3fT0ZFOflqi8lgfY5pGq9SZmOPIYfMlhYZNP1rOpkY+qBIr73ATM
         Zs+ZRG5uF94Ikoy6w+g/GuS2d9J5YVO/GN9uQ+x+TPiGuhIEyz5z268hq/xogcgWLgQT
         fR9A==
X-Forwarded-Encrypted: i=1; AJvYcCUe/kVUrQhg1nUXuF3SGvPL1GUKvyjnqgY5yPKHOtHL3I+pQMCCZCKt1RlpiI8eT1LLehR5Su5io5mJWWmWEWcvGkAFAL7549jnwrJX
X-Gm-Message-State: AOJu0YwJdDvTnARdw28WxPkOJlGa7qzpMXXa7tjCdXooB8PiEHSqYgxb
	sufPvRaQ/vMk9X9ulCpy05++qr05H3G1+ul4TssRKGgR8jk6WbxPapWHzpCFOK4=
X-Google-Smtp-Source: AGHT+IHyckCjaxFsQHMtIDAZv7wEdAat6m2tUFjdH9I1ji+XQfTeAoj5hu9HAz770Ekw5+eb0V75BA==
X-Received: by 2002:a05:6358:3389:b0:17e:8e40:47f5 with SMTP id i9-20020a056358338900b0017e8e4047f5mr8624180rwd.11.1710800578468;
        Mon, 18 Mar 2024 15:22:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id k12-20020aa790cc000000b006e71cd9c02bsm3240212pfk.129.2024.03.18.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:22:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rmLNf-003nTk-25;
	Tue, 19 Mar 2024 09:22:55 +1100
Date: Tue, 19 Mar 2024 09:22:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Kiselev, Oleg" <okiselev@amazon.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Theodore Ts'o <tytso@mit.edu>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <Zfi+v/9vF+mfZ4Bl@dread.disaster.area>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
 <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
 <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0A342BA-631D-4D6E-B6D2-692A45509F63@amazon.com>

On Mon, Mar 18, 2024 at 09:51:04PM +0000, Kiselev, Oleg wrote:
> On 3/15/24, 09:51, "Kent Overstreet" <kent.overstreet@linux.dev <mailto:kent.overstreet@linux.dev>> wrote:
> > On Fri, Mar 15, 2024 at 12:45:50PM -0400, Theodore Ts'o wrote:
> > > On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> > > > the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> > > > filesystem in a fs agnostic way, potentially nudging us towards
> > > > standarizing some of our reporting.
> > > >
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > > > sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> > > > #endif
> > > > super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> > > > + super_set_sysfs_name_bdev(sb);
> > >
> > > Should we perhaps be hoisting this call up to the VFS layer, so that
> > > all file systems would benefit?
> >
> >
> > I did as much hoisting as I could. For some filesystems (single device
> > filesystems) the sysfs name is the block device, for the multi device
> > filesystems I've looked at it's the UUID.
> 
> Why not use the fs UUID for all cases, single device and multi device?

Because the sysfs directory heirachy has already been defined for
many filesystems, and technically sysfs represents a KABI that we
can't just break for the hell of it.

e.g. changing everything to use uuid will break fstests
infrastructure because it assumes that it can derive the sysfs dir
location for the filesystem from the *device name* the filesystem is
mounted on. btrfs has a special implementation of that derivation
that runs the btrfs command to retreive the UUID of the filesysem.

So, yes, while we could technically change it, we break anything in
userspace that has introduced a dependency on bdev name as the sysfs
fs identifier. We're not going to break userspace like this,
especially as it is trivial to avoid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

