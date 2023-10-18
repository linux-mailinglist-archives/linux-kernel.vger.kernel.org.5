Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78EF7CD1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbjJRBeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjJRBeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:34:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCDF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:33:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5569580735
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:33:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E4B118091C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:33:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697592838; a=rsa-sha256;
        cv=none;
        b=gYPCKFq8gfIxGk7TyyONSkTiSrbS7bNpnoEXFpiW8MKWLOCR0C06E5pPyfidDhQvKnVkVV
        yTFrST90EklP9PuvSCmX5nI95Ls5YNnwB+C+jRE4sx0ssqzRBmk5yifwJ5/0S2GL4DFTS7
        mD8KJs3BSli0aM2ORKY0rBuFJEv+WDCADSXPBmA8fsGMY/iZjqI9ZWctUQpzdb37aXxL+T
        3bw70fpPYeW3Wqpi+6wSNa5O5TcEcMsNCIA4b9UDzymjv1EGuZL9am8uqxwXMaLJqWgFRE
        Lffc1PHNI/Vxu6Ic1ZW6FtN7Nkkunq1u+D1XOBL3zBCLTVSeEBqffrbIZiNfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697592838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vd0Xck8mcg9xcRF5wt8r7Tn5ey7m1v7me2mhfXHihEs=;
        b=YfbgIp85nuiONoXGnaiGC/5C1b87/qjETvvhYCAEpNcYsGRrmrAawbVFocKs9LMqXPcy4I
        ze3JV9CZszl0VcCN2oCZjc9i1T1MQV+B/o+Df0+TpugzcaMX053rE6vykoTN+CsNt0hf8n
        L9AlkyNk5i30CIHWETIVOLsuhfRu5/Y1VnL7B5/1klcwQ9HAaV6KBc3ybBfMjuMGb7CPqL
        PxnH4SY2TBr7D9MZ7AYmikDx3xR5/ttBlA9LXsC7xxnmS2GAAeNHNXbZHOxHfrIKjgYUp6
        vsunJOz0Ksxud6Hh+X7xoS3tioO8Frt4MgqVZdhaW6tmXe5xrkWsSP1NJ9picQ==
ARC-Authentication-Results: i=1;
        rspamd-555cdc57c9-drd66;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Supply: 15b605de2da126f0_1697592839161_636014578
X-MC-Loop-Signature: 1697592839161:3762437862
X-MC-Ingress-Time: 1697592839161
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.222.52 (trex/6.9.2);
        Wed, 18 Oct 2023 01:33:59 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S9D061FxTzRR
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1697592838;
        bh=vd0Xck8mcg9xcRF5wt8r7Tn5ey7m1v7me2mhfXHihEs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=c64xqLxv+mCCkyi4tQUAc/a30ChapTuCb4kEIISZrT3dh1Br19VxixZNnJaQz8bI/
         KpIhtXF/mnB31iueDtYHXYatfgawJOJmpnHiECStlOVtXicNsUOO6edoXSFLXHYuYZ
         3VYFtkA4ou5HxniLRUoq/4uB40qsi+L3FJoNz31Vfvc77uEM1xsxuk0EnXlvlt/XaC
         t6rpu2GigOAIuXEieGUEZrMWRKWWN6CK9w/Ljy7Tjn9BP0q9DbfDMfhe2tbSTsPBzg
         dwP2tcKSsHNbzK/5RKjAodAm1pzB6fWbL50N8c6up1nvqxJZ3LQeHYEJCo64KsS6jH
         KmTfOyDR1sgTg==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0083
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 17 Oct 2023 18:33:46 -0700
Date:   Tue, 17 Oct 2023 18:33:46 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231018013346.GA3902@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com>
 <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com>
 <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
 <20231011163220.GA1970@templeofstupid.com>
 <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On Wed, Oct 11, 2023 at 08:27:34PM +0200, Miklos Szeredi wrote:
> On Wed, 11 Oct 2023 at 18:32, Krister Johansen <kjlx@templeofstupid.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 09:07:33AM +0200, Miklos Szeredi wrote:
> > > On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:
> > >
> > > > I am curious what you have in mind in order to move this towards a
> > > > proper fix?  I shied away from the approach of stealing a nlookup from
> > > > mp_fi beacuse it wasn't clear that I could always count on the nlookup
> > > > in the parent staying positive.  E.g. I was afraid I was either going to
> > > > not have enough nlookups to move to submounts, or trigger a forget from
> > > > an exiting container that leads to an EBADF from the initial mount
> > > > namespace.
> > >
> > > One idea is to transfer the nlookup to a separately refcounted object
> > > that is referenced from mp_fi as well as all the submounts.
> >
> > That seems possible.  Would the idea be to move all tracking of nlookup
> > to a separate refcounted object for the particular nodeid, or just do
> > this for the first lookup of a submount?
> 
> Just for submounts.  And yes, it should work if the count from the
> first lookup is transferred to this object (fuse_iget()) and
> subsequent counts (fuse_dentry_revalidate()) go to the mountpoint
> inode as usual.  This will result in more than one FORGET in most
> cases, but that's okay.
> 
> > Would you like me to put together a v3 that heads this direction?
> 
> That would be great, thanks.

Thanks for the pointers here.  I started over and followed the approach
that you suggested.  It condensed to a single patch, so I'll send it as
a follow-up to this thread.

-K
