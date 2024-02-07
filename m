Return-Path: <linux-kernel+bounces-57059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC384D388
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C341F24518
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42F128373;
	Wed,  7 Feb 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Q/YldqDE"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F91127B53
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340586; cv=none; b=BCWYAj0t+PtOi+vVYxVq8CnNgZKVtMWvUF764tvy/mKgmB453u0UgzMmQ9PslRkY6Y/2taKqEwIdkQ7Ko9XxxTgRiA1r+J6/Oys6dr2mY6xF/PXykBcYiWI3M7baiepJOC8axmAPdJe146GD/WpWfVGshhTa4ySnC728rAhZkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340586; c=relaxed/simple;
	bh=w+fIBjPrK/nT6xuFbVQ1juBBDVb1ZDo31jplpYMA5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+iDkaSAtbIHV69TwBE5KJ5/OFGXetlPBxVwE72GqPj9v6IBdQgT/T2rL9GTcfbUHimQMMXfl3xNNBr9ZO9BcXdefQB95Bjk8OQUE6IPOFUJFYVbBwNJc9Ae9peTYKlqp7pb+Dh22ZIXfuad51Acq17xOcMkuI1tzVUAdb/slLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Q/YldqDE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso817956a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707340584; x=1707945384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gqlkqgjh5mviyHn6MD8miUxLgv9IqeBU6I07NHmQEg=;
        b=Q/YldqDEbY/bCM6JheFI9FpScrpdO78vVb50ro+eZbfSXo1YK7LE1RsrUMnMNTko8U
         6m/Fz3A+JXA1Y4+YYuYdA7eQ9krWvg32mPwmMpWimR6Uy6n7vX4TPkdWkdILIw93Au5s
         oSEzh5j28cdFrPI8PQR3934x//JWqcbLxe9MJTtCt4zKAHQrksVBUEYizrWWqJu5HQ6w
         6eY4Wu1ggECX3O0Yg6RTHK9XE4y+7serA+adPVf5A+vsUb5FeDmSLdHuvKNyZBAwnxE/
         Dfz4Tf4rlRUD9OwRnOWdNxzxg1n2hr3N1FUdexSIdprGmzT3fgD0Y0WSoJgp+03WdMwh
         tDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340584; x=1707945384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gqlkqgjh5mviyHn6MD8miUxLgv9IqeBU6I07NHmQEg=;
        b=cbb5EgIPXdFJtMOns7+iVRE/9I2Z3p5o3sMd6DhioZ+1HMWehEXXpdhtSWlCg2hOUR
         DRkp3n5sbObhtc1e1eBRpLtxDVvTcOl17V7nivaqGysNHZrmSeOXbYh74PZLcqsLlae9
         SLI8pm+f0hna559TtMH5qr6gh70Gn7sGy4a4s0u+4Ay/rdAmhCvYM6cGdP0YGysgPlLf
         gnKs3ekA1uV/KpVo4ZdBxQqVNOAP291bOoCRGYB1mArIEgFWxk5bXerl39pA1HZg+KB8
         fxm1mZl03x/RGjPTijMU49UfirITAmMNePuTrkDFvg9m3fyKX3vv8bT6bQ+WMTQeXy22
         91hw==
X-Gm-Message-State: AOJu0YxiKNdLleLeWCz9nTd0pJ8RxQLdZidqZm6RrHMmJWF4IjkIJjcZ
	117AcDPjBlgFIDxbfOXVepvddxZyrG1ZqPuqgYd15vKEBF3PeWkE4+/obDMZD00=
X-Google-Smtp-Source: AGHT+IFePLqKUcwz7TT7inMgRHMqSnOOGtNeTkWD1Yt+i5WWwKtaMmhtffaSfHUiH8/oQpO8GTuxKQ==
X-Received: by 2002:a05:6a20:3d0e:b0:19c:6a9c:2c76 with SMTP id y14-20020a056a203d0e00b0019c6a9c2c76mr7209700pzi.10.1707340584431;
        Wed, 07 Feb 2024 13:16:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXb2OVOLLZHdGwuFn/U1Iyk1hXgiAvRmYL2Qd14d66VH8Ss+iP7b5sf0SgSU2ALeeGHpJkdpcAkeIXxqTtjEjZpwCfOPpqGAjuntcTs7iAcihTMjkRvZri8Qz2SNCEz518PVL3NyHcV2A8zvlPGCwzsblGKk908BMoVuCN+F9U0XAD/qDuOY/EXM1hf2sq1h6Wcqv8WBreHLeE6hxRbP0FuBLlS4Fdpyck5eKhRIbulRlLcS6uVl5CTj6/PPdY1CHCHHlf4eQV05tEmN8k3gSnVZ/+CpI51QcvjTCk8fnE7OpkZPz987nPyFjCh5z1D2KbLQxU3SK2D4DW9Dc5XWKPhjPDfebnXv7knUHwCH9VSHILvVjYdEQfDRFp4Dv8phRq0zgRTFp+1T1DMGaW7Fml3ZAemDTjV6CNpe6ugeMguOg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001d8f111804asm1911449plc.113.2024.02.07.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:16:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpHJ-003R7L-1Z;
	Thu, 08 Feb 2024 08:16:21 +1100
Date: Thu, 8 Feb 2024 08:16:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	dchinner@redhat.com, djwong@kernel.org, ebiggers@kernel.org,
	hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	sandeen@sandeen.net, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <ZcPzJWwhd++wGtd8@dread.disaster.area>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <00000000000053ecb50610bfb6f0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000053ecb50610bfb6f0@google.com>

On Tue, Feb 06, 2024 at 04:24:04PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1110ad7be80000
> start commit:   40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

Hahahahahaha!

syzbot, you're drunk. Go home.

-Dave
-- 
Dave Chinner
david@fromorbit.com

