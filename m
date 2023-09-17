Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E97A33F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjIQGLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjIQGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 02:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5113E;
        Sat, 16 Sep 2023 23:10:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3396FC433C7;
        Sun, 17 Sep 2023 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694931054;
        bh=JyvYGLdb8BIcaE9svmQ+0s9rrC3nDZAE3iwY4+nnvU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozJuRew/hURbGLEz/9HsHn/MrUr7gGBlsirFxecZQUU07YvGd+Gco8FPD/ywCbjUa
         NxGls4aIN57FIkGyA1TulgZMqk3fA0uRePo/bSDTzPXqrBQs2iJ+FiAvf04/H+6Qmn
         c+sscAv5aRP2paUGhBVZxQ0u5DTZNRsXNUkIuEgk=
Date:   Sun, 17 Sep 2023 08:10:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
Message-ID: <2023091742-static-unedited-b414@gregkh>
References: <1694366957@msgid.manchmal.in-ulm.de>
 <ZQWUzwiKWLk79qbp@debian.me>
 <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
 <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com>
 <3ee4b922-7686-ec20-f280-48c06bff09cf@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee4b922-7686-ec20-f280-48c06bff09cf@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 07:02:50AM +0200, Helge Deller wrote:
> Greg & Sasha,
> 
> can you please queue-up this upstream patch for kernel v6.5-stable ?
> 
> commit 3cec50490969afd4a76ccee441f747d869ccff77
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Sep 16 12:31:42 2023 -0700
> 
>     vm: fix move_vma() memory accounting being off

Now queued up, thanks.

greg k-h
