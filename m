Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3629E7802A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353052AbjHRAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356717AbjHRAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD32723
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B5B62DE6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370FBC433C8;
        Fri, 18 Aug 2023 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692317683;
        bh=xQZeNLubnblVJt+8p5dRVcAKIMGTMir+chTN0oqb6Bg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FBHWVlBRIWnj2iPVIIW2BKUiFSupKC6OnL4qqNKlTop6vU41IeoLO6LuN/YVy1xud
         UQdayxu6IaxqO1WLJ/tg8UVF0O/xsK/eQGDEiyAlJnjeh/MNmEhWLdPRlqxaev9tXg
         b27i1/7japIztAkcGpiDherpbIFUW1oJ/2gASe5dMVduYDadKdFXoLmwSofwCDEqkn
         I+uw2V3FcpCNETCMRV8yssbJFy7oNa9tAcUeZ/MT/5CdhxO23GTrBBsJgSmsqY+adW
         ujoGNxSyFRcHYhdVaBAuRL+YFfX9/anPl/vW12RTYWbzCYfR9kFs5SDp/zIzjRqQmo
         19EKRRx/BroAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7264CE0EFD; Thu, 17 Aug 2023 17:14:42 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:14:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [paulmck-rcu:dev.2023.08.14a 49/51]
 kernel/rcu/rcutorture.c:24:10: fatal error: linux/rcu_notifier.h: No such
 file or directory
Message-ID: <2b23fc83-339a-44f6-850d-f90436beb92c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202308160930.YEekR3Wf-lkp@intel.com>
 <a5fa35dc-6244-41ef-9f5b-08aa497d9a74@paulmck-laptop>
 <63593d36f4bfb665fb7e62733114d2c5e3d3f873.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63593d36f4bfb665fb7e62733114d2c5e3d3f873.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:05:10AM +0000, Liu, Yujie wrote:
> On Tue, 2023-08-15 at 19:19 -0700, Paul E. McKenney wrote:
> > On Wed, Aug 16, 2023 at 09:55:30AM +0800, kernel test robot wrote:
> > > tree:  
> > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > >  dev.2023.08.14a
> > > head:   a90c4cbc91475bd5df35f712a954972fbfff40a1
> > > commit: 37730a9ba11627b63d8108dd8b3061ea2ee04df9 [49/51]
> > > rcutorture: Add test of RCU CPU stall notifiers
> > > config: sh-allmodconfig
> > > (https://download.01.org/0day-ci/archive/20230816/202308160930.YEek
> > > R3Wf-lkp@intel.com/config)
> > > compiler: sh4-linux-gcc (GCC) 12.3.0
> > > reproduce:
> > > (https://download.01.org/0day-ci/archive/20230816/202308160930.YEek
> > > R3Wf-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a
> > > new version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202308160930.YEekR3Wf-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > kernel/rcu/rcutorture.c:24:10: fatal error:
> > > > > linux/rcu_notifier.h: No such file or directory
> > >       24 | #include <linux/rcu_notifier.h>
> > >          |          ^~~~~~~~~~~~~~~~~~~~~~
> > >    compilation terminated.
> > 
> > You would think that I would remember "git add".  ;-)
> > 
> > Does the patch below fix things up?
> 
> Yes, the build error is gone after adding the new header file. Seems
> this fixup patch is already included in dev.2023.08.15a branch :)

Something about my having hit it when pulling the commits onto the
test systems.  ;-)

							Thanx, Paul

> Thanks,
> Yujie
> 
> >                                                         Thanx, Paul
> > 
> > ---------------------------------------------------------------------
> > ---
> > 
> > commit 2b7e462695eee212f81f7000af4f4af2523ece35
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Aug 15 19:17:50 2023 -0700
> > 
> >     fixup! rcu: Add RCU CPU stall notifier
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/include/linux/rcu_notifier.h
> > b/include/linux/rcu_notifier.h
> > new file mode 100644
> > index 000000000000..ebf371364581
> > --- /dev/null
> > +++ b/include/linux/rcu_notifier.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Read-Copy Update notifiers, initially RCU CPU stall notifier.
> > + * Separate from rcupdate.h to avoid #include loops.
> > + *
> > + * Copyright (C) 2023 Paul E. McKenney.
> > + */
> > +
> > +#ifndef __LINUX_RCU_NOTIFIER_H
> > +#define __LINUX_RCU_NOTIFIER_H
> > +
> > +// Actions for RCU CPU stall notifier calls.
> > +#define RCU_STALL_NOTIFY_NORM  1
> > +#define RCU_STALL_NOTIFY_EXP   2
> > +
> > +#ifdef CONFIG_RCU_STALL_COMMON
> > +
> > +#include <linux/notifier.h>
> > +#include <linux/types.h>
> > +
> > +int rcu_stall_chain_notifier_register(struct notifier_block *n);
> > +int rcu_stall_chain_notifier_unregister(struct notifier_block *n);
> > +
> > +#else // #ifdef CONFIG_RCU_STALL_COMMON
> > +
> > +// No RCU CPU stall warnings in Tiny RCU.
> > +static inline int rcu_stall_chain_notifier_register(struct
> > notifier_block *n) { return -EEXIST; }
> > +static inline int rcu_stall_chain_notifier_unregister(struct
> > notifier_block *n) { return -ENOENT; }
> > +
> > +#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
> > +
> > +#endif /* __LINUX_RCU_NOTIFIER_H */
> > 
> 
