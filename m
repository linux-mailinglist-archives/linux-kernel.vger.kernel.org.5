Return-Path: <linux-kernel+bounces-118022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270B88B27F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA4D2E8301
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EB6D1CC;
	Mon, 25 Mar 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="x2FyTEI2"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAB5B669
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401404; cv=none; b=BJRV+1l+Iz69GoFa2QzeK13USmR9tgyJXOljzkSXwlhqol9NkQiHtrAnlYJOJfjzSiNth6OvLoTtknAtsNu9nE4/rJEXPU3/Lbo6TISRtvIfUR/iPB1c1x11BT7dnA0PYMvsSX15lMla2+ut8H1zqLUt80Llny3a+C8hFMicREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401404; c=relaxed/simple;
	bh=8Nahw41+JrrFLaowDhNTSh/QV4VstGtS4camkBglTlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhIVEhsf2Hm0u6CsQCw54XsLweT2LDTSSZ01kaQ6Ad2Ws+fq2vgR6QNc2LmMpscThfb8o+4a5UZVJf5etMELGogZxpsBgYPsruGlneomEEatsU8K43Mdlmqno1Bn8SJG0AVGYVRsDVO7BivIEohCRuK9xcGw2OazbGvxTo3V4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=x2FyTEI2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dddb160a37so31729335ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1711401403; x=1712006203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJrOzTRRAIet2df0BwTVFrV7spSvPuh97bPmsvwqkus=;
        b=x2FyTEI2tToUByfFt7qKLvwH6awcBpMAiCyErhR1qqeN1b8LBOgLdBjEF4jUree7ye
         MRWJ/2fiSemc9wHcehmo4dnnqaGcBvVvxxm92+vXymegzRA8vhX82RR1+3X0W/JoZOpH
         MlmfVEgXG0qUXeMhZvBdlgEMBblIIDhQc2dEbH1BSwjeewOs0lxZfqN3WtZoaSOxVnWf
         4/uqoZIcvl5zSxRriMsYwQCxoGRC7M2aS8KlDjs5HcCojImKFSJsojZv4Arnr+bx1Z+D
         5KYWvST4qbQHhMt1M6ocNfQs+ptr1h9wRFecMoLOfEKpNUqT889iAJixpq5/Ah+SyMvv
         hLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401403; x=1712006203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJrOzTRRAIet2df0BwTVFrV7spSvPuh97bPmsvwqkus=;
        b=tieG2RmHpm15UFgqGBe4GLjGrCy46tq/ziohmcEKjUqWAm8JREvtV+Px7SDOAxvjzM
         j2M4VBhylskwmbbr2hCh3CsNSVUxCSsr1gLC9xVCrMYGVU9HM/FYl/vUPE42cnfr+WCv
         N6cqadgy8qOUzFktlSNoiGJnrQmk6r4WoO2dIc3Gz4MzH03j8cbQPAImIZBwr2jqakyT
         pcmpvuT8JdgmFx6UX1w4OKbmZ8EtcrJnx7Mr5ksSVYwnmPsECjrLaikLJnnD3iXycwBP
         1FjjsiMnS7TeU9W8HIOOotrK+PSOt4h7rYTJyhAmoOiPGBE4YYZxtO4l+Vmk7rS2AzRg
         biRw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2+X9d0/3CEsKnWWOngQQzvC8gPj59Y5aFW4rXbGTphewtc1Sde+4kSKVpP+8q7Fay7ftY1tyTgAYJw3fF7z2qmCRr10mmdvsToyn
X-Gm-Message-State: AOJu0YxXC1SMGb3lrcU/vgvhA+CHAU7syiervftz3oHbYlKCjkxwEmca
	SK9778sTQ/T2r2cwuUaUejU22su/3I/apvh/n2xn7Ze3jL+ytH7Fz3d3CqkDzHBWvbN1D4DjuWZ
	C
X-Google-Smtp-Source: AGHT+IE1T64RzY6SQAo/CoKesHPLNU5CSm34ZOwtFdyydPV2JaPr1t8PQjxBRzakKMKeng0mK2DfzQ==
X-Received: by 2002:a17:903:186:b0:1dd:7df8:9ed7 with SMTP id z6-20020a170903018600b001dd7df89ed7mr11960029plg.15.1711401402537;
        Mon, 25 Mar 2024 14:16:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902708a00b001e0d9daa927sm759086plk.49.2024.03.25.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:16:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rorgN-009yrN-0Y;
	Tue, 26 Mar 2024 08:16:39 +1100
Date: Tue, 26 Mar 2024 08:16:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_qm_dqget
Message-ID: <ZgHptxp5Bc4tf3Wc@dread.disaster.area>
References: <0000000000007b5ec50614821d6f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007b5ec50614821d6f@google.com>

On Mon, Mar 25, 2024 at 01:35:33PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=102618b1180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa52b47267f5cac8c654
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor.5/6047 is trying to acquire lock:
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
> ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x48/0x340 mm/slub.c:3852
> 
> but task is already holding lock:
> ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:825 [inline]
> ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget+0x2c4/0x640 fs/xfs/xfs_dquot.c:901
> 
> which lock already depends on the new lock.

#syz dup: possible deadlock in xfs_qm_dqget_cache_insert
-- 
Dave Chinner
david@fromorbit.com

