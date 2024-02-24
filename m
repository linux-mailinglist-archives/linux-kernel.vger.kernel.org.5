Return-Path: <linux-kernel+bounces-79900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B341862870
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B731F21A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027A4DA1C;
	Sat, 24 Feb 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Wz/SoFsQ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CC4DA15
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708816338; cv=none; b=G2JJRfDHsRtI5uvWu7xCeDhUa8mqKYV6Qf/HjkSS16eTknhsXoo08bPBl9vE2Zsoj4dxHzadYluqDsNLJh/Cwyx6puexUXdDw6wmfDf6kUXnEfI2+B4LwN8ICelwPP5RliwJjMR2X3qWR+/KnVMxaTAPvefBNqVUWfQdvTwq3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708816338; c=relaxed/simple;
	bh=1G6UBPQOt1jMUOLwIKI1YddODQf7olQpZNiocdqVRrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhqOthT9b6CBgiAPE53RUVx4hs6z9ujDksxbDMkdv7lusZ+muq6+e6QXVMoP75bTbnP/+gv5RL+I1L3Tq/Gqkz1AL9QzrqhYN0ZsSX1ErYJcHc8X9CKCDzbA/DPK3aw4I1oYpSW/J8JtREI2CvEVr4Ce3zuPFirasPInz1RdqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Wz/SoFsQ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2770e44d0so15758691fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708816335; x=1709421135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Uyo66Ikrhwk+3TAWwFJQUJfWyVOGzjT5F7h+oNDShA=;
        b=Wz/SoFsQaBL3n4nG90Pm3wvoxP9OHLi0Hw0BbBN7gBqZPsakZpmVuqimcYuauMH1Ro
         +gaDE+zV9HWHgwo84BLD3Dz2DPjc2bRDrzhjzNUEcvQ7Wsb3vwEkDkdc/DReBTHRwkAH
         llzVfBgbimy2XU4zPLCXBKlYjDPpwOSLAquO+xtDQ0eQmGO+iB7NvB+qezXmkJosRLA8
         aKOAdF1CyMwN0w5ue1UznfYQqO2iWiikxSF9nbWDwqmwXWooXZcObAOMnlv6ctP5Vjql
         0v9O9acJKltnVbRprAVY2I4LRTKDW/KarRqKj9fk2XLbRCZsjZuWyYNs0gznKB6DlYIQ
         1oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708816335; x=1709421135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Uyo66Ikrhwk+3TAWwFJQUJfWyVOGzjT5F7h+oNDShA=;
        b=JJmC0tQ2EAGmdwe2QTuhnO4qiRIhptSl/K0GRj7PtweHp9gWw/RBvZL/w1veLS1bpl
         iVVQ+gaLBk4hSb7YDQ0gPeIEcht6uYCWMZ9ubav6AR5HzDCmrkSqq1AG6+r4FuSOgb1k
         BBTHKlXIgg7oHRJ0GCSRE/VSoURUwbccYmykWqAgAF+VY41DE470svmp1cjZE3qB8wfi
         tiy0hsHpO6598jWpKkMmRiBLmihvrafq3l0EcrmhcmMzmefKXqGdoPm7TB8cwjkNjIa5
         jt5dCaRUlEeLIg2Os4DwQqCMXSYwzPL604badhlL/TA4cGh6HeHlcWzXhMk4SI6leRPQ
         8zrw==
X-Gm-Message-State: AOJu0YwPxNFlVKK5r2EcriAxZMnU4u4voZwvRXfT+3KQo8W0nzO/NcfY
	7Ku3AhzvDoqHswXYbvvmbmR9X7Vbz2he77oVRIOO79a293asfpLROHAuKe0q9FM3K9BuMopvKgB
	O
X-Google-Smtp-Source: AGHT+IEGUEiM1Td2l08D5DZPTBAcbK/Z5mNG2Kxs7gu0Tbs6Fv0kqittUkx1PuvP4tyHOX3WN3jUgw==
X-Received: by 2002:a2e:9209:0:b0:2d2:3a8e:e2b4 with SMTP id k9-20020a2e9209000000b002d23a8ee2b4mr1581862ljg.42.1708816334594;
        Sat, 24 Feb 2024 15:12:14 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b00412a218a68fsm379464wmq.31.2024.02.24.15.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 15:12:14 -0800 (PST)
Date: Sat, 24 Feb 2024 23:12:13 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing IO
Message-ID: <20240224231213.7zszol4lfq2zc7ey@airbuntu>
References: <20240223155749.2958009-1-qyousef@layalina.io>
 <1bb797ef-573b-4bda-98bf-1eb63f6f4ffe@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bb797ef-573b-4bda-98bf-1eb63f6f4ffe@linux.ibm.com>

On 02/24/24 19:13, Shrikanth Hegde wrote:
> 
> 
> On 2/23/24 9:27 PM, Qais Yousef wrote:
> > Due to recent changes in how topology is represented on asymmetric multi
> > processing systems like big.LITTLE where all cpus share the last LLC, there is
> > a performance regression as cpus with different compute capacities appear under
> > the same LLC and we no longer send an IPI when the requester is running on
> > a different cluster with different compute capacity.
> > 
> > Restore the old behavior by adding a new cpus_equal_capacity() function to help
> > check for the new condition for these systems.
> > 
> > Changes since v1:
> > 
> > 	* Split the patch per subsystem.
> > 	* Convert cpus_gte_capacity() to cpus_equal_capacity()
> > 	* Make cpus_equal_capacity() return immediately for SMP systems.
> > 
> 
> nit: Did you mean !SMP systems here? 
> Because in changes i see its returning true directly if its in !CONFIG_SMP path. 

I was referring to this hunk

+       if (!sched_asym_cpucap_active())
+               return true;

in cpus_equal_capacity(). In SMP system the condition is always true and
there's a static key that tells us if the system is asymmetric.

> 
> > Qais Yousef (2):
> >   sched: Add a new function to compare if two cpus have the same
> >     capacity
> >   block/blk-mq: Don't complete locally if capacities are different
> > 
> >  block/blk-mq.c                 |  5 +++--
> >  include/linux/sched/topology.h |  6 ++++++
> >  kernel/sched/core.c            | 11 +++++++++++
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> > 

