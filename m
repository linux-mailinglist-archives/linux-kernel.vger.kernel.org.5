Return-Path: <linux-kernel+bounces-161584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5F8B4E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB11C208BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9246C122;
	Sun, 28 Apr 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="I/KgNh0t"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C6B664
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341398; cv=none; b=m4zxgEboGwUn4vAZrG9e5e+WKLLbghZK1JF92Sx56aHPSBWDnKBDjXucrxupEJqy9QQnF8OR4ro8VDOe04u4dePiXStKwQ8g+gDXxYsY+/Oc4wNd+793Y1UNeDYNjEyfNF32/dQFTgEJcfVnaBJxW4yAlVvxrBUR4ATQarfcQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341398; c=relaxed/simple;
	bh=0sr9nBLxt1MlrbNjDBRrpAf3yb8QHo0lIswi5d1GWQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRd9Gb7C+M7mt4jPSGWG3/CVRSDVK8lurNroYpVac3qA+n1f1UNLAdGwqrz8IrzrJhQEVYi9gPZZMQ0t3mZ4kLD9Jrj8QqF7T12VtpSQMVAC7ezJYKaQSJZ2gkqWTvfkgAgtCaFwlimco3O/RGM9uzlqNtEb9p94I4SnwTzd6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=I/KgNh0t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2758009a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714341396; x=1714946196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Kg16f7V8LCJhvMH5AebLBMpqsrdjvBouIxT3v254Zo=;
        b=I/KgNh0tn+E1ZRu4TpP1pfhgmPugD91i2kwSCvN1opKZaLYtBeZlFaZbJiwq6m0MAK
         rARLXkcV9Z/8y5DE68q/r+H75HmB4jIJZjsA7OkyF+JV91vJDtF8RMaeR4f10L15o3l3
         6vsJvYZRA1SRGnFYOdS6zp8Rptg8HNB5sewmkLrcyk2lwaGlY1xzYh0K2K29meMQ8ouq
         TFiBldf0+bR7IN+iE5mBrRiowfTe2NnuUwttwnNOQjaH3TvHHo9SBzF04FlX+Q670w+W
         /QXgmEjiwdYVnokcQB0Rlnd82TzCcEnruxnhHp/3XzDFUpgY1JJqEkPEz/Yfgo9lJ4/Z
         yeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341396; x=1714946196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Kg16f7V8LCJhvMH5AebLBMpqsrdjvBouIxT3v254Zo=;
        b=NN+jVNMUjomWGoh+SVEdA5j5FME6IxjO7Xdk9Li4s2ejdmAxIn2VArGng1W1MSBURS
         WpmBGVLJHdi3FyfNe7FODI+gSBxoSXMXCWly1Rxod67fEOdl3EcTp18kRdoxjcYPyTj0
         lgHJOJEfDAJwj+dZWKvlUCJyH6Lb7cmjxV2FDd+465FYsahEdkRCrBnMMpyMjpU1ML27
         r+36K5hJGhqVXC3ZTNX4wNK882Eltv7t5Urw/tz4o+bj8jiaLV4CToFHeSNgbjBj204A
         HnumWyN1YMRlnecPVfVgNiX8Uv5d910Gxc474O9olrJRkocH9RuB9pxc5OBUTbAOhDI1
         G2ig==
X-Forwarded-Encrypted: i=1; AJvYcCWjTbR7x/15W8QKayz33G8ne7UHeGcMbVNvxehtlgSwBwOzkyrHn/DDXJixHriD9wF/G+ScZa1LGCyKo92THIxujweJn/82N99+QS+8
X-Gm-Message-State: AOJu0YxMHYXYpU4cGbX8fO1fDd0cjDLKhGaYVb4nz2X9xEbUgLeN5vu8
	wANSk9aLjjSUvEripBueWAcR2keguWWR/SNrfme51qfprESVWbSyxq7pHYGFNNo=
X-Google-Smtp-Source: AGHT+IH0oPElznCzJ/jpEziWktDvEKVRFnAvY3Tg4+M7CP8dueNqK+noAm16Y9DcDszdGotJJgzksQ==
X-Received: by 2002:a05:6a20:12ca:b0:1aa:5e75:d31f with SMTP id v10-20020a056a2012ca00b001aa5e75d31fmr11670237pzg.16.1714341395841;
        Sun, 28 Apr 2024 14:56:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id j28-20020a63fc1c000000b005e83b3ce8d9sm17921446pgi.8.2024.04.28.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 14:56:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1CVb-00EKqc-28;
	Mon, 29 Apr 2024 07:56:31 +1000
Date: Mon, 29 Apr 2024 07:56:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+4a799ff34dbbb5465776@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_qm_flush_one
Message-ID: <Zi7GDznXWDsW4CsH@dread.disaster.area>
References: <000000000000fbf10e06164f3695@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fbf10e06164f3695@google.com>

On Wed, Apr 17, 2024 at 11:42:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a4a1dd180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a799ff34dbbb5465776
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xfs_ilock_data_map_shared

-- 
Dave Chinner
david@fromorbit.com

