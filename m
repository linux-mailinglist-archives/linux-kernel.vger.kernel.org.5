Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB31811248
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379170AbjLMNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379155AbjLMNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2444D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:00:51 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E22192253E;
        Wed, 13 Dec 2023 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702472450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fc6oe/XMIOwA5ngedPo5oLgqOy7OCBLCUg0DlfK38Lk=;
        b=B55tobPWLFHdIJlmeI69FNLLnCE7Vw+40W+lZLgeNLcLKu/cFRCzGxfjbO5+QQzdVnncYB
        ko+Vg89dv1fg0uoWPOVz9vRb7qY1AL8GOaxl30lJcSSK7jdU9YE3KkbcGjpzQfrAeTqhjS
        AOJKzaV4CNsZFMK51IybJ/I+Ta7dpGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702472450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fc6oe/XMIOwA5ngedPo5oLgqOy7OCBLCUg0DlfK38Lk=;
        b=CjI5e0gFQcqBTK2Bl+EdnsJR+aQ83XB6Qo/X+peRT2oMBET1lqbIEaCHvHeF2rYHDDvZ7O
        ld3n6jrp9JvqDpAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702472449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fc6oe/XMIOwA5ngedPo5oLgqOy7OCBLCUg0DlfK38Lk=;
        b=wTb1cv0Csna/1yuml5biItuDVVtSajSrMHCBtTOzeYjnD3qFZvt0r3lplQSnPwFfgOYY+G
        tZJYVmQr27fiWGAm3z43B/Fci7iu+pn2NFWuggpycFgySZKh6w1WIMHsV/QW0M/LwRie1r
        oGAxzc+TwFMdR92ftayfyuiZgAcm/+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702472449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fc6oe/XMIOwA5ngedPo5oLgqOy7OCBLCUg0DlfK38Lk=;
        b=MW5UH5MLm6+1w4wF+IN4ty4fdtoXToNEAhSUV9UGyTVn96vJcS7rgKsj5YFZPLPBl/fjdF
        OxpI9LEC0+lD1QAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC3C313240;
        Wed, 13 Dec 2023 13:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id LG69LQGreWVeJAAAn2gu4w
        (envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 13:00:49 +0000
Date:   Wed, 13 Dec 2023 13:53:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, julia.lawall@inria.fr,
        clm@fb.com, dsterba@suse.com, baptiste.lepers@gmail.com
Subject: Re: [paulmck-rcu:frederic.2023.12.08a 29/37]
 fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329'
 declared with 'error' attribute: Need native word sized stores/loads for
 atomicity.
Message-ID: <20231213125358.GB3001@suse.cz>
Reply-To: dsterba@suse.cz
References: <202312091837.cKaPw0Tf-lkp@intel.com>
 <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0487d7cc-b906-4a4a-b284-9c79700b4ede@paulmck-laptop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -1.50
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.50
X-Spamd-Result: default: False [-1.50 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         BAYES_HAM(-3.00)[99.99%];
         RCPT_COUNT_SEVEN(0.00)[10];
         DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,toxicpanda.com,inria.fr,fb.com,suse.com,gmail.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 07:51:30AM -0800, Paul E. McKenney wrote:
> On Sat, Dec 09, 2023 at 06:20:37PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
> > head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
> > commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
> > config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
> >    warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
> >    warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
> > >> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
> >      496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
> >          |             ^
> 
> Ooooh!!!  :-/
> 
> From what I can see, the current code can tear this load on 32-bit
> systems, which can result in bad comparisons and then in failure to wait
> for a partially complete transaction.
> 
> So is btrfs actually supported on 32-bit systems?  If not, would the
> following patch be appropriate?

There are limitations on 32bit systems, eg. due to shorter inode numbers
(ino_t is unsigned long) and that radix-tree/xarray does support only
unsigned long keys, while we have 64bit identifiers for inodes or tree
roots.

So far we support that and dropping it completely is I think a big deal,
like with any possibly used feature. What I've seen there are NAS boxes
with low power ARM that are 32bit.

> If btrfs is to be supported on 32-bit systems, from what I can see some
> major surgery is required, even if a 32-bit counter is wrap-safe for
> this particular type of transaction.  (But SSDs?  In-memory btrfs
> filesystems?)

We won't probably do any major surgery to support 32bit systems.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 4fb925e8c981..4d56158c34f9 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -19,6 +19,7 @@ config BTRFS_FS
>  	select RAID6_PQ
>  	select XOR_BLOCKS
>  	depends on PAGE_SIZE_LESS_THAN_256KB
> +	depends on 64BIT

Can we keep the current inefficient smp_* barriers instead of dropping
the whole 32bit support as an alternative. If the smp_load_acquire are
better but not strictly necessary for the correctness (from the barriers
POV) I'd suggest to leave it as-is. We can put comments in case somebody
wants to optimize it in the future again.
