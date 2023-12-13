Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B281155A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442012AbjLMO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442004AbjLMO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:56:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DF93
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:56:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35478C433C8;
        Wed, 13 Dec 2023 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702479398;
        bh=RbqO8lhLpHDZIavrq3v7GldwAkkZy4gcb11Zs9mg9yQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hrd+mK15OXrooHgeQnsU/Nu8j0gvSF67u3rJRkr1x7BgKkJsKCMjnx94V7Hxi3Qu1
         6LpfA/+/pAB1NJcwCRXFVfK8Sn/EMlmLr7IuZEdkl/pARDfRiVsv/FedIrC3RQqBFL
         7N8ZRtfPmy4b+VvdQoS2RTupHG856iiRvGQbA+Qi2fsFKNWi+6s7VfjS9GqbbGv7x4
         1znbv5REK8/qZEvQfKI+Im1Q1y8srpTP9g7IFJJFSggyNhOCk3I9n1lfI8IB+Io+7c
         MOeS8gqCKcwLx+OLmyxMziV0y01viOoBHusbBcFhqUcoSreV/NQanCnypVYYmJ/aB7
         szsxbI3LQoD3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B381DCE105C; Wed, 13 Dec 2023 06:56:37 -0800 (PST)
Date:   Wed, 13 Dec 2023 06:56:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, julia.lawall@inria.fr,
        clm@fb.com, dsterba@suse.com, baptiste.lepers@gmail.com
Subject: Re: [paulmck-rcu:frederic.2023.12.08a 29/37]
 fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329'
 declared with 'error' attribute: Need native word sized stores/loads for
 atomicity.
Message-ID: <4c814394-6eab-4aca-96af-43f99fb94c01@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312091837.cKaPw0Tf-lkp@intel.com>
 <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
 <20231213125358.GB3001@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213125358.GB3001@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:53:58PM +0100, David Sterba wrote:
> On Sat, Dec 09, 2023 at 07:51:30AM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
> > > head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> > > commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> > > config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> > >    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> > >    warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
> > > >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
> > >      496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
> > >          |             ^
> > 
> > Ooooh!!!  :-/
> > 
> > From what I can see, the current code can tear this load on 32-bit
> > systems, which can result in bad comparisons and then in failure to wait
> > for a partially complete transaction.
> > 
> > So is btrfs actually supported on 32-bit systems?  If not, would the
> > following patch be appropriate?
> 
> There are limitations on 32bit systems, eg. due to shorter inode numbers
> (ino_t is unsigned long) and that radix-tree/xarray does support only
> unsigned long keys, while we have 64bit identifiers for inodes or tree
> roots.
> 
> So far we support that and dropping it completely is I think a big deal,
> like with any possibly used feature. What I've seen there are NAS boxes
> with low power ARM that are 32bit.
> 
> > If btrfs is to be supported on 32-bit systems, from what I can see some
> > major surgery is required, even if a 32-bit counter is wrap-safe for
> > this particular type of transaction.  (But SSDs?  In-memory btrfs
> > filesystems?)
> 
> We won't probably do any major surgery to support 32bit systems.

Got it, and thank you for the background!  My takeaway is that 32-bit
BTRFS must work in the common case, but might have issues on some
workloads, for example, running out of inode numbers or load tearing.

> > ------------------------------------------------------------------------
> > 
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index 4fb925e8c981..4d56158c34f9 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -19,6 +19,7 @@ config BTRFS_FS
> >  	select RAID6_PQ
> >  	select XOR_BLOCKS
> >  	depends on PAGE_SIZE_LESS_THAN_256KB
> > +	depends on 64BIT
> 
> Can we keep the current inefficient smp_* barriers instead of dropping
> the whole 32bit support as an alternative. If the smp_load_acquire are
> better but not strictly necessary for the correctness (from the barriers
> POV) I'd suggest to leave it as-is. We can put comments in case somebody
> wants to optimize it in the future again.

We still have the barrier placement issue, given that smp_rmb() enforces
only the ordering of earlier and later loads, correct?  Or am I missing
some other ordering constraint that makes all that work?

But I can make each of the current patch's smp_load_acquire() call instead
be be a READ_ONCE() followed by an smp_rmb(), the test_bit_acquire()
call be test_bit() followed by smp_rmb(), and the smp_store_release()
call be an smp_wmb() followed by a WRITE_ONCE().  This provides the needed
ordering, bullet-proofs the 64-bit code against compilers, but works on
32-bit systems.  For example, on a 32-bit system the 64-bit READ_ONCE()
and WRITE_ONCE() might still be compiled as a pair of 32-bit memory
accesses, but they will both be guaranteed to be single memory accesses
on 64-bit systems.

Would that work for you guys?

							Thanx, Paul
