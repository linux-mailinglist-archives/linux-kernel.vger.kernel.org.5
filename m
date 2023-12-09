Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C280B51F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjLIPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 10:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 10:51:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31311D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 07:51:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB26C433C8;
        Sat,  9 Dec 2023 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702137090;
        bh=B3v9bwxxiKJCYTZLonVR80MhGHU+cdr4njBxdTxrBZ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d4vPiUZgGBp/xiPQThXJAATl3ojnowbYpykR84SpURS3H5bRnDo/aL+ZbJWapa2Q4
         +NnwnQ7fRXZDz0+QeeoO6V94YORod1WZhFn25o6Vw3I6bm5IMq9O7F5cagNoSM795B
         LIoPVAqu18I9s4SApslb6bP4Ashzt2WdKRQa7PmUktT71HSDRTn5mxP6O3tRQDSAN8
         wxOUlI23WMhEbhSsrpd9qQPDpALR4J+Hxm0v4/8V5OvjyxwpvXrTWSnn+xM+4J5NG9
         41xfD22q+3t7pEu3qrg+0dePAhEayiDH3eMI9U+5PejE0Rp0n+9zuTetFFXseZ1SbL
         rpxKfObL7MCxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B3F4CE0D18; Sat,  9 Dec 2023 07:51:30 -0800 (PST)
Date:   Sat, 9 Dec 2023 07:51:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        julia.lawall@inria.fr, clm@fb.com, dsterba@suse.com,
        baptiste.lepers@gmail.com
Subject: Re: [paulmck-rcu:frederic.2023.12.08a 29/37]
 fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329'
 declared with 'error' attribute: Need native word sized stores/loads for
 atomicity.
Message-ID: <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312091837.cKaPw0Tf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312091837.cKaPw0Tf-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
> head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
>    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
>    warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
> >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
>      496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
>          |             ^

Ooooh!!!  :-/

From what I can see, the current code can tear this load on 32-bit
systems, which can result in bad comparisons and then in failure to wait
for a partially complete transaction.

So is btrfs actually supported on 32-bit systems?  If not, would the
following patch be appropriate?

If btrfs is to be supported on 32-bit systems, from what I can see some
major surgery is required, even if a 32-bit counter is wrap-safe for
this particular type of transaction.  (But SSDs?  In-memory btrfs
filesystems?)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 4fb925e8c981..4d56158c34f9 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -19,6 +19,7 @@ config BTRFS_FS
 	select RAID6_PQ
 	select XOR_BLOCKS
 	depends on PAGE_SIZE_LESS_THAN_256KB
+	depends on 64BIT
 
 	help
 	  Btrfs is a general purpose copy-on-write filesystem with extents,
