Return-Path: <linux-kernel+bounces-32342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D81835A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA58B1C21AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16394525D;
	Mon, 22 Jan 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="equt+5O5"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7B5227
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902399; cv=none; b=qysX0kU251za0j4geOGPf76+eyz1PjYDCubABYpZ0lYuwW9aDdb8ksnno1HRdhYhekZdDSA0K2VRYBbdt/MpVvROPvF4kEg5Ne13vPH/AJod0JKoCZg/dgWK6edX6KUz00Dr+NAe6BMILD6XkcIwOZPrCPo3XbdFoJuuWg9WL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902399; c=relaxed/simple;
	bh=1rBvZM1Ljwa8WBCUNlYPqcVcf0Xlz7obw+J+fO/FviM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJgLUeWvZACikjPk2+HVOUl8hpdwAwPAMHmc7sE+Zt3aMWEQctxJhJseZj5Q1vwmZw8z+AzfWsZfHN4L5Pe/4UVgPLlDKie3q5OkYyqf5Gox91pakVi2O51OV5Y9voqxyi57B8D3Y401iGTwJTVfzZa0YzDiRNgfzqLka39AwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=equt+5O5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d748d43186so1681065ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 21:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705902396; x=1706507196; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IflNS6Etc8g12+qLnuO+gXfIx3jLJ1iHCnSoNRmsAEY=;
        b=equt+5O5HIPZygVQBPm7jwu5J7KklWMyCJOCD9tKn4XHb93Rl9vlW7SV1/SwccK4ze
         TH4M0BljvL8SrDPIDaB/KRSfyYsqNPBKMZgIFWDC7YC6pbqqtmEibMLnvETazSs7qG3a
         d06Cll2ZotG7EzInEixrngYevcfJqbJiak8BrE8jvnNSCiy1YVvpz3ibkwMS28DXGhun
         bWfTZpf5ZjvaRY1RqJ94RoSp+eRngu391HTQpAnfz449xBBvJAlLzAx+x+tqIvPlUlNk
         tWF8YuZYOiouVJvUEe0qQX2CW3EVoTGJKI2dTud8AcnlpaAwRy7IGaYMw0WV0/blt0RQ
         6FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705902396; x=1706507196;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IflNS6Etc8g12+qLnuO+gXfIx3jLJ1iHCnSoNRmsAEY=;
        b=iRpIeQWaw7gYHXdPXNHlVhgU8tfAaYG5Uv79qPbOC0LKyrCXznk4vUZ6wzSteNeUOz
         aEhG0BaO/b5HAepcBEQaqPuJwi51roEfOOuaoCH03VZ+g+2Ibrd0ocVC0oEnV9jrIbaN
         xqzf95DA1swxQZFAcPv0vvckiUkZl2ZdwgzZi8oFg3YgUoch9iqMtMON6+eLNcZ/GwK0
         gSgJ8tbolqdQ2VKL5x+gXz5TbJVM4cpn77MxlUHTkaAHZMTQLdHamXv4rzK1b7hIIwlD
         RZ3YqDIVhKmr3+PJ1ebDpE9oRPJmQbtON05NcgfOG4Uh1jOKSDpFH70xIxCbc7/O6Fpj
         sfyg==
X-Gm-Message-State: AOJu0Yyg8m+MBwN8MDIANhWQERQ0WNkxhWg+KUw0fKu9Kt+MVJfU+wQ9
	/6T4pgWZrzHE41fyyQRh1uZLsCg20kfT4+zNW0lcoi3L2qqkKgSqiM9EtaX4
X-Google-Smtp-Source: AGHT+IHG1N155t3rfeAWb6fP/BEBG5N33Go4BNyWCFzghW9M1uDKo4TALaThs42HCSbSIuc5tQvc6w==
X-Received: by 2002:a17:902:7794:b0:1d0:6ffd:6e85 with SMTP id o20-20020a170902779400b001d06ffd6e85mr1471333pll.125.1705902396245;
        Sun, 21 Jan 2024 21:46:36 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id kl5-20020a170903074500b001d72d445778sm3233018plb.204.2024.01.21.21.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2024 21:46:35 -0800 (PST)
Date: Mon, 22 Jan 2024 13:46:31 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20240122054631.GA7880@cuiyangpei>
References: <20231203054313.GA14316@cuiyangpei>
 <20231203193745.57035-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193745.57035-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > Hi Cuiyangpei,
