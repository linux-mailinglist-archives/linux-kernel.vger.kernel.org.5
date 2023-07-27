Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E412E765BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjG0Syj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjG0Syh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:54:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0610AE47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNWm7Qj0zcqYV1uaAHA9r3BYTjGYeJaJbjbaVhyDo/Q=; b=bYCxwhkQhxXoRkeilo2KkfmpKY
        i2ZSsYa0bjTBU5p66reYujey0ty3H3wgzfjUBKLXgHHN9aumXx0OflRS8z/5AMUoG/2dgbCiw9ovQ
        XETTqAo8rhZY60UhGbfhL6+bYCISjJ8IjPWEEpel6V96sTzzlfp1tz5nsI7ej0vx+Sn4OFnXi4Tf9
        nYqWvoYj/rbP4X8nlvvJpoYYsqFqmal8etvHFWGRQh8ApnM3/oEOG5dQ1veRBDcpAS/dOimxZiZN2
        9KWJPcrLgUZtXrPsGNuA11+D7JsVM/oC1v/vTMnIsFBhBdl8JN65I9So6dNXlYf7ZVUF2X3VhIxEI
        /RVw60vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP68A-007mTH-BQ; Thu, 27 Jul 2023 18:54:34 +0000
Date:   Thu, 27 Jul 2023 19:54:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <ZMK9arq/gzFEqUOs@casper.infradead.org>
References: <ZMK9C+iq3y8POOGp@casper.infradead.org>
 <0000000000004ccc7906017c79e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004ccc7906017c79e0@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:53:02AM -0700, syzbot wrote:
> > On Tue, Jul 25, 2023 at 11:57:22PM -0700, syzbot wrote:
> >> syzbot has bisected this issue to:
> >> 
> >> commit a52f58b34afe095ebc5823684eb264404dad6f7b
> >> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Date:   Mon Jul 24 18:54:10 2023 +0000
> >> 
> >>     mm: handle faults that merely update the accessed bit under the VMA lock
> >> 
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
> >> start commit:   [unknown] 
> >> git tree:       linux-next
> >
> > #syz test linux-next a52f58b34afe095ebc5823684eb264404dad6f7b
> 
> "linux-next" does not look like a valid git repo address.

Well, now, that's your fault, isn't it?  You're abbreviating the git
tree in the report, but then refusing to accept the abbreviation in
the response.

