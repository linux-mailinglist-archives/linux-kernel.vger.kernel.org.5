Return-Path: <linux-kernel+bounces-165937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E2D8B939E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE58B215A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110911B813;
	Thu,  2 May 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sOxfjY5Y"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912B18054
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619561; cv=none; b=nLqe9cvdtPQwojSsFivCYhC17GexURwT6BUurgzBbRkfiLI4fe9yrwMZ5XhwOD5jywSdoIWI3p1oN2B8zfrDbqhl9dDxCjQcVCjERXjkyWAyq6T3IbsHcEbgBbyIQO05RLUUsQFmHgS9E08g8Hcgm5Tb1ugoxxPQarh4x/MDcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619561; c=relaxed/simple;
	bh=WgnYev3iL3bTtE7UnbSWD1Q1DqsNg+ZMEji4e1ykjnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ZBprXUl41WVrnjshejUkydfji7B/dtAPyp9AcWVR8ID0LhBF4t8uqg++7/vRzxMUn/5UeZnn99Bg2Z5zdVvbnIgHi5lYsqWBpw67bba8XUfK4UoVQlS7yPM9mfdPmBCoJuSvKBkqhChs6jjmwelY/G0Jcbr99HF3ngNrs3dOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sOxfjY5Y; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3907ff128so5874929a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714619557; x=1715224357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxU4uj4hkcp1dLz22ktDIDCqUdqy1TVfUCsqX6hkqK0=;
        b=sOxfjY5Y6Emew5nkqpEQxXxQ1dUAilUXiA0tcT1h0wYOXyOeoe3JjXm/N/Dk4XjZoK
         5EqgbPhu6G77A1CPwiCRB7N78vtNNBY022g4npkbAkReQVlQ6b6eKFIfFFxv0Fn9JnT+
         YHqCbr5KLq60q0sWwwYdNaeD2Yaf1MTjgm3RKo+pRdjhkG/Q4WuhOhyY7pgVK/y77k7J
         099kxL2oK/rUpyeH0gHJW+Mg2ISQz4rjU1QuosSkqK+lVI690E9mobEycLb/TquHjB+S
         yUxnlCjbyGBRR4rfWSbNroNgayo3akedthGKquWDXp9B2lXgcg3890gQ0ajO3GTMGrTK
         fbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619557; x=1715224357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxU4uj4hkcp1dLz22ktDIDCqUdqy1TVfUCsqX6hkqK0=;
        b=FUJSWVDC/QLnoU1fLbl2MKvBZHoEjAMvSPoh4yyGK6EVABTBn3YD3kc+kS2hYTB+PK
         uH/UoxTEdUDN/pYvCG0IL71+UY3A3l1h7u/nxQzcarwEinSFOSExiBqg+wc0v4m5fWls
         vy/27RHw4nA923UzudJyx9pvtXEBeiaGxnIDKeOs/DvgUKLkFm9eACthihanVGssl8r+
         kuclWWX6wnjR0mbi4Np/u4fhW240OnFRVSacRTQxjcQY+Vlp/0682IWTGsnPGxF7WPDH
         VGEN0aXlPrk7xpygdXq1R+9TaiiK9xwO+Fl2GVUZzhFXzH/wMOUyXQAwdpp3tueF7qGG
         mhdw==
X-Forwarded-Encrypted: i=1; AJvYcCUtzLiLkDNqxNivZzLQ0M+u/dVSgyw0WMX/CswX18k8V6WwSr9ifUbqkdphackNFO/6+XiSVpa+xy8bIHmImindq2TqlYH4Szx5k4tq
X-Gm-Message-State: AOJu0YwJfiuufDEJAIdrJq02RwArn4svlo3Gjr2/1ifJUFg3jzZTkAFs
	+AkAvFYJ/qMst+ZFX/3EdxTSB/pkidsn236myrGr4QXInlm9oZPi+DCCO/8aMOqUHJiaKy/IGVl
	/
X-Google-Smtp-Source: AGHT+IFk0SsIAhiTdnh8fa+N0OtU/vL7UYnH56mZggyi13eZnYq8j8uY1qc9WZRSbkde1s6/dI0yvA==
X-Received: by 2002:a05:6a21:498e:b0:1a5:bc5d:3c0a with SMTP id ax14-20020a056a21498e00b001a5bc5d3c0amr870776pzc.61.1714619556914;
        Wed, 01 May 2024 20:12:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm131849pfb.80.2024.05.01.20.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 20:12:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2Ms5-000T8k-1e;
	Thu, 02 May 2024 13:12:33 +1000
Date: Thu, 2 May 2024 13:12:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	chandan.babu@oracle.com, willy@infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
	p.raghav@samsung.com, linux-xfs@vger.kernel.org,
	catherine.hoang@oracle.com
Subject: Re: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
Message-ID: <ZjMEob4s3721orKp@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-13-john.g.garry@oracle.com>
 <ZjGSiOt21g5JCOhf@dread.disaster.area>
 <20240501235310.GP360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501235310.GP360919@frogsfrogsfrogs>

On Wed, May 01, 2024 at 04:53:10PM -0700, Darrick J. Wong wrote:
> On Wed, May 01, 2024 at 10:53:28AM +1000, Dave Chinner wrote:
> > On Mon, Apr 29, 2024 at 05:47:37PM +0000, John Garry wrote:
> > > Like we already do for rtvol, only free full extents for forcealign in
> > > xfs_free_file_space().
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  fs/xfs/xfs_bmap_util.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > > index f26d1570b9bd..1dd45dfb2811 100644
> > > --- a/fs/xfs/xfs_bmap_util.c
> > > +++ b/fs/xfs/xfs_bmap_util.c
> > > @@ -847,8 +847,11 @@ xfs_free_file_space(
> > >  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
> > >  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
> > >  
> > > -	/* We can only free complete realtime extents. */
> > > -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> > > +	/* Free only complete extents. */
> > > +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
> > > +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> > > +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> > > +	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> > >  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
> > >  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
> > >  	}
> > 
> > When you look at xfs_rtb_roundup_rtx() you'll find it's just a one
> > line wrapper around roundup_64().
> 
> I added this a couple of cycles ago to get ready for realtime
> modernization.

Yes, I know. I'm not suggesting that there's anything wrong with
this code, just pointing out that the RT wrappers are doing the
exact same conversion as the force-align code is doing. And from
that observation, a common implementation makes a lot of sense
because that same logic is repeated in quite a few places....

> That will create a bunch *more* churn in my tree just to
> convert everything *back*.

This doesn't change anything significant in your tree, nor do you
need to "convert everything back". The RT wrappers are unchanged,
and the only material difference in your tree vs the upstream
xfs_free_file_space() this patchset is based on is this:

-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
+	if (xfs_inode_has_bigrtalloc(ip)) {

That's it.

All the suggestion I made does is change where you need to make this
one line change. It would also remove the need to do this one line
change in multiple other places, so it would actually -reduce- your
ongoing rebase pain, not make it worse.

That's a net win for everyone, and it's most definitely not a reason
to shout at people and threaten to revert any changes they might
make in this area of the code.

> Where the hell were you when that was being reviewed?!!!

How is this sort of unhelpful statement in any way relevant to
improving the forcealign functionality to the point where we can
actually merge it and start making use of it for atomic writes?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