> > > 
> > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > Hi Cuiyangpei,
> > > > > 
> > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > 
> > > > > > Hi SeongJae,
> > > > > > 
> > > > > > We also investigated the operation schemes you mentioned, but we don't
> > > > > > think it can fit our needs.
> > > > > > 
> > > > > > On android, user will open many apps and switch between these apps as
> > > > > > needs. We hope to monitor apps' memory access only when they are on
> > > > > > foreground and record the memory access pattern when they are switched
> > > > > > to the background. 
> > > > > > 
> > > > > > When avaliable memory reaches a threshold, we will use these access
> > > > > > patterns with some strategies to recognize those memory that will have
> > > > > > little impact on user experience and to reclaim them proactively.  
> > > > > > 
> > > > > > I'm not sure I have clarified it clearly, if you still have questions
> > > > > > on this, please let us know.
> > > > > 
> > > > > So, to my understanding, you expect applications may keep similar access
> > > > > pattern when they are in foreground, but have a different, less aggressive
> > > > > access pattern in background, and therefore reclaim memory based on the
> > > > > foreground-access pattern, right?
> > > > >
> > > > 
> > > > Different apps may have different access pattern. On android, the apps will
> > > > join in freeze cgroup and be frozen after switch to the background. So we 
> > > > monitor apps' memory access only when they are in foreground.
> > > 
> > > Thank you for this enlightening me :)
> > > 
> > > > > Very interesting idea, thank you for sharing!
> > > > > 
> > > > > Then, yes, I agree current DAMOS might not that helpful for the situation, and
> > > > > this record feature could be useful for your case.
> > > > > 
> > > > > That said, do you really need full recording of the monitoring results?  If
> > > > > not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> > > > > monitoring results snapshot that include both frequency and recency of all
> > > > > regions in an efficient way.  If single snapshot is not having enough
> > > > > information for you, you could collect multiple snapshots.
> > > > > 
> > > > > You mentioned absence of Python on Android as a blocker of DAMOS use on the
> > > > > previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> > > > > or Python.
> > > > > 
> > > > > Of course, I think you might already surveyed it but found some problems.
> > > > > Could you please share that in detail if so?
> > > > > 
> > > > DAMOS tried regions feature you mentioned is not fully applicable. It needs to
> > > > apply schemes on regions. There is no available scheme we can use for our use
> > > > case. What we need is to return regions with access frequency and recency to
> > > > userspace for later use.
> > > 
> > > 
> > > Thank you for the answer, I understand your concern.  One of the available
> > > DAMOS action is 'stat'[1], which does nothing but just count the statistic.
> > > Using DAMOS scheme for any access pattern with 'stat' action, you can extract
> > > the access pattern via DAMOS tried regions feature of DAMON sysfs interface,
> > > without making any unnecessary impact to the workload.
> > > 
> > > Quote from [2]:
> > > 
> > >     The expected usage of this directory is investigations of schemes' behaviors,
> > >     and query-like efficient data access monitoring results retrievals. For the
> > >     latter use case, in particular, users can set the action as stat and set the
> > >     access pattern as their interested pattern that they want to query.
> > > 
> > > For example, you could
> > > 
> > > # cd /sys/kernel/mm/damon/admin
> > > #
> > > # # populate directories
> > > # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
> > > # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> > > # cd kdamonds/0/contexts/0/schemes/0
> > > #
> > > # # set the access pattern for any case (max as 2**64 - 1), and action as stat
> > > # echo 0 > access_pattern/sz/min
> > > # echo 18446744073709551615 > access_pattern/sz/max
> > > # echo 0 > access_pattern/nr_accesses/min
> > > # echo 18446744073709551615 > access_pattern/nr_accesses/max
> > > # echo 0 > access_pattern/age/min
> > > # echo 18446744073709551615 > access_pattern/age/max
> > > # echo stat > action
> > > 
> > > And this is how DAMON user-space tool is getting the snapshot with 'damo show'
> > > command[3].
> > > 
> > > Could this be used for your case?  Please ask any question if you have :)
> > > 
> > > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n
> > > [2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions,
> > > [3] https://github.com/awslabs/damo/blob/next/USAGE.md#damo-show
> > 
> > Thank you for your detailed response, it is very helpful to us. We will look into it
> > and contact you if we have any questions.
> 
> So glad to hear this.  Please let me know if you have any questions or need any
> help :)
> 
> 
> Thanks,
> SJ
> 
> > 
> > > 
> > > 
> > > Thanks,
> > > SJ
> > > 
> > > > > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> > > > > [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > SJ
> > > > > 
> > > > > > 
> > > > > > Thanks.

Hi SeongJae,

We set 'access_pattern' and 'stat' action in schemes when apps are on
foreground, record apps' memory access pattern when they are switched
to the background with 'update_schemes_tried_regions' state. But it
catch the snapshot after next aggregation interval. DAMON is still
sampling during the app switches to the background and the next
aggregation time, which can cause the value of "age" to change. The
sampling results during this period cannot accurately reflect the app's
foreground access pattern.

Is there any way to catch sampling result immediately after setting the
"update_schemes_tried_regions" state? Alternatively, can it return the
"last_nr_accesses" and "last_age" values in tried_regions/<N> directory?

Do you have any other suggestions?

Thanks.


