Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854FB75A404
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGTBeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGTBeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:34:01 -0400
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DCF2699;
        Wed, 19 Jul 2023 18:33:44 -0700 (PDT)
X-QQ-mid: bizesmtp69t1689816815thvqecog
Received: from winn-pc ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 20 Jul 2023 09:33:34 +0800 (CST)
X-QQ-SSF: 01400000000000F0H000000A0000000
X-QQ-FEAT: ed3fCvOSdPtok9dqNbjZOUiBz3j5AlKdThUzqIrSzdkBL8VMn7X8/7SOjvGQD
        1S0+Nn5RRbWySoa+AcUfAxlDEU67uYFBuLAChaaGsCVxgx7LQsGFzCSMHoB/efhqTdHPYrQ
        P5xb06vUxcIiSeO3GDxz5XLGTknwFiD0kkmGnS2Aa1Grg0BgKYxJ3JGtf6i9eCTK3NiV0dR
        TaacX/Dr8ZwtkxbUdNfx9R46anPlxWlAFsBpuvvMezWt0uMtYkUtHzVs/1XvA2hFa0ojmqs
        zOEu9OJZ08rflGDk4J8BWR9beiot36Rx7y58Z90NRhfUyxYsAlGXKdsceVU7myrqsY4jw1e
        wWR6gZLhtwvSmgNfZY1RieOpsPb+WucPSnmnl5VZH8G0ZdnqD1A8DEAumlcVqqBvt1Tzved
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3347760861191863388
Date:   Thu, 20 Jul 2023 09:33:34 +0800
From:   Winston Wen <wentao@uniontech.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the cifs tree
Message-ID: <C27A47B8189477B4+20230720093334.2682929e@winn-pc>
In-Reply-To: <20230720110021.3f2f9457@canb.auug.org.au>
References: <20230720103540.0436273d@canb.auug.org.au>
        <CAH2r5mugNKYBNXm7AuPFL=V=77Qkm3q6TtXCj-B0kugmpL0aYQ@mail.gmail.com>
        <20230720110021.3f2f9457@canb.auug.org.au>
Organization: Uniontech
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 11:00:21 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Wed, 19 Jul 2023 19:47:42 -0500 Steve French <smfrench@gmail.com>
> wrote:
> >
> > Winston had an updated version of the patch - just replaced it with
> > his updated one which does a cast to (char *)
> > 
> >           ses->local_nls = load_nls((char
> > *)ctx->local_nls->charset);
> > 
> > But as he noted in an earlier email thread:
> > > Perhaps I should make a change to load_nls() to take a const char
> > > * instead of char *? If this make sense, I'll do it soon.  
> > 
> > which is probably cleaner
> 
> s/probably/definitely/  ;-)
> 

haha yes!

I'll make a small patch for this in the next cycle.

-- 
Thanks,
Winston

