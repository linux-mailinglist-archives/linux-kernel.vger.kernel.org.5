Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEF7765848
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjG0QHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjG0QH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:07:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C9359A;
        Thu, 27 Jul 2023 09:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D40C61EEA;
        Thu, 27 Jul 2023 16:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFBBC433C8;
        Thu, 27 Jul 2023 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474028;
        bh=uBvzXfHO1nsSRjLcionOhLpZMwIec1LCVD6wwCarigE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RYz+SK6ZEzLzz1Mdh24O+2stfplmHIts9XxT584v30nxRw0nUPQc6XakHgC9iMd7n
         pBUkiritFqLokBmoWgQ0P7Hh+mjz5+KZ2Tkqf/KACVUkVKX8ww2DMg7L7y7eKqsb3M
         UGben2x0vnCsT4p3UJDQjMrvKLX0ddut/p7gPmhBeb5DEsp1QzXINvdytZZ6udQX49
         YCGjV5+fy1hEdtaU5ABOsUqrT4Ky8ITEea9kbNnHA8RDeMj9jBWTvArHq+yrGNsKxA
         cRcSJJ7lEWQYvzY6H2Y9PLW53FfW4zmH/NaJqS4kjZrr4yXi5LiZv+UtWpTAXiEAY/
         TWS7V31i+PJLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53053CE0B66; Thu, 27 Jul 2023 09:07:08 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:07:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <ebe4a969-8a24-4bb8-8dbe-f77db89f65c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
 <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:39:54AM -0700, Guenter Roeck wrote:
> On 7/27/23 07:06, Paul E. McKenney wrote:
> > On Thu, Jul 27, 2023 at 09:26:52AM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Jul 27, 2023, at 7:35 AM, Pavel Machek <pavel@denx.de> wrote:
> > > > 
> > > > ﻿Hi!
> > > > 
> > > > > > This is the start of the stable review cycle for the 6.4.7 release.
> > > > > > There are 227 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > > The whole patch series can be found in one patch at:
> > > > > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> > > > > > and the diffstat can be found below.
> > > > > 
> > > > > I saw this when running rcutorture, this one happened in the TREE04
> > > > > configuration. This is likely due to the stuttering issues we are discussing
> > > > > in the other thread. Anyway I am just making a note here while I am
> > > > > continuing to look into it.
> > > > 
> > > > So is the stuttering new in 6.4.7?
> > > 
> > > No it is an old feature in RCU torture tests. But is dependent on timing. Something
> > > changed in recent kernels that is making the issues with it more likely. Its hard to bisect as failure sometimes takes hours.
> > > 
> > > > 
> > > > > Other than that, all tests pass:
> > > > > Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > ...or you still believe 6.4.7 is okay to release?
> > > 
> > > As such, it should be Ok. However naturally I am not happy that the RCU testing
> > > is intermittently failing. These issues have been seen in last several 6.4 stable releases
> > > so since those were released, maybe this one can be too?
> > > The fix for stuttering is currently being reviewed.
> > 
> > Or, to look at it another way, the stuttering fix is specific to torture
> > testing.  Would we really want to hold up a -stable release only because
> > rcutorture occasionally gives a false-positive failure on certain types
> > of systems?
> > 
> 
> No. However, (unrelated) in linux-next, rcu tests sometimes result in apparent hangs
> or long runtime.
> 
> [    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
> [    0.779011] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
> [    0.797998] Running RCU synchronous self tests
> [    0.798209] Running RCU synchronous self tests
> [    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family: 0x15, model: 0x2, stepping: 0x0)
> [    0.923398] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
> [    0.925419] Running RCU-tasks wait API self tests
> 
> (hangs until aborted). This is primarily with Opteron CPUs, but also with others such as Haswell,
> Icelake-Server, and pentium3. It is all but impossible to bisect because it doesn't happen
> all the time. All I was able to figure out was that it has to do with rcu changes in linux-next.
> I'd be much more concerned about that.

First I have heard of this, so thank you for letting me know.

About what fraction of the time does this happen?

							Thanx, Paul
