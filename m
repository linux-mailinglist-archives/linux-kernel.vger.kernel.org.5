Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7047F7D23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKXSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:21:34 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5C1FFB;
        Fri, 24 Nov 2023 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bnFjemGG/8+Q+bMrL9c3IGKLpEaIgBd22FVZzfxkBmw=; b=DTBogjrL33PG/f/pZc4RUVoUQ2
        xaIKTpKFfXcdm8dGtodAaFMG8GmtS4OVftisdxckWdx3/V8LCZPi8mtIgxrs25O3Hg2hf/nwFLVsX
        aAulmIQZxr178U2OlrP/BKb57c3Xk+emUtmWmV28U7eNRacxbcmaAJ1yHfx6ZWCN3ydKkiQBFLbSi
        VVcH1VIqcWYl7sAIIqLF+jWtThLZ8vW1vjFJf9zqg3EiZdH2PKOw4oD3YtUq4/QQyL5EKdmmMQq38
        abys6t3MgSghInemF42CSgKo9xblRff9FOQiHqLW5OSwBl5VTvczu5tl2NUCI21IujkfDnJHSmOx2
        Ca6UrVLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6ao5-002fEc-2c;
        Fri, 24 Nov 2023 18:21:37 +0000
Date:   Fri, 24 Nov 2023 18:21:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Cedric Blancher <cedric.blancher@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: identifiers
Message-ID: <20231124182137.GX38156@ZenIV>
References: <20231124060553.GA575483@ZenIV>
 <20231124065759.GT38156@ZenIV>
 <20231124074856.GA581958@ZenIV>
 <10399078.nUPlyArG6x@lichtvoll.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10399078.nUPlyArG6x@lichtvoll.de>
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

[search bait removed from subject]
On Fri, Nov 24, 2023 at 10:36:05AM +0100, Martin Steigerwald wrote:
> Al Viro - 24.11.23, 08:48:57 CET:
> > To elaborate a bit: what that function does (well, tries to do - it has
> > serious limitations, which is why there is only one caller remaining and
> > that one is used only when nothing else can access the filesystem
> > anymore) is "kill given dentry, along with all its children, all their
> > children, etc."
> 
> I never got why in the context of computers anything is ever being killed. 
> It does not live to begin with.

Simple - one deals with objects that have complex lifecycle, with very
different possible behaviour at various stages.  And about the only
example of such that would be well-covered in natural languages is
just that - both in adjectives for states and verbs for transitions between
those.

Note that the word "lifecycle" itself is rather commonly used outside
of biological context.

> You can stop something, remove it, delete it, destroy it, pause it, resume 
> it, overwrite it and you can do it really quickly or (almost) instantly or 
> slowly or recursively or some combination of those, but kill? You cannot 
> kill what does not live. 

Why?  "Do something that changes the state of target into one in which
the target gradually becomes incapable of normal activity until it goes
completely inert and eventually disappears, with its parts recycled for
unrelated objects" vs. "kill the target", with associated transitional
state being refered to as "dying"?

Your suggestions all refer to operation rather than state transition.

> d_delete/destroy/remove_recursively() could be a suitable function name. 
> Pick one.

Thanks, but no thanks.  d_delete() already exists and refers to rather
different operation; "destroy" in such contexts would be loaded with
an existing technical meaning, and that would be actively confusing;
"remove_recursively"?  Guess what the better-behaving replacement (far
too heavy-weight for the only remaining use) is called?  "simple_recursive_removal".
It does more than this one, though.

> Similar it is with the term children or parent. There are no children in 
> computer software. Period.

Well-asserted.  Unfortunately, the statement is wrong - "parents" and
"children" have specific meanings when applied to nodes of directed graphs.
And there's a plenty of those dealt with by software.  Directory tree, in
particular.
