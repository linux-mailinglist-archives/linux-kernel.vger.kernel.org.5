Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636476E08C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHCGxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 02:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjHCGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:52:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83751E72;
        Wed,  2 Aug 2023 23:52:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1608880FE;
        Thu,  3 Aug 2023 06:52:51 +0000 (UTC)
Date:   Thu, 3 Aug 2023 09:52:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <20230803065249.GF14799@atomide.com>
References: <20230725054216.45696-4-tony@atomide.com>
 <202308021529.35b3ad6c-oliver.sang@intel.com>
 <ca09d15f-50ab-452c-a3d5-f2b4cde6426f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ca09d15f-50ab-452c-a3d5-f2b4cde6426f@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [230802 18:20]:
> On Wed, Aug 02, 2023 at 04:15:28PM +0800, kernel test robot wrote:
> 
> > kernel test robot noticed machine hang on:
> 
> > commit: 4de64f4800a581e7eeba6392b3b2ce2131195145 ("[PATCH v5 3/3] serial: core: Fix serial core controller port name to show controller id")
> > url: https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-core-Controller-id-cannot-be-negative/20230725-134452
> > base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
> > patch link: https://lore.kernel.org/all/20230725054216.45696-4-tony@atomide.com/
> > patch subject: [PATCH v5 3/3] serial: core: Fix serial core controller port name to show controller id
> > 
> > in testcase: boot
> > 
> > compiler: gcc-12
> > test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> 
> I've also bisected this commit as causing boot hangs on at least the
> i.MX8MP-EVK, though most of the boards in my lab and a huge swathe of
> those in KernelCI are out:
> 
>    https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20230802/plan/baseline/
> 
> which is having a pretty devastating effect on -next testing.

Yes sorry about that, I should have noticed it right away. I thought I
still had my test machine set to use the console=DEVNAME:0.0 style
naming and I mostly test over ssh and was just looking at the DEVNAME.

Regards,

Tony
