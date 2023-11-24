Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE27F6C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKXG56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:57:56 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D0D68;
        Thu, 23 Nov 2023 22:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+vLvHxYJJOw29EYw/MB5/XlBvEEwrjF5Jmtn5wI/ABk=; b=pDnz7xHs9Qcdi/vulE3FTzMjbt
        0lurosUN2iB/UDl21QxxDZMQMF+GW24sdDgRYgEwOOTVcoVfxvoKERypLGPZzb3nsAuM8DO4HOIe6
        5A3f1r6PRB2JT2Y/xk+6tK3olbXGxZqEZ+/vkYSmt6eeNBtRoBJdwuKEUyhh5rpirrwT+2oSnF2tQ
        ED0jEofA226r619cTq6YG8psFUAIMqgdy25rc7XBu1F1xLPTxEaHEO4PLCix1tdo0QdlnHt+PycXU
        qdIb6b6DCnjnEm3yvkjhd/sisvenuuduH/CW+i8lztRmXrqChnFsclgu08igcKNPOHIKlduT0tRP7
        dyC53W+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6Q8V-002QzC-2E;
        Fri, 24 Nov 2023 06:57:59 +0000
Date:   Fri, 24 Nov 2023 06:57:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: d_genocide()? What about d_holodomor(), d_massmurder(),
 d_execute_warcrimes()? Re: [PATCH 15/20] d_genocide(): move the extern into
 fs/internal.h
Message-ID: <20231124065759.GT38156@ZenIV>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-15-viro@zeniv.linux.org.uk>
 <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 07:35:34AM +0100, Cedric Blancher wrote:
> On Fri, 24 Nov 2023 at 07:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/internal.h          | 1 +
> >  include/linux/dcache.h | 3 ---
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 9e9fc629f935..d9a920e2636e 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -219,6 +219,7 @@ extern void shrink_dcache_for_umount(struct super_block *);
> >  extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
> >  extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
> >                                 const struct qstr *name, unsigned *seq);
> > +extern void d_genocide(struct dentry *);
> 
> Seriously, who came up with THAT name? "Genocide" is not a nice term,
> not even if you ignore political correctness.
> Or what will be next? d_holodomor()? d_massmurder()? d_execute_warcrimes()?

kill_them_all(), on the account of that being what it's doing?

I can explain the problems with each of your suggested identifiers,
if you really wish that, but I would stronly suggest taking that off-list.

As for the bad words...  google "jesux" someday.  Yes, we do have
identifiers like "kill", "abort", etc. and those are really not going
anywhere; live with it.
