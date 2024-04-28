Return-Path: <linux-kernel+bounces-161585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69DF8B4E10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CD228108E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960ADBE49;
	Sun, 28 Apr 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bIJNctnC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDEB664
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341490; cv=none; b=nTt7MzXBIC4HYA5MN7hSGxMcl9Z/6lb+qu9cdZCwhvwDtcuKyE2/A4g1hslS/D+CxXxF+x6xOKROrN7Pz+DaU5YXVZgcRlxi0I3B5z03WzTn+k5KJjLEJNw0wcDLXKTB5AZiKfFB+zABScG9mA+XwuPj2uWerqBveDn/bj/p5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341490; c=relaxed/simple;
	bh=tdAhCl7mjJa8RjUt4m4/7T2fZ2dVw3IwCO8GrNawYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkHU70GpVBRJtd96gn7GX2mPfV+RwuVLiAe/xV3cA3RF/d6AeIiQfPIV97U1P5NCE1fHkS2GQ9hOIsRpFGFarYrZjGBqbibdAOPEVyLylnR+pubDTTAa0Rvh3TiCKEkQ3CpU/gm8PbjIMnzXeHzjckXaHyRzRFPTlW0fDgLPzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bIJNctnC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3699508b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714341489; x=1714946289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXuV7csRtJz4GGD7tR7/rDnQZRyGku0WW8DuEX0XcjY=;
        b=bIJNctnCWEY9lV3LZntTmI5WvDBMx1KFZkm9CIn25Et6vGQpLxi5cUC+JVyK3btS1w
         ep8CNfUn1x+UPTsLHKczGOmLnhdLQ6rd4E5Y438D3aqEf2thRdILmeXpGtMtdM76Sa7m
         ENQJW3e0n/sjT0g8v4cvtq+s6GjVV19WWqxH1UPvGuQoah7irri5JfOGuJZr/OOcUttO
         6pObWAZl+nmnPzzoxuanQA/YCPUoTfK5dJrKutlodSPvaTaa6Eg7Xovs7pBSkyIlYH9D
         hqqMl+HNCsp+grtDj0iMebnR3Ctug9eu6ZPlqmXTDBRV5Yt7PqLvrJPZjKIaMVDPIIvE
         cqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341489; x=1714946289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXuV7csRtJz4GGD7tR7/rDnQZRyGku0WW8DuEX0XcjY=;
        b=ZlFiPWV1q9JWdVtdKDedxuNQLatOYzDwHXvVk0hdi2fWbeLd9Cy5BJ/2uLc/lijlI6
         fXw1RYg/POWEk1EdPgVNO9epgVb1Ll6iPrbvcZRjCwtRFuuIqAVr5iWke2nfuMXLlU8h
         qArtDUGeK/YkW+V/7Svfwj25Joh7/3CnOW5tS6FcSlJbndb4K+hYn/N0BN9fJenT1sy1
         aFhleyTssCN+fWIrXSgT9GINugUxakrA6meUgxTW2g5oE1mqWXO3agMw0AgmkcSdTvXc
         +xTuza4t33JVBwDgNh/ppMXK8QArnqDslGTHgTD8FLhDNzJo7gA5eWNbfAVIDpgQM+ut
         wLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BIc4fZSmhdgFy/+aKeBBcOi97i5i+qvbSwI6VV9HMoYx/1X/qWUQzlwkQiIcZkCNCdsFQRjtcBfNF3oYU+rTCOf7bFoDrHNsJw0N
X-Gm-Message-State: AOJu0YySKLvawQDKMjXpRbQNb8VLID7RxagqsndaAPu1FTyjb0lTHzIr
	d8GhvFSzci/1BkBEPW1tKtfCOIKt3Z7FBnTkjMGq/EB+nYuiYzmpZML90yhzLLcyE38IP4bZn11
	M
X-Google-Smtp-Source: AGHT+IGye1ehSZZt4yT2nFPbQ7vud3lFr2xIjqVEFKvhITtSxlMsboN0QCMiyts7aBjcuVaOJTfFww==
X-Received: by 2002:a05:6a00:4fc3:b0:6ed:5f64:2fef with SMTP id le3-20020a056a004fc300b006ed5f642fefmr6735175pfb.17.1714341488792;
        Sun, 28 Apr 2024 14:58:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id n7-20020a635907000000b0061236221eeesm1876214pgb.21.2024.04.28.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 14:58:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1CX7-00EKuy-0J;
	Mon, 29 Apr 2024 07:58:05 +1000
Date: Mon, 29 Apr 2024 07:58:05 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_icwalk_ag
Message-ID: <Zi7GbdillYG7gSB6@dread.disaster.area>
References: <000000000000a1ce0006144f7533@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a1ce0006144f7533@google.com>

On Sat, Mar 23, 2024 at 01:09:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11525d81180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7766d4a620956dfe7070
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xfs_ilock_data_map_shared

-- 
Dave Chinner
david@fromorbit.com

