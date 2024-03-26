Return-Path: <linux-kernel+bounces-119350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234B88C775
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD1232069D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1AD13D276;
	Tue, 26 Mar 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FU+gkBTH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5013C8E9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467395; cv=none; b=P95G5+pTCCVD+HSGHWeba6Ks68lerNQB9G+Tl89bLuNqcfXP3HXgAHf4VlBHKM5yGi5sSR/ryMFqgt83DoRAlzwAkqQPaMLmCrMlSi4AVC98F6sL9E2+CKvXipxP/vI0E0x+7783NEHYnUuZBHeGZARQ9Rz+H4cyTbqy/I0mdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467395; c=relaxed/simple;
	bh=ed5+VWC5wvky3Uqb83H3Ghri5kxsYjWy0B0ksNy+wDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efe0Aj01GVBTVv+4m5D3TXrZFgWtqVv80lkYrjCU0s/Oez95aecibGWZO1Cr/pi/O6tMWnLozSI3lXIcjZ1p2+wlgRD/lUO/c01snoSEznwqdUjwR7Lc7nQkcMDAd4cAx3uBUUDtj1PWVkfyXryBdEbXU/zYGvahOD6s1iIJ7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FU+gkBTH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c36c67deaso80840a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711467392; x=1712072192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePvCs1Z2FnylYkus0K9OBiNjZtXP+dPS6SCXTC+sxh0=;
        b=FU+gkBTHWtsCc+5ypB6wGMTlbF2G+LhlEQovlfiqh3LUu9qTbN6TG4l2SA/YKmrZ3+
         clwZBolzmhdNEyYW/Dn/rtgdlOZ6X+6urxg8XdduiKKupYlx0w9F0xdLyCYuAP4rrUrW
         06Gi/oz4v7k7RAJw1D0zlsqK1M9ClFRMdUxam/RqObJnSPbMCxTrbLVXP77QkyGCi07A
         TsqZwHJW2uamn7Bs3bXNb0MHGlEpBaPixQb7JgSzdtHLJxczqoxo1AXRylkGerc6c7YN
         fVjD2GxYSpJWYoSZzWGAOzOr2EodY/Eo60ZhC7/+GcKnp/a+aMGl9mxXC887KcL2c3H1
         qB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467392; x=1712072192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePvCs1Z2FnylYkus0K9OBiNjZtXP+dPS6SCXTC+sxh0=;
        b=ZfyIOy4klTeCXdXIXdquVbjWu1InBJmoHwXkPEPN1h5H9XVqRd2MV49YQ5P4gHXbDv
         PbhAaQV1Z3+wW6GCnSRT70GkPkzy0521R8z6tZO584tlDcjwOsO7E/XGoS0ivDUftYLS
         Ob8P9QA4fZlXFoUa2exHpy/QH40cOJXFzghANlCr0bfe7IGYNkcIlKOUBYMtZHFMO1z6
         YZ8+o4CMANAlbveWTkmmGdwxSyBWi7RrBKUwNZdmLcyj+Wp407md4ep21Pgt2yGRG3ZH
         /1vNbn4YxvjZ+jE/T9X6DQs+16cD3m4PESVvP1juhVHP5qf5EUEoaFrKZrp5cMhVMXj/
         5Ygw==
X-Forwarded-Encrypted: i=1; AJvYcCVg8+Lwh3edYuui8u1fD9t5pV9pdeACk3E1tDdB5v0C8gvjK0FuhRCtD7V5Avo+uxK9LGfcoRw1kScB2R5Wcoa3bdaFX8ho9hfLmppD
X-Gm-Message-State: AOJu0YyCDpa9VkPl6t4Jr8+J693PjR9kOXrXqtgiRiCi14k6q0bJvtM2
	Rx5Kk5KmWd+lyhzGnldAB5LjfwnvgKojdWV/JNCJHG6gncfqBvpltZJzBLIYwQM=
X-Google-Smtp-Source: AGHT+IHbh4n/1ZdaSBVSm9HNyyXwDDnWrgPGbIJ/GpeK7xfXhmqR2KKND9oQ7Es7phpkmhR9Fv08yg==
X-Received: by 2002:a17:906:128d:b0:a47:11a9:9038 with SMTP id k13-20020a170906128d00b00a4711a99038mr7617158ejb.58.1711467392013;
        Tue, 26 Mar 2024 08:36:32 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906b09400b00a469e55767dsm4330686ejy.214.2024.03.26.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:36:31 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:36:30 +0100
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
Message-ID: <ZgLrfvRD63aB3gMT@alley>
References: <cover.1709127473.git.geert+renesas@glider.be>
 <ZfmqihpAyrhPn-7P@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfmqihpAyrhPn-7P@alley>

On Tue 2024-03-19 16:09:01, Petr Mladek wrote:
> On Wed 2024-02-28 15:00:01, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > When printk-indexing is enabled, each printk() invocation emits a
> > pi_entry structure, containing the format string and other information
> > related to its location in the kernel sources.  This is even true when
> > the printk() is protected by an always-false check, as is typically the
> > case for debug messages: while the actual code to print the message is
> > optimized out by the compiler, the pi_entry structure is still emitted.
> > Hence when debugging is disabled, this leads to the inclusion in the
> > index of lots of printk formats that cannot be emitted by the current
> > kernel.
> > 
> > This series fixes that for the common debug helpers under include/.
> > It reduces the size of an arm64 defconfig kernel with
> > CONFIG_PRINTK_INDEX=y by ca. 1.5 MiB, or 28% of the overhead of
> > enabling CONFIG_PRINTK_INDEX=y.
> > 
> > Notes:
> >   - netdev_(v)dbg() and netif_(v)dbg() are not affected, as
> >     net{dev,if}_printk() do not implement printk-indexing, except
> >     for the single global internal instance of __netdev_printk().
> >   - This series fixes only debug code in global header files under
> >     include/.  There are more cases to fix in subsystem-specific header
> >     files and in sources files.
> > 
> > Thanks for your comments!
> > 
> > Geert Uytterhoeven (4):
> >   printk: Let no_printk() use _printk()
> >   dev_printk: Add and use dev_no_printk()
> >   dyndbg: Use *no_printk() helpers
> >   ceph: Use no_printk() helper
> > 
> >  include/linux/ceph/ceph_debug.h | 18 +++++++-----------
> >  include/linux/dev_printk.h      | 25 +++++++++++++------------
> >  include/linux/dynamic_debug.h   |  4 ++--
> >  include/linux/printk.h          |  2 +-
> >  4 files changed, 23 insertions(+), 26 deletions(-)
> 
> The whole series looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going take it via printk tree for 6.10.

JFYI, the patchset has been committed into printk/linux.git, branch
for-6.10.

Best Regards,
Petr

