Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380447D81F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344794AbjJZLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:41:14 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4931A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:41:11 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 006d021491bc7-5842a7fdc61so422834eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698320471; x=1698925271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLNTg7ehEKZxV7vTljjTdg5VnMvDILeA+3MbDYFCwn8=;
        b=HX7GD8YLpE5+RcSlxTiBtpjX6Juw6o0eALTUekN7BMeTBIpTC5i/M3/+uNgLzbxGbS
         QydA6RpxTYoBD//ELUrrpEIfxhM7eaInQCFwmKMeEwdDT07VhLlgRT5wkX8dfuwtJAE5
         6zkoYZ6j7+edo3jo077zRkrSwOjfl9NrcKEQJRh5IoM+voqMIdpmfaOMxF7f5sIq4biJ
         ThF8k3YRNgJvlaYIozBaBIsZukLldVnevIr41Sla/YaB/BEYpF869ubJ0rETQv7lnotM
         yJT8TXZ5hZS3V1+oDrpZfaphfwX7DBORRcrNsBnGd5ATB+4j6yQv291m41MRM3PiX4Ih
         NbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320471; x=1698925271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLNTg7ehEKZxV7vTljjTdg5VnMvDILeA+3MbDYFCwn8=;
        b=titU9AiqRgg7L8EDyIm1gytQS8rrO6I2jaHt1kPrWwqkbNqc/rOvBhr0fdIetGPZvv
         l2qaUGhy9w/on/QeIC1GX9V2sZ/HMuyobCEqX/+WSHCNoY3uob6+vfGJAlf3VivFqiZv
         9J/volx3WCNX2fk3ptxazzxaFPQK3toQy2ttOKfz3ckFBpR19WvnpbcClotsRJdIrdCS
         KRBQpFyZON9c6271EDMJGfD8/8zLxeYpJbss7cZ5RyXGy+9xpSflXHYCGvkJM71rs5fN
         TRFOAhr2902xjlg2RNmO5JmLQqJaA2QunY7FnztcinGXHzYAwkjoO7aIyetFoDedti3M
         eIKw==
X-Gm-Message-State: AOJu0YyUXEYuQr05G0+Dl44te4zZub7Vxsk8j4NhEvaQN6d6wJOpWUw7
        SQ88o4O4xn6AAES37IlYm9Gnbw==
X-Google-Smtp-Source: AGHT+IHWMB/ksANaifdTpLAGghTDYRn/7xMWVD082ShcgmYVOdJbdiat4/OU3rVqHMdqUxHA9VxDZA==
X-Received: by 2002:a4a:8515:0:b0:583:fc94:c3f3 with SMTP id k21-20020a4a8515000000b00583fc94c3f3mr17207199ooh.9.1698320470873;
        Thu, 26 Oct 2023 04:41:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a01c1000000b005813f95e695sm448856oor.41.2023.10.26.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 04:41:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qvyjc-004zhX-Sz;
        Thu, 26 Oct 2023 08:41:08 -0300
Date:   Thu, 26 Oct 2023 08:41:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in
 iommufd_ioas_iova_ranges
Message-ID: <20231026114108.GS691768@ziepe.ca>
References: <000000000000d621b406088a2f55@google.com>
 <20231026110502.2046-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026110502.2046-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:05:02PM +0800, Hillf Danton wrote:
> On Wed, 25 Oct 2023 15:32:20 -0300 Jason Gunthorpe <jgg@ziepe.ca>
> > On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> > > Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372
> > 
> > Oh *ugh* I knew about this limitation once and forgot about it
> > apparently.
> > 
> >   CPU 0         CPU1
> >  down_read()
> >  up_read()
> >                 down_write()
> >                 up_write()
> > 		kfree()
> >  [..]
> >   tail portion of up_read()
> > 
> > I suppose the rwsem should be turned into a refcount and completion
>
> The line [1] syzbot caught is before preempt is disabled, 

So? It is SMP.

> so no lock is released yet, and the report is a simple uaf with
> nothing to do with down_write().

down_write() is one of the concurrent paths toward kfree.

        tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
         ^^^^ This allows the down_write to proceed to kfree

	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
		      RWSEM_FLAG_WAITERS)) {
		clear_nonspinnable(sem);
		rwsem_wake(sem);
	}

And so if we are unlucky we can UAF someplace in this latter part.

Actually, this is a problem but it is not this problem since the sybot
traces don't show it going down the down_write side

I guess this is still just problems with the iommufd_object_remove,
since put is ordered 

	refcount_dec(&obj->users);
	up_read(&obj->destroy_rwsem);

And remove doesn't touch the destroy_rwsem so it simple UAFs anywhere
in up_read and that matches the syzcaller trace of concurrent destroy

Jason
