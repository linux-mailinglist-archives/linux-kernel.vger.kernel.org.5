Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C725811FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjLMUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjLMUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:15:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9099C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:15:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755F2C433C8;
        Wed, 13 Dec 2023 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702498548;
        bh=VVv2/Ib7Vit2NFYKScdAAE1I3DHv8bSUId6nc0S42ck=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nD6PtNgb36xyYE2VKPKUQX71mi/8rPfdJ2ZWyiDvjWoBdOkhZzUpn6bbv3Dq4goPc
         4VXwMj1uag+vaiSWz1/ixSP0fbPdCiXC4IJ6Tps8fCiL6z1WgVqZn4yP2CCT0lKGGO
         z/Aa9lcxBw31QZY4OpaNEEy/iar11lFnNPGUbrKpWBgm+8yfhLfVbPjXZgTBEjBeXC
         0thXdQCeC1DZp6MyYyi1XzgIHvd7aMqOv0VyyMDzNF/Ed8qqhBAsqs6i6UEHK2svOB
         tge/Uv1rCNkWGxR4r/G470obaCcCFHl/uvCgEJ6UQMuXzr0f9hv8DqSUyRe91M64iJ
         Abwx5YMLMWDaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0348BCE0C4D; Wed, 13 Dec 2023 12:15:47 -0800 (PST)
Date:   Wed, 13 Dec 2023 12:15:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, julia.lawall@inria.fr, clm@fb.com,
        dsterba@suse.com, baptiste.lepers@gmail.com
Subject: Re: [paulmck-rcu:frederic.2023.12.08a 29/37]
 fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329'
 declared with 'error' attribute: Need native word sized stores/loads for
 atomicity.
Message-ID: <e14a8037-687d-42b7-b8b5-87c893275d1b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312091837.cKaPw0Tf-lkp@intel.com>
 <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
 <20231213125358.GB3001@suse.cz>
 <4c814394-6eab-4aca-96af-43f99fb94c01@paulmck-laptop>
 <20231213155440.GA454379@perftesting>
 <505dba1e-4950-4968-a789-434c52a3e1c7@paulmck-laptop>
 <CAEzrpqfDjwi4oE19i2s+AZJHd8uxfxKVtnTD0O9VXGYzSYhQsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqfDjwi4oE19i2s+AZJHd8uxfxKVtnTD0O9VXGYzSYhQsw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 02:53:52PM -0500, Josef Bacik wrote:
> On Wed, Dec 13, 2023 at 1:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 10:54:40AM -0500, Josef Bacik wrote:
> > > On Wed, Dec 13, 2023 at 06:56:37AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Dec 13, 2023 at 01:53:58PM +0100, David Sterba wrote:
> > > > > On Sat, Dec 09, 2023 at 07:51:30AM -0800, Paul E. McKenney wrote:
> > > > > > On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote:
> > > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
> > > > > > > head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> > > > > > > commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> > > > > > > config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> > > > > > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> > > > > > >
> > > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > > the same patch/commit), kindly add following tags
> > > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/
> > > > > > >
> > > > > > > All errors (new ones prefixed by >>):
> > > > > > >
> > > > > > >    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> > > > > > >    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> > > > > > >    warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
> > > > > > > >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
> > > > > > >      496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
> > > > > > >          |             ^
> > > > > >
> > > > > > Ooooh!!!  :-/
> > > > > >
> > > > > > From what I can see, the current code can tear this load on 32-bit
> > > > > > systems, which can result in bad comparisons and then in failure to wait
> > > > > > for a partially complete transaction.
> > > > > >
> > > > > > So is btrfs actually supported on 32-bit systems?  If not, would the
> > > > > > following patch be appropriate?
> > > > >
> > > > > There are limitations on 32bit systems, eg. due to shorter inode numbers
> > > > > (ino_t is unsigned long) and that radix-tree/xarray does support only
> > > > > unsigned long keys, while we have 64bit identifiers for inodes or tree
> > > > > roots.
> > > > >
> > > > > So far we support that and dropping it completely is I think a big deal,
> > > > > like with any possibly used feature. What I've seen there are NAS boxes
> > > > > with low power ARM that are 32bit.
> > > > >
> > > > > > If btrfs is to be supported on 32-bit systems, from what I can see some
> > > > > > major surgery is required, even if a 32-bit counter is wrap-safe for
> > > > > > this particular type of transaction.  (But SSDs?  In-memory btrfs
> > > > > > filesystems?)
> > > > >
> > > > > We won't probably do any major surgery to support 32bit systems.
> > > >
> > > > Got it, and thank you for the background!  My takeaway is that 32-bit
> > > > BTRFS must work in the common case, but might have issues on some
> > > > workloads, for example, running out of inode numbers or load tearing.
> > > >
> > > > > > ------------------------------------------------------------------------
> > > > > >
> > > > > > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > > > > > index 4fb925e8c981..4d56158c34f9 100644
> > > > > > --- a/fs/btrfs/Kconfig
> > > > > > +++ b/fs/btrfs/Kconfig
> > > > > > @@ -19,6 +19,7 @@ config BTRFS_FS
> > > > > >         select RAID6_PQ
> > > > > >         select XOR_BLOCKS
> > > > > >         depends on PAGE_SIZE_LESS_THAN_256KB
> > > > > > +       depends on 64BIT
> > > > >
> > > > > Can we keep the current inefficient smp_* barriers instead of dropping
> > > > > the whole 32bit support as an alternative. If the smp_load_acquire are
> > > > > better but not strictly necessary for the correctness (from the barriers
> > > > > POV) I'd suggest to leave it as-is. We can put comments in case somebody
> > > > > wants to optimize it in the future again.
> > > >
> > > > We still have the barrier placement issue, given that smp_rmb() enforces
> > > > only the ordering of earlier and later loads, correct?  Or am I missing
> > > > some other ordering constraint that makes all that work?
> > > >
> > > > But I can make each of the current patch's smp_load_acquire() call instead
> > > > be be a READ_ONCE() followed by an smp_rmb(), the test_bit_acquire()
> > > > call be test_bit() followed by smp_rmb(), and the smp_store_release()
> > > > call be an smp_wmb() followed by a WRITE_ONCE().  This provides the needed
> > > > ordering, bullet-proofs the 64-bit code against compilers, but works on
> > > > 32-bit systems.  For example, on a 32-bit system the 64-bit READ_ONCE()
> > > > and WRITE_ONCE() might still be compiled as a pair of 32-bit memory
> > > > accesses, but they will both be guaranteed to be single memory accesses
> > > > on 64-bit systems.
> > > >
> > > > Would that work for you guys?
> > >
> > > Actually I think we just need to re-work all of this to make it less silly.
> > > Does this look reasonable to you Paul?  I still have to test it, but I think it
> > > addresses your concerns and lets us keep 32bit support ;).  Thanks,
> >
> > Things that avoid the need for memory barriers are often improvements!
> >
> > I don't claim to understand enough of the BTRFS code to fully judge
> > this, but I do ask one stupid question below just in case it inspires
> > a non-stupid idea.  ;-)
> 
> Not a stupid question, I see what you're getting at.  We mix short
> term flags and long term flags on ->state.  SHAREABLE in this case is
> set at allocation time and never changes, so I'm not worried about
> that changing ever.  The only thing here that actually changes is the
> RECORDED flag, so just the normal test_bit for that is fine.  Thanks,

In that case, looks good to me:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul
