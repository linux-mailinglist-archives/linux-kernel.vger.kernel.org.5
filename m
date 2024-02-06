Return-Path: <linux-kernel+bounces-55697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B518784C029
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429151F24B99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F51C68A;
	Tue,  6 Feb 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EtHu6CLX"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E391C283
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259050; cv=none; b=Lqsl25mOC7Tu2uN0Md6jQV19xy9ndT9Cb0Olj4EiUQ1eHa+h1/uAGOVIJw1gMevNxYvc/uPQPpWxYO5Oy2mFw6RMKhS3/rQ5oA8oVga3V4R5lUdQ5Uz+HMZUPWwi1kLuXtodq8r9lrO3pup9YmWVTY3K+Blb02j+8ScOa/DNMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259050; c=relaxed/simple;
	bh=NoYKDKrdvmM6zBnMQkYnbmzo7vUZnBcE5T8cmk/NgZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aja0KU+ZxuARYOJS4/EqWWfiEYqrAj3tpGG3tJu8IJ0wUUnVHC5QqIZugRf1g+DM/z/EOIcXlpLdeS2Y4Ga49yjYfmv6uZ2e+7eh6EScJ4kLXpny6dJZ2yAc2E94UM72n1YfhlB4GiHSQzXnJwa4PwUzHvSzO2EiwXLxRzivoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EtHu6CLX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 Feb 2024 17:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707259046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/J7xLRNpqlWMLi11r8cBIHfkqYcuKq2CydU4UKz57I=;
	b=EtHu6CLXpksfKg4IzDd04DLwS8KvsFspD35fw601Lcs8qFAxTsKpnbZFM1mMQi4pJRrJQW
	S18u5OJtb0ME5UNFaybOQNsTAB4YDSoz6rLGAcUam8vrB54WYzEXvX0EFQ25jMzg/0tdFw
	ahNt+U/4HpQg7MzLHdfUWOAEHSpvOFA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <cm4wbdmpuq6mlyfqrb3qqwyysa3qao6t5sc2eq3ykmgb4ptpab@qkyberqtvrtt>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
 <ZcKsIbRRfeXfCObl@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKsIbRRfeXfCObl@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 09:01:05AM +1100, Dave Chinner wrote:
> On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> > +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> > +{
> > +	struct super_block *sb = file_inode(file)->i_sb;
> > +
> > +	if (!sb->s_uuid_len)
> > +		return -ENOIOCTLCMD;
> > +
> > +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> > +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> > +
> > +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> > +}
> 
> Can we please keep the declarations separate from the code? I always
> find this sort of implicit scoping of variables both difficult to
> read (especially in larger functions) and a landmine waiting to be
> tripped over. This could easily just be:
> 
> static int ioctl_getfsuuid(struct file *file, void __user *argp)
> {
> 	struct super_block *sb = file_inode(file)->i_sb;
> 	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> 
> 	....
> 
> and then it's consistent with all the rest of the code...

The way I'm doing it here is actually what I'm transitioning my own code
to - the big reason being that always declaring variables at the tops of
functions leads to separating declaration and initialization, and worse
it leads people to declaring a variable once and reusing it for multiple
things (I've seen that be a source of real bugs too many times).

But I won't push that in this patch, we can just keep the style
consistent for now.

> > +/* Returns the external filesystem UUID, the same one blkid returns */
> > +#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
> > +
> 
> Can you add a comment somewhere in the file saying that new VFS
> ioctls should use the "0x12" namespace in the range 142-255, and
> mention that BLK ioctls should be kept within the 0x12 {0-141}
> range?

Well, if we're going to try to keep the BLK_ and FS_IOC_ ioctls in
separate ranges, then FS_IOC_ needs to move to something else becasue
otherwise BLK_ won't have a way to expand.

So what else -

ioctl-number.rst has a bunch of other ranges listed for fs.h, but 0x12
appears to be the only one without conflicts - all the other ranges seem
to have originated with other filesystems.

So perhaps I will take Darrick's nak (0x15) suggestion after all.

