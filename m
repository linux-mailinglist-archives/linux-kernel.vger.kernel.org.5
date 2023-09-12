Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D773C79D443
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjILPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjILPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:04:24 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [IPv6:2001:41d0:203:375::e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE68CC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:04:20 -0700 (PDT)
Date:   Tue, 12 Sep 2023 11:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694531058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KuWSEZptyoIKYbVUjrrCSBbg/IDp1Wjy8rRVOQLAIiA=;
        b=iF7PavcoJP3MP3UoQNX9FjNdKP7hMUnvG7X1LSuSWx/CPKNB+6E53OMTMSn+XXkgRVCN20
        sD9LwtpDktc4HM6hwLc/9kvCBX/2UIMTuVZDJtZJSnZzHlrKbJFQZ59VtpvKfcRVlrpu8V
        YJp+B6pxyf175WZ2P6Bz7LTyc9Z9tjo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Fix a handful of spelling mistakes in
 various messages
Message-ID: <20230912150414.p3fx5ryd77e2ju43@moria.home.lan>
References: <20230912082527.3913330-1-colin.i.king@gmail.com>
 <ZQBs2yEEupnoa2ZI@bfoster>
 <82d97565-ebb4-806c-70ba-c0fec16d51d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d97565-ebb4-806c-70ba-c0fec16d51d5@gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:00:23PM +0100, Colin King (gmail) wrote:
> On 12/09/2023 14:51, Brian Foster wrote:
> > On Tue, Sep 12, 2023 at 09:25:27AM +0100, Colin Ian King wrote:
> > > There are several spelling mistakes in error messages. Fix these.
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   fs/bcachefs/alloc_background.c | 2 +-
> > >   fs/bcachefs/backpointers.c     | 2 +-
> > >   fs/bcachefs/btree_iter.c       | 2 +-
> > >   fs/bcachefs/fsck.c             | 2 +-
> > >   fs/bcachefs/recovery.c         | 2 +-
> > >   fs/bcachefs/snapshot.c         | 2 +-
> > >   fs/bcachefs/super-io.c         | 2 +-
> > >   7 files changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
> > > index 540d94c0cceb..dd9f3cbace1e 100644
> > > --- a/fs/bcachefs/alloc_background.c
> > > +++ b/fs/bcachefs/alloc_background.c
> > > @@ -1247,7 +1247,7 @@ static noinline_for_stack int __bch2_check_discard_freespace_key(struct btree_tr
> > >   		return ret;
> > >   	if (fsck_err_on(!bch2_dev_bucket_exists(c, pos), c,
> > > -			"entry in %s btree for nonexistant dev:bucket %llu:%llu",
> > > +			"entry in %s btree for non-existent dev:bucket %llu:%llu",
> > 
> > "nonexistent" doesn't necessarily need to be hyphenated, right?
> 
> either way is valid, but some folk prefer the hyphenated version as it's
> apparently easier to scan.

Let's stick with the non hyphenated.
