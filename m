Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC117BC488
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjJGECF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJGECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:02:02 -0400
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E6BD;
        Fri,  6 Oct 2023 21:02:00 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4S2WlG3PyszB0Y9d;
        Sat,  7 Oct 2023 11:59:38 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 7 Oct
 2023 12:01:48 +0800
Date:   Sat, 7 Oct 2023 12:01:48 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] padata: Fix the UAF issue related to parallel_data
Message-ID: <ZSDYLKRcGFp2Kcxe@fedora>
References: <ZRTLHY5A+VqIKhA2@fedora>
 <rjayevj3rwpj6wt2uq2jc7c3oqbewnobdqhs5bkrjte7fxzkct@k5rpt4g6tnqh>
 <paajlxnnp6isq435i7w2onndi56xpwahq6tl6hbjwqdhta375l@kqgpf5nkcsog>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <paajlxnnp6isq435i7w2onndi56xpwahq6tl6hbjwqdhta375l@kqgpf5nkcsog>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:07:10PM -0400, Daniel Jordan wrote:
> On Wed, Oct 04, 2023 at 10:54:29AM -0400, Daniel Jordan wrote:
> > On Thu, Sep 28, 2023 at 08:38:53AM +0800, Wang Jinchao wrote:
...
> > This could use a Fixes tag.  From Nicolai's patch[0] we agreed on
> > 
> > Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
> > 
> > With that,
> > 
> > Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > 
> > Thanks!
> > 
...
> 
> Oh, I should've also said please move the declaration of pd to the top
> of the function like scripts/checkpatch.pl suggests.
> 
> > > +	if (refcount_dec_and_test(&pd->refcnt))
> > > +		padata_free_pd(pd);
> > >  	mutex_unlock(&ps->pinst->lock);
> > >  
> > >  	kfree(ps);
> > > -- 
> > > 2.40.0
> > > 
Thanks for suggestion, both were updated in V3.
V3: https://lore.kernel.org/all/ZSDWAcUxXcwD4YUZ@fedora/
