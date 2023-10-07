Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7E7BC7E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbjJGNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbjJGNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:00:58 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA1C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1696683633; bh=6e/J14qgrz5/5aSBCNVxqNF6zVd6jEJWQXAXSY4IkQs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=Wl/YS/3c1/JXS9cetGFFrgwJM4to1+2/hZSU41yumdXep8sVGnd2NwUKQqvfJL1Es
         ERE2lEUgaUMAO9iQ3VwKlYKrK9L+VG+4watCndLoHV9j8lcnLVBFSOtUe40Avp+D6s
         DMOwvjnWgnzDTU7r2mBBXGgtdD+3cbLwBMgNB3Ps=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Sat,  7 Oct 2023 15:00:33 +0200 (CEST)
X-EA-Auth: CAve3YZ/hZSuwfASOt92PtmM7Xx8xFaK9CD6lQ30TkqPKvGUURv8G1rIc+WBPmvrICkK34P+vUG14I6ddiREXgxjMkykTT5H
Date:   Sat, 7 Oct 2023 18:30:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: kmap() transformation: Question about copy_user_highpage
Message-ID: <ZSFWa44FTi48hDyE@runicha.com>
References: <ZSBV+h/gjPWV7+Gj@runicha.com>
 <CAAhV-H7B2tqw-PWD2775Nx1JiPVwh8nGYsVDTiA0QjBhTYbrMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7B2tqw-PWD2775Nx1JiPVwh8nGYsVDTiA0QjBhTYbrMw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:55:14PM +0800, Huacai Chen wrote:
> Hi, Deepak,

Hello Huacai,

>
> On Sat, Oct 7, 2023 at 2:46 AM Deepak R Varma <drv@mailo.com> wrote:
> >
> > Hello,
> > I am attempting to work on replacing the kmap[_atomic]() calls by
> > kmap_local_page() function call. A detail on this change can be found here [0].
> >
> > I would like to know if this function:
> >         arch/loongarch/mm/init.c::copy_user_highpage()
> > is currently in use or is it a dead code?
> >
> > If this code is not in use, can this be removed instead? However, if it is in
> > use, can you comment why kmap_atomic() was preferred over kmap()
> > function call?
> I think this function will be used for the 32bit kernel, and we will
> add loongarch32 support in the near future.

Okay. Sounds good.

>
> But on the other hand, you can replace kmap_atomic() with
> kmap_local_page(), there is no special reason to use kmap_atomic().

Looks like you sent in a patch. Thank you. I was working on trying to cross
compile my patch for the arch. I still would like to attempt that. Will request
your help if I get stuck.

regards,
deepak.


>
> Huacai
>
> >
> > [0] https://lore.kernel.org/all/20201029222652.302358281@linutronix.de/
> >
> > Thank you,
> > Deepak.
> >
> >
> >


