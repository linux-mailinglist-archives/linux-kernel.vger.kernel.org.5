Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0738B790B6D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjICJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:55:43 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9860C91
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:55:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3839tKMD028386;
        Sun, 3 Sep 2023 11:55:20 +0200
Date:   Sun, 3 Sep 2023 11:55:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/4] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZPRYCERluK66jsLE@1wt.eu>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
 <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
 <ZPOOPjK+z847Ivq4@biznet-home.integral.gnuweeb.org>
 <ZPRBBT1ENJIB0cEp@1wt.eu>
 <a1cea8e2-610a-c17e-22df-b1a23a226f31@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1cea8e2-610a-c17e-22df-b1a23a226f31@gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 03:39:33PM +0700, Ammar Faizi wrote:
> [ Resend, I sent it using the wrong From address. ]
> 
> On 2023/09/03 ??3:17, Willy Tarreau wrote:
> > On Sun, Sep 03, 2023 at 02:34:22AM +0700, Ammar Faizi wrote:
> > > On Sun, Sep 03, 2023 at 02:28:18AM +0700, Alviro Iskandar Setiawan wrote:
> > > > nit: Be consistent. Use \n\t for the memset too.
> > > 
> > > Good catch, I'll fix that in v4 revision.
> > 
> > Ammar, I'm overall fine with your series. I can as well add the missing \t
> > to your patch while merging it, or wait for your v4, just let me know.
> 
> I'm now traveling and will be available in Jakarta on Monday. Thus, I
> actually planned to send the v4 revision on Monday.
> 
> However, since you don't have further objections to this series, I'll
> leave the trivial missing bit to you. Please merge this series and I
> will not send a v4 revision.

OK now merged with the \t appended. No need to spend your time on a v4
anymore.

Thanks!
Willy
