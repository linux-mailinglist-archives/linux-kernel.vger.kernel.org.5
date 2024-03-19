Return-Path: <linux-kernel+bounces-107691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FE880041
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF851B20F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340BB657D9;
	Tue, 19 Mar 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DizG0a9m"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337C657C7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860944; cv=none; b=b8ulvYsiw4s0BJaV5lnFhUoWRoBiqVb61xQFdto3UFaB1VEb+xcr6O4IqpgCC4zWOWbYXtKZiLt5RoSlRrIuuUx23ian8GtZkTevrBHUGsuo29DJ7Lb/bA/8lX2NLaQpp0Nc7X0o2QXQACyOafdq0+hO5vxkemk9SQv/VY40Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860944; c=relaxed/simple;
	bh=AduthGbtQ503NWc/iPovz6pKbBm8npo69sGP7oQmalc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQcZbEU84hjCDfWLCnSr2oXqeHD1l0EwL3lAS/YkNwt+nPe0+OfttFU6WqDp4cNEmO5kwSZC+S0yyhmxtIpczi1wctaSby13IVEXQf5GNwsECQYp04TfN1xXIkXSDtqwLr0M92Sv4zEG/Baknp3L37El3jNNr1XUN9Jm1MECxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DizG0a9m; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so254656a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710860940; x=1711465740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vVW1HzP6IOcVuRYdPUYojDY6rzYnYjkQOqlmjORT00=;
        b=DizG0a9mRs2JYkrg7/n/6oZ7h0KsYJtZDVNmIjG1y2muDmfjm69wWeqfGQKECndFay
         mDqR5a6vgZGdr3cr1FLB3ONUqH2ct1wP3xtZB+F0CkEDhOW1ioLOYyNZ5NAvmMab7e+7
         YnFjgAim086t6DnN7ApNjZpXiaJmkc/JYtocW5VjhxulmuNPTNB1XkvO+I2jMjVejeXc
         HFBt7UuXEwoHVeheGPaFRXP4+CQJVtliiGRM5zbBG3a3j8ovy/lcqTWGkLfyPSDrMnAm
         iox0tVRbms2FEL2dseEslYJjTRyup3aYJNfhG8Q7q3PAM2iUJPWKnvKAElejpV4t/Xsh
         HUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860940; x=1711465740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vVW1HzP6IOcVuRYdPUYojDY6rzYnYjkQOqlmjORT00=;
        b=Apz6vRM45zk90D0BJQZiaRuUOIBE4ZC8SAQO7JGtDoKXx5U7qc9ULx3rHKq8GrgYTr
         WksGMgxtp/O44eN1ZowRg8qzeykId3rVLeGlKxR/F3u9Bpps3Y8A9a3ljFTIlOQVHRUf
         b2Yv8flnxdBAcGIPpHANgLvmoxhjrvRIHu7zaSRMM+WU4LrEZhm7Wz5l1Rjq3RHN76UU
         mlqtde/OfGb03dgjXYZgietIU7elTWFBVCvomB1bfGp/ZaWWaJnAZdXEGhxHv5eyY/TB
         40DWbv5XBh1kMJQtUsusGn+Z50yUjE3qUHTSrspuANCTlPsv4Kw0e4zrkoVMEAJGedYx
         OGaw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkvyR/O/a/87cYlyMh56LtLAqNp7EKeJ3NoBc1eNmIf8BraG0s3Z64dZqsZUE9VtwLSckMpOrZgtlP09DBLxfsaxGbohVJ3fSE/hI
X-Gm-Message-State: AOJu0YxHly343B4cQPcdR5dJdiMzoGbbgrK9AM/FuiOrgy6qvPXfZ7T6
	YZrg8r+YYxnMpFLvL9ULsyzcykBZrYoG0mI46nJ3hkBSik7i36fDToaONgi8qkxp1Ev4tnLs02z
	M
X-Google-Smtp-Source: AGHT+IEU4aA3OJtwbmANEftZa3Y1K8Y1Av3UtRZT7xLYjrH5u09EsLG01f4jd+nbMYggdaVPSMdzDg==
X-Received: by 2002:a17:906:3105:b0:a46:13a9:b78e with SMTP id 5-20020a170906310500b00a4613a9b78emr10602241ejx.2.1710860940584;
        Tue, 19 Mar 2024 08:09:00 -0700 (PDT)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906344f00b00a46e07cd1fcsm809541ejb.133.2024.03.19.08.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 08:09:00 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:08:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Down <chris@chrisdown.name>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/4] printk_index: Fix false positives
Message-ID: <ZfmqihpAyrhPn-7P@alley>
References: <cover.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>

On Wed 2024-02-28 15:00:01, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> When printk-indexing is enabled, each printk() invocation emits a
> pi_entry structure, containing the format string and other information
> related to its location in the kernel sources.  This is even true when
> the printk() is protected by an always-false check, as is typically the
> case for debug messages: while the actual code to print the message is
> optimized out by the compiler, the pi_entry structure is still emitted.
> Hence when debugging is disabled, this leads to the inclusion in the
> index of lots of printk formats that cannot be emitted by the current
> kernel.
> 
> This series fixes that for the common debug helpers under include/.
> It reduces the size of an arm64 defconfig kernel with
> CONFIG_PRINTK_INDEX=y by ca. 1.5 MiB, or 28% of the overhead of
> enabling CONFIG_PRINTK_INDEX=y.
> 
> Notes:
>   - netdev_(v)dbg() and netif_(v)dbg() are not affected, as
>     net{dev,if}_printk() do not implement printk-indexing, except
>     for the single global internal instance of __netdev_printk().
>   - This series fixes only debug code in global header files under
>     include/.  There are more cases to fix in subsystem-specific header
>     files and in sources files.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (4):
>   printk: Let no_printk() use _printk()
>   dev_printk: Add and use dev_no_printk()
>   dyndbg: Use *no_printk() helpers
>   ceph: Use no_printk() helper
> 
>  include/linux/ceph/ceph_debug.h | 18 +++++++-----------
>  include/linux/dev_printk.h      | 25 +++++++++++++------------
>  include/linux/dynamic_debug.h   |  4 ++--
>  include/linux/printk.h          |  2 +-
>  4 files changed, 23 insertions(+), 26 deletions(-)

The whole series looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going take it via printk tree for 6.10.

I am sorry that I haven't looked at it in time before the merge
window for 6.9. I have been snowed under various tasks. The changes
are not complicated. But they also are not critical to be pushed
an expedite way.

Best Regards,
Petr

