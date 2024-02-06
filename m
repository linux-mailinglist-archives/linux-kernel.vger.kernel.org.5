Return-Path: <linux-kernel+bounces-55662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7401E84BFA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239811F23A60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290591BF24;
	Tue,  6 Feb 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gdhluxCu"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4A1BC20
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256872; cv=none; b=Tar9e2V1rVBlbZ+SpDl5TimRct700THspKpj7xJZJ6ykICsTc6t03ePhXzzGpphzCyRoakXNEAT85tyVwngdNvMRTBO2WbrlkygvLy+CgteDn0q+UwJmaOEqZ8NcWXiq0Gg2WBKyhhWS4WKaIRJv6QfUADwa1K5s4LgxF0kG+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256872; c=relaxed/simple;
	bh=0XWCJx6r9kaginjf7jeBU72KPDksZh5dzBUHgy17Ov0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8eTpckasFrM/xQs1WrqsIX+1SrkQjQ0qQ+1POrxVHK65DiCn/hQ9eiClT7hDEJI7UgePCknCt5bJ5cdD2FSkkx9FRZVWKYvJ9U5kcDJvK0OOVvXy0Ff1JHFkS8OEvjitpmNnIrMo3WFTk6/iUNo26W5yATKGDaSANkzh1HhI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gdhluxCu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296cca91667so844105a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707256869; x=1707861669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvZ5azBZ7Nuk9kkZVfMLpaJq4zKB8RvisM69RueKA8s=;
        b=gdhluxCumI26cRaC7M6va2tFc0VLBl7dzz/hpismPdSg/V1EcJcTKKjZHOQWN99fe/
         0e6LHIuwg+XOEWktaEfoIJ0TL/5oyOW4L+mvJaPcs8H25cBgahSJXDc8Y7xT+gFpClGX
         KC5VBPyoMQWgehaQmmBXjCp+jGyrBJGoBMX9Od2hxZAgACt+Tfr8bUUOw0FgfF1lUGfU
         KUg8D41weGClCg/AfO9vLZmeLx4MVOnaCmrQX2Vq9Hw796qCxFoTDu8bdNAUMByb1OND
         rPPnorOhgrXkwlXCGCAoLoyWxYIGSKz/ss6MIPDr5t9shd23YKvPq+b/RwN8PcxT9Gmj
         hWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256869; x=1707861669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvZ5azBZ7Nuk9kkZVfMLpaJq4zKB8RvisM69RueKA8s=;
        b=u4DHaWN/GKqK5jMad/oxgmh0rX7mU0UOaGBz6GgTMKaNsfWw9xftOFW7YnuqKAJk+S
         kPZ3QRfC9gQCkKUOjH5QQVl5wPJl6KNAKsn7GojUT29OvvzBS0c/hn++UyzurtckqIJy
         cHEEXI0WZD+tfgvkSiI4jF9GiVBLbogUXlwNg7HTzILXkFgyd5C8tySE3mf2R9WkxkYY
         hQiGsypbbZ7DuQFMF3AM10YPkbJ6Sr4TdFkuAu3SG3YAaAon4u3K7KRVh1yDRi7CYVpE
         Ck+vLucQphDIjOOWnVraoz7CI8v1WBQr4QmlGM18rBSSUst3oH+4eaa5+x0ekG2PaIjl
         FMsw==
X-Gm-Message-State: AOJu0YzZN7XemWGWppYn3vVTrgoqtPw0XoBWGyRdn/Rc/BdfQcGDYiTM
	3LHpiO7qXwbYkjCNKI2J2UMYnh/VsR3KIwsWpYJ+Lk7M4/psFgDJOIMPNKrjI7k=
X-Google-Smtp-Source: AGHT+IETjKsirskxmg+9FIvzJnvCRGGlyVKClNsRYcHPIfie2WjA/Vqc2mH9qeAmAHf6g7uZXIa6mw==
X-Received: by 2002:a17:90a:b014:b0:296:2afe:25e with SMTP id x20-20020a17090ab01400b002962afe025emr979615pjq.32.1707256868849;
        Tue, 06 Feb 2024 14:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLxqIvg1xX8jznnY+omiFFjT6noNNt2KzmiuHmKZajnc8MVKjCew+hYcurLVYlICKhCJNu0ntvteLWNGeDXt/zICTEnP+sMcgvljHTh4FH5zsNEoHFjHISMwCjDd6UJ0qcjFcMVqjBXakdiR93NG097Lhj0Iwsrr8i/eJiSWgM9IAie7rLUzwOMJTiNuVwEE7XXF4bNxklH6aPtRUUmVA7zvpPZmen+HDDon3DgRoyabV6U2wk6GA0XZt412SXJkonBB1KTvoRHqYCPTrV+A==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001d8f99dbe4asm6328plc.4.2024.02.06.14.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:01:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXTV3-0030UX-1Q;
	Wed, 07 Feb 2024 09:01:05 +1100
Date: Wed, 7 Feb 2024 09:01:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Message-ID: <ZcKsIbRRfeXfCObl@dread.disaster.area>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-4-kent.overstreet@linux.dev>

On Tue, Feb 06, 2024 at 03:18:51PM -0500, Kent Overstreet wrote:
> Add a new generic ioctls for querying the filesystem UUID.
> 
> These are lifted versions of the ext4 ioctls, with one change: we're not
> using a flexible array member, because UUIDs will never be more than 16
> bytes.
> 
> This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> reads from super_block->s_uuid. We're not lifting SETFSUUID from ext4 -
> that can be done on offline filesystems by the people who need it,
> trying to do it online is just asking for too much trouble.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-fsdevel@vger.kernel.or
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/ioctl.c              | 16 ++++++++++++++++
>  include/uapi/linux/fs.h | 17 +++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..046c30294a82 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
>  	return err;
>  }
>  
> +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> +{
> +	struct super_block *sb = file_inode(file)->i_sb;
> +
> +	if (!sb->s_uuid_len)
> +		return -ENOIOCTLCMD;
> +
> +	struct fsuuid2 u = { .len = sb->s_uuid_len, };
> +	memcpy(&u.uuid[0], &sb->s_uuid, sb->s_uuid_len);
> +
> +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> +}

Can we please keep the declarations separate from the code? I always
find this sort of implicit scoping of variables both difficult to
read (especially in larger functions) and a landmine waiting to be
tripped over. This could easily just be:

static int ioctl_getfsuuid(struct file *file, void __user *argp)
{
	struct super_block *sb = file_inode(file)->i_sb;
	struct fsuuid2 u = { .len = sb->s_uuid_len, };

	....

and then it's consistent with all the rest of the code...

> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..16a6ecadfd8d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,19 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/*
> + * We include a length field because some filesystems (vfat) have an identifier
> + * that we do want to expose as a UUID, but doesn't have the standard length.
> + *
> + * We use a fixed size buffer beacuse this interface will, by fiat, never
> + * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
> + * users to have to deal with that.
> + */
> +struct fsuuid2 {
> +	__u8	len;
> +	__u8	uuid[16];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -190,6 +203,9 @@ struct fsxattr {
>   * (see uapi/linux/blkzoned.h)
>   */
>  
> +/* Returns the external filesystem UUID, the same one blkid returns */
> +#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
> +

Can you add a comment somewhere in the file saying that new VFS
ioctls should use the "0x12" namespace in the range 142-255, and
mention that BLK ioctls should be kept within the 0x12 {0-141}
range?

Probably also document this clearly in
Documentation/userspace-api/ioctl/ioctl-number.rst, too?

-Dave.


-- 
Dave Chinner
david@fromorbit.com

