Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72557A9036
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjIUAi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIUAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:38:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E0D7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:38:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c364fb8a4cso3416765ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695256701; x=1695861501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMd1KRyDEvQHJgfGmaNgihRzYBqmhVKvC+CzE4oWItk=;
        b=FFpSRnPATnEb/+Y1pQyexh9atCnUu9eFdC9bx7xhJXmn34X+fXRiwfk67BClML5skb
         jSE+U7TNaVrstBvFacVrq/KOmh0FRK4vlu9xy/To+FJibmqcRXl58xfOJad2sRfWdAag
         ZCg8ixFC7MwLv1OzA8ZzsFJfw4JHnoawAAv5pXvI5UdUTWpKH3XpcPT08s5HPE0IxTP0
         SeCxVKGdOC9rlBlLbPZxqpwHImq4kI5caSPv+gVZhvkQPsSNhFhTn6M3nMsyQSrBCBal
         uA/z3rs86C5hpaYcszxHChDgv4tCx6OWt0cjilG7Y8Opn0Q9vkyMQrtoPsM6wvJxGNG4
         0i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695256701; x=1695861501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMd1KRyDEvQHJgfGmaNgihRzYBqmhVKvC+CzE4oWItk=;
        b=Ty75oRXos2vFEMlXp2ryOoD7W5Am/5dI9KXxu963hmDJIQs6elKXL+k/5NIamjpUH7
         TVnAxrdTqYHJ0yWOaSw3+zLbjbMjUnPwFk2VdPlL5Wc7pteJrsJjQWIEk9J1UJuOZQWu
         unwmgfxd/zS4/ljDcX8yIXZcTekdDU/CfQj1B4pgThdguZ/4GFFCQIqQvlypOVCl4VpY
         Mk66vdtomsoN3qKMLT77/qp+tXAu9teY/QHmv5GyFOWrpteDW1+X/XxlhPxNVch8yL8a
         1ALx77A0Wr8sE8pTwKFDJxNHzme7XYCVLsk2SeGCx1DILSmNezvSkQCJE7RI4vL35i/Z
         lGNQ==
X-Gm-Message-State: AOJu0YziGZ8AXAQuP8sifXgGnCXlS5OjdxOiO8L4iRpWBF0orv0F1dc5
        QThkNa1N12U6hHT9xJsF7RmhUg==
X-Google-Smtp-Source: AGHT+IEzLBFMk3kEDzcaTGMq6sgJhldRQhr+5QWyOipuNTfWB8uF3/9WdBQ08yQlD0BAeEqi8ebKKg==
X-Received: by 2002:a17:903:228b:b0:1bb:e71f:793c with SMTP id b11-20020a170903228b00b001bbe71f793cmr4666954plh.44.1695256700664;
        Wed, 20 Sep 2023 17:38:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001bd41b70b65sm111056plb.49.2023.09.20.17.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 17:38:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qj7hx-003RjF-0J;
        Thu, 21 Sep 2023 10:38:17 +1000
Date:   Thu, 21 Sep 2023 10:38:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
Message-ID: <ZQuQeWm3UIn31ciq@dread.disaster.area>
References: <000000000000e534bb0604959011@google.com>
 <ZPeaH+K75a0nIyBk@dread.disaster.area>
 <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
 <20230908082846.GB9560@lst.de>
 <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:56:56AM +0200, Aleksandr Nogikh wrote:
> # set subsystems: iomap

No. As I said when I originally reassigned this from XFS to the
block subsystem, this is a regression caused by changes to the block
device code. Just because that overall change was to use iomap for
block devices, that doesn't make it an iomap regression or the
responsibility of XFS or iomap maintainers to triage and fix this
block device regression.

> On Fri, Sep 8, 2023 at 10:28 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> > >
> > > The reason why syzbot marked this report as xfs is that, per
> > > MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> > > adjust the rules syzbot uses so that these are routed to "block".
> > >
> > > But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> > > LIBRARY with xfs in this case?
> >
> > I'd tag it with iomap, as it's a different subsystem just sharing
> > the mailing list.  We also have iommu@lists.linux.dev for both the
> > iommu and dma-mapping subsystems as a similar example.
> >
> > But what's also important for issues like this is that often the
> > called library code (in this case iomap) if often not, or only
> > partially at fault.  So capturing the calling context (in this
> > case block) might also be useful.

Which is exactly what Christoph also said.

Please don't conflate a discussion about the incorrect assignment
by syzbot (i.e. associating iomap with XFS because of a shared
mailing list) with the actual problem that was initially reported.

So, set this back to the block subsystem where it actually belongs.

#syz set subsystems: block

-Dave
-- 
Dave Chinner
david@fromorbit.com
