Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B077C659
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjHOD1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjHODZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:25:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AD14223;
        Mon, 14 Aug 2023 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uNOIPPxb0nzhj17QBQUBlRg6NF9GT8npgIRWptb0k1I=; b=KPvoUD0EdzjuBQMFamzppGty18
        I0G0bhPAXi9ZJjiA4pSxo/zQnyCzIdjFeviFx576u0F3/yofr9sUBMY8hdQZNbIzbKl9Hlfe2t7uq
        3iJMxhkXbfhqZWJyUm6SxcPFsrv6vmc8QQuNN7mO6RQknxzGtk3itLaYOMV1q2fK187JtuYkfF24v
        cetPkfV8RCA0dX20IPDOBIyxPUsVq9H3BCwiNNDeoSbuKRg1GvZJWznIfsBzw9NAQYBE0aHjTMMPK
        QrqQZPib6swERMNoIXQfl8tTTMKnE3H8UcDLeTkAUnX9m3Yxq3JhoPF+kTGrZeVjPwlo4KqLnwxrF
        CTXuAsUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVkZR-005o2Q-8y; Tue, 15 Aug 2023 03:18:13 +0000
Date:   Tue, 15 Aug 2023 04:18:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the csky tree with the mm tree
Message-ID: <ZNrudXYzylps9xtG@casper.infradead.org>
References: <20230815104604.54f65293@canb.auug.org.au>
 <CAJF2gTRVG+yX7fktLru4U=OVKrTg73kTR5hirw1hh1P9c+MNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRVG+yX7fktLru4U=OVKrTg73kTR5hirw1hh1P9c+MNOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:11:52AM +0800, Guo Ren wrote:
> On Tue, Aug 15, 2023 at 8:46 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the csky tree got a conflict in:
> >
> >   arch/csky/abiv2/cacheflush.c
> >
> > between commit:
> >
> >   1222e1310d64 ("csky: implement the new page table range API")
> Could I take this patch into csky next tree to solve the conflict.

No.  It depends on the predecessor patches in that series.
