Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C678B2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjH1OJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjH1OJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:09:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F2114;
        Mon, 28 Aug 2023 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hwS7Tr7cwvM8RoL5HlUQtUZrL4nEzt4+7EbQ2IC3lY8=; b=QItc5MAX+cz4JCtjY2sEKO+9xj
        IGIr+1a8yA4sbCHCD8vkT418hvpskmNi9ButFChI0IuFkAoyCtQmqMlrDLyaMBn096v2sfA42KPrG
        3Xk8fEkCqusisXtiwvRKsO6lUwakiJDdIqyNmk7I9j7yXJmYz7kvHbXesSq7U6DqFq8RJ242+lR4x
        S3meOEy5y/jnHMK1TyqY2I6T4jm7pM9mQU7TuIIvkke8sKJlvJevNUoyfaepI7obnL9pgoAxmCmnM
        vo5516VDjYn+XUJNcWZqZwqY1vDzqS4RmQ9id7cIKBC8VoX0ZCUWIydGGF9oM0tB8zxtELpkf2hp3
        iyUk59bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qacvU-000fif-Tn; Mon, 28 Aug 2023 14:09:08 +0000
Date:   Mon, 28 Aug 2023 15:09:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Nishanth Menon <nm@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Message-ID: <ZOyqhL32tuiMlS23@casper.infradead.org>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
 <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings>
 <87edjn2sj0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edjn2sj0.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:41:39AM -0600, Jonathan Corbet wrote:
> Youtube references aren't a great way to explain the value of a patch;
> you'll find that maintainers will, in general, lack the time or
> inclination to follow them up.  The patch should explain itself.

I agree that the way this has been presented is awful.

> > prompt:: bash $ is clearly readable that this is prompt documentation
> > in fact, dropping the "$" in the example logs, one can easily copy paste
> > the documentation from rst files as well.
> 
> .. prompt:: is clutter.  It also adds a bit of extra cognitive load to
> reading that part of the documentation.
> 
> Quick copy-paste of multiple lines of privileged shell commands has
> never really been a requirement for the kernel docs; why do we need that
> so badly?
> 
> I appreciate attempts to improve our documentation, and hope that you
> will continue to do so.  I am far from convinced, though, that this
> change clears the bar for mainline inclusion.

I'd ask that you reconsider.  Looking at patch 2, I prefer what is
written there.  I don't think it adds cognitive load when reading the
plain docs.  I find the "copy and paste from html" argument not very
convincing, but I do like "copy and paste from rst", which this enables.

I also have a certain fond memory of how the plan9 people set up 'rc'
(their shell) so that ";" was both an empty statement, and the default
prompt.  So you could copy-paste lines starting with the ; prompt and
they'd work.  It's a small usabillity improvement, but it is there,
and wow is it annoying when you don't have it any more.
