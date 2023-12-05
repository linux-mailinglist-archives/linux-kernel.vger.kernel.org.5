Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE76804A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjLEG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjLEG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:27:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1AE116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:27:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d045097b4cso21892715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701757651; x=1702362451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhXYhRtk/KY/XHQgM/c3wDRTe8PmVUkWLPFRhdkev5c=;
        b=VDe5+ovG8apuH9dXqs7gsMH9oPS5VeZljXRRqfAjOh2gxR7byrpmJBz8ho6pfbKHwj
         qOQueLGVaKVco4VFZRtCC3urwX7rrqenY+YpYgYxCLlpClPkSJH0xmSYE3BeRS9oLQuk
         rL6H1uJbzrwFyzUTAfBYsQvJZxkBcjymMIx5M/QYqN1BOvG9AEOiADt3hAIdSJY+5yHb
         uxk8ARsAojkzwMwWN+ZbGr9H+HSetccLBaaK5uXCR5bONn87bPUp4cFUc7fjI+EVf4uL
         of3qfum9sd2ESOS3hGv6ksMK4/wPitekuefp+H7TRUs/GZsktGX+ozYqhed46pnSZjiE
         zGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701757651; x=1702362451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhXYhRtk/KY/XHQgM/c3wDRTe8PmVUkWLPFRhdkev5c=;
        b=TUe+BdrFSK0PL0lYsaE84iRJW+bVjoZZ3ruhcooo9t4wvlcMH4uelkuLbyNP30saf0
         xni7oSr+UK/oHX92G1sj0eGUNC7uCRr3xadRj5/b7GlzYGDGpUxhCHNA5IVtGh9mlgVZ
         TLyVkOe0AsZjgBloQBcSJ2KX4//f6L4ZOiCMIY1YR9p3xuzXcZ21v3TEfKo4GBZYbUyP
         GOmqgVFyWhYKc/HgjOiOexvgFK607ShYkBkOF5VniuJJVVXwucg023p+PkJq2PS4OJL1
         a7f60LPd1g82yUylMwAkoUubup5kApwcjEtLZC/pwXqYe/XaqeA+CxKWmkXYSNglXpXV
         lulA==
X-Gm-Message-State: AOJu0YymSm5NracKepxrZcPN9xWIpRxJOk+3BUIyCEaGQRICawltZDfc
        L2IjqjAq/7BCR0P8o9A53ymt1Q==
X-Google-Smtp-Source: AGHT+IEUis2isZKyvLiufA2OSYo4xSVBLvpOU4Mj0HrgxtGTqwJ5IEKmqVKYaMx9UVf4tDFqmIy5mw==
X-Received: by 2002:a17:902:c40d:b0:1cf:6ac3:81c2 with SMTP id k13-20020a170902c40d00b001cf6ac381c2mr3414170plk.47.1701757651517;
        Mon, 04 Dec 2023 22:27:31 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001d087f68ef8sm543248plk.37.2023.12.04.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 22:27:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAOu0-00449x-2P;
        Tue, 05 Dec 2023 17:27:28 +1100
Date:   Tue, 5 Dec 2023 17:27:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZW7C0Cq+WZz+fnaS@dread.disaster.area>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <20231204024031.GV38156@ZenIV>
 <170172483155.7109.15983228851050210918@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170172483155.7109.15983228851050210918@noble.neil.brown.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:20:31AM +1100, NeilBrown wrote:
> On Mon, 04 Dec 2023, Al Viro wrote:
> > On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > 
> > > This means that any cost for doing the work is not imposed on the kernel
> > > thread, and importantly excessive amounts of work cannot apply
> > > back-pressure to reduce the amount of new work queued.
> > 
> > It also means that a stuck ->release() won't end up with stuck
> > kernel thread...
> 
> Is a stuck kernel thread any worse than a stuck user-space thread?
> 
> > 
> > > earlier than would be ideal.  When __dput (from the workqueue) calls
> > 
> > WTF is that __dput thing?  __fput, perhaps?
> 
> Either __fput or dput :-)
> ->release isn't the problem that I am seeing.
> The call trace that I see causing problems is
> __fput -> dput -> dentry_kill -> destroy_inode -> xfs_fs_destroy_inode

What problem, exactly, are you having with xfs_fs_destroy_inode()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
