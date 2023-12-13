Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDF811BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjLMSFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjLMSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:05:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D004114
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:05:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CF2C433CC;
        Wed, 13 Dec 2023 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702490752;
        bh=4vH4cEVo8W55BC4iyBqtXcMfUYzLk1TrXzqxAwaowug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k+CYcQm5dEJr9o8GA81Xp8OmOxk4eOWgnj5m/vm8gLWkdfi6helpGS/YQO1TxJtsj
         AhY8Eh+wCPHTdjswg2ot22M7q+cuwdY8st9K4BtfSLg0qt1/02H/t8uC5QcWsz25jg
         u1WkL6CRIRiHiQ5zdGRlMMZ8JTSTRONKO+U/vv4boJecosYyGx9RuZxfly4rcpuJRa
         5rBYpUc0LCaUPQ1fbHNFxCVd+z5PBPiDH0yoODcsxOVFmEbSlIvcwr0Tb1S7PWlNVC
         le1z09VGKqLUTr8+WeFN6QnpKw/V94OBXD48f3c1p05HiULtNgxUVmVwZcWR8ymLx6
         yADhkWb+xjyNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E24ECE0C4D; Wed, 13 Dec 2023 10:05:52 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:05:52 -0800
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
Message-ID: <505dba1e-4950-4968-a789-434c52a3e1c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312091837.cKaPw0Tf-lkp@intel.com>
 <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
 <20231213125358.GB3001@suse.cz>
 <4c814394-6eab-4aca-96af-43f99fb94c01@paulmck-laptop>
 <20231213155440.GA454379@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213155440.GA454379@perftesting>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:54:40AM -0500, Josef Bacik wrote:
> On Wed, Dec 13, 2023 at 06:56:37AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 13, 2023 at 01:53:58PM +0100, David Sterba wrote:
> > > On Sat, Dec 09, 2023 at 07:51:30AM -0800, Paul E. McKenney wrote:
> > > > On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
> > > > > head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> > > > > commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> > > > > config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> > > > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/
> > > > > 
> > > > > All errors (new ones prefixed by >>):
> > > > > 
> > > > >    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> > > > >    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> > > > >    warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
> > > > > >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
> > > > >      496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
> > > > >          |             ^
> > > > 
> > > > Ooooh!!!  :-/
> > > > 
> > > > From what I can see, the current code can tear this load on 32-bit
> > > > systems, which can result in bad comparisons and then in failure to wait
> > > > for a partially complete transaction.
> > > > 
> > > > So is btrfs actually supported on 32-bit systems?  If not, would the
> > > > following patch be appropriate?
> > > 
> > > There are limitations on 32bit systems, eg. due to shorter inode numbers
> > > (ino_t is unsigned long) and that radix-tree/xarray does support only
> > > unsigned long keys, while we have 64bit identifiers for inodes or tree
> > > roots.
> > > 
> > > So far we support that and dropping it completely is I think a big deal,
> > > like with any possibly used feature. What I've seen there are NAS boxes
> > > with low power ARM that are 32bit.
> > > 
> > > > If btrfs is to be supported on 32-bit systems, from what I can see some
> > > > major surgery is required, even if a 32-bit counter is wrap-safe for
> > > > this particular type of transaction.  (But SSDs?  In-memory btrfs
> > > > filesystems?)
> > > 
> > > We won't probably do any major surgery to support 32bit systems.
> > 
> > Got it, and thank you for the background!  My takeaway is that 32-bit
> > BTRFS must work in the common case, but might have issues on some
> > workloads, for example, running out of inode numbers or load tearing.
> > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > > > index 4fb925e8c981..4d56158c34f9 100644
> > > > --- a/fs/btrfs/Kconfig
> > > > +++ b/fs/btrfs/Kconfig
> > > > @@ -19,6 +19,7 @@ config BTRFS_FS
> > > >  	select RAID6_PQ
> > > >  	select XOR_BLOCKS
> > > >  	depends on PAGE_SIZE_LESS_THAN_256KB
> > > > +	depends on 64BIT
> > > 
> > > Can we keep the current inefficient smp_* barriers instead of dropping
> > > the whole 32bit support as an alternative. If the smp_load_acquire are
> > > better but not strictly necessary for the correctness (from the barriers
> > > POV) I'd suggest to leave it as-is. We can put comments in case somebody
> > > wants to optimize it in the future again.
> > 
> > We still have the barrier placement issue, given that smp_rmb() enforces
> > only the ordering of earlier and later loads, correct?  Or am I missing
> > some other ordering constraint that makes all that work?
> > 
> > But I can make each of the current patch's smp_load_acquire() call instead
> > be be a READ_ONCE() followed by an smp_rmb(), the test_bit_acquire()
> > call be test_bit() followed by smp_rmb(), and the smp_store_release()
> > call be an smp_wmb() followed by a WRITE_ONCE().  This provides the needed
> > ordering, bullet-proofs the 64-bit code against compilers, but works on
> > 32-bit systems.  For example, on a 32-bit system the 64-bit READ_ONCE()
> > and WRITE_ONCE() might still be compiled as a pair of 32-bit memory
> > accesses, but they will both be guaranteed to be single memory accesses
> > on 64-bit systems.
> > 
> > Would that work for you guys?
> 
> Actually I think we just need to re-work all of this to make it less silly.
> Does this look reasonable to you Paul?  I still have to test it, but I think it
> addresses your concerns and lets us keep 32bit support ;).  Thanks,

