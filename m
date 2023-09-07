Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34B9797DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbjIGVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:01:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7841BCE;
        Thu,  7 Sep 2023 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694120496; x=1725656496;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1TJX2fxitiy8P/tUl0ZPLXAl8DRdzkpD4eQW3906Ids=;
  b=k2HQjPCO7BDi+LS02F6wqf3qzBsKFQeW6xSJcoRa9vwAWfwRMYIqoJVE
   8lHRelKrvdO+4+bGSI92aAmyTS/3j1PAxenQ3swzMUvktpXaUgzRltNJv
   pdp0qKt41KW2qtk7K6D+/tE+qSLeRrosm9cmMVcG5yCfcw3OOoFg0leCR
   TOUvbMrTTZupKVqFkTq7xzv5krUQUqvgfwG2sJWx+VSFnpDJ0PyQUcLbw
   2KVVeEzuqAmcDXsBcSq1UAC8dgBcmiY/r7yy/Rew2qvxesPBZW0eN+sXq
   9kODFHXWt6WF25e1vT5i/16oiHWSCEeZhomJxWWb/rpGwLj6n2sSch8rC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367736355"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="367736355"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:01:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807690341"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807690341"
Received: from ayushgup-mobl.amr.corp.intel.com (HELO [10.209.118.125]) ([10.209.118.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:01:10 -0700
Message-ID: <171e6a9435a33885a73b48762f86954e447c26c2.camel@linux.intel.com>
Subject: Re: [External] Re: Fwd: WARNING: CPU: 13 PID: 3837105 at
 kernel/sched/sched.h:1561 __cfsb_csd_unthrottle+0x149/0x160
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Hao Jia <jiahao.os@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Igor Raits <igor.raits@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Date:   Thu, 07 Sep 2023 14:01:10 -0700
In-Reply-To: <3544d5e3-3070-9ddc-fa6c-a05ed35dfd14@bytedance.com>
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
         <xm26cyz4ibnb.fsf@google.com>
         <55e2861e-9722-08f8-2c49-966035ff4218@bytedance.com>
         <20230904222351.GC2568@noisy.programming.kicks-ass.net>
         <3544d5e3-3070-9ddc-fa6c-a05ed35dfd14@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 16:59 +0800, Hao Jia wrote:
>=20
> On 2023/9/5 Peter Zijlstra wrote:
> > On Thu, Aug 31, 2023 at 04:48:29PM +0800, Hao Jia wrote:
> >=20
> > > If I understand correctly, rq->clock_update_flags may be set to
> > > RQCF_ACT_SKIP after __schedule() holds the rq lock, and sometimes the=
 rq
> > > lock may be released briefly in __schedule(), such as newidle_balance=
(). At
> > > this time Other CPUs hold this rq lock, and then calling
> > > rq_clock_start_loop_update() may trigger this warning.
> > >=20
> > > This warning check might be wrong. We need to add assert_clock_update=
d() to
> > > check that the rq clock has been updated before calling
> > > rq_clock_start_loop_update().
> > >=20
> > > Maybe some things can be like this?
> >=20
> > Urgh, aside from it being white space mangled, I think this is entirely
> > going in the wrong direction.
> >=20
> > Leaking ACT_SKIP is dodgy as heck.. it's entirely too late to think
> > clearly though, I'll have to try again tomorrow.

I am trying to understand why this is an ACT_SKIP leak.
Before call to __cfsb_csd_unthrottle(), is it possible someone
else lock the runqueue, set ACT_SKIP and release rq_lock?
And then that someone never update the rq_clock?=20

>=20
> Hi Peter,
>=20
> Do you think this fix method is correct? Or should we go back to the=20
> beginning and move update_rq_clock() from unthrottle_cfs_rq()?
>=20
If anyone who locked the runqueue set ACT_SKIP also will update rq_clock,
I think your change is okay.  Otherwise rq_clock could be missing update.

Thanks.

Tim
