Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0C7F969C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKZXo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E104E10F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701042273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXjCU1JMw8WXLHo5e8MuCVi+8FCFwFKjN2ELDKbyjzQ=;
        b=aA66b//26DyQWeNpuepywbpD7+A3DI3aMHgYh1HrnHSwoaVareB0/N6+9nOsc9gfKox4VY
        0lm5FgjhaNMXQmuP68blYnVFtRT3YcCn7SsAlBOnAww8dMFGaUz32GpwBWrkiOGYzfFZB2
        I1/oPpvcHBAsTqOyuihmNpmd22vNn1g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-LqD3yBzGPx2fdXQpWo1BRw-1; Sun,
 26 Nov 2023 18:44:27 -0500
X-MC-Unique: LqD3yBzGPx2fdXQpWo1BRw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A2938062A5;
        Sun, 26 Nov 2023 23:44:27 +0000 (UTC)
Received: from localhost (unknown [10.22.16.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5770A492BE7;
        Sun, 26 Nov 2023 23:44:26 +0000 (UTC)
Date:   Sun, 26 Nov 2023 20:44:25 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.201-rt98
Message-ID: <ZWPYWRyjRA5sjvdV@uudg.org>
References: <ZV1S4yDcPKwj5_N1@uudg.org>
 <ZV4D1yBGSOE-OVUF@uudg.org>
 <2023112455-anytime-unmapped-ed7d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112455-anytime-unmapped-ed7d@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:11:35PM +0000, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2023 at 10:36:23AM -0300, Luis Claudio R. Goncalves wrote:
> > On Tue, Nov 21, 2023 at 10:01:25PM -0300, Luis Claudio R. Goncalves wrote:
> > > Hello RT-list!
> > > 
> > > I'm pleased to announce the 5.10.201-rt98 stable release.
> > > 
> > > This release is just an update to the new stable 5.10.201
> > > version and no RT changes have been made.
> > > 
> > > You can get this release via the git tree at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > > 
> > >   branch: v5.10-rt
> > >   Head SHA1: 3a93f0a0d49dd0db4c6876ca9a7369350e64320e
> > 
> > Greg KH,
> > 
> > While testing v5.10.201-rt98 I stumbled over this warning:
> > 
> >     [ 1000.312397] run blktests nvme/005 at 2023-11-21 21:46:30
> >     ...
> >     [ 1000.500478] workqueue: WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp] is flushing !WQ_MEM_RECLAIM events:0x0
> >     [ 1000.500490] WARNING: CPU: 0 PID: 6 at kernel/workqueue.c:2620 check_flush_dependency+0x11f/0x140
> > 
> > That seems to be fixed by:
> > 
> >     533d2e8b4d5e4 nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
> >         (and depending on what else is backported)
> >         ddd2b8de9f85b nvmet: fix workqueue MEM_RECLAIM flushing dependency
> > 
> > Is this something that can be added to your v5.10 queue or should I carry
> > this fix on v5.10-rt in the meantime?
> 
> That's odd, as this commit is already in the 5.10.138 release, so how
> can we apply it again?

I am really sorry for the confusion on my side. Either myself of the CI I used
mixed up the test branches and ended up using older code. And I missed that
when reviewing the results.
 
> confused,

Sorry again. I owe you a (root?) beer next LPC.

> greg k-h

Best regards,
Luis

