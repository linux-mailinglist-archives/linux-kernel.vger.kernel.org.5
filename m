Return-Path: <linux-kernel+bounces-57058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9F84D385
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423DD28B4BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41F128380;
	Wed,  7 Feb 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KbwVS21i"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162F1D546
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340531; cv=none; b=ll1Qr3bmBkEuNtVF0aORsmQMdUazmpxnWqa3tfxC11Jq8wDHKVepgmbRuJE8D/1I7Q1Ag1/L9HYfj14mmUwIDDRMu/T5kmWlGQcaw++unQCgly3/gF6sihY7LSt9kSgTnzifXhCW/jcLU8QVatqhdIFblpIGbLvvvGt5VbXvCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340531; c=relaxed/simple;
	bh=19oFLOywtRTDwr5C4A46OzhtascO/FjsYpXHX8JQkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkkb+rEwCVWPL/S+9WuhvHB8yBD2QCJmCKaLonQqRO9OWmZWzGTIsYW/9/JE64VhEfxvTYGfBfE3FbJqxrMW3LF1r2BRZxo89X+dCESWHswYrGB9ueIqI0oZoaFyDooP3XcreZ7S/JQ5XHNuZUxPb4tmAqilK5ex+zsMccNyb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KbwVS21i; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso213342b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707340529; x=1707945329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04OQtEbZdH/pUOm6NUHTngrItClskq9Yti7ODoE+vKs=;
        b=KbwVS21i+mVfi3kUN7l4faD+1PsEOcYY8tqP/TvKGm9DThaLcOTHYBTUk0EwtDsbkM
         4hzf9QjWaIaIC0+o4ezhGILesNISMiSMxk9ioGFzHfkHrxodYx7xT4lccX4HquQDOXkh
         cXgotaZ9vL2rRbTli0UL/FCFRMxVBT2JUngp65PynnKK2v1aYaSMz9qblAZzf/+Bcj+t
         5omVRQ2m8ac8MvNnOspevLLigYQ5IkXbKK+yQ/GI9IQjDbtAjFtG5IOmGWH8tfkeivLH
         jPUb78DFCQHBPDrcWn9lmgnDqNqu1bXem7F6qpccaatNR6U/pJsaX3NM9JNc0VzG5Y/S
         WU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340529; x=1707945329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04OQtEbZdH/pUOm6NUHTngrItClskq9Yti7ODoE+vKs=;
        b=vpxIwt6tB95r8Lc7S/srtv0LN+DYY51yFAz/LhamUgzW2Z3hBLaSagUaUPVUj05Jjp
         LmG5bGbWpCFOMpKZLrOQcMx+sWxxl9TsuSDyJ/PIWZSbgIaMgsuzQbiGbzh93pPF2hc1
         3yen9Eey+7vh2sxJirZ7gOg7qCsO7lGQwelekDiayktN3wqRQLD+87LJNFdh4MHeP5vR
         rjasKtfB++0F2p3nsZEiAFU4Ll17LtPaD2TtSbwrdGhS/Zuut9jMnvTL6ChKe6qLEXvs
         bUyGqYGVmGKYfvv6USE6y20no2RatIx4GI3laMsTNxI+RpF1ntrfN9//B3mEu+ZSn6Q+
         ijRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUicqw/KUkl6uiiL0Uz5d2+S+x4pHGfj4EMDDpuRTM0mdneAjyU+KI8RijZ1+Jo2K7m1bJcTQTZFIUC7di5BWCWdNAxI8u5kJd2W7Lj
X-Gm-Message-State: AOJu0Ywc9eQIdXmZf5dNoM+Q5bnNDoWwVmhBxrLHi3CaSlF6mo5+K9Xn
	Ngv3k1FHCMsIHXPr0IUqti0LbJWF0fgJZpDbwbAvVHeVnZw7l943CZe8D6KBiYs=
X-Google-Smtp-Source: AGHT+IHW5jPend1XcjCroAlSsQfuNUH2BCxiWinXUuj9oBba79YI/CYXbOgMa4EIipr05A/LEP2yog==
X-Received: by 2002:a62:f207:0:b0:6e0:5149:3040 with SMTP id m7-20020a62f207000000b006e051493040mr1036504pfh.5.1707340528832;
        Wed, 07 Feb 2024 13:15:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUepmCBRtg9CtTqz+61+TUFDmeXMUFsG6AUptVta3ZOix7VzXdsOe2QipA/7T+glNzueVo0ub1tD7nqsetWHcQbGiZ7VB7Np2f9XSs3Ru9WsDnVzLNK+xhT8/dsIDYIAINbSpD9DCJfzufcmgeoB1ln/LmvLme0qduZMv7Uile4lVkubgjpggjrrGCO8MTZ8sBDocBmkodBIngI861R2Qhr4Fv19J1Tw8fKJMwqgK/yBijNo+8TfK+sFHNG5OAPIElMM9T3r2XIwewo8W9irxKSHTdJSAPf1yoycpcPwA6+wkeEd3+ZMfvLBfrTKGwXaim0gqLygA==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id lp20-20020a056a003d5400b006e04c3b3b58sm2186789pfb.179.2024.02.07.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:15:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpGQ-003R6W-0B;
	Thu, 08 Feb 2024 08:15:26 +1100
Date: Thu, 8 Feb 2024 08:15:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+3f083e9e08b726fcfba2@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_buf_item_unpin
Message-ID: <ZcPy7sm6SujCXwXv@dread.disaster.area>
References: <0000000000009c7eb105f5b88b70@google.com>
 <0000000000006f69c90610a8edb3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006f69c90610a8edb3@google.com>

On Mon, Feb 05, 2024 at 01:13:04PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176f2d7be80000
> start commit:   d2980d8d8265 Merge tag 'mm-nonmm-stable-2023-02-20-15-29' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=471a946f0dd5764c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a077d8c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d91c74c80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

No, not even close.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

