Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3017D1832
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJTVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJTVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:34:09 -0400
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340710C8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:33:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4C2FBC1F4F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 21:33:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0E3C8C0183
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 21:33:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697837623; a=rsa-sha256;
        cv=none;
        b=ct4ZZjc0Tx3LsEGXxhCGKeIc0s9Rn6I5mutTKpMlvZoGRzyB09mrFt6zIG/UNmA/hGi2iy
        hfABJYXY3+GJyy4XU6pZ8tM0YSejFiCSA0Tfb+l0VQUuEdCaM3hmuVeFPV/sBrMISNg2hB
        TLV8YjalSQOsFbTr1zMU+k1t1Rv8bqJQHQdqx05UC85Jcc2/HDe4FeeU/UGtr8eZgPr2ak
        MhZAgfj4rhMPlEegVSZ3ENf9cujVqIiFxk8D0uHbaBy9CftF0E9ZCCJFvY+1MauhKAyl2D
        dZKvOii4cvVTU7WZBuDw6rIU30DrpZXIg2TKynHVVYtAqUDh9vXEXT8XP0ZTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697837623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=tAOkwi0YuJDJdJg4hvrE80c/LLCeFBLsZA85g0a3bLA=;
        b=SRujAP9vadYdq7MgyZayfUP64FwN0oN9IVpm26KVpb9tfDaSD8kqeypaNGb4UE86mBYihl
        7yD1+yFh2kHGb12V+MoxUdITcCDqdEE7BlhfW02xxN3/NZrSLj5cI5ZJZhJ5oGPDnyvMtI
        oyhj8WLtFzHzlI548d9Dg1nmZxLjzRliWchFcZPZnOaGdDR/kvs4eFXeZllvqy5l5h6OBv
        8UAe01jvbbYgFm6BwI2YKbxn6BRgOd2ifc0Rt20plkN/bzvExnRY0Ub+qZ69+99TKvaFkM
        5lvbm9YGIIeKSQiifJ8HkjtezzKhK0a0FKBchjVOQQei6lwVbhifxcjqvLnSTQ==
ARC-Authentication-Results: i=1;
        rspamd-846f4b758b-sm9qj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Turn-Bottle: 79efae1560261831_1697837623136_1612333314
X-MC-Loop-Signature: 1697837623136:4101853044
X-MC-Ingress-Time: 1697837623136
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.117.92.249 (trex/6.9.2);
        Fri, 20 Oct 2023 21:33:43 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SByWV27q5zLZ
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1697837622;
        bh=tAOkwi0YuJDJdJg4hvrE80c/LLCeFBLsZA85g0a3bLA=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=OVTFOlQsgFzLIiYCpoMztlhv5iEGoTEcT7Lt7DWIRHnOU8uD2iWm04tPLH/OzVvCN
         izKzWEFvYdGenUkwdWKLqGhEIj6IqbY7RoEacAruLnnDD1JKIEP4MHkTLyjiIujg5t
         nttA6wTOM2WNnPo9r7DU8J3cKRKhlbiaUoPomPUciNUkofYm3eupQRP/gFCGp+bvg4
         ia6cFCvZNhaZgsAEeJbEG2WxTqC41zJ9bJrumYGd90NNKcyeoqDPF73jnj6nYtmFyO
         VMqetFb2pN1Lmdh06k+6x03loxDU5GU6eiA4zTIULqvK8WS5PWynuHi3xzmW+hT4Uf
         Gm8RAD+ulz4kA==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 20 Oct 2023 14:33:37 -0700
Date:   Fri, 20 Oct 2023 14:33:37 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [PATCH v3] fuse: share lookup state between submount and its
 parent
Message-ID: <20231020213337.GA2113@templeofstupid.com>
References: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
 <20231018013359.GB3902@templeofstupid.com>
 <CAOssrKdH5x7YAnK4P8+5O8V934XtbH9JBSvctyM-pSmDMCq8yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKdH5x7YAnK4P8+5O8V934XtbH9JBSvctyM-pSmDMCq8yQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,
Thanks for all the feedback. I've made all the changes you requested and
was pleased to find that this reduced the overall size of the patch.

On Thu, Oct 19, 2023 at 02:39:34PM +0200, Miklos Szeredi wrote:
> On Wed, Oct 18, 2023 at 3:34 AM Krister Johansen
> <kjlx@templeofstupid.com> wrote:
> >
> > Fuse submounts do not perform a lookup for the nodeid that they inherit
> > from their parent.  Instead, the code decrements the nlookup on the
> > submount's fuse_inode when it is instantiated, and no forget is
> > performed when a submount root is evicted.
> >
> > Trouble arises when the submount's parent is evicted despite the
> > submount itself being in use.  In this author's case, the submount was
> > in a container and deatched from the initial mount namespace via a
> > MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
> > inode from the parent was evicted, which triggered enough forgets to
> > render the submount's nodeid invalid.
> >
> > Since submounts should still function, even if their parent goes away,
> > solve this problem by sharing refcounted state between the parent and
> > its submount.  When all of the references on this shared state reach
> > zero, it's safe to forget the final lookup of the fuse nodeid.
> >
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
> > ---
> >  fs/fuse/fuse_i.h | 20 +++++++++++
> >  fs/fuse/inode.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 105 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 405252bb51f2..0d1659c5016b 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -63,6 +63,24 @@ struct fuse_forget_link {
> >         struct fuse_forget_link *next;
> >  };
> >
> > +/* Submount lookup tracking */
> > +struct fuse_submount_lookup {
> > +       /** Refcount */
> > +       refcount_t count;
> > +
> > +       /** Unique ID, which identifies the inode between userspace
> > +        * and kernel */
> > +       u64 nodeid;
> > +
> > +       /** Number of lookups on this inode */
> > +       u64 nlookup;
> 
> sl->nlookup will always be one.  So that can just be implicit and this
> field can just go away.
> 
> > +
> > +       /** The request used for sending the FORGET message */
> > +       struct fuse_forget_link *forget;
> > +
> > +       struct rcu_head rcu;
> 
> RCU would be needed if any fields could be accessed from RCU protected
> code.  But AFAICS there's no such access, so this shouldn't be needed.
>   Am I missing something?

No, you're correct and not missing anything.  I've cleaned this up.

Thanks again,

-K
