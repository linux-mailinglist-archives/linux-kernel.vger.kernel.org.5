Return-Path: <linux-kernel+bounces-161319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E107C8B4AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D35EB21296
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F54524C3;
	Sun, 28 Apr 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ecGu1KaS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4D51004
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291778; cv=none; b=HcA7zjaip5wM7fWdihiB/BnbS+9+0HXdd4cJsOP9On5l4qe7hl3vA7CI7SUpN9idLu6ftPMKVH8XXmwzEYaAZ3DVff/Dpvph2L8rSQNpt/6IIEngl4JA0FAPFoIjemjtlJ45IEJM9VU0TlRBCqDF0yfTsbK5o7OBsW/ip/dP+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291778; c=relaxed/simple;
	bh=RGtjeZHfticbLVVHVwKN60wvYIzeLxe4ZhOw7GQu+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3qMi4q4HXZB/V2L1cPFxMFeyTnVjsH1vd61GKjOl6hohpsLpeXyu0nc0aE3GqWJpiM30bDSUSWrLV3dls78z1K2SccbYIW0mQFdviUmI1mMfqQXfiFlyyQT61f5/tc+dzFMEam0g2EjxtuCn+iNCmCbRa+D+dt9urV4L4TPJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ecGu1KaS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so3229735b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714291777; x=1714896577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr2/pezhFZvy2ti4izAfkmb7Mo4zjJj1mKJct8ejdOU=;
        b=ecGu1KaSF4BC9/wR/c/ZUhvWZOTYc/tr7ywxtedLjjlhZNW7iyBTgVfIsc/envqEpY
         U/p2TuUEJXjcB/zlvoJehCv+kL+MTgrXZkAhgOB6RAtq8Suxay1/V3oJTRTdbbJjEV8M
         rR9Ol/eVDMWsNkDnp0uGADJ1pkDo6WTfsDc+HbimSRa1D7FhALg2/hrZg/i951lbQkH9
         zyKwpBJK1pJSpy5XfBRyt0vq/FamhY7R76Z7sAZi+TXdoDhvilpmTpHhd3JE5lI4UBJJ
         +B1bO+5U1gN3J9J4/mcU5sCtoWYLNvIlayQpgJ2iYQD9wRgLtnMzIwhxfktvirDtVCK0
         /CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291777; x=1714896577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr2/pezhFZvy2ti4izAfkmb7Mo4zjJj1mKJct8ejdOU=;
        b=dUJrgXSmcPRBjDYv8o24gwWmfYNvV0ha7dlogtv7cUBcC+jkZWJQa4WEut9wvfBkQ4
         r8YZ7r4zWYMzd7/uMrtzndS/Ec/HI8XjDYyouujg0kPmgi0muxW6UwzHF8nc3QK0PHrR
         TCA5n9DfXneHjYfFJRCH9R8R0ZKzTsmHOTYjM3XqENbCNpwnhxGH7HU6m+gCngbOBJfe
         K0m4J+5qSa8fTB63aaJ7HqvuVpnXzSOXph1ZGeCeB1MJGI+kZKWIbIRJCUeUp+TptuSb
         qp2GXMsbVxftIpoulxmkAvXcptZFxhwOVzZ6YcqW4zwy/st6LIX98iog8JVHPGNkik/k
         xUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl/LEPUaeAoP5HKpZjgh7t5nSB3SYMBfqnd6GJfDqzXPSUjn0dBTXt/feaoSWSNjtEv1/GZOsfPUtZjswJlYV+TDRgKUkyEHgs3hNg
X-Gm-Message-State: AOJu0YxUALlJN/kw61H0Djc+ooxyw27BUSsTFV9+4P4/94FKcFwgZ8IY
	11U7Tz7e+lGX3FexchfWMDMc+9G899icXKifwJFtNanjTs9ggxfBhYfCj6wdh48=
X-Google-Smtp-Source: AGHT+IFVq6F6PgiUJXdrmsEFFbPDCdWKUqbzFYW11KIw0Ka/fKJVMKo5MPDPlwhCu84K4aFEZj2KKA==
X-Received: by 2002:a05:6a00:3c88:b0:6ec:ebf4:439a with SMTP id lm8-20020a056a003c8800b006ecebf4439amr9369087pfb.5.1714291776828;
        Sun, 28 Apr 2024 01:09:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79892000000b006ed0c9751d0sm17777890pfl.98.2024.04.28.01.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:09:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s0zbJ-00Dfbv-36;
	Sun, 28 Apr 2024 18:09:33 +1000
Date: Sun, 28 Apr 2024 18:09:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
Message-ID: <Zi4EPfTFLZZibR7X@dread.disaster.area>
References: <000000000000fee02e0616f8fdff@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fee02e0616f8fdff@google.com>

On Thu, Apr 25, 2024 at 10:15:29PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xfs_ilock_data_map_shared

-- 
Dave Chinner
david@fromorbit.com