Things that avoid the need for memory barriers are often improvements!

I don't claim to understand enough of the BTRFS code to fully judge
this, but I do ask one stupid question below just in case it inspires
a non-stupid idea.  ;-)

							Thanx, Paul

> Josef
> 
> From: Josef Bacik <josef@toxicpanda.com>
> Date: Wed, 13 Dec 2023 10:46:57 -0500
> Subject: [PATCH] btrfs: cleanup how we record roots in the transaction
> 
> Previously we didn't have a bit field for tracking if a root was
> recorded in the transaction, it was simply an integer on the root.
> Additionally we have the ->last_trans which we record the last
> transaction this root was modified in.  We had various memory barriers
> to attempt to synchronize these two updates so we could avoid taking the
> ->reloc_mutex all of the time for transaction starts.
> 
> However this code has changed a lot, but the dubious memory ordering has
> remained.  Fix up this code to make it more clear and get rid of the
> memory barriers.  All we're trying to avoid here is constantly taking
> the ->reloc_mutex, so add a new bit to mark that the root has been
> recorded.  If this bit is set then we can skip the expensive step,
> otherwise we have to take the lock and wait.
> 
> Add a big comment indicating why we're doing the ordering and locking
> the way we are, and use ->fs_roots_radix_lock as the arbiter of this new
> bit.
> 
> This makes the code simpler, removes the memory barriers, and documents
> clearly what we're doing so it's less confusing for future readers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h       | 11 ++++---
>  fs/btrfs/disk-io.c     |  1 +
>  fs/btrfs/transaction.c | 69 +++++++++++++++++-------------------------
>  3 files changed, 34 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 70e828d33177..eb44cf191863 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -90,12 +90,13 @@ struct btrfs_path {
>   */
>  enum {
>  	/*
> -	 * btrfs_record_root_in_trans is a multi-step process, and it can race
> -	 * with the balancing code.   But the race is very small, and only the
> -	 * first time the root is added to each transaction.  So IN_TRANS_SETUP
> -	 * is used to tell us when more checks are required
> +	 * We set this after we've recorded the root in the transaction.  This
> +	 * is used to avoid taking the reloc_mutex every time we call
> +	 * btrfs_start_transaction(root).  Once the root has been recorded we
> +	 * don't have to do the setup work again, and this is cleared on
> +	 * transaction commit once we're done with the root.
>  	 */
> -	BTRFS_ROOT_IN_TRANS_SETUP,
> +	BTRFS_ROOT_RECORDED,
>  
>  	/*
>  	 * Set if tree blocks of this root can be shared by other roots.
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c6907d533fe8..0410fac5f78e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4805,6 +4805,7 @@ static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
>  			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>  					(unsigned long)root->root_key.objectid,
>  					BTRFS_ROOT_TRANS_TAG);
> +			clear_bit(BTRFS_ROOT_RECORDED, &root->state);
>  		}
>  	}
>  	spin_unlock(&fs_info->fs_roots_radix_lock);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 5b3333ceef04..186089ddac27 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -407,54 +407,43 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
>  	int ret = 0;
>  
>  	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
> -	    root->last_trans < trans->transid) || force) {
> +	     !test_bit(BTRFS_ROOT_RECORDED, &root->state)) || force) {

Would it make sense to test both bits at once?  Something like:

	if ((READ_ONCE(root->state) & (BIT(BTRFS_ROOT_SHAREABLE) | BIT(BTRFS_ROOT_RECORDED))) == BIT(BTRFS_ROOT_SHAREABLE))

That way you get an atomic test of both bits without the memory-ordering
aggravation.  Though you already hold the mutex here, so this should
not matter in this case, hence the question being stupid.  ;-)

>  		WARN_ON(!force && root->commit_root != root->node);
>  
>  		/*
> -		 * see below for IN_TRANS_SETUP usage rules
> -		 * we have the reloc mutex held now, so there
> -		 * is only one writer in this function
> +		 * We are using ->fs_roots_radix_lock as the ultimate protector
> +		 * of BTRFS_ROOT_RECORDED, which means we want to set it once
> +		 * we're completely done, so we call btrfs_init_reloc_root()
> +		 * first.
> +		 *
> +		 * This is ok because we are protected here by ->reloc_mutex, so
> +		 * in reality we won't ever race and call
> +		 * btrfs_init_reloc_root() twice on the same root back to back.
> +		 * However if we do it's ok, because again we're protected by
> +		 * ->reloc_mutex and the second call will simply update the
> +		 * ->last_trans on the reloc root to the current transid, making
> +		 * it essentially a no-op.
> +		 *
> +		 * We're using ->fs_roots_radix_lock here because
> +		 * btrfs_drop_snapshot will clear the tag so we don't update the
> +		 * root, and we will clear the RECORDED flag there without the
> +		 * ->reloc_mutex lock held.  Again this is fine because we won't
> +		 * be messing with a dropped root anymore, but for concurrency
> +		 * it's best to keep the rules nice and simple.
>  		 */
> -		set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
> -
> -		/* make sure readers find IN_TRANS_SETUP before
> -		 * they find our root->last_trans update
> -		 */
> -		smp_wmb();
> +		ret = btrfs_init_reloc_root(trans, root);
>  
>  		spin_lock(&fs_info->fs_roots_radix_lock);
> -		if (root->last_trans == trans->transid && !force) {
> +		if (test_bit(BTRFS_ROOT_RECORDED, &root->state) && !force) {
>  			spin_unlock(&fs_info->fs_roots_radix_lock);
>  			return 0;
>  		}
>  		radix_tree_tag_set(&fs_info->fs_roots_radix,
>  				   (unsigned long)root->root_key.objectid,
>  				   BTRFS_ROOT_TRANS_TAG);
> -		spin_unlock(&fs_info->fs_roots_radix_lock);
> +		set_bit(BTRFS_ROOT_RECORDED, &root->state);
>  		root->last_trans = trans->transid;
> -
> -		/* this is pretty tricky.  We don't want to
> -		 * take the relocation lock in btrfs_record_root_in_trans
> -		 * unless we're really doing the first setup for this root in
> -		 * this transaction.
> -		 *
> -		 * Normally we'd use root->last_trans as a flag to decide
> -		 * if we want to take the expensive mutex.
> -		 *
> -		 * But, we have to set root->last_trans before we
> -		 * init the relocation root, otherwise, we trip over warnings
> -		 * in ctree.c.  The solution used here is to flag ourselves
> -		 * with root IN_TRANS_SETUP.  When this is 1, we're still
> -		 * fixing up the reloc trees and everyone must wait.
> -		 *
> -		 * When this is zero, they can trust root->last_trans and fly
> -		 * through btrfs_record_root_in_trans without having to take the
> -		 * lock.  smp_wmb() makes sure that all the writes above are
> -		 * done before we pop in the zero below
> -		 */
> -		ret = btrfs_init_reloc_root(trans, root);
> -		smp_mb__before_atomic();
> -		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
> +		spin_unlock(&fs_info->fs_roots_radix_lock);
>  	}
>  	return ret;
>  }
> @@ -476,6 +465,7 @@ void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
>  	radix_tree_tag_clear(&fs_info->fs_roots_radix,
>  			     (unsigned long)root->root_key.objectid,
>  			     BTRFS_ROOT_TRANS_TAG);
> +	clear_bit(BTRFS_ROOT_RECORDED, &root->state);
>  	spin_unlock(&fs_info->fs_roots_radix_lock);
>  }
>  
> @@ -488,13 +478,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
>  	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
>  		return 0;
>  
> -	/*
> -	 * see record_root_in_trans for comments about IN_TRANS_SETUP usage
> -	 * and barriers
> -	 */
> -	smp_rmb();
> -	if (root->last_trans == trans->transid &&
> -	    !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
> +	if (test_bit(BTRFS_ROOT_RECORDED, &root->state))
>  		return 0;
>  
>  	mutex_lock(&fs_info->reloc_mutex);
> @@ -1531,6 +1515,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>  			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>  					(unsigned long)root->root_key.objectid,
>  					BTRFS_ROOT_TRANS_TAG);
> +			clear_bit(BTRFS_ROOT_RECORDED, &root->state);
>  			spin_unlock(&fs_info->fs_roots_radix_lock);
>  
>  			btrfs_free_log(trans, root);
> -- 
> 2.43.0
> 
