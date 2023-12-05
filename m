Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C90805D98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbjLESBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:01:38 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB8651BC;
        Tue,  5 Dec 2023 10:01:44 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1rAZjr-0003nO-00; Tue, 05 Dec 2023 19:01:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BCBD4C0A2B; Tue,  5 Dec 2023 18:52:36 +0100 (CET)
Date:   Tue, 5 Dec 2023 18:52:36 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Aurelien Jarno <aurel32@debian.org>
Subject: Re: [PATCH] MIPS: kernel: Clear FPU states when setting up kernel
 threads
Message-ID: <ZW9jZDTkw3T9dBtS@alpha.franken.de>
References: <20231130163601.185270-1-tsbogend@alpha.franken.de>
 <6f290f4b-5dc2-44f3-9f2d-01496f78d629@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f290f4b-5dc2-44f3-9f2d-01496f78d629@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:12:21AM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年11月30日十一月 下午4:36，Thomas Bogendoerfer写道：
> > io_uring sets up the io worker kernel thread via a syscall out of an
> > user space prrocess. This process might have used FPU and since
> > copy_thread() didn't clear FPU states for kernel threads a BUG()
> > is triggered for using FPU inside kernel. Move code around
> > to always clear FPU state for user and kernel threads.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Aurelien Jarno <aurel32@debian.org>
> > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1055021
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Perhaps
> Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> As well :-)

I've added both

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
