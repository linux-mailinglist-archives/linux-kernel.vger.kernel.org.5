Return-Path: <linux-kernel+bounces-109191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E268815EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5800B2124A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2E6A025;
	Wed, 20 Mar 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Dxzq99gY"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9E6A014
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953583; cv=none; b=oJGGVcuJPi+1WeBvZTsZG7uEB9YM7Kyq8qdrlSjJmEdixwoC+ncQDGgwkHbX4I9eD4MHcqh5LGxbJXU7DiIQ6p9fZOWuivrpQSQ2nOL9/3iMc9pSVYp134aiwhFxQ8nUF0tJWBJqo6wD7PrZRticA+y+8+xwSnmApgvCBBk1CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953583; c=relaxed/simple;
	bh=kHS7OT3WV0i5gyks/LxsdRn1IByYJCkt7R0PrcsET2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPQdF+7Sc4A4fKmjUl9+kYyN0XFeadwrQ4kO8Gqu97eFctBSFHZ91FGN6BOxUyqcgM3xCby7LIs873glApEHFB0rfrIP4JqubjnhAq06gludLwXfGKLP1WyR15qN8yqygsxs5ahjxOdCIF2KXO4oKJja6gzrEO2G0zB/wd3EKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Dxzq99gY; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc05d36c86so34374339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710953581; x=1711558381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XqEO2hE+am6xlkWyV+/YerxP+gL90St3CNUnsdFUKA8=;
        b=Dxzq99gYyk+L+RRJoLnQH1+hevonUO+NpftroJt+A8KGwOZJ1C53h1QvExlcBBFA3P
         MOerNLzZURhpXvSJl6xxOqUPL5k4nviSanRgVsw0l2fkumB0wBGi2L0oa0Rd8aCxkGMS
         T4nYanSJfDuqKw6Gg+dZYLRC3ZK1ZzeW2KQHCUgPb0dVSwJL9Q20Du/7p+dWRS4D1ZmC
         q3jepvQKsC9BXyV3pgNdP3hf6LDrhqeb+16b+fMqRLK50pZorvJZNjUZPGYnLKUHu71C
         kwd7cwUYj8d3g2kaz0Ac8QBBtGV/fXqkqLqZx0aVqqBts4CHIG7l2NaOrlrX9pc+kfZP
         CT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710953581; x=1711558381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqEO2hE+am6xlkWyV+/YerxP+gL90St3CNUnsdFUKA8=;
        b=wqRGxQjM56xRQnlvBUN+5Zgng0ssVAqxgBTZ/VnN1iyg+lC/pCtj3iUe6vtmWEKUN7
         VJ0vMN9lz40ze9eb/TkPxKs40bwvsqj+KgoNtb1P0+pYNiVzXBuTW9aa0GQrPcphtm3T
         GoFFGOn7/ByfDkkJ3MCFfoJ7fgDYd2ymtiCoGdPENGmKjRJ33+zC8gPbgeWop6c5Awse
         kiURh6Jhtrm4fHNiIE38J0lFlU9XMHtVP/X8EkatVsx1NVGQhQSEaBS5FpmSHXwt/v5Q
         imdqTLvcZC9zTakr6R15/WXKEW4xtpV4BNqZEvWQzPjAzT+hepPiqCPWBzk0vXV8Zne8
         XvWg==
X-Forwarded-Encrypted: i=1; AJvYcCXQFyKrZF6ZJJA0ORqhtXdyZ7Nhg5QsSGZPr82ChFB8vBuqigTpI1EYvO5HIfELSsOvL522yijIllL5+s26zodo2S73ZWS2GudIISWS
X-Gm-Message-State: AOJu0Yxhh5a1C4eaG/y2C6QGMdnVlsmsumtMDh+15MWpc4GNQMZf18Ve
	7Gk9RoW8/ZJNEJNm85VOIa/cyZhmDBQ8l8I7BQUhx57oeoaOHIzQyE1Lmnwi5iQ=
X-Google-Smtp-Source: AGHT+IHLaPw1CZtRokQHxq61eRCAr7dVNEdHZNKsVxpPNsk4DU448kelDY69LiWQG9lIH/nlJqyuoA==
X-Received: by 2002:a05:6e02:1281:b0:366:a9b8:44ec with SMTP id y1-20020a056e02128100b00366a9b844ecmr139291ilq.12.1710953580795;
        Wed, 20 Mar 2024 09:53:00 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:4be::79:24])
        by smtp.gmail.com with ESMTPSA id fh15-20020a056638628f00b00474dc6544c2sm3666232jab.97.2024.03.20.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:53:00 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:52:58 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	glandvador@yahoo.com, bugzilla@eyal.emu.id.au,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 0/1] Fix for recent bugzilla reports related to long
 halts during block allocation
Message-ID: <ZfsUaicHDpOtkkVv@CMGLRV3>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
 <170476879011.637731.13228432208887255974.b4-ty@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170476879011.637731.13228432208887255974.b4-ty@mit.edu>

Hi Theodore and Ojaswin,

On Mon, Jan 08, 2024 at 09:53:18PM -0500, Theodore Ts'o wrote:
> 
> On Fri, 15 Dec 2023 16:49:49 +0530, Ojaswin Mujoo wrote:
> > This patch intends to fix the recent bugzilla [1] report where the
> > kworker flush thread seemed to be taking 100% CPU utilizationa and was
> > slowing down the whole system. The backtrace indicated that we were
> > stuck in mballoc allocation path. The issue was only seen kernel 6.5+
> > and when ext4 was mounted with -o stripe (or stripe option was
> > implicitly added due us mkfs flags used).
> > 
> > [...]
> 
> Applied, thanks!

I backported this patch to at least 6.6 and tested on our fleet of
software RAID 0 NVME SSD nodes. This change worked very nicely
for us. We're interested in backporting this to at least 6.6.

I tried looking at xfstests, and didn't really see a good match
(user error?) to validate the fix via that. So I'm a little unclear what
the path forward here is.

Although we experienced this issue in 6.1, I didn't backport to 6.1 and
test to verify this also works there, however, setting stripe to 0 did in
the 6.1 case.

Best,
Fred

> 
> [1/1] ext4: fallback to complex scan if aligned scan doesn't work
>       commit: a26b6faf7f1c9c1ba6edb3fea9d1390201f2ed50
> 
> Best regards,
> -- 
> Theodore Ts'o <tytso@mit.edu>

