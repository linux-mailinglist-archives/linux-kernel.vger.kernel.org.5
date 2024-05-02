Return-Path: <linux-kernel+bounces-165903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A432F8B932A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6571F22A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA8168B7;
	Thu,  2 May 2024 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XWZdedso"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269D3207
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614216; cv=none; b=c65J4oGf94eRNmwm/RCkmUbs2KMjCIwE4j0UQNpDrkeaskDyjgshlZuWA09KZqj6sECEePBrmgFGChLXzGOJWrU8K+AJRatmWUIB/05qJUDfVNGgPDljd8WkoYjhz0k6rjJ56gPrUrGI2KQRJ0UpCBiwZT4YDFT2QNuhE4fYNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614216; c=relaxed/simple;
	bh=Bl7xaTCifxr7O+80tnD004gRnMC1H8XKmKgcszt6Fz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJlGYYCi+rY6wYII3FXoejhgUYj132DJRSttkqBSPDheVxgegaE4y1Pz+CO0gtf3DnoGaMkbnJTGrhjDbbkwp3Oa3nIrHq+CHKYI1YyaDoAflOBh4o2moKNCQqdAwALEKlp5K8dbiwDyI4tJUugGrJEugyYDviXNdrRiCFu2H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XWZdedso; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4f341330fso68556595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714614214; x=1715219014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RD76l1MXA6SInQldy5GmBoit4g9TYS57g8CJpm+KZ4=;
        b=XWZdedsoHnlkJxV4n0lkLQliRBa90kXdazvc/WcX9WR1Ya6vLiso4r/sLDiT4FuQY8
         xmBITfQD7J15ncfBWt3Ve5HRnhzEWwo4jJDaMEQze8TwbPZJkPzIiBP1sQ3mJybywaWt
         ZvjAX49KV4I6LT+v4b7Piuac7RK7/fme6o/utUywF2XaWyRCN96VcSjq7I+By7g0dYUN
         FYqWeqHNsT+itdCXvaa3U0QKdA7KpgCTp48o0d+ZnYqdOHo9g1pMkqsqvGXOQjGWjAqF
         27rblKUrmU46ajuSJgfEaZUJI31lgSBLJQTyTwZntiLqmTqEUkd+YjgISv/Q1G4Ye7qB
         aWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714614214; x=1715219014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RD76l1MXA6SInQldy5GmBoit4g9TYS57g8CJpm+KZ4=;
        b=tEXdan3KMaE97uigx8jNmg4HcdOygwSVmKTFoiTs1O44oBJCPGUNk+y3tbY1SQYnO8
         26fOY/Aye18RnoIZMMWyiRTG4601X6hztFIQupAp4yJnzJcRlTn3lkdMTtQ7g2QJiPzm
         Rr40X/9dOli6iJu9nwmmsa1jZLloqXDK5kJtXZupB5IG5qTZgx741RsL9NpT3uiLfY2H
         5lDR+TNK0Gen3T7Em7tt/RA6J58aD07bY68emIuknL7HBi18wGd6xB1LMCRjcqMVIG69
         FXUdqF2wb5W6qJNMUnWBfhPovRJvLaLHpLFAEPlGI9vV+XaOZkYSi3CNvLBoFs6opBgG
         F1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW1R1A5CcgG90OeR8wyfQUPwJZP9G6I3guyUQqCctvlkicDsbXLmJGcmEMdjWQTx36XTiiOpycUYkIfhjwDgg6nVBEXQ8YFbF9xyJ0+
X-Gm-Message-State: AOJu0YzVPyiCIF7JcM/x1m+XAJ2OPQVufOn5EYcoBzFtj8HwcCHMI5eU
	S7VcuE7bE0CQNKaDEiWVFUiwiTDYw+kC49VDYXSFkZNCFwgUMYFPSLsTmJYUYmQ=
X-Google-Smtp-Source: AGHT+IGF6Yr3/AQWnhsY0aR4NlbeEwPWwmPkMtkvwxYyCdykGHR3PyMA0nyTE/BtT7prN/QCnIl6ig==
X-Received: by 2002:a17:903:2444:b0:1eb:3dad:aced with SMTP id l4-20020a170903244400b001eb3dadacedmr4696923pls.11.1714614213756;
        Wed, 01 May 2024 18:43:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001e98f928d0fsm21987plg.10.2024.05.01.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:43:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2LTv-000Oik-0K;
	Thu, 02 May 2024 11:43:31 +1000
Date: Thu, 2 May 2024 11:43:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 17/21] iomap: Atomic write support
Message-ID: <ZjLvw3Y5m9AxH71u@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-18-john.g.garry@oracle.com>
 <ZjGfOyJl5y3D49fC@dread.disaster.area>
 <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>

On Wed, May 01, 2024 at 12:08:34PM +0100, John Garry wrote:
> On 01/05/2024 02:47, Dave Chinner wrote:
> > On Mon, Apr 29, 2024 at 05:47:42PM +0000, John Garry wrote:
> > > Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.
> > > 
> > > We rely on the FS to guarantee extent alignment, such that an atomic write
> > > should never straddle two or more extents. The FS should also check for
> > > validity of an atomic write length/alignment.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
..
> > > +
> > >   		bio->bi_private = dio;
> > >   		bio->bi_end_io = iomap_dio_bio_end_io;
> > > @@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   		}
> > >   		n = bio->bi_iter.bi_size;
> > > +		if (is_atomic && n != orig_count) {
> > > +			/* This bio should have covered the complete length */
> > > +			ret = -EINVAL;
> > > +			bio_put(bio);
> > > +			goto out;
> > > +		}
> > 
> > What happens now if we've done zeroing IO before this? I suspect we
> > might expose stale data if the partial block zeroing converts the
> > unwritten extent in full...
> 
> We use iomap_dio.ref to ensure that __iomap_dio_rw() does not return until
> any zeroing and actual sub-io block write completes. See iomap_dio_zero() ->
> iomap_dio_submit_bio() -> atomic_inc(&dio->ref) callchain. I meant to add
> such info to the commit message, as you questioned this previously.

Yes, I get that. But my point is that we may have only done -part-
of a block unaligned IO.

This is effectively a failure from a bio_iov_iter_get_pages() call.
What does the bio_iov_iter_get_pages() failure case do that this new
failure case not do? Why does this case have different failure
handling?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

