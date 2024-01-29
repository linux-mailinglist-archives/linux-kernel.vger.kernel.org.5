Return-Path: <linux-kernel+bounces-43585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDF8415F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DDE1C23573
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BF51C34;
	Mon, 29 Jan 2024 22:46:57 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824054F1EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568417; cv=none; b=mlmI4LFRxCJz6nANxEodIXUj45QMRuPfKJYgdGBexQ4DjPC9NV3bDTG1z/wHt5a4+qZHdBV2JtbnfdJ/iDyEpb1dskFEzU51KlLibTvoNetqtxpw5j8/OmdxyehaGAvinJjdVnpJB+2f8J8/CUuGlwgBD2+zQepDk9qWQ++WVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568417; c=relaxed/simple;
	bh=z4i3/tfWy/FJa7/iha829M+16JqzAz4CEfvIfR+Zbvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlJzsrjzxV2phjCDcfJWlpUEhRxUYlhsIKvL3gpWpKgT/aK92/LKiv5RvxHVgNZatvPe4b2K9LAlR7LQBk9nZiSJrpo6+3kAdG4NzqgzlVEfQMC7WAAsAZE9Eg1HrYWJlSW0i4kHtMjCgQgEtCswhIKO4aoziRPjgyVlQDHr8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a8900bb93so34117301cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568414; x=1707173214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y1TC6ozjJZpDR660NrUM2DmjgjZssr5RPk8k265VkY=;
        b=hTo8n0vTJi7Rihh8BZiaRTzf9Wb+gYzJUIHsB4/AWTrxyFZ/pIg5LUZDJqDyQ35XLl
         gmML2jUaDsOtlp0uCclZAoKoKhQwCjJzMhUsvpn9egDO7dRaBTujIXYJd9i13dYPd5pa
         xJesSghv5c6kFMGc+gnvHlJKjuBKRmXu31qyi1C61ohtTtrZ+nzxUABlQ2bzbfSAvlW1
         Nmpox1kMF+N6COvLrTtF/n4qxTfTBXoKCapcNG+Mdz98Zqn5WVxzkGCZ6U4nANfFVkOf
         q4J1Ae2uAmHCB1z/849wuzxUjZxL9plNeIvkg1LwkeKva88F0exco3v1N1IkrGLNTPk9
         7D1Q==
X-Gm-Message-State: AOJu0YzSnRv6bzJx2sJC6ic6qtKCgtDdt4Ex4YqJJRRjuVHPY+ISWD0T
	ypEy6dvVfbjP2vTmsza9ayRD1w8P5NvpConQuDe5F5C5uvsv00zENsS0nuv09Q==
X-Google-Smtp-Source: AGHT+IE6sdw2UMPyjdmSHO2Q/aOZ/VKQc/wBLWuOWcfTwiePWMJWreri2G4nKR0FgOPeREPo2MLweQ==
X-Received: by 2002:ac8:7c4d:0:b0:42a:b4c2:e71d with SMTP id o13-20020ac87c4d000000b0042ab4c2e71dmr293866qtv.70.1706568414455;
        Mon, 29 Jan 2024 14:46:54 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bc6-20020a05622a1cc600b00427f1fa87e6sm2079280qtb.56.2024.01.29.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:46:54 -0800 (PST)
Date: Mon, 29 Jan 2024 17:46:52 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ming Lei <ming.lei@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <Zbgq3B8nmMuJooEl@redhat.com>
References: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbfeBrKVMaeSwtYm@redhat.com>
 <Zbgi6wajZlEkWISO@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbgi6wajZlEkWISO@dread.disaster.area>

On Mon, Jan 29 2024 at  5:12P -0500,
Dave Chinner <david@fromorbit.com> wrote:

> On Mon, Jan 29, 2024 at 12:19:02PM -0500, Mike Snitzer wrote:
> > While I'm sure this legacy application would love to not have to
> > change its code at all, I think we can all agree that we need to just
> > focus on how best to advise applications that have mixed workloads
> > accomplish efficient mmap+read of both sequential and random.
> > 
> > To that end, I heard Dave clearly suggest 2 things:
> > 
> > 1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
> >    bdi->io_pages, not bdi->ra_pages * 2
> > 
> > 2) Have the application first issue MADV_SEQUENTIAL to convey that for
> >    the following MADV_WILLNEED is for sequential file load (so it is
> >    desirable to use larger ra_pages)
> > 
> > This overrides the default of bdi->ra_pages and _should_ provide the
> > required per-file duality of control for readahead, correct?
> 
> I just discovered MADV_POPULATE_READ - see my reply to Ming
> up-thread about that. The applicaiton should use that instead of
> MADV_WILLNEED because it gives cache population guarantees that
> WILLNEED doesn't. Then we can look at optimising the performance of
> MADV_POPULATE_READ (if needed) as there is constrained scope we can
> optimise within in ways that we cannot do with WILLNEED.

Nice find! Given commit 4ca9b3859dac ("mm/madvise: introduce
MADV_POPULATE_(READ|WRITE) to prefault page tables"), I've cc'd David
Hildenbrand just so he's in the loop.

FYI, I proactively raised feedback and questions to the reporter of
this issue:
 
CONTEXT: madvise(WILLNEED) doesn't convey the nature of the access,
sequential vs random, just the range that may be accessed.
 
Q1: Is your application's sequential vs random (or smaller sequential)
access split on a per-file basis?  Or is the same file accessed both
sequentially and randomly?
 
  A1: The same files can be accessed either randomly or sequentially,
  depending on certain access patterns and optimizing logic.
 
Q2: Can the application be changed to use madvise() MADV_SEQUENTIAL
and MADV_RANDOM to indicate its access pattern?
 
  A2: No, the application is a Java application. Java does not expose
  MADVISE API directly. Our application uses Java NIO API via
  MappedByteBuffer.load()
  (https://docs.oracle.com/javase/8/docs/api/java/nio/MappedByteBuffer.html#load--)
  that calls MADVISE_WILLNEED at the low level. There is no way for us
  to switch this behavior, but we take advantage of this behavior to
  optimize large file sequential I/O with great success.
 
So it's looking like it'll be hard to help this reporter avoid
changes... but that's not upstream's problem!

Mike

