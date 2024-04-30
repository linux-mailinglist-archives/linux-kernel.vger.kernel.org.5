Return-Path: <linux-kernel+bounces-164798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A38B830C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E651F23AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4561C0DEB;
	Tue, 30 Apr 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OB8Lb87u"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1281E49F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520125; cv=none; b=OMJdMrSMgnW9p3ufSKJPrlUNYoyklHCCdjZBXvcWqEspk4PMVWxNDUFbGoXBavKgi7pHcGuzKTUcgIdRcC8Khx2AHfwTatCnWPSOxnEkVbC703ROIQXRTLyp8TyycIhzzzj4LWNJllEj9bjEj9yIE+TqTSMrT9DbPkXc+gldG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520125; c=relaxed/simple;
	bh=zPLAG6BC9oqdmiJPIVvNKy2SbltyL+Qt1bdLKj01Us8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpFSipJdFgWjymViSP8KZdAc4muIllFXjPsZs7lm1B3hdD/yxrE/ynGN2g2rGNZP8cijDWPUJ16df9OwAyvCXpmjS9MBEzGwrl2q2HtdPmm8GwbDX46DXFDfR0S1YwYvFXIaji/r0+ywrQIaPuzf/mls6Nnm21BjqyoSF5iJRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OB8Lb87u; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso9535395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714520122; x=1715124922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebJ+P7E3aPLzGdXLYVSI2foIXw8t4rGULdg+JhpGfGw=;
        b=OB8Lb87u/3QqijEVkcv43sf0DSe4BNdNBWcFn2i8Y8hMd4lHZY+sRMdDhkukp1CTZz
         bed9P3Hy6+rW4/hjOg7Uvp20Po4sBx/1vYyeDfXMG5q1TJk8RsuWUSLIcMSbp0a+GorD
         7jP2TknkPKtpd5J0E67wp+JCFFWh91KQI+Vv9WG5qPIqCzfIa+RXwwzZiBF0PIzs8lyf
         qJBJ22SUyol+9NBZYCWryewVVjv0LhYx+MjTj7CirvD+Dcpmy538+JFMk2kI2Z2J9/27
         xGJOI2HJsGC/lxRbdBqS9HLNqnwI+/wOzDpy8jJH/NK97f6pJ9RgDHa6dY9iXNLFE41H
         KX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520122; x=1715124922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebJ+P7E3aPLzGdXLYVSI2foIXw8t4rGULdg+JhpGfGw=;
        b=UcjvZyGEMrAqDtYKb6lpoJmP7I/MvPLkTVStVsZk56khYHZFB++E27QWuYgjgO3L0e
         vNasNqfr4t+o8I0F2SX3+iu9mlQglSCI6C/0DUNUHY6emb9DlyLUUmU5pG/Hfzcw6y0j
         q/ebJRHtShevWq1MT2l+AxqBwpP/eia4s8rdfJMerHvjr5N03bo/SntceIS6vXzaOek7
         l4uPr/JZYxucH9hZHxz1ciWXIlZNkBvD98GnFAMeWv51ghp8v+C8b95jkH3tkzCbHziL
         XGs4rIYB0DMkSUbCIJ54PjxXTl9o04zltOKmB1sxq9K9tfDirhjpOKNd5pvSoBvU9lVo
         EDwA==
X-Forwarded-Encrypted: i=1; AJvYcCXhBIaR5jsrRO5mb4YVsg8nuLWtTVN5xujMzNZC0FAS5qUdztkqLI+mhopuUvLsfNUDrm12b9SG39w7QN8QAWpQYAZ2ky9fD1UXZofF
X-Gm-Message-State: AOJu0YwsE4LN/bSOU2fGfa8txlV19+cM7WkXz//3EBkMxn5GQS4/v1/4
	kyXt52/rNExPmMprG3NsigWYaKQk4E6BFrr+VXT4mcRb3+/h2HMca/McQrKfBx8=
X-Google-Smtp-Source: AGHT+IE3t6+966YIcpEKzQ8cccfZ2BAKj6uBcJiHH6Y92YMU+lJ5oaeNPKZc5ddIgEnzUQ298y/KoQ==
X-Received: by 2002:a17:902:bb17:b0:1ec:6b87:e125 with SMTP id im23-20020a170902bb1700b001ec6b87e125mr867641plb.50.1714520122398;
        Tue, 30 Apr 2024 16:35:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902c78900b001ea699b79cbsm1603839pla.213.2024.04.30.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:35:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1x0J-00GjfX-18;
	Wed, 01 May 2024 09:35:19 +1000
Date: Wed, 1 May 2024 09:35:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 10/21] xfs: Update xfs_is_falloc_aligned() mask for
 forcealign
Message-ID: <ZjGAN8g3yqH01g1w@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-11-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:35PM +0000, John Garry wrote:
> For when forcealign is enabled, we want the alignment mask to cover an
> aligned extent, similar to rtvol.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 632653e00906..e81e01e6b22b 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -61,7 +61,10 @@ xfs_is_falloc_aligned(
>  		}
>  		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
>  	} else {
> -		mask = mp->m_sb.sb_blocksize - 1;
> +		if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> +			mask = (mp->m_sb.sb_blocksize * ip->i_extsize) - 1;
> +		else
> +			mask = mp->m_sb.sb_blocksize - 1;
>  	}
>  
>  	return !((pos | len) & mask);

I think this whole function needs to be rewritten so that
non-power-of-2 extent sizes are supported on both devices properly.

	xfs_extlen_t	fsbs = 1;
	u64		bytes;
	u32		mod;

	if (xfs_inode_has_forcealign(ip))
		fsbs = ip->i_extsize;
	else if (XFS_IS_REALTIME_INODE(ip))
		fsbs = mp->m_sb.sb_rextsize;

	bytes = XFS_FSB_TO_B(mp, fsbs);
	if (is_power_of_2(fsbs))
		return !((pos | len) & (bytes - 1));

	div_u64_rem(pos, bytes, &mod);
	if (mod)
		return false;
	div_u64_rem(len, bytes, &mod);
	return mod == 0;

-Dave.
-- 
Dave Chinner
david@fromorbit.com

